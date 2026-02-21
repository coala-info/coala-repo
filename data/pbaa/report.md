# pbaa CWL Generation Report

## pbaa_cluster

### Tool Description
Run clustering tool for HiFi reads using guide sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/pbaa:1.2.0--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/pbAA
- **Package**: https://anaconda.org/channels/bioconda/packages/pbaa/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pbaa/overview
- **Total Downloads**: 21.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/PacificBiosciences/pbAA
- **Stars**: N/A
### Original Help Text
```text
pbaa cluster - Run clustering tool.

Usage:
  pbaa cluster [options] <guide input> <read input> <prefix>

  guide input                FILE   Guide sequence(s) in fasta format indexed with samtools faidx version 1.9 or
                                    greater. A FOFN can be provide for multiple files.
  read input                 FILE   De-multiplexed HiFi reads in fastq format indexed with samtools fqidx version 1.9
                                    or greater. A FOFN can be provide for multiple files.
  prefix                     STR    Output prefix for run.

Placement and Variant Options:
  --filter                   INT    Variants with coverage lower than filter will be ignored. [3]
  --trim-ends                INT    Number of bases to trim from both sides of reads during graph construction and
                                    variant detection. [5]
  --pile-size                INT    The number of best alignments to keep for each read during error correction. [30]
  --min-var-frequency        FLOAT  Minimum coverage frequency within a pile. [0.3]
  --max-alignments-per-read  INT    The number of random alignments, for each read, within a guide grouping [1000]

Clustering Options:
  --seed                     INT    Randomization seed. [1984]
  --max-reads-per-guide      INT    The number randomly selected reads to use within a guide grouping. [500]
  --iterations               INT    Number of iterations to run k-means. [9]

Consensus Options:
  --max-consensus-reads      INT    Maximum number of reads to use per cluster consensus. [100]

Filtering Options:
  --max-amplicon-size        INT    Upper read length cutoff, longer reads will be skipped. [15000]
  --min-read-qv              FLOAT  Low read QV cutoff. [20]
  --off-target-groups        STR    Group names to exclude, i.e. these loci are off-target (not amplified).
  --min-cluster-frequency    FLOAT  Low frequency cluster cutoff. [0.1]
  --max-uchime-score         FLOAT  High UCHIME score cutoff. [1]
  --min-cluster-read-count   INT    Low read count cluster cutoff. [5]

General Options:

  -h,--help                         Show this help and exit.
  --version                         Show application version and exit.
  -j,--num-threads           INT    Number of threads to use, 0 means autodetection. [0]
  --log-level                STR    Set log level. Valid choices: (TRACE, DEBUG, INFO, WARN, FATAL). [WARN]
  --log-file                 FILE   Log to a file, instead of stderr.

Copyright (C) 2004-2024     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```


## pbaa_bampaint

### Tool Description
Add color tags to BAM records, based on pbaa clusters.

### Metadata
- **Docker Image**: quay.io/biocontainers/pbaa:1.2.0--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/pbAA
- **Package**: https://anaconda.org/channels/bioconda/packages/pbaa/overview
- **Validation**: PASS

### Original Help Text
```text
pbaa bampaint - Add color tags to BAM records, based on pbaa clusters.

Usage:
  pbaa bampaint [options] <read info file> <input bam> <output bam>

  read info file    FILE  Read information file produced by pbaa cluster.
  input bam         FILE  Bam file to add color tags.
  output bam        FILE  Output bam file name.

Options:
  -h,--help               Show this help and exit.
  --version               Show application version and exit.
  -j,--num-threads  INT   Number of threads to use, 0 means autodetection. [0]
  --log-level       STR   Set log level. Valid choices: (TRACE, DEBUG, INFO, WARN, FATAL). [WARN]
  --log-file        FILE  Log to a file, instead of stderr.

Copyright (C) 2004-2024     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```


## Metadata
- **Skill**: generated
