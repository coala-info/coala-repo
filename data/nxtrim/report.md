# nxtrim CWL Generation Report

## nxtrim

### Tool Description
Trims adapter sequences from FASTQ files.

### Metadata
- **Docker Image**: quay.io/biocontainers/nxtrim:0.4.3--he513fc3_0
- **Homepage**: https://github.com/sequencing/NxTrim
- **Package**: https://anaconda.org/channels/bioconda/packages/nxtrim/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/nxtrim/overview
- **Total Downloads**: 5.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sequencing/NxTrim
- **Stars**: N/A
### Original Help Text
```text
Program:	nxtrim
Version:	v0.4.3
Contact:	joconnell@illumina.com

Copyright (c) 2016, Illumina, Inc. All rights reserved. See LICENSE for further details.

Usage:	nxtrim -1 R1.fastq.gz -2 R2.fastq.gz [options]

Required arguments:
  -1 [ --r1 ] arg                 read 1 in fastq format (gzip allowed)
  -2 [ --r2 ] arg                 read 2 in fastq format (gzip allowed)
Allowed options:
  -O [ --output-prefix ] arg      output prefix
  --justmp                        just creates a the mp/unknown libraries (reads with adapter at the start will be completely N masked)
  --stdout                        print trimmed reads to stdout (equivalent to justmp)
  --stdout-mp                     print only known MP reads to stdout (good for scaffolding)
  --stdout-un                     print only unknown reads to stdout
  --rf                            leave mate pair reads in RF orientation [by default are flipped into FR]
  --preserve-mp                   preserve MPs even when the corresponding PE has longer reads
  --ignorePF                      ignore chastity/purity filters in read headers
  --separate                      output paired reads in separate files (prefix_R1/prefix_r2). Default is interleaved.
  -a, --aggressive                more aggressive adapter search (see docs/adapter.md)
  -s, --similarity arg (=0.85)    The minimum similarity between strings to be considered a match (Hamming distance divided by string length)
  -v, --minoverlap arg (=12)      The minimum overlap to be considered for matching
  -l, --minlength arg  (=21)      The minimum read length to output (smaller reads will be filtered)
```

