#!/bin/bash

# get ldap username
read -e -p "enter username: " new_collaborator
if [[ -z "$new_collaborator" ]]; then
  echo "Error: username cannot be empty"
  echo "Exiting"; exit 1
fi

userdel $new_collaborator

# delete home directory
rm -rf /home/$new_collaborator

# remove database access
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
mysql --host=$database_server --user=root --password=$mysql_root_password << EOF
DROP DATABASE $database_name;
DROP USER '$new_collaborator'@'localhost';
DROP USER '$new_collaborator'@'%';
EOF

# delete virtual host
rm -rf /var/www/test/$new_collaborator
