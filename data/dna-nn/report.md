# dna-nn CWL Generation Report

## dna-nn_dna-brnn

### Tool Description
Reads a sequence file and performs training or prediction using a recurrent neural network.

### Metadata
- **Docker Image**: quay.io/biocontainers/dna-nn:0.1--h077b44d_3
- **Homepage**: https://github.com/lh3/dna-nn
- **Package**: https://anaconda.org/channels/bioconda/packages/dna-nn/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dna-nn/overview
- **Total Downloads**: 1.9K
- **Last updated**: 2025-07-17
- **GitHub**: https://github.com/lh3/dna-nn
- **Stars**: N/A
### Original Help Text
```text
Usage: dna-brnn [options] <seq.fq>
Options:
  General:
    -i FILE    read a trained model from FILE []
    -o FILE    write model to FILE []
    -u INT     window length [150]
    -B INT     mini-batch size [256]
    -t INT     number of threads [1]
  Model construction:
    -l INT     number of GRU layers [1]
    -n INT     number of hidden neurons [32]
    -d FLOAT   dropout rate [0.25]
    -w FLOAT   weight on false positive errors [0]
  Training:
    -r FLOAT   learning rate [0.001]
    -m INT     number of epochs [25]
    -b INT     number of bases to train per epoch [10000000]
    -s INT     PRNG seed [11]
  Prediction:
    -A         predict using a trained model (req. -i)
    -E         predict and evaluate a trained model (req. -i)
    -O INT     segment overlap length [50]
    -L INT     min signal len (0 to disable) [50]
    -X INT     X-drop len (0 to disable) [50]
```


## dna-nn_gen-fq

### Tool Description
Generate FASTQ from FASTA and BED files.

### Metadata
- **Docker Image**: quay.io/biocontainers/dna-nn:0.1--h077b44d_3
- **Homepage**: https://github.com/lh3/dna-nn
- **Package**: https://anaconda.org/channels/bioconda/packages/dna-nn/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gen-fq [-m maxLbl] <in.fa> <in.bed>
```

