#!/bin/bash
new_collaborator=$(whoami)

# get local credentials from test virtual host
database_credentials_file="/var/www/test/$new_collaborator/_resources/SQL/credentials_local.bash"

if [ -f $database_credentials_file ]; then
  source $database_credentials_file

  # mysql shortcut
  echo "alias mysqlme='mysql --user=\"$database_user\" --password=\"$database_password\"  --database=\"$database_name\"'" >> /home/$new_collaborator/.bashrc

  chmod 600 /home/$new_collaborator/.bashrc
else
  echo "ERROR: $database_credentials_file doesn't exist"; exit 1
fi
