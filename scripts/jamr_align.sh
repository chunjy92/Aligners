#!/bin/bash

# from https://github.com/c-amr/camr/blob/master/scripts/jamr_align.sh
BASEDIR=$(readlink -m $(dirname $0))
JAMR_HOME=$(dirname $BASEDIR)/jamr

echo "JAMR Home: $JAMR_HOME"

#### Config ####
${JAMR_HOME}/scripts/config.sh

#### Align the tokenized amr file ####

#echo "### Aligning $1 ###"
# input should be tokenized AMR file, which has :tok tag in the comments
${JAMR_HOME}/run Aligner -v 0 --print-nodes-and-edges < $1 > $1.jamr
