set -x

# map the output data location to the directory name used by the script

export ORIGINAL_SPECs_DIR=$1/data_pose_config
export DATA_DIR=$2/data
export DATASET_EXPORT_SPEC=$3
export UPDATED_SPECs_DIR=$4/specs/data_pose_config
export TF_RECORDS_DIR=$4
export OUTPUT_FILENAME=$5
export SPECFILE_REFERENCE_DATA_DIR=$6
export MODE=$7
export RELATIVE_MASK_DIRECTORY=$8

echo "hwolff ${ORIGINAL_SPECS_DIR}"
mkdir $TF_RECORDS_DIR
mkdir $TF_RECORDS_DIR/$RELATIVE_MASK_DIRECTORY
mkdir -p $UPDATED_SPECs_DIR

bash ./update_specs.sh ${ORIGINAL_SPECs_DIR} ${UPDATED_SPECs_DIR} ${DATASET_EXPORT_SPEC} ${SPECFILE_REFERENCE_DATA_DIR}:${DATA_DIR},${RELATIVE_MASK_DIRECTORY}:${TF_RECORDS_DIR/$RELATIVE_MASK_DIRECTORY}
bash ./tao_body_pose_dataset_convert.sh ${UPDATED_SPECs_DIR} ${DATASET_EXPORT_SPEC} ${TF_RECORDS_DIR/$RELATIVE_MASK_DIRECTORY} ${OUTPUT_FILENAME} ${MODE}