# excludonfinder CWL Generation Report

## excludonfinder_ExcludonFinder

### Tool Description
ExcludonFinder main processing script

### Metadata
- **Docker Image**: quay.io/biocontainers/excludonfinder:0.2.0--hdfd78af_0
- **Homepage**: https://github.com/Alvarosmb/ExcludonFinder
- **Package**: https://anaconda.org/channels/bioconda/packages/excludonfinder/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/excludonfinder/overview
- **Total Downloads**: 2.2K
- **Last updated**: 2025-11-03
- **GitHub**: https://github.com/Alvarosmb/ExcludonFinder
- **Stars**: N/A
### Original Help Text
```text
ExcludonFinder main processing script
Usage:
    main.sh -f <reference.fasta> -1 <reads_R1.fastq> [-2 <reads_R2.fastq>] -g <annotation.gff> [options]

Required arguments:
    -f <file>    Reference genome in FASTA format
    -1 <file>    Input FASTQ file (Read 1 for paired-end data)
    -g <file>    Annotation file in GFF format

Optional arguments:
    -2 <file>    Input FASTQ file (Read 2 for paired-end data)
    -t <float>   Coverage threshold (default: 0.5)
    -j <int>     Number of threads (default: 8)
    -l           Use long-read mode (uses minimap2 instead of bwa-mem2)
    -o <dir>     Supply a custom output dir (default: ./output)
    -k           Keep intermediate files (default: remove)
    -C           Run quality control checks
    -h, --help   Show this help message
```

