#!/bin/bash

echo "Creating Online Endpoint"
az ml online-endpoint create -f scripts/auxiliary_files/endpoint_aml.yml 

echo "Creating Online Deployment"
az ml online-deployment create -f scripts/auxiliary_files/deployment_aml.yml 
