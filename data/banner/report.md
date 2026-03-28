# banner CWL Generation Report

## banner_train

### Tool Description
Train takes a banner-matrix file from hulk and uses it to train a Random Forest Classifier

### Metadata
- **Docker Image**: quay.io/biocontainers/banner:0.0.2--py_0
- **Homepage**: https://www.github.com/will-rowe/banner
- **Package**: https://anaconda.org/channels/bioconda/packages/banner/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/banner/overview
- **Total Downloads**: 6.0K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
##########
# BANNER #
##########
subcommand: train
usage: banner [-h] -m MATRIX [-o OUTFILE] [-p PROCESSORS] [-e ESTIMATORS]

Train takes a banner-matrix file from hulk and uses it to train a Random
Forest Classifier

optional arguments:
  -h, --help            show this help message and exit
  -m MATRIX, --matrix MATRIX
                        The matrix from hulk smash
  -o OUTFILE, --outFile OUTFILE
                        Where to write the model to
  -p PROCESSORS, --processors PROCESSORS
                        Number of processors to use for training
  -e ESTIMATORS, --estimators ESTIMATORS
                        Number of estimators to use for training
```


## banner_predict

### Tool Description
Collects sketches from STDIN and classifies them using a RFC

### Metadata
- **Docker Image**: quay.io/biocontainers/banner:0.0.2--py_0
- **Homepage**: https://www.github.com/will-rowe/banner
- **Package**: https://anaconda.org/channels/bioconda/packages/banner/overview
- **Validation**: PASS

### Original Help Text
```text
##########
# BANNER #
##########
subcommand: predict
usage: banner [-h] -m MODEL [-p PROBABILITY] [-v]

Predict collects sketches from STDIN and classifies them using a RFC

optional arguments:
  -h, --help            show this help message and exit
  -m MODEL, --model MODEL
                        The model that banner trained
  -p PROBABILITY, --probability PROBABILITY
                        The probability threshold for reporting
                        classifications
  -v, --verbose         Print all predictions and probability, even if
                        threshold not met yet
```


## Metadata
- **Skill**: generated
