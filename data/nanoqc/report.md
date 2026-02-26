# nanoqc CWL Generation Report

## nanoqc_nanoQC

### Tool Description
Investigate nucleotide composition and base quality.

### Metadata
- **Docker Image**: quay.io/biocontainers/nanoqc:0.10.0--pyhdfd78af_0
- **Homepage**: https://github.com/wdecoster/nanoQC
- **Package**: https://anaconda.org/channels/bioconda/packages/nanoqc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/nanoqc/overview
- **Total Downloads**: 48.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/wdecoster/nanoQC
- **Stars**: N/A
### Original Help Text
```text
usage: nanoQC [-h] [-v] [-o OUTDIR] [--rna] [-l MINLEN] fastq

Investigate nucleotide composition and base quality.

positional arguments:
  fastq                 Reads data in fastq.gz format.

options:
  -h, --help            show this help message and exit
  -v, --version         Print version and exit.
  -o OUTDIR, --outdir OUTDIR
                        Specify directory in which output has to be created.
  --rna                 Fastq is from direct RNA-seq and contains U
                        nucleotides.
  -l MINLEN, --minlen MINLEN
                        Filters the reads on a minimal length of the given
                        range. Also plots the given length/2 of the begin and
                        end of the reads.
```

