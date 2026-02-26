# fasta-splitter CWL Generation Report

## fasta-splitter

### Tool Description
Divide FASTA files into parts based on size, count, or number of parts.

### Metadata
- **Docker Image**: quay.io/biocontainers/fasta-splitter:0.2.6--0
- **Homepage**: http://kirill-kryukov.com/study/tools/fasta-splitter/
- **Package**: https://anaconda.org/channels/bioconda/packages/fasta-splitter/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fasta-splitter/overview
- **Total Downloads**: 9.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
fasta-splitter, version 0.2.6, 2017-08-01
Copyright (c) 2012-2017 Kirill Kryukov
Usage: fasta-splitter [options] <file>...
Options:
    --n-parts <N>        - Divide into <N> parts
    --part-size <N>      - Divide into parts of size <N>
    --measure (all|seq|count) - Specify whether all data, sequence length, or
                           number of sequences is used for determining part
                           sizes ('all' by default).
    --line-length        - Set output sequence line length, 0 for single line
                           (default: 60).
    --eol (dos|mac|unix) - Choose end-of-line character ('unix' by default).
    --part-num-prefix T  - Put T before part number in file names (def.: .part-)
    --out-dir            - Specify output directory.
    --nopad              - Don't pad part numbers with 0.
    --version            - Show version.
    --help               - Show help.
```

