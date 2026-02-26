# mp-est CWL Generation Report

## mp-est_mpest

### Tool Description
Maximum Pseudo-likelihood Estimation of Species Trees - MPEST

### Metadata
- **Docker Image**: quay.io/biocontainers/mp-est:3.1.0--h7b50bb2_0
- **Homepage**: https://github.com/lliu1871/mp-est
- **Package**: https://anaconda.org/channels/bioconda/packages/mp-est/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mp-est/overview
- **Total Downloads**: 3.2K
- **Last updated**: 2025-10-31
- **GitHub**: https://github.com/lliu1871/mp-est
- **Stars**: N/A
### Original Help Text
```text
Maximum Pseudo-likelihood Estimation of Species Trees - MPEST
Version 3.0
(c) Copyright, 2014-2024 Liang Liu
Department of Statistics, University of Georgia

Usage: mpest [-i inputfile] [-n #] [-s #] [-u NAME] [-h] [-B|-C|-L|-N|-P|-Q|-T|]
  -i: NAME = name of input file in nexus format. Input gene trees must be rooted; polytomy trees are allowed.
  -n: # = number of runs [default = 1].
  -s: # = seed for random number generator [default = system generated].
  -u: NAME = name of user tree file.
  -c: # = convert short branches (<#) to polytomies in gene trees.
  -h: help message [default = random].
  -B: optimize branch lengths of a fixed species tree provided through usertree option -u.
  -L: calculate loglikelihood of a species tree provided through usertree option -u.
  -N: build NJst tree.
  -P: calculate partitions for gene trees.
  -Q: calculate pairwise quartet distances among gene trees. Polytomy (unrooted or rooted) gene trees are allowed.
  -T: calculate pairwise triple distances of gene trees. Polytomy rooted gene trees are allowed.
```

