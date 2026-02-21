# pbmarkdup CWL Generation Report

## pbmarkdup

### Tool Description
Mark duplicate reads from PacBio sequencing of an amplified library.

### Metadata
- **Docker Image**: quay.io/biocontainers/pbmarkdup:1.2.0--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/pbmarkdup
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pbmarkdup/overview
- **Total Downloads**: 16.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/PacificBiosciences/pbmarkdup
- **Stars**: N/A
### Original Help Text
```text
pbmarkdup - Mark duplicate reads from PacBio sequencing of an amplified library.

Usage:
  pbmarkdup [options] <INFILE.bam|xml|fa|fq|fofn> <OUTFILE.bam|xml|fa.gz|fq.gz>

  INFILE.bam|xml|fa|fq|fofn    STR   Input file(s) as BAM, DATASET.XML, FASTA[.GZ], FASTQ[.GZ], or FOFN
  OUTFILE.bam|xml|fa.gz|fq.gz  STR   Output file as BAM, DATASET.XML, FASTA.GZ or FASTQ.GZ


Duplicate Marking Options:
  --cross-library,-x                 Identify duplicates across sequencing libraries (LB tag in read group).

Output Options:
  --rmdup,-r                         Exclude duplicates from OUTFILE. Redundant when --dup-file is provided.
  --dup-file                   STR   Write duplicates to this file instead of OUTFILE.
  --clobber,-f                       Overwrite OUTFILE if it exists.

  -h,--help                          Show this help and exit.
  --version                          Show application version and exit.
  -j,--num-threads             INT   Number of threads to use, 0 means autodetection. [0]
  --log-level                  STR   Set log level. Valid choices: (TRACE, DEBUG, INFO, WARN, FATAL). [WARN]
  --log-file                   FILE  Log to a file, instead of stderr.

Copyright (C) 2004-2024     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```


## Metadata
- **Skill**: generated
