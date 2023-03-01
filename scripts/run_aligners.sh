#!/bin/bash
# see https://github.com/IBM/transition-amr-parser/blob/structured-mbart/preprocess/align.sh

# install each aligner separately and before running this script
set -eu
set -o pipefail

INPUT=$(readlink -m $1)
echo "Input file: $INPUT"

BASEDIR=$(dirname $0)
echo "Base Dir: $BASEDIR"
cd $BASEDIR

if [[ "$VIRTUAL_ENV" != "" ]]
then
  source deactivate
fi

python3 -V

echo -e "\n1. Running JAMR Aligner\n"
./jamr_align.sh $INPUT

echo " running jamr2isi"
python3 ./jamr2isi.py $INPUT.jamr

echo -e "\n2. Running ISI Aligner\n"
./isi_align.sh $INPUT.amrs $INPUT.sents $INPUT.isi

echo " cleaning isi"
python3 ./clean_isi.py $INPUT.isi $INPUT.bad_amrs

echo -e "\n3. Post-proessing\n"
./run_jtok.sh $INPUT.isi $INPUT.jamr

mv $INPUT.isi.mrged $INPUT.mrged
rm 1 2 3 4 5 6 7 8 9

echo " cleaning $INPUT.mrged"
python3 clean.py $INPUT.mrged

echo -e "\n3. Running LEAMR Aligner\n"
./leamr_align.sh $INPUT.mrged

cd -
