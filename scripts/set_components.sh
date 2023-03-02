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

SUB='pipeline'
###pipeline components should be created after all regular command components have been created
for component_file in $(find $COMPONENTS_DIR -name '*.yml');
do
    if [[ "$component_file" != *"$SUB"* ]]; then
        echo "az ml component create --file ${component_file}"
        az ml component create --file ${component_file};
    fi
done;

for component_file in $(find $COMPONENTS_DIR -name '*.yml');
do
    if [[ "$component_file" == *"$SUB"* ]]; then
        echo "az ml component create --file ${component_file}"
        az ml component create --file ${component_file};
    fi
done;

