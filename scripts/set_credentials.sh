#!/bin/bash

source scripts/config_files/config.sh
az login

az account set -s ${subscription_id} 

az configure --defaults group=${resource_group} workspace=${workspace}