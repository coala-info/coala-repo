# swalign CWL Generation Report

## swalign

### Tool Description
Simple Smith-Waterman aligner

### Metadata
- **Docker Image**: quay.io/biocontainers/swalign:0.3.7--pyhdfd78af_0
- **Homepage**: https://github.com/mbreese/swalign/
- **Package**: https://anaconda.org/channels/bioconda/packages/swalign/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/swalign/overview
- **Total Downloads**: 15.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mbreese/swalign
- **Stars**: N/A
### Original Help Text
```text
Simple Smith-Waterman aligner

Usage: swalign {options} ref query

Reference and query arguments can either be written on the command-line, read
from stdin, or read as FASTA format files. If there is more than one sequence
in the reference FASTA file, the query will be aligned to all reference
sequences and only the best scoring alignment will be displayed. If more than
one sequence is in a query FASTA file, each query sequence will be aligned to
the reference.

Alignments will be made in both forward and reverse directions.

Options:
  -m N              Match score (default: 2)
  -mm N             Mismatch penalty (default: 1)
  -gap N            Gap penalty (default: 1)
  -gapext N         Gap extension penalty (default: 1)
  -gapdecay N       Decay the gap extension penalty (default: 0.0)
  -wrap N           Wrap alignments when they are longer than N bases
  -global           Perform a global alignment (experimental)
  -query            Align the full query sequence (mix of local/global)
  -summary fname    Write a summary files of match locations (tab-delimited)
  -useregion        Use regions for coordinates if included in FASTA ref

Example:
    ~$ swalign AAGGGGAGGACGATGCGGATGTTC AGGGAGGACGATGCGG
```

