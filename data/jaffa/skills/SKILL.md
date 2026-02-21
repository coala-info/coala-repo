---
name: jaffa
description: JAFFA (Joined Assembly of Fusion Transcripts) is a specialized pipeline designed to identify gene fusions by comparing a sample's transcriptome against a reference transcriptome.
homepage: https://github.com/Oshlack/JAFFA
---

# jaffa

## Overview

JAFFA (Joined Assembly of Fusion Transcripts) is a specialized pipeline designed to identify gene fusions by comparing a sample's transcriptome against a reference transcriptome. Unlike genome-centric fusion finders, JAFFA's transcript-centric approach allows it to maintain high sensitivity across a wide range of read lengths, from 50bp short reads to full-length transcripts. It is particularly effective because it provides the cDNA sequence of the fusion breakpoint, facilitating downstream validation.

## Execution Modes

Select the appropriate wrapper based on your input data type:

- **jaffa-direct**: Recommended for short reads (typically 100bp or longer). It aligns reads directly to the reference transcriptome.
- **jaffa-assembly**: Best for very short reads (e.g., 50bp) where de novo assembly helps resolve fusion boundaries.
- **jaffa-hybrid**: Combines assembly and direct alignment; use this when maximum sensitivity is required at the cost of computational time.
- **JAFFAL**: The dedicated pipeline for long-read transcriptome sequencing (ONT or PacBio).

## Configuration and Environment

Before running JAFFA, you must define the location of your reference data. JAFFA requires a reference base directory containing the necessary genomic and transcriptomic indices (e.g., hg19, hg38).

Set the environment variable:
```bash
export JAFFA_REF_BASE=/path/to/your/jaffa_reference_directory
```

## Common CLI Patterns

### Basic Short-Read Analysis
To run the direct pipeline on paired-end FASTQ files:
```bash
jaffa-direct sample_R1.fastq.gz sample_R2.fastq.gz
```

### Long-Read Analysis (JAFFAL)
For Oxford Nanopore or PacBio data, use the JAFFAL script:
```bash
bpipe run JAFFAL.groovy sample_long_reads.fastq.gz
```

### Customizing Parameters
JAFFA wrappers pass arguments directly to the underlying Bpipe execution. You can specify the number of threads or other Bpipe-specific configurations:
```bash
jaffa-direct -n 8 sample_R1.fastq.gz sample_R2.fastq.gz
```

## Expert Tips and Best Practices

- **Reference Preparation**: Ensure you have run the `prepare_reference.sh` script (found in the JAFFA source) if you are using a custom reference or if the pre-built indices are missing.
- **Memory Management**: Assembly-based modes (`jaffa-assembly` and `jaffa-hybrid`) are memory-intensive. Ensure your environment has sufficient RAM (typically 32GB+) for human transcriptome assembly.
- **Output Interpretation**: The primary output is a CSV file containing candidate fusions. Pay close attention to the "Classification" column:
    - **HighConfidence**: Fusions with strong supporting evidence.
    - **LowConfidence**: Often characterized by low read support or homology issues.
    - **PotentialTranscriptStart**: Fusions that may be alternative splicing events or internal read-throughs.
- **Long-Read Advantages**: When using `JAFFAL`, the pipeline can often resolve complex rearrangements that short reads miss by spanning the entire fusion transcript in a single read.

## Reference documentation

- [JAFFA Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_jaffa_overview.md)
- [JAFFA GitHub Repository](./references/github_com_Oshlack_JAFFA.md)
- [JAFFA Wiki Home](./references/github_com_Oshlack_JAFFA_wiki.md)