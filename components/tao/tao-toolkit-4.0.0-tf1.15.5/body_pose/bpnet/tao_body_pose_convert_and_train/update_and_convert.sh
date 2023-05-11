set -x

# map the output data location to the directory name used by the script
export ORIGINAL_SPECs_DIR=$1/data_pose_config
export DATA_DIR=$2/data
export DATASET_EXPORT_SPEC=$3
export UPDATED_SPECs_DIR=${10}/specs/data_pose_config
export TF_RECORDS_DIR=$4 # this is the output that's created by AzureML
export SPECFILE_REFERENCE_DATA_DIR=$5
export TRAIN_MODE=$6
export VAL_MODE=$7
export RELATIVE_TRAIN_MASK_DIRECTORY=$8
export RELATIVE_VAL_MASK_DIRECTORY=$9
# export UPDATED_DIR=$10/specs/data_pose_config # was $10

# mkdir $TF_RECORDS_DIR 
mkdir -p $TF_RECORDS_DIR/$RELATIVE_TRAIN_MASK_DIRECTORY
mkdir -p $TF_RECORDS_DIR/$RELATIVE_VAL_MASK_DIRECTORY
mkdir -p $UPDATED_SPECs_DIR

# UPDATED_SPECs_DIR was previously DATA_DIR, but this doesn't work because that is an input
bash ./update_specs.sh ${ORIGINAL_SPECs_DIR} ${UPDATED_SPECs_DIR} ${DATASET_EXPORT_SPEC} ${SPECFILE_REFERENCE_DATA_DIR}:${DATA_DIR},${RELATIVE_TRAIN_MASK_DIRECTORY}:${TF_RECORDS_DIR}/${RELATIVE_TRAIN_MASK_DIRECTORY},${RELATIVE_VAL_MASK_DIRECTORY}:${TF_RECORDS_DIR}/${RELATIVE_VAL_MASK_DIRECTORY}

echo "hwolff"
ls ${UPDATED_SPECs_DIR} 

bash ./tao_body_pose_convert_and_train.sh ${UPDATED_SPECs_DIR} ${DATASET_EXPORT_SPEC} \
    ${TF_RECORDS_DIR}/${RELATIVE_TRAIN_MASK_DIRECTORY} ${TF_RECORDS_DIR}/${RELATIVE_VAL_MASK_DIRECTORY} \
    ${TRAIN_MODE} ${VAL_MODE}