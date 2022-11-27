#!/bin/bash

curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
az extension remove -n azure-cli-ml
az extension remove -n ml
az extension add -n ml
az extension update -n ml

python3 scripts/set_credentials.py
source scripts/config.sh

az login
az account set -s $subscription_id
az configure --defaults group=$resource_group workspace=$workspace_name

cp scripts/auxiliary_files/tao_client_aml.py tao-toolkit-triton-apps/tao_triton/python/entrypoints/
cp scripts/auxiliary_files/clustering_config_detectnet.prototxt tao-toolkit-triton-apps/tao_triton/python/clustering_specs/

cd tao-toolkit-triton-apps
python3 -m venv virtualenv
source virtualenv/bin/activate
pip3 install -r tao_triton/requirements-pip.txt 
pip3 install nvidia-pyindex
pip3 install tritonclient[all]
cd ../
