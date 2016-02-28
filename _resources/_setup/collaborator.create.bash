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
mysql_root_password=""
# move to working directory
cd $( dirname "${BASH_SOURCE[0]}" )
# trump credentials if external file exists
if [ -f credentials_local.bash ]; then
  source credentials_local.bash
fi
if [[ -z "$mysql_root_password" ]]; then
  read -e -p "enter mysql root password: " mysql_root_password
fi
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
GRANT SELECT ON *.* TO '$new_collaborator'@'$database_server';
GRANT SELECT ON *.* TO '$new_collaborator'@'%';
EOF
echo "
mysql database name: $database_name
mysql username: $new_collaborator
mysql password: $database_password
"

# create virtual host
cd /var/www/test/
git clone https://github.com/admonkey/projects.uark.edu.git
cd projects.uark.edu/
git checkout -b $new_collaborator
# create local credentials files
# php
echo "
<?php
\$database_username='$new_collaborator';
\$database_password='$database_password';
\$database_name='$database_name';
?>
" > _resources/credentials_local.inc.php
# bash
echo "
database_user='$new_collaborator'
database_password='$database_password'
database_name='$database_name'
" > _resources/SQL/credentials_local.bash
cd ..
mv projects.uark.edu/ $new_collaborator/
chown -R $new_collaborator:$new_collaborator $new_collaborator/

# copy error log alias to .bashrc
echo 'alias elog="cat /var/log/httpd/test.projects.uark.edu.ssl-error_log"' >> /home/$new_collaborator/.bashrc

# move to virtual host directory
echo "alias www='cd /var/www/test/$new_collaborator'" >> /home/$new_collaborator/.bashrc
