---
name: star-fusion
description: STAR-Fusion identifies candidate fusion transcripts from RNA-Seq reads by detecting chimeric sequences and mapping them against reference annotations. Use when user asks to identify fusion transcripts, detect oncogenic drivers, or analyze chimeric sequences from transcriptomic data.
homepage: https://github.com/STAR-Fusion/STAR-Fusion
metadata:
  docker_image: "quay.io/biocontainers/star-fusion:1.15.1--hdfd78af_1"
---

# star-fusion

## Overview

STAR-Fusion is a specialized bioinformatic tool designed to identify candidate fusion transcripts from Illumina RNA-Seq reads. It leverages the STAR aligner to detect chimeric sequences and then maps junction and spanning reads against reference annotations to provide high-confidence fusion calls. It is a core component of the Trinity Cancer Transcriptome Analysis Toolkit (CTAT) and is essential for researchers investigating oncogenic drivers and chromosomal rearrangements in transcriptomic data.

## Installation

The recommended method for installation is via Bioconda:

```bash
conda install bioconda::star-fusion
```

## Core Workflows

### 1. Standard Execution (From FASTQ)
This is the most common entry point. It performs the STAR alignment and fusion calling in a single command.

```bash
STAR-Fusion --genome_lib_dir /path/to/CTAT_resource_lib \
            --left_fq reads_1.fq \
            --right_fq reads_2.fq \
            --output_dir star_fusion_outdir
```

*   **Note**: For single-end reads, omit `--right_fq`. Reads should be at least 100bp for reliable detection.
*   **Memory**: Requires approximately 40GB of RAM for the alignment phase.

### 2. Kickstart Mode (From Existing STAR Output)
If you have already run STAR separately, you can provide the `Chimeric.out.junction` file to skip the alignment step.

```bash
STAR-Fusion --genome_lib_dir /path/to/CTAT_resource_lib \
            -J Chimeric.out.junction \
            --output_dir star_fusion_outdir
```

## Expert Best Practices

### Required STAR Parameters for Manual Alignment
If running STAR manually before using Kickstart mode, the following flags are **essential** for compatibility:

*   `--chimSegmentMin 12`: Enables chimeric read detection.
*   `--chimOutJunctionFormat 1`: Includes required metadata in the junction file.
*   `--chimJunctionOverhangMin 8`: Minimum overhang for a chimeric junction.
*   `--outSAMunmapped Within`: Keeps unmapped reads in the SAM/BAM for downstream analysis.

### Resource Management
*   **CTAT Genome Library**: You must download or build a CTAT resource library (e.g., GRCh38_gencode_vXX_CTAT_lib).
*   **Environment Variable**: Set `export CTAT_GENOME_LIB=/path/to/lib` to avoid passing `--genome_lib_dir` in every command.

### Interpreting Results
The primary output is `star-fusion.fusion_predictions.tsv`. Key columns include:
*   **JunctionReadCount**: Number of reads directly overlapping the fusion breakpoint.
*   **SpanningFragCount**: Number of paired-end fragments where one mate is on one gene and the other mate is on the fusion partner.
*   **FFPM**: Fragments Per Million Mapped Reads; used to normalize fusion expression across samples.
*   **LargeAnchorSupport**: Indicates if the fusion is supported by reads with significant overlap on both sides of the breakpoint (YES_LDAS).

## Reference documentation
- [STAR-Fusion Wiki](./references/github_com_STAR-Fusion_STAR-Fusion_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_star-fusion_overview.md)