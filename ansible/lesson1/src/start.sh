#!/bin/bash
PATH_TO_ALL_PROJECT=`pwd`
PATH_TO_PLYBOOKS="$PATH_TO_ALL_PROJECT/playbook"
echo $PATH_TO_ALL_PROJECT
echo $PATH_TO_PLYBOOKS
if [ -d "$PATH_TO_PLYBOOKS" ]; then
  echo "Dir does exist. $PATH_TO_PLYBOOKS"
  docker-compose up -d && \
  sleep 2
  ansible-playbook -i $PATH_TO_PLYBOOKS/inventory/prod.yml --vault-password-file $PATH_TO_PLYBOOKS/vault_pass $PATH_TO_PLYBOOKS/site.yml && \
  sleep 2 
  docker-compose down
else
  echo "Dir with playbooks dosnt exist, end script"
fi