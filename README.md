# Aligners 
Nov 20, 2022

## 1. Setup

### A. JAMR
* java version: 1.8.0_352
  * installed with eclipse temurin
* sbt version: 1.0.2
  * should be reflected in `project/build.properties`
  * installed with SDKMAN!
* scala version: 2.11.12
  * should be reflected in `build.sbt` and `scripts/config.sh`
  * installed with SDKMAN!
* see modified `project/plugins.sbt`
  * see references below
* see `jamr_post_setup.sh` which fixes outdated perl expression
* references:
  1. https://github.com/jflanigan/jamr/issues/44
  2. https://github.com/DreamerDeo/JAMR

### B. ISI
* requires python2
  * `python2-env` virtualenv within ISI dir by default; or set up new one separately
* `mgizapp` requires Boost c++ libraries
  * `sudo apt-get install libboost-all-dev`
* running `scripts/jamr2isi.py` on JAMR output prepares input data in required format

### C. LEAMR
* requires python3
  * pyenv virtualenv by default; or set up new one separately
* relies on Stanza and spaCy whose version may be different from what model uses
  * set up Stanza with `STANZA_RESOURCES_DIR=./leamr/leamr_stanza_resources python -c "import stanza; stanza.download('en')"`
* also need to set up `neuralmonkey` separately
* contains minor modifications
  * don't drop `.txt` in the outputs filename
  * use pre-tokenized outputs, assuming the input is a product of CAMR-style pre-processing

## 2. Run
to run all 3 aligners
```shell

./scripts/run_aligners.sh [input_file]

```

to run only one aligner

### A. JAMR
```shell
./scripts/jamr_align.sh [input_file]
```
### B. ISI
```shell
./scripts/isi_align.sh [input_file]
```
### C. LEAMR
```shell
./scripts/leamr_align.sh [input_file]
```
