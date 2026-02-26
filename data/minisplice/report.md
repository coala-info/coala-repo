# minisplice CWL Generation Report

## minisplice_gentrain

### Tool Description
Generate training data for minisplice

### Metadata
- **Docker Image**: quay.io/biocontainers/minisplice:0.4--h577a1d6_0
- **Homepage**: https://github.com/lh3/minisplice
- **Package**: https://anaconda.org/channels/bioconda/packages/minisplice/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/minisplice/overview
- **Total Downloads**: 299
- **Last updated**: 2025-07-17
- **GitHub**: https://github.com/lh3/minisplice
- **Stars**: N/A
### Original Help Text
```text
Usage: minisplice gentrain [options] <in.bed> <in.fastx>
Options:
  -l INT       length of flanking sequences [100]
  -p FLOAT     fraction of positive sites [0.25]
```


## minisplice_train

### Tool Description
Train a model for minisplice

### Metadata
- **Docker Image**: quay.io/biocontainers/minisplice:0.4--h577a1d6_0
- **Homepage**: https://github.com/lh3/minisplice
- **Package**: https://anaconda.org/channels/bioconda/packages/minisplice/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: minisplice train [options] <in.data>
Options:
  Model construction:
    -k INT     1D-CNN kernel size [5]
    -f INT     number of features per 1D-CNN layer [16]
    -F INT     number of neurons in the dense layer [16]
    -d FLOAT   dropout rate (use for large models) [0]
  Model training:
    -r FLOAT   learning rate [0.001]
    -e INT     min number of epoches [3]
    -E INT     max number of epoches [100]
    -m INT     minibatch size [64]
    -s INT     random seed [11]
    -t INT     number of threads [1]
  Model I/O:
    -i FILE    input model []
    -o FILE    output model []
Input format:
  Two columns: integer label, and fixed-length sequence
  Or gentrain output
```


## minisplice_predict

### Tool Description
Predict splice sites

### Metadata
- **Docker Image**: quay.io/biocontainers/minisplice:0.4--h577a1d6_0
- **Homepage**: https://github.com/lh3/minisplice
- **Package**: https://anaconda.org/channels/bioconda/packages/minisplice/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: minisplice predict [options] <in.kan> <in.fastx>|<train.txt>
Options:
  General:
    -t INT      number of threads [1]
    -m INT      minibatch size [128]
    -d          donor only
    -a          acceptor only
    -E          print calibration data
  Prediction:
    -c FILE     calibration data []
    -l INT      min score [-6]
    -h INT      max score [13]
    -p          print values at the last max1d layer
  Calibration:
    -b FILE     annotated splice sites in BED12 []
    -s FLOAT    score bin size [0.02]
    -r          input formatted as training data
```

