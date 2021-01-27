#!/bin/bash

kubectl apply -f sc/
kubectl apply -f results-pvc.yaml


for size in 100 1024 4095 8192 16384; do

    for sc in azurediskcsi-prem azurediskcsi-std azurefile-prem azurefile-std azurefilecsi-prem azurefilecsi-std azurefilecsinfs-prem manageddisk-prem manageddisk-std; do

        if [[ "$sc" = "azurediskcsi-std" && "$size" -gt "1024" ]]; then continue; fi
        if [[ "$sc" = "azurediskcsi-prem" && "$size" -gt "4095" ]]; then continue; fi
        if [[ "$sc" = "azurefilecsi-std" && "$size" -gt "5120" ]]; then continue; fi
        if [[ "$sc" = "azurefile-std" && "$size" -gt "5120" ]]; then continue; fi
        
        ./create_job.sh $sc ${size}Gi 20G 4M 4 8

    done

done
