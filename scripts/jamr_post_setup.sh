#!/bin/bash

# fix outdated perl expression
sed 's@\(.*tamil\)@#\1@' -i tools/cdec/corpus/support/quote-norm.pl
