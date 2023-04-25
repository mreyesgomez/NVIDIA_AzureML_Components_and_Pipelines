set -x

# map the output data location to the directory name used by the script

export ORIGINAL_SPECs_DIR=$1
export DATA_DIR=$2/data
export DATASET_EXPORT_SPEC=$3
export UPDATED_SPECs_DIR=$4/specs
export TF_RECORDS_DIR=$4/data
export OUTPUT_FILENAME=$5
export SPECFILE_REFERENCE_DATA_DIR=$6
export MODE=$7

mkdir $TF_RECORDS_DIR
mkdir $UPDATED_SPECs_DIR

echo update_specs.sh ${ORIGINAL_SPECs_DIR} ${UPDATED_SPECs_DIR} ${DATASET_EXPORT_SPEC} ${SPECFILE_REFERENCE_DATA_DIR}:${DATA_DIR}
bash ./update_specs.sh ${ORIGINAL_SPECs_DIR} ${UPDATED_SPECs_DIR} ${DATASET_EXPORT_SPEC} ${SPECFILE_REFERENCE_DATA_DIR}:${DATA_DIR}
echo tao_body_pose_dataset_convert.sh ${UPDATED_SPECs_DIR} ${DATASET_EXPORT_SPEC} ${TF_RECORDS_DIR} ${OUTPUT_FILENAME} ${MODE}
bash ./tao_body_pose_dataset_convert.sh ${UPDATED_SPECs_DIR} ${DATASET_EXPORT_SPEC} ${TF_RECORDS_DIR} ${OUTPUT_FILENAME} ${MODE}