#!/bin/bash

set -eu
set -o pipefail

echo -e "\nRunning LEAMR\n"

INPUT=$(readlink -m $1)
echo "Input file: $INPUT"

BASEDIR=$(readlink -m $(dirname $0))
LEAMR_HOME=$(dirname $BASEDIR)/leamr
echo "LEAMR HOME: $LEAMR_HOME"
cd $LEAMR_HOME

export STANZA_RESOURCES_DIR=$LEAMR_HOME/leamr_stanza_resources

venv=leamr
echo -e "\nPyenv VENV: $venv"
#. $HOME/.pyenv/versions/3.7.17/envs/leamr/bin/activate
. $PYENV_ROOT/versions/$venv/bin/activate
python3 -V

python nlp_data.py $INPUT

#echo " aligning INPUT"
python align_with_pretrained_model.py -t $INPUT \
  --subgraph-model ldc+little_prince.subgraph_params.pkl \
  --relation-model ldc+little_prince.relation_params.pkl \
  --reentrancy-model ldc+little_prince.reentrancy_params.pkl

cd -
