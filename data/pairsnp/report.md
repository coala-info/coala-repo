# pairsnp CWL Generation Report

## pairsnp

### Tool Description
Fast pairwise SNP distance matrices

### Metadata
- **Docker Image**: quay.io/biocontainers/pairsnp:0.3.1--h077b44d_4
- **Homepage**: https://github.com/gtonkinhill/pairsnp
- **Package**: https://anaconda.org/channels/bioconda/packages/pairsnp/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pairsnp/overview
- **Total Downloads**: 12.6K
- **Last updated**: 2025-08-14
- **GitHub**: https://github.com/gtonkinhill/pairsnp
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
SYNOPSIS
  Fast pairwise SNP distance matrices
USAGE
  pairsnp [options] alignment.fasta[.gz] > matrix.csv
OPTIONS
  -h	Show this help
  -v	Print version and exit
  -s	Output in sparse matrix form (i,j,distance).
  -d	Distance threshold for sparse output. Only distances <= d will be returned.
  -k	Will on return the k nearest neighbours for each sample in sparse output.
  -c	Output CSV instead of TSV
  -i	Output sequence index inplace of header (useful for downstream processing)
  -t	Number of threads to use (default=1)
```


## Metadata
- **Skill**: generated
