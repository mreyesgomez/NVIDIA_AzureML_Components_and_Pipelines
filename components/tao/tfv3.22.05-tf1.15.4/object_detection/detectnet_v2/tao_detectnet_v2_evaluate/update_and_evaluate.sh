set -x

# map the output data location to the directory name used by the script

export ORIGINAL_SPECs_DIR=$1
export SPEC_FILE=$2
export DATA_DIR=$3
export BASE_MODEL_DIR=$4
export TF_RECORDS_DIR=$5
export KEY=$6
export MODEL_NAME=$7
export MODEL_SUBFOLDER=$8
export TARGET_MODEL_DIR=$9/detectnet_v2
export UPDATED_SPECs_DIR=./specs
export FRAMEWORK=${10}
export USE_TRAINING_SET=${11} 
export GPU_INDEX=${12}

mkdir $UPDATED_SPECs_DIR

bash ./update_specs.sh ${ORIGINAL_SPECs_DIR} ${UPDATED_SPECs_DIR} ${SPEC_FILE} /home/jupyter/data/training:${DATA_DIR}/data/training,/home/jupyter/data/tfrecords:${TF_RECORDS_DIR}/data/tfrecords,/home/jupyter/detectnet_v2:${BASE_MODEL_DIR}/detectnet_v2
bash ./tao_detectnet_v2_evaluate.sh ${UPDATED_SPECs_DIR} ${SPEC_FILE} ${TARGET_MODEL_DIR} ${MODEL_SUBFOLDER} ${KEY} ${MODEL_NAME} ${FRAMEWORK} ${USE_TRAINING_SET} ${GPU_INDEX}

