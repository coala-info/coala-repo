# dajin2 CWL Generation Report

## dajin2_DAJIN2

### Tool Description
DAJIN2 batch mode or DAJIN2 GUI mode

### Metadata
- **Docker Image**: quay.io/biocontainers/dajin2:0.8.0--pyhdfd78af_0
- **Homepage**: https://github.com/akikuno/DAJIN2
- **Package**: https://anaconda.org/channels/bioconda/packages/dajin2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dajin2/overview
- **Total Downloads**: 21.9K
- **Last updated**: 2026-01-31
- **GitHub**: https://github.com/akikuno/DAJIN2
- **Stars**: N/A
### Original Help Text
```text
usage: DAJIN2 [-h] [-s SAMPLE] [-c CONTROL] [-a ALLELE] [-n NAME] [-g GENOME]
              [-b GENOME_COORDINATE] [-t THREADS] [--no-filter] [-v]
              {batch,gui} ...

positional arguments:
  {batch,gui}
    batch               DAIJN2 batch mode
    gui                 DAIJN2 GUI mode

options:
  -h, --help            show this help message and exit
  -s SAMPLE, --sample SAMPLE
                        Path to a sample directory including FASTQ file
  -c CONTROL, --control CONTROL
                        Path to a control directory including FASTQ file
  -a ALLELE, --allele ALLELE
                        Path to a FASTA file
  -n NAME, --name NAME  Output directory name
  -g GENOME, --genome GENOME
                        Reference genome ID (e.g hg38, mm39) [default: '']
  -b GENOME_COORDINATE, --bed GENOME_COORDINATE
                        Path to BED6 file containing genomic coordinates
                        [default: '']
  -t THREADS, --threads THREADS
                        Number of threads [default: 1]
  --no-filter           Disable minor allele filtering (keep alleles <0.5%)
  -v, --version         show program's version number and exit
```

