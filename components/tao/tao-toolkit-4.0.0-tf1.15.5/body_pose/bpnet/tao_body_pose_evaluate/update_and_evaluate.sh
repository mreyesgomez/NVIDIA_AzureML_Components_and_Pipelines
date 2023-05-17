set -x

# map the output data location to the directory name used by the script

export ORIGINAL_SPECs_DIR=$1
export SPEC_FILE=$2
export KEY=$3
export BASE_MODEL_DIR=$4 # might just entirely be the model dir
export SPECFILE_REFERENCE_MODEL_DIR=$5
export MODEL_NAME=$6
export MODEL_SUBFOLDER=$7
export TARGET_MODEL_DIR=$8

export SPECFILE_REFERENCE_MODEL_DIR=$9
export SPECFILE_REFERENCE_TRAIN_DIR=${10}
export UPDATED_SPECs_DIR=${11}
export TRAIN_SPEC_PATH=${13}
export DATA_POSE_SPEC_PATH=${14}
# export MODEL_PATH
# export FRAMEWORK=${17}
# export USE_TRAINING_SET=${18}
# export GPU_INDEX=${19}

# mkdir $TARGET_MODEL_DIR
# mkdir $UPDATED_SPECs_DIR
#base_model_subdir migth be not defined so /ND pattern needs to be removed
# BASE_MODEL_DIR=`echo ${BASE_MODEL_DIR} | sed -e 's%/ND%%g'`

ls -l $MODEL_PATH
ls -l $TRAIN_SPEC_PATH
ls -l $DATA_POSE_SPEC_PATH


bash ./update_specs.sh ${ORIGINAL_SPECs_DIR} ${UPDATED_SPECs_DIR} ${SPEC_FILE} ${SPECFILE_REFERENCE_MODEL_DIR}:${TARGET_MODEL_DIR}/bpnet/exp_m1_unpruned/model.step-0.tlt,${SPECFILE_REFERENCE_TRAIN_DIR}:${TRAIN_SPEC_PATH}/specs/bpnet_train_m1_coco.yaml


bash ./tao_body_pose_evaluate.sh ${UPDATED_SPECs_DIR} ${SPEC_FILE} ${BASE_MODEL_DIR} ${MODEL_SUBFOLDER} ${KEY} ${MODEL_NAME} ${DATA_POSE_SPECS_PATH}

