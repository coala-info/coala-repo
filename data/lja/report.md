# lja CWL Generation Report

## lja

### Tool Description
genome assembler for PacBio HiFi reads based on de Bruijn graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/lja:0.2--h5b5514e_2
- **Homepage**: https://github.com/AntonBankevich/LJA
- **Package**: https://anaconda.org/channels/bioconda/packages/lja/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/lja/overview
- **Total Downloads**: 2.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/AntonBankevich/LJA
- **Stars**: N/A
### Original Help Text
```text
Failed to parse command line parameters.
output-dir missing

LJA: genome assembler for PacBio HiFi reads based on de Bruijn graph.
Usage: lja [options] -o <output-dir> --reads <reads_file> [--reads <reads_file2> ...]

Basic options:
  -o <file_name> (or --output-dir <file_name>)  Name of output folder. Resulting graph will be stored there.
  --reads <file_name>                           Name of file that contains reads in fasta or fastq format. This option can be used any number of times in the same command line. In this case reads from all specified files will be used as an input.
  -h (or --help)                                Print this help message.

Advanced options:
  -t <int> (or --threads <int>)                 Number of threads. The default value is 16.
  -k <int>                                      Value of k used for initial error correction.
  -K <int>                                      Value of k used for final error correction and initialization of multiDBG.
  --diploid                                     Use this option for diploid genomes. By default LJA assumes that the genome is haploid or inbred.
```

