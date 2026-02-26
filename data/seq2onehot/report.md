# seq2onehot CWL Generation Report

## seq2onehot

### Tool Description
Convert biological sequences (DNA/RNA/Protein) from FASTA format to one-hot encoded NumPy arrays.

### Metadata
- **Docker Image**: quay.io/biocontainers/seq2onehot:0.0.1--pyhfa5458b_0
- **Homepage**: https://github.com/akikuno/seq2onehot
- **Package**: https://anaconda.org/channels/bioconda/packages/seq2onehot/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/seq2onehot/overview
- **Total Downloads**: 2.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/akikuno/seq2onehot
- **Stars**: N/A
### Original Help Text
```text
usage: seq2onehot [-h] -i <in.fasta> -o <out.npy> -t <dna/rna/protein> [-a]
                  [-v]

optional arguments:
  -h, --help            show this help message and exit
  -i <in.fasta>, --input <in.fasta>
                        FASTA or Sequence file
  -o <out.npy>, --output <out.npy>
                        Numpy .npy format
  -t <dna/rna/protein>, --type <dna/rna/protein>
                        Sequence type (DNA/RNA/Protein)
  -a, --ambiguous       Accept ambiguous characters
  -v, --version         show program's version number and exit
```

