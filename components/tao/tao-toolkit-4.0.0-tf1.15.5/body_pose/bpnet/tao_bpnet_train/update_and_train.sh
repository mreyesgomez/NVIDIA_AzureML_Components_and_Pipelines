set -x

# map the output data location to the directory name used by the script
export ORIGINAL_SPECs_DIR=$1
export SPEC_FILE=$2
export NUM_EPOCHS=$3
export TRAINING_DATA_DIR=$4
export SPECFILE_REFERENCE_TRAINING_DATA_DIR=$5
export VALIDATION_DATA_DIR=$6
export SPECFILE_REFERENCE_VALIDATION_DATA_DIR=$7
export TRAINING_TF_RECORDS_DIR=$8
export SPECFILE_REFERENCE_TRAINING_TF_RECORDS_DIR=${9}
export VALIDATION_TF_RECORDS_DIR=${10}
export SPECFILE_REFERENCE_VALIDATION_TF_RECORDS_DIR=${11}
export KEY=${12}
export BASE_MODEL_DIR=${13}
export SPECFILE_REFERENCE_MODEL_DIR=${14}
export NUM_GPUS=${15}
export MODEL_NAME=${16}
export MODEL_SUBFOLDER=${17}
export TRAINED_MODEL_DIR=${18}
export UPDATED_SPECs_DIR=${18}/specs
export GPU_INDEX=${19}
export USE_AMP=${20}
export LOG_FILE=${21}
export SPECFILE_MODEL_POSE_DIR=${22}
export SPECFILE_DATA_POSE_DIR=${23}


#base_model_subdir migth be not defined so /ND pattern needs to be removed
BASE_MODEL_DIR=`echo ${BASE_MODEL_DIR} | sed -e 's%/ND%%g'`
BASE_MODEL_DIR="${BASE_MODEL_DIR}/pretrained_model/bodyposenet_vtrainable_v1.0" # added 

mkdir -p $TRAINED_MODEL_DIR/$MODEL_SUBFOLDER
mkdir $UPDATED_SPECs_DIR
# mkdir $SPECFILE_MODEL_POSE_DIR

ls -l $TRAINING_DATA_DIR
ls -l $VALIDATION_DATA_DIR
ls -l $TRAINING_TF_RECORDS_DIR
ls -l $VALIDATION_TF_RECORDS_DIR
ls -l $BASE_MODEL_DIR
ls -l $SPECFILE_MODEL_POSE_DIR
ls -l $SPECFILE_DATA_POSE_DIR

if [[ "${SPECFILE_REFERENCE_VALIDATION_DATA_DIR}" != "ND" ]]
then
    # TODO make the update specs calls differente depending on validation data dir (rn update specs is the same)
    bash ./update_specs.sh ${ORIGINAL_SPECs_DIR} ${UPDATED_SPECs_DIR} ${SPEC_FILE} 'num_epochs: [0-9]\+'%'num_epochs: '${NUM_EPOCHS},${SPECFILE_REFERENCE_TRAINING_DATA_DIR}%${TRAINING_DATA_DIR},${SPECFILE_REFERENCE_TRAINING_TF_RECORDS_DIR}%${TRAINING_TF_RECORDS_DIR},${SPECFILE_REFERENCE_MODEL_DIR}%${BASE_MODEL_DIR}/${MODEL_NAME},${SPECFILE_MODEL_POSE_DIR}%${ORIGINAL_SPECs_DIR}/model_pose_config/bpnet_18joints.json,${SPECFILE_DATA_POSE_DIR}%${ORIGINAL_SPECs_DIR}/data_pose_config/coco_spec.json
else
    bash ./update_specs.sh ${ORIGINAL_SPECs_DIR} ${UPDATED_SPECs_DIR} ${SPEC_FILE} 'num_epochs: [0-9]\+'%'num_epochs: '${NUM_EPOCHS},${SPECFILE_REFERENCE_TRAINING_DATA_DIR}%${TRAINING_DATA_DIR},${SPECFILE_REFERENCE_TRAINING_TF_RECORDS_DIR}%${TRAINING_TF_RECORDS_DIR},${SPECFILE_REFERENCE_MODEL_DIR}%${BASE_MODEL_DIR}/${MODEL_NAME},${SPECFILE_MODEL_POSE_DIR}%${ORIGINAL_SPECs_DIR}/model_pose_config/bpnet_18joints.json,${SPECFILE_DATA_POSE_DIR}%${ORIGINAL_SPECs_DIR}/data_pose_config/coco_spec.json
fi

bash ./tao_bpnet_train.sh ${UPDATED_SPECs_DIR} ${SPEC_FILE} ${TRAINED_MODEL_DIR} ${MODEL_SUBFOLDER} ${NUM_GPUS} ${KEY} ${GPU_INDEX} ${USE_AMP} 
# TODO -- probably want to log not logging for now ${LOG_FILE}


if [[ "${LOG_FILE}" != "ND" ]]
then 
    LOG_FILE=$TRAINED_MODEL_DIR/$LOG_FILE
    python3 ./parse_info.py --logfile=$LOG_FILE --class_list=$CLASS_LIST --num_epochs=$NUM_EPOCHS
fi