# deepsig CWL Generation Report

## deepsig

### Tool Description
Predictor of signal peptides in proteins

### Metadata
- **Docker Image**: quay.io/biocontainers/deepsig:1.2.5--pyhca03a8a_1
- **Homepage**: https://github.com/BolognaBiocomp/deepsig
- **Package**: https://anaconda.org/channels/bioconda/packages/deepsig/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepsig/overview
- **Total Downloads**: 11.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/BolognaBiocomp/deepsig
- **Stars**: N/A
### Original Help Text
```text
usage: deepsig [-h] -f FASTA -o OUTF -k {euk,gramp,gramn} [-m {json,gff3}]
               [-t THREADS] [--version]

DeepSig: Predictor of signal peptides in proteins

optional arguments:
  -h, --help            show this help message and exit
  -f FASTA, --fasta FASTA
                        The input multi-FASTA file name
  -o OUTF, --outf OUTF  The output file
  -k {euk,gramp,gramn}, --organism {euk,gramp,gramn}
                        The organism the sequences belongs to
  -m {json,gff3}, --outfmt {json,gff3}
                        The output format: json or gff3 (default)
  -t THREADS, --threads THREADS
                        Number of threads to use (default = number of
                        available CPUs)
  --version             show program's version number and exit
```

