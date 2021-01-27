#!/usr/bin/bash

resource_group=aks-io-benchmark
location=westeurope
vm_size=Standard_D16s_v3
pool_init=1
pool_min=1
pool_max=2
aks_name=kube

if ! which az >/dev/null 2>&1; then
    echo "error: az cli not installed"
    exit 1
fi

if ! which kubectl >/dev/null 2>&1; then
    echo "error: kubectl not installed"
    exit 1
fi

echo "creating resource group"
az group create --name $resource_group --location $location

echo "creating aks cluster"
az aks create --resource-group $resource_group --name $aks_name \
    --node-vm-size $vm_size --generate-ssh-keys --enable-cluster-autoscaler \
    --node-count $pool_init --min-count $pool_min --max-count $pool_max

echo "setting kubectl credentials"
az aks get-credentials --overwrite-existing --resource-group $resource_group --name $aks_name
