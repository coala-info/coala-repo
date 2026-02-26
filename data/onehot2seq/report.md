# onehot2seq CWL Generation Report

## onehot2seq

### Tool Description
Converts one-hot encoded sequences to biological sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/onehot2seq:0.0.2--pyh086e186_1
- **Homepage**: https://github.com/akikuno/onehot2seq
- **Package**: https://anaconda.org/channels/bioconda/packages/onehot2seq/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/onehot2seq/overview
- **Total Downloads**: 3.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/akikuno/onehot2seq
- **Stars**: N/A
### Original Help Text
```text
usage: onehot2seq [-h] -i INPUT -o OUTPUT -t <dna/rna/protein> [-a]
                  [-f {txt,fasta}] [-v]

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Numpy npy file
  -o OUTPUT, --output OUTPUT
                        FASTA or text file
  -t <dna/rna/protein>, --type <dna/rna/protein>
                        Sequence type (DNA/RNA/Protein)
  -a, --ambiguous       Accept ambiguous characters
  -f {txt,fasta}, --format {txt,fasta}
                        FASTA or text file (defalt:txt)
  -v, --version         show program's version number and exit
```

