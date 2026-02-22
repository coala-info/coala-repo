# actc CWL Generation Report

## actc

### Tool Description
Align clr to ccs reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/actc:0.6.1--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/actc
- **Package**: https://anaconda.org/channels/bioconda/packages/actc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/actc/overview
- **Total Downloads**: 6.2K
- **Last updated**: 2025-06-12
- **GitHub**: https://github.com/PacificBiosciences/actc
- **Stars**: 14
### Original Help Text
```text
actc - Align clr to ccs reads.

Usage:
  actc [options] <IN.subreads.bam> <IN.ccs.bam> <OUT.bam>

  IN.subreads.bam   FILE  Subreads BAM.
  IN.ccs.bam        FILE  CCS BAM.
  OUT.bam           FILE  Aligned subreads to CCS BAM.

  --chunk           STR   Operate on a single chunk. Format i/N, where i in [1,N]. Examples: 3/24 or 9/9
  --trim-flanks-bp  INT   Trim N bp from each flank of the CCS read alignment [0]
  --min-ccs-length  INT   Minimum CCS read length after --trim-flanks-bp [100]

  -h,--help               Show this help and exit.
  --version               Show application version and exit.
  -j,--num-threads  INT   Number of threads to use, 0 means autodetection. [0]
  --log-level       STR   Set log level. Valid choices: (TRACE, DEBUG, INFO, WARN, FATAL). [WARN]
  --log-file        FILE  Log to a file, instead of stderr.

Copyright (C) 2004-2023     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```


## Metadata
- **Skill**: generated
