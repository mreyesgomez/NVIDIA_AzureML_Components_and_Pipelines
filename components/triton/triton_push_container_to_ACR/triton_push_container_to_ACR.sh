#!/bin/bash

az account set -s $subscription_id
az configure --defaults group=$resource_group workspace=$workspace_name

echo "Login to Azure Container Registry"
az acr login -n $registryname

echo "Building the new docker image and tag it"
docker build -t $registryname.azurecr.io/tao -f scripts/auxiliary_files/Dockerfile_aml.yml .

echo "Pushing the image to ACR"
docker push ${registryname}.azurecr.io/tao:latest


