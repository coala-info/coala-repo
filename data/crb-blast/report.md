# crb-blast CWL Generation Report

## crb-blast

### Tool Description
Conditional Reciprocal Best BLAST

### Metadata
- **Docker Image**: quay.io/biocontainers/crb-blast:0.6.9--hdfd78af_0
- **Homepage**: https://github.com/cboursnell/crb-blast
- **Package**: https://anaconda.org/channels/bioconda/packages/crb-blast/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/crb-blast/overview
- **Total Downloads**: 9.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/cboursnell/crb-blast
- **Stars**: N/A
### Original Help Text
```text
CRB-Blast v0.6.9 by Chris Boursnell <cmb211@cam.ac.uk>

Conditional Reciprocal Best BLAST

USAGE:
crb-blast <options>

OPTIONS:
  -q, --query=<s>      query fasta file
  -t, --target=<s>     target fasta file
  -e, --evalue=<f>     e-value cut off for BLAST. Format 1e-5 (default:
                       1.0e-05)
  -h, --threads=<i>    number of threads to run BLAST with (default: 1)
  -o, --output=<s>     output file as tsv
  -s, --split          split the fasta files into chunks and run multiple blast
                       jobs and then combine them.
  -v, --verbose        be verbose
  -r, --version        Print version and exit
  -l, --help           Show this message
```

