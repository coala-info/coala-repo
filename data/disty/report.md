# disty CWL Generation Report

## disty

### Tool Description
compute a distance matrix from a core genome alignment file

### Metadata
- **Docker Image**: quay.io/biocontainers/disty:0.1.0--1
- **Homepage**: https://github.com/c2-d2/disty
- **Package**: https://anaconda.org/channels/bioconda/packages/disty/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/disty/overview
- **Total Downloads**: 8.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/c2-d2/disty
- **Stars**: N/A
### Original Help Text
```text
Program: Disty McMatrixface - compute a distance matrix from a core genome alignment file
Version: 0.1.0
Contact: Karel Brinda <kbrinda@hsph.harvard.edu>

Usage:   disty <alignment.fa>

Options:
  -n  FLOAT  skip columns having frequency of N > FLOAT [1.00]
  -i  INT    input format [0]
                 0: ACGT
                 1: 01
  -s  INT    strategy to deal with N's [0]
                 0: ignore pairwisely
                 1: ignore pairwisely and normalize
                 2: ignore globally
                 3: replace by the major allele
                 4: replace by the closest individual (not implemented yet)
  -h         print help message and exit
  -v         print version and exit
```

