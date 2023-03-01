#!/bin/bash

set -eu
set -o pipefail

LEAMR_HOME=''

export STANZA_RESOURCES_DIR=leamr_stanza_resources

echo -e "\nRunning LEAMR\n"

INPUT=$(readlink -m $1)
echo "Input file: $INPUT"

#for filename in ./outputs/*.stanza.prp; do
#echo " preprocessing INPUT"
python nlp_data.py $INPUT

#echo " aligning INPUT"
python align_with_pretrained_model.py -t $INPUT --subgraph-model ldc+little_prince.subgraph_params.pkl --relation-model ldc+little_prince.relation_params.pkl --reentrancy-model ldc+little_prince.reentrancy_params.pkl
#done
