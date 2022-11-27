set -x

# map the output data location to the directory name used by the script

export SOURCE_FILE=$1/config.sh

source $SOURCE_FILE

bash ./build_container.sh
bash ./push_container_to_ACR.sh