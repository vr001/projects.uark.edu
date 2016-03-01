#!/bin/bash
new_collaborator=$(whoami)

# install mysql database shortcut
alias ddl="/var/www/test/$new_collaborator/_resources/SQL/projects.ddl.sql.bash"
