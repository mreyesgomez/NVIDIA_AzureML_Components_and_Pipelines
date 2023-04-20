#!/bin/bash

source scripts/config_files/config.sh
echo "az ml environment create --workspace-name ${workspace} --file environments/${nvidia_product}/${container}/${nvidia_product}.yml"