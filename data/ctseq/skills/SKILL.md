---
name: ctseq
description: "ctseq is a bioinformatics pipeline that automates the analysis of methylation patch PCR data from ctDNA. Use when user asks to process sequencing reads for methylation state determination, perform UMI deduplication, or align bisulfite-treated reads using targeted patch PCR panels."
homepage: https://github.com/ryanhmiller/ctseq
---


# ctseq

## Overview

ctseq is a specialized bioinformatics pipeline designed for the analysis of methylation patch PCR data. It automates the complex workflow of processing ctDNA, including adapter trimming, UMI (Unique Molecular Identifier) deduplication, and bisulfite alignment. Use this skill when you need to process sequencing reads to determine methylation states, specifically when working with targeted patch PCR panels where specific adapter sequences must be accounted for in the reference alignment.

## Reference Preparation

The most critical step for successful alignment in ctseq is the manual modification of your reference FASTA file. The pipeline expects specific adapter sequences to be present in the reference to facilitate accurate trimming and alignment.

**Required Adapter Sequences:**
- **Prefix (5'):** `AGAGAATGAGGAAGGTGGGGAGT`
- **Suffix (3'):** `AGTGTGGGAGGGTAGTTGGTGTT`

Every sequence in your `.fa` reference file must be formatted as follows:
`>Fragment_Name`
`[PREFIX][TARGET_SEQUENCE][SUFFIX]`

## Input Requirements and Naming

ctseq enforces strict naming conventions to correctly identify samples and paired-end reads.

1.  **Sample Naming:** Files must start with the sample name followed by an underscore (e.g., `Sample01_...fastq.gz`).
2.  **File Consolidation:** If a single sample has multiple fastq files (e.g., from different lanes), they must be concatenated into a single file per read type (Forward, Reverse, UMI) before running the pipeline.
3.  **Read Order:** Ensure that read names are in the exact same order in both the forward and reverse fastq files.

## Command Line Usage

### Core Analysis
The primary command is `ctseq analyze`. You must specify the directory containing your fastq files and the directory containing your modified reference file.

```bash
ctseq analyze \
  --refDir /path/to/reference_folder \
  --dir /path/to/fastq_folder \
  --umiType separate \
  --umiLength 12 \
  --forwardExt R1_001.fastq.gz \
  --reverseExt R3_001.fastq.gz \
  --umiExt R2_001.fastq.gz \
  --cutadaptCores 8 \
  --bismarkCores 4 \
  --processes 10 \
  --nameRun ProjectName
```

### UMI Configuration
ctseq supports two UMI locations via the `--umiType` flag:
- `separate`: UMIs are in a dedicated fastq file (requires `--umiExt`).
- `readname`: UMIs are embedded within the fastq header (e.g., `@Header:UMI:N:0:...`).

## Best Practices

- **Resource Allocation:** Balance `--cutadaptCores` and `--bismarkCores` against your total available CPU. Bismark is significantly more resource-intensive; if memory is limited, reduce `--bismarkCores`.
- **Extension Matching:** Use the `--forwardExt`, `--reverseExt`, and `--umiExt` flags to precisely match your sequencer's output naming (e.g., `_R1.fastq.gz` vs `_L001_R1_001.fastq.gz`).
- **Visualization:** To generate heatmaps and plots, you must provide a "Fragment Info" file. This file requires a `fragOrder` column to define the vertical arrangement of fragments in the output plots.

## Reference documentation
- [ctseq GitHub Repository](./references/github_com_ryanhmiller_ctseq.md)
- [ctseq Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ctseq_overview.md)