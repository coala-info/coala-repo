# tssv CWL Generation Report

## tssv

### Tool Description
Targeted characterisation of short structural variation.

### Metadata
- **Docker Image**: quay.io/biocontainers/tssv:1.1.2--py312h0fa9677_6
- **Homepage**: The package home page
- **Package**: https://anaconda.org/channels/bioconda/packages/tssv/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tssv/overview
- **Total Downloads**: 13.9K
- **Last updated**: 2025-06-24
- **GitHub**: https://github.com/jfjlaros/tssv
- **Stars**: N/A
### Original Help Text
```text
usage: tssv [-h] [-m THRESHOLD] [-M MISMATCHES] [-n INDEL_SCORE]
            [-r REPORT_HANDLE] [-j] [-d PATH] [-a MINIMUM] [-v]
            INPUT LIBRARY

Targeted characterisation of short structural variation.

positional arguments:
  INPUT             a FASTA/FASTQ file
  LIBRARY           library of flanking sequences

options:
  -h, --help        show this help message and exit
  -m THRESHOLD      mismatches per nucleotide (default=0.08)
  -M MISMATCHES     fixed number of mismatches, overrides -m (default=None)
  -n INDEL_SCORE    insertions and deletions are penalised this number of
                    times more heavily than mismatches (default=1)
  -r REPORT_HANDLE  name of the report file
  -j                use json format for the output file
  -d PATH           output directory
  -a MINIMUM        minimum count per allele (default=0)
  -v                show program's version number and exit

Copyright (c) Jeroen F.J. Laros <J.F.J.Laros@lumc.nl>
```

