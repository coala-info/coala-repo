# gamma CWL Generation Report

## gamma_GAMMA.py

### Tool Description
This scripts makes annotated gene calls from matches in an assembly using a gene database

### Metadata
- **Docker Image**: quay.io/biocontainers/gamma:2.2--hdfd78af_1
- **Homepage**: https://github.com/rastanton/GAMMA
- **Package**: https://anaconda.org/channels/bioconda/packages/gamma/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gamma/overview
- **Total Downloads**: 11.3K
- **Last updated**: 2025-09-18
- **GitHub**: https://github.com/rastanton/GAMMA
- **Stars**: N/A
### Original Help Text
```text
usage: GAMMA.py [-h] [-a] [-e] [-f] [-g] [-n] [-l] [-i PERCENT_IDENTITY]
                input_fasta database output

This scripts makes annotated gene calls from matches in an assembly using a
gene database

positional arguments:
  input_fasta           input fasta
  database              input database
  output                output name

options:
  -h, --help            show this help message and exit
  -a, --all             include all gene matches, even overlaps
  -e, --extended        writes out all protein mutations
  -f, --fasta           write fasta of gene matches
  -g, --gff             write gene matches as gff file
  -n, --name            writes name in front of each gene match line
  -l, --headless        removes the header from the output gamma file
  -i, --percent_identity PERCENT_IDENTITY
                        minimum nucleotide identity for blat search (default =
                        90)
```

