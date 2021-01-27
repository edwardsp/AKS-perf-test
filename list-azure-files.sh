#!/bin/bash

resource_group=$1

for i in $(az storage account list -g $resource_group --query [].name -o tsv 2>/dev/null); do

    echo "Storage Account: $i ($(az storage account show --name $i --query "keys(tags)" --output tsv | tr '\n' ',' | sed 's/,$//g'))"

    az storage share list --account-name $i --query '[].{name:name,quota:properties.quota}' -o table 2>/dev/null
    if [[ "$?" != "0" ]]; then
        echo "Error listing account shares:"
        echo "    az storage share list --account-name $i --query '[].{name:name,quota:properties.quota}' -o table"
    fi

    echo 
    
done
