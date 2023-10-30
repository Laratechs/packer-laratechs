#!/bin/bash
#
# Creates dedicated non-interactive user for service use.

declare -a errors
errors=()

while getopts u:p: flag
do
    case "${flag}" in
        u) username=${OPTARG};;
        p) path=${OPTARG};;
    esac
done

if [[ -z ${username} ]];  
then  
  errors+=("Use the -u flag to set a username") 
fi

if [[ -z ${path} ]];  
then  
  errors+=("Use the -p flag to set a path")
fi

if [ ${#errors[@]} -ne 0 ]
then
  echo -e "Please fix the following errors:\n"
  for (( i=0; i<${#errors[@]} ; i++ ));
  do
    echo -e "\t${errors[$i]}"
  done
  exit 1
fi

echo "Username: $username";
echo "Path: $path";

sudo useradd -r -m minecraft

sudo chown -R minecraft:minecraft $path
