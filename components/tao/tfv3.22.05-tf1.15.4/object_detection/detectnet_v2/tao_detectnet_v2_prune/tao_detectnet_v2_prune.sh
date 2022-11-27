set -x

# map the output data location to the directory name used by the script

export UNPRUNED_MODEL_DIR=$1/detectnet_v2
export UNPRUNNED_MODEL_SUBFOLDER=$2
export UNPRUNNED_MODEL_NAME=$3
export PRUNNED_MODEL_SUBFOLDER=$4
export PRUNNED_MODEL_NAME=$5
export KEY=$6
export PRUNED_MODEL_DIR=$7/detectnet_v2
export EQUALIZATION_CRITERION=${8}
export PTH=${9}
export NORMALIZER=${10}
export EXCLUDED_LAYERS=${11} 
export PRUNING_GRANULARITY=${12}
export MIN_NUM_FILTERS=${13} 

mkdir ${PRUNED_MODEL_DIR}
mkdir ${PRUNED_MODEL_DIR}/experiment_dir_pruned

ADDITIONAL_ARGS=""

if [[ "${EQUALIZATION_CRITERION}" != "ND" ]]
then
    ADDITIONAL_ARGS="$ADDITIONAL_ARGS -eq ${EQUALIZATION_CRITERION}"
fi

if [[ "${PTH}" != "ND" ]]
then
    ADDITIONAL_ARGS="$ADDITIONAL_ARGS -pth ${PTH}"
fi

if [[ "${NORMALIZER}" != "ND" ]]
then
    ADDITIONAL_ARGS="$ADDITIONAL_ARGS -n ${NORMALIZER}"
fi

if [[ "${EXCLUDED_LAYERS}" != "ND" ]]
then
    ADDITIONAL_ARGS="$ADDITIONAL_ARGS -el ${EXCLUDED_LAYERS}"
fi

if [[ "${PRUNING_GRANULARITY}" != "ND" ]]
then
    ADDITIONAL_ARGS="$ADDITIONAL_ARGS -pg ${PRUNING_GRANULARITY}"
fi

if [[ "${MIN_NUM_FILTERS}" != "ND" ]]
then
    MIN_NUM_FILTERS="$ADDITIONAL_ARGS -nf ${MIN_NUM_FILTERS}"
fi


detectnet_v2 prune -m ${UNPRUNED_MODEL_DIR}/${UNPRUNNED_MODEL_SUBFOLDER}/weights/${UNPRUNNED_MODEL_NAME}.tlt -o ${PRUNED_MODEL_DIR}/${PRUNNED_MODEL_SUBFOLDER}/${PRUNNED_MODEL_NAME}.tlt $ADDITIONAL_ARGS -k $KEY

ls -rlt ${PRUNED_MODEL_DIR}/experiment_dir_pruned/







