#!/bin/bash

pvc=$1
capacity=$2
size=$3
bs=$4
njobs=$5
iodepth=$6

ts=$(date +"%Y%m%d%H%M%S")

name=fio-${pvc}-${capacity}-${size}-${bs}-${njobs}-${iodepth}-${ts}
namelower=${name,,}

cp -r tpl $namelower

sed -i "s/{{namelower}}/${namelower}/g;s/{{name}}/${name}/g;s/{{pvc}}/${pvc}/g;s/{{capacity}}/${capacity}/g;s/{{size}}/${size}/g;s/{{bs}}/${bs}/g;s/{{njobs}}/$njobs/g;s/{{iodepth}}/${iodepth}/g" ${namelower}/*

kubectl apply -f $namelower
