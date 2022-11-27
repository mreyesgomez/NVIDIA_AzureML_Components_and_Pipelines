#!/bin/bash

if [ "$#" -ne 4 ]; then
    echo "infer.sh requires 4 arguments"
exit 2
fi

endpoint=$1
key=$2
input=$3
output=$4

cd tao-toolkit-triton-apps
python3 -m venv virtualenv
source virtualenv/bin/activate
export PYTHONPATH=$(pwd)/tao_triton:${PYTHONPATH}
python tao_triton/python/entrypoints/tao_client_aml.py $3 -m detectnet_tao -x 1 -b 8 --mode DetectNet_v2 --class_list car,cyclist,pedestrian -i https -u $1 -t $2 --async --output_path $4 --postprocessing_config tao_triton/python/clustering_specs/clustering_config_detectnet.prototxt 