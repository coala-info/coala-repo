# svdss CWL Generation Report

## svdss_SVDSS

### Tool Description
SVDSS [index|smooth|search|call]

### Metadata
- **Docker Image**: quay.io/biocontainers/svdss:2.1.0--h9013031_0
- **Homepage**: https://github.com/Parsoa/SVDSS
- **Package**: https://anaconda.org/channels/bioconda/packages/svdss/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/svdss/overview
- **Total Downloads**: 8.3K
- **Last updated**: 2025-05-12
- **GitHub**: https://github.com/Parsoa/SVDSS
- **Stars**: N/A
### Original Help Text
```text
SVDSS [index|smooth|search|call] --help
      --help                           print help message
      --version                        print version
```


## svdss_run_svdss

### Tool Description
Run SVDSS for structural variant detection.

### Metadata
- **Docker Image**: quay.io/biocontainers/svdss:2.1.0--h9013031_0
- **Homepage**: https://github.com/Parsoa/SVDSS
- **Package**: https://anaconda.org/channels/bioconda/packages/svdss/overview
- **Validation**: PASS

### Original Help Text
```text
ERROR: Wrong number of arguments.


Usage: run_svdss <reference.fa> <alignments.bam>

Arguments:
     -w                 output directory (default: .)
     -i                 use this FMD index/store it here (default: build FMD index and store to <reference.fa.fmd>)
     -q                 mapping quality (default: 20)
     -p                 accuracy percentile (default: 0.98)
     -s                 minimum support for calling (default: 2)
     -l                 minimum length for SV (default: 50)
     -t                 do not consider haplotagging information (default: consider it)
     -@                 number of threads (default: 4)
     -x                 path to SVDSS binary (default: SVDSS)
     -k                 path to kanpig binary (default: kanpig)
     -v                 print version
     -h                 print this help and exit

Positional arguments:
     <reference.fa>     reference file in FASTA format
     <alignments.bam>   alignments in BAM format
```

