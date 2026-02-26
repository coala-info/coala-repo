# circulocov CWL Generation Report

## circulocov

### Tool Description
Calculate coverage for circular genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/circulocov:0.1.20240104--pyhdfd78af_0
- **Homepage**: https://github.com/erinyoung/CirculoCov
- **Package**: https://anaconda.org/channels/bioconda/packages/circulocov/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/circulocov/overview
- **Total Downloads**: 1.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/erinyoung/CirculoCov
- **Stars**: N/A
### Original Help Text
```text
usage: circulocov [-h] [-s SAMPLE] -g GENOME [-i ILLUMINA [ILLUMINA ...]]
                  [-n NANOPORE] [-p PACBIO] [-a | --all | --no-all]
                  [-d PADDING] [-w WINDOW] [-o OUT] [-log LOGLEVEL]
                  [-t THREADS] [-v]

options:
  -h, --help            show this help message and exit
  -s SAMPLE, --sample SAMPLE
                        Sample name
  -g GENOME, --genome GENOME
                        Genome (draft or complete)
  -i ILLUMINA [ILLUMINA ...], --illumina ILLUMINA [ILLUMINA ...]
                        Input illumina fastq(s)
  -n NANOPORE, --nanopore NANOPORE
                        Input nanopore fastq
  -p PACBIO, --pacbio PACBIO
                        Input pacbio fastq
  -a, --all, --no-all
  -d PADDING, --padding PADDING
                        Amount of padding added to circular sequences
  -w WINDOW, --window WINDOW
                        Number of windows for coverage
  -o OUT, --out OUT     Result directory
  -log LOGLEVEL, --loglevel LOGLEVEL
                        Logging level
  -t THREADS, --threads THREADS
                        Number of threads to use
  -v, --version         Print version and exit
```

