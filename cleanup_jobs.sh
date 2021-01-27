#!/bin/bash

for i in $(kubectl get jobs | grep '1/1' | cut -f1 -d' '); do

    echo "cleaning up $i..."
    kubectl delete -f $i/
    rm -rf $i

done
