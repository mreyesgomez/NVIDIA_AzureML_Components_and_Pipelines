#!/bin/bash  
export SPECS_DIR=$1
export DATASET_EXPORT_SPEC=$2
export TF_RECORDS_DIR=$3/$5 # ends in either train or val -- this determines the name of the file like train-fold-000-of-001
export DATA_FILENAME=$4
export MODE=$5

mkdir -p $TF_RECORDS_DIR
rm -rf $TF_RECORDS_DIR/*

ls $SPECS_DIR
ls $TF_RECORDS_DIR

# export ADDITIONAL_ARGS=""

# if [[ "${VALIDATION_FOLD}" != "ND" ]]
# then
#     ADDITIONAL_ARGS="$ADDITIONAL_ARGS -f ${VALIDATION_FOLD}"
# fi

echo "bpnet dataset_convert -m $MODE -o $TF_RECORDS_DIR --generate_masks --dataset_spec $SPECS_DIR/data_pose_config/$DATASET_EXPORT_SPEC"
bpnet dataset_convert -m $MODE -o $TF_RECORDS_DIR --generate_masks --dataset_spec $SPECS_DIR/$DATASET_EXPORT_SPEC