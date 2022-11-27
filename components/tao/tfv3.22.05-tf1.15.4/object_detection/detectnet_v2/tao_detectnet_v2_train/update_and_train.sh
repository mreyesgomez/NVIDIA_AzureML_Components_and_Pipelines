set -x

# map the output data location to the directory name used by the script

export ORIGINAL_SPECs_DIR=$1
export SPEC_FILE=$2
export DATA_DIR=$3
export BASE_MODEL_DIR=$4
export TF_RECORDS_DIR=$5
export NUM_GPUS=$6
export KEY=$7
export NAME_STRING_FOR_THE_MODEL=$8
export MODEL_SUBFOLDER=$9
export TRAINED_MODEL_DIR=${10}/detectnet_v2
export UPDATED_SPECs_DIR=${10}/specs
export GPU_INDEX=${11}
export USE_AMP=${12}
export LOG_FILE=${13}

mkdir $UPDATED_SPECs_DIR
mkdir $TRAINED_MODEL_DIR

bash ./update_specs.sh ${ORIGINAL_SPECs_DIR} ${UPDATED_SPECs_DIR} ${SPEC_FILE} /home/jupyter/data/training:${DATA_DIR}/data/training,/home/jupyter/data/tfrecords:${TF_RECORDS_DIR}/data/tfrecords,/home/jupyter/detectnet_v2:${BASE_MODEL_DIR}/detectnet_v2
bash ./tao_detectnet_v2_train.sh ${UPDATED_SPECs_DIR} ${SPEC_FILE} ${TRAINED_MODEL_DIR} ${MODEL_SUBFOLDER} ${NUM_GPUS} ${KEY} ${NAME_STRING_FOR_THE_MODEL} ${GPU_INDEX} ${USE_AMP} ${LOG_FILE}