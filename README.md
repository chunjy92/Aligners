# Aligners 
Nov 20, 2022
* UPDATE: March 2024

## 1. Setup

### A. JAMR
* java version: 1.8.0_392
  * installed with eclipse temurin (via sdkman)
* sbt version: 1.0.2
  * should be reflected in `project/build.properties`
  * installed with SDKMAN!
* scala version: 2.11.12
  * should be reflected in `build.sbt` and `scripts/config.sh`
  * installed with SDKMAN!
* see modified `project/plugins.sbt`
  * see references below
* make executables
  * `chmod +x setup compile sbt scripts/config.sh`
* run `sbt` first! (not `./sbt` but just `sbt`)
  * `setup`, etc scripts
* see `jamr_post_setup.sh` which fixes outdated perl expression
* references:
  1. https://github.com/jflanigan/jamr/issues/44
  2. https://github.com/DreamerDeo/JAMR

### B. ISI
* requires python2
  *  `pip2 install virtualenv` then `python2 -m virtualenv python2-env`
  * `python2-env` virtualenv within ISI dir by default; or set up new one separately
* `mgizapp` requires Boost c++ libraries
  * `sudo apt-get install libboost-all-dev`
* read instructions in `INSTALL` inside `mgizapp`
* running `scripts/jamr2isi.py` on JAMR output prepares input data in required format

### C. LEAMR
* requires python3 (3.7.3 or 3.7.6 on ubuntu 22.04) -> UPDATE: 3.7.17 seems fine, or rather required, with spacy==2.3.7
  * pyenv virtualenv by default; or set up new one separately
* relies on Stanza and spaCy whose version may be different from what model uses
  * set up Stanza with `STANZA_RESOURCES_DIR=./leamr/leamr_stanza_resources python -c "import stanza; stanza.download('en')"`
* also need to set up `neuralmonkey` separately
  * `pip install cython==0.29 --upgrade`
* don't forget `python -m spacy download en`
* for torch, `1.13.1+cu117` seems fine
* contains minor modifications
  * doesn't drop `.txt` in the outputs filename
  * uses pre-tokenized outputs

## 2. Run

May have to set `pyenv global` to Python2 + Python3, i.e.
```shell
pyenv global 2.7.15
```
* since Python3 are usually pre-installed, this exposes python2 and python3.

In order to run all 3 aligners in sequence (JAMR -> ISI -> LEAMR)
```shell

./scripts/run_aligners.sh [input_file]

```

Or, to run only a single aligner:
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
