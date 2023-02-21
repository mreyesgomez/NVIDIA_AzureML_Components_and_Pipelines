#!/bin/bash

source scripts/config_files/config.sh


##Create Triton Components by Default
export COMPONENTS_DIR=components/triton/

for component_file in $(find $COMPONENTS_DIR -name '*.yml');
do
    echo "az ml component create --file ${component_file}"
    az ml component create --file ${component_file};
done;

export COMPONENTS_DIR=components/${nvidia_product}/${container}

for component_file in $(find $COMPONENTS_DIR -name '*.yml');
do
    echo "az ml component create --file ${component_file}"
    az ml component create --file ${component_file};
done;

