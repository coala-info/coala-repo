# prophasm CWL Generation Report

## prophasm

### Tool Description
a greedy assembler for k-mer set compression

### Metadata
- **Docker Image**: quay.io/biocontainers/prophasm:0.1.1--h077b44d_5
- **Homepage**: https://github.com/prophyle/prophasm
- **Package**: https://anaconda.org/channels/bioconda/packages/prophasm/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/prophasm/overview
- **Total Downloads**: 11.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/prophyle/prophasm
- **Stars**: N/A
### Original Help Text
```text
Program:  prophasm (a greedy assembler for k-mer set compression)
Version:  0.1.1
Contact:  Karel Brinda <kbrinda@hsph.harvard.edu>

Usage:    prophasm [options]

Examples: prophasm -k 15 -i f1.fa -i f2.fa -x fx.fa
             - compute intersection of f1 and f2
          prophasm -k 15 -i f1.fa -i f2.fa -x fx.fa -o g1.fa -o g2.fa
             - compute intersection of f1 and f2, and subtract it from them
          prophasm -k 15 -i f1.fa -o g1.fa
             - re-assemble f1 to g1

Command-line parameters:
 -k INT   K-mer size.
 -i FILE  Input FASTA file (can be used multiple times).
 -o FILE  Output FASTA file (if used, must be used as many times as -i).
 -x FILE  Compute intersection, subtract it, save it.
 -s FILE  Output file with k-mer statistics.
 -S       Silent mode.

Note that '-' can be used for standard input/output.
```

