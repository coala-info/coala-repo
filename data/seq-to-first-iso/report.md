# seq-to-first-iso CWL Generation Report

## seq-to-first-iso

### Tool Description
Read a tsv file with sequences and charges and compute intensity of first isotopologues

### Metadata
- **Docker Image**: quay.io/biocontainers/seq-to-first-iso:1.1.0--py_0
- **Homepage**: https://github.com/pierrepo/seq-to-first-iso
- **Package**: https://anaconda.org/channels/bioconda/packages/seq-to-first-iso/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/seq-to-first-iso/overview
- **Total Downloads**: 11.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/pierrepo/seq-to-first-iso
- **Stars**: N/A
### Original Help Text
```text
usage: seq-to-first-iso [-h] [-o OUTPUT] [-u amino_a] [-v]
                        input_file_name sequence_col_name charge_col_name

Read a tsv file with sequences and charges and compute intensity of first
isotopologues

positional arguments:
  input_file_name       file to parse in .tsv format
  sequence_col_name     column name with sequences
  charge_col_name       column name with charges

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        name of output file
  -u amino_a, --unlabelled-aa amino_a
                        amino acids with default abundance
  -v, --version         show program's version number and exit
```

