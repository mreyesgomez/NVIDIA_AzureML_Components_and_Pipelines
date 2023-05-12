set -x

# ################################################################
# 
# Updating dataset convert specs and creating tfrecords
#
# ################################################################

# map the output data location to the directory name used by the script
export ORIGINAL_SPECs_DIR=$1
export DOWNLOADED_DATA_DIR=$2/data
export DATASET_EXPORT_SPEC=$3
export UPDATED_SPECs_DIR=${10}/specs/data_pose_config
export DATA_DIR=$4 # this is the output that's created by AzureML
export SPECFILE_REFERENCE_DATA_DIR=$5
export TRAIN_MODE=$6
export VAL_MODE=$7
export RELATIVE_TRAIN_MASK_DIRECTORY=$8
export RELATIVE_VAL_MASK_DIRECTORY=$9
# export UPDATED_DIR=$10/specs/data_pose_config # was $10

# mkdir $TF_RECORDS_DIR 
mkdir -p $DATA_DIR/$RELATIVE_TRAIN_MASK_DIRECTORY
mkdir -p $DATA_DIR/$RELATIVE_VAL_MASK_DIRECTORY
mkdir -p $DATA_DIR/train2017
mkdir -p $UPDATED_SPECs_DIR

# UPDATED_SPECs_DIR was previously DATA_DIR, but this doesn't work because that is an input
bash ./update_specs.sh ${ORIGINAL_SPECs_DIR}/data_pose_config ${UPDATED_SPECs_DIR} ${DATASET_EXPORT_SPEC} ${SPECFILE_REFERENCE_DATA_DIR}:${DOWNLOADED_DATA_DIR},${RELATIVE_TRAIN_MASK_DIRECTORY}:${DATA_DIR}/${RELATIVE_TRAIN_MASK_DIRECTORY},${RELATIVE_VAL_MASK_DIRECTORY}:${DATA_DIR}/${RELATIVE_VAL_MASK_DIRECTORY}

ls ${UPDATED_SPECs_DIR} 

bash ./tao_body_pose_convert.sh ${UPDATED_SPECs_DIR} ${DATASET_EXPORT_SPEC} \
    ${DATA_DIR}/${RELATIVE_TRAIN_MASK_DIRECTORY} ${DATA_DIR}/${RELATIVE_VAL_MASK_DIRECTORY} \
    ${TRAIN_MODE} ${VAL_MODE}


# ################################################################
# 
# Updating train specs and training
#
# ################################################################

export ORIGINAL_TRAIN_SPECs_DIR=${11}
export SPEC_FILE=${12}
export NUM_EPOCHS=${13}
export SPECFILE_REFERENCE_ROOT_DATA_DIR=${14}
# export VALIDATION_DATA_DIR=${15}
# export SPECFILE_REFERENCE_VALIDATION_DATA_DIR=${16}
export SPECFILE_REFERENCE_TRAINING_TF_RECORDS_DIR=${17}
# export SPECFILE_REFERENCE_VALIDATION_TF_RECORDS_DIR=${18}
export KEY=${19}
export BASE_MODEL_DIR=${20}
export SPECFILE_REFERENCE_MODEL_DIR=${21}
export NUM_GPUS=${22}
export MODEL_NAME=${23}
export MODEL_SUBFOLDER=${24}
export TRAINED_MODEL_DIR=${25}
# export UPDATED_SPECs_DIR=${25}/specs
UPDATED_TRAIN_SPECs_DIR=${10}/specs
UPDATED_SPECs_DIR=${25}/specs
export GPU_INDEX=${26}
export USE_AMP=${27}
export LOG_FILE=${28}
export SPECFILE_MODEL_POSE_DIR=${29}
export SPECFILE_DATA_POSE_DIR=${30}

#base_model_subdir migth be not defined so /ND pattern needs to be removed
BASE_MODEL_DIR=`echo ${BASE_MODEL_DIR} | sed -e 's%/ND%%g'`
BASE_MODEL_DIR="${BASE_MODEL_DIR}/pretrained_model/bodyposenet_vtrainable_v1.0" # added 

mkdir -p $TRAINED_MODEL_DIR/$MODEL_SUBFOLDER
mkdir -p $UPDATED_TRAIN_SPECs_DIR

ls -l $DOWNLOADED_DATA_DIR
# ls -l $VALIDATION_DATA_DIR
ls -l $BASE_MODEL_DIR
ls -l $SPECFILE_MODEL_POSE_DIR
ls -l $SPECFILE_DATA_POSE_DIR
ls -l ${DATA_DIR}/${RELATIVE_TRAIN_MASK_DIRECTORY}
ls -l ${DATA_DIR}/${RELATIVE_VAL_MASK_DIRECTORY}

# TODO: change me to copying all the images
echo "Copying input downloaded data to generic data directory"
cp $DOWNLOADED_DATA_DIR/train2017/000000362944.jpg $DATA_DIR/train2017
cp $DOWNLOADED_DATA_DIR/train2017/000000362278.jpg $DATA_DIR/train2017
cp -r $DOWNLOADED_DATA_DIR/annotations $DATA_DIR

mv $DATA_DIR/$RELATIVE_TRAIN_MASK_DIRECTORY/train-fold-000-of-001 $DATA_DIR
# do this for val as well if successful

ls -l $DATA_DIR

bash ./update_train_specs.sh ${ORIGINAL_TRAIN_SPECs_DIR} ${UPDATED_TRAIN_SPECs_DIR} ${SPEC_FILE} 'num_epochs: [0-9]\+'%'num_epochs: '${NUM_EPOCHS},${SPECFILE_REFERENCE_ROOT_DATA_DIR}%${DATA_DIR},${SPECFILE_REFERENCE_TRAINING_TF_RECORDS_DIR}%${DATA_DIR},${SPECFILE_REFERENCE_MODEL_DIR}%${BASE_MODEL_DIR}/${MODEL_NAME},${SPECFILE_MODEL_POSE_DIR}%${ORIGINAL_SPECs_DIR}/model_pose_config/bpnet_18joints.json,${SPECFILE_DATA_POSE_DIR}%${ORIGINAL_SPECs_DIR}/data_pose_config/coco_spec.json

bash ./tao_bpnet_train.sh ${UPDATED_TRAIN_SPECs_DIR} ${SPEC_FILE} ${TRAINED_MODEL_DIR} ${MODEL_SUBFOLDER} ${NUM_GPUS} ${KEY} ${GPU_INDEX} ${USE_AMP} 
# TODO -- probably want to log not logging for now ${LOG_FILE}

if [[ "${LOG_FILE}" != "ND" ]]
then 
    LOG_FILE=$TRAINED_MODEL_DIR/$LOG_FILE
    python3 ./parse_info.py --logfile=$LOG_FILE --class_list=$CLASS_LIST --num_epochs=$NUM_EPOCHS
fi