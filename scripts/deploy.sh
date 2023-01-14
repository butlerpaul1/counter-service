#!/bin/bash
while getopts p:i: flag
do
    case "${flag}" in
        p) port=${OPTARG};;
        i) image=${OPTARG};;
    esac
done

echo "Pulling $image"
docker pull $image
echo "Running $image on port:$port"
docker run -p $port:8080 $image
