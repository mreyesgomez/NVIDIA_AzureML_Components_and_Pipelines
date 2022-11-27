set -x

# map the output data location to the directory name used by the script

export ORIGINAL_SPECs_DIR=$1
export SPECS_FILE=$2
export DATA_DIR=$3
export BASE_MODEL_DIR=$4
export TF_RECORDS_DIR=$5
export OUTPUT_SUBFOLDER=$6
export OUTPUT_FILENAME=$7
export OUTPUT_DIR=$8/detectnet_v2
export UPDATED_SPECs_DIR=$8/specs
export MAX_BATCHES=$9
export USE_VALIDATION_SET=${10}

mkdir $UPDATED_SPECs_DIR
mkdir $OUTPUT_DIR

bash ./update_specs.sh ${ORIGINAL_SPECs_DIR} ${UPDATED_SPECs_DIR} ${SPECS_FILE} /home/jupyter/data/training:${DATA_DIR}/data/training,/home/jupyter/data/tfrecords:${TF_RECORDS_DIR}/data/tfrecords,/home/jupyter/detectnet_v2:${BASE_MODEL_DIR}/detectnet_v2
bash ./tao_detectnet_v2_calibration_tensorfile.sh ${UPDATED_SPECs_DIR} ${SPECS_FILE} ${OUTPUT_SUBFOLDER} ${OUTPUT_FILENAME} ${OUTPUT_DIR} ${MAX_BATCHES} ${USE_VALIDATION_SET}

ls -l $OUTPUT_DIR/${OUTPUT_SUBFOLDER}

