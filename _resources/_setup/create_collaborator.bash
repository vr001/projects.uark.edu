#!/bin/bash

#functions
genpasswd() {
  local l=$1
  [ "$l" == "" ] && l=16
  tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${l} | xargs
}

# get ldap username
read -e -p "enter username: " new_collaborator
if [[ -z "$new_collaborator" ]]; then
  echo "Error: username cannot be empty"
  echo "Exiting"; exit 1
fi

adduser $new_collaborator

# set up git prompt environment
sudo -u $new_collaborator bash << EOF
cd /home/$new_collaborator
/usr/local/git/bin/git clone https://github.com/admonkey/prefage.git
echo 'host_color=\$orangish' > prefage/bash/host-color.bash
./prefage/install-or-update.bash
EOF

# TODO: create git ssh keys

# add database access
read -e -p "enter mysql root password: " mysql_root_password
if [[ -z "$mysql_root_password" ]]; then
  echo "Error: mysql_root_password cannot be empty"
  echo "Exiting"; exit 1
fi
database_server="localhost"
database_password="$mysql_root_password"
database_name="projects_$new_collaborator"
database_password=$(genpasswd)
mysql --host=$database_server --user=root --password=$mysql_root_password << EOF
CREATE DATABASE $database_name;
CREATE USER '$new_collaborator'@'$database_server' IDENTIFIED BY '$database_password';
GRANT ALL PRIVILEGES ON $database_name.* TO '$new_collaborator'@'$database_server';
CREATE USER '$new_collaborator'@'%' IDENTIFIED BY '$database_password';
GRANT ALL PRIVILEGES ON $database_name.* TO '$new_collaborator'@'%';
EOF
echo "
mysql database name: $database_name
mysql username: $new_collaborator
mysql password: $database_password
"

# TODO: create virtual host
