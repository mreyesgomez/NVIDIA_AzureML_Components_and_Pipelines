set -x

# map the output data location to the directory name used by the script

export ORIGINAL_SPECs_DIR=$1
export SPECS_FILE=$2
export DATA_DIR=$3/data
export INPUT_SUBFOLDER=$4
export MODEL_DIR=$5
export KEY=$6
export OUTPUT_SUBFOLDER=$7
export RESULTS_DIR=$8/detectnet_v2
export UPDATED_SPECs_DIR=$8/specs

mkdir $UPDATED_SPECs_DIR
mkdir $RESULTS_DIR

bash ./update_specs.sh ${ORIGINAL_SPECs_DIR} ${UPDATED_SPECs_DIR} ${SPECS_FILE} /home/jupyter/detectnet_v2:${MODEL_DIR}/detectnet_v2
bash ./tao_detectnet_v2_inference.sh ${UPDATED_SPECs_DIR} ${SPECS_FILE} ${RESULTS_DIR} ${OUTPUT_SUBFOLDER} ${DATA_DIR} ${INPUT_SUBFOLDER} ${KEY}

