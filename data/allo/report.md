# allo CWL Generation Report

## allo

### Tool Description
Allo is a software that allocates multi-mapped reads in gene regulatory data.

### Metadata
- **Docker Image**: quay.io/biocontainers/allo:1.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/seqcode/allo
- **Package**: https://anaconda.org/channels/bioconda/packages/allo/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/allo/overview
- **Total Downloads**: 4.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/seqcode/allo
- **Stars**: 24
### Original Help Text
```text
usage: allo [-h] [-v] -seq {pe,se} [-o OUTFILE] [--mixed] [--dnase] [--atac]
            [--splice] [-p PROCESSES] [-max MAXLOCATIONS] [--keep-unmap]
            [--remove-zeros] [--r2] [--readcount] [--random] [--ignore]
            [--parser]
            input

(Version 1.2.0) Allo is a software that allocates multi-mapped reads in gene
regulatory data. Developed by Mahony Laboratory @ The Pennsylvania State
University

positional arguments:
  input

options:
  -h, --help         show this help message and exit
  -v, --version      show program's version number and exit
  -seq {pe,se}       Single-end or paired-end sequencing mode
  -o OUTFILE         Output file name
  --mixed            Use CNN trained on a dataset with mixed ChIP-seq peaks,
                     narrow by default
  --dnase            Use CNN trained on a DNase-seq datasets
  --atac             Use CNN trained on a ATAC-seq datasets
  --splice           Remove splice sites based on cigar string when
                     constructing image
  -p PROCESSES       Number of processes, 1 by default
  -max MAXLOCATIONS  Maximum value for number of locations a read can map
  --keep-unmap       Keep unmapped reads and reads that include N in their
                     sequence
  --remove-zeros     Disregard multi-mapped reads that map to regions with 0
                     uniquely mapped reads (random assignment)
  --r2               Use read 2 for allocation procedure instead of read 1
                     (only for paired-end sequencing)
  --readcount        CNN will not be used in allocation, only read counts
  --random           Reads will be randomly assigned (similar to Bowtie and
                     BWA on default)
  --ignore           Ignore warnings about read sorting
  --parser           Parse alignment files to extract uniquely and multi-
                     mapped reads

For more pre-processing info and basic usage, please visit
https://github.com/seqcode/allo
```

