# rebaler CWL Generation Report

## rebaler

### Tool Description
reference-based long read assemblies of bacterial genomes

### Metadata
- **Docker Image**: quay.io/biocontainers/rebaler:0.2.0--py_0
- **Homepage**: https://github.com/rrwick/Rebaler
- **Package**: https://anaconda.org/channels/bioconda/packages/rebaler/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rebaler/overview
- **Total Downloads**: 21.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/rrwick/Rebaler
- **Stars**: N/A
### Original Help Text
```text
tput: No value for $TERM and no -T specified
usage: rebaler [-d] [-t THREADS] [--random] [-h] [--version] reference reads

Rebaler: reference-based long read assemblies of bacterial genomes

Positional arguments:
  reference               FASTA file of reference assembly
  reads                   FASTA/FASTQ file of long reads

Optional arguments:
  -d, --direct            If set, Rebaler will polish the given genome without
                          first producing an unpolished version (default:
                          False)
  -t THREADS, --threads THREADS
                          Number of threads to use for alignment and polishing
                          (default: 16)
  --random                If a part of the reference is missing, replace it
                          with random sequence (default: leave it as the
                          reference sequence)

Help:
  -h, --help              Show this help message and exit
  --version               Show program's version number and exit
```

