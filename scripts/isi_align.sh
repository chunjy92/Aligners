#!/bin/bash

# from https://github.com/IBM/transition-amr-parser/blob/structured-mbart/preprocess/run_kevin_aligner.sh
set -o errexit
set -o pipefail
[ "$#" -lt 3 ] && echo "e.g. $0 amrs sents out" && exit 1

BASEDIR=$(readlink -m $(dirname $0))
ISI_HOME=$(dirname $BASEDIR)/isi
cd $ISI_HOME

echo "ISI Home: $ISI_HOME"

amrs=$1
sents=$2
outfile=$3
set -o nounset

## virtualenv
#. python2-env/bin/activate
venv=isi
echo -e "\nPyenv VENV: $venv"
. $PYENV_ROOT/versions/$venv/bin/activate
python -V

echo -e "AMR=$amrs\nENG=$sents\nMGIZA_SCRIPT=mgiza/mgizapp/scripts\nMGIZA_BIN=mgiza/mgizapp/bin\n" > addresses.keep
bash run.sh
cp AMR_Aligned.keep $outfile

source deactivate

cd -
