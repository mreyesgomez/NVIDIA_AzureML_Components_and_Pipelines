set -x

# map the output data location to the directory name used by the script

export URL_IMAGES=$1
export URL_LABELS=$2
export IMAGES_CHECKSUM=$3
export LABELS_CHECKSUM=$4
export LOCAL_PROJECT_DIR=$5
export LOCAL_DATA_DIR=$LOCAL_PROJECT_DIR"/data"

bash download_data.sh $LOCAL_DATA_DIR "IMAGES" $URL_IMAGES $IMAGES_CHECKSUM
bash download_data.sh $LOCAL_DATA_DIR "LABELS" $URL_LABELS $LABELS_CHECKSUM