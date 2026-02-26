---
name: isoseq
description: The isoseq toolset transforms PacBio HiFi reads into high-quality, full-length transcript sequences through clustering and polishing. Use when user asks to cluster reads into isoforms, collapse redundant transcripts, or classify and filter transcripts using the pigeon toolkit.
homepage: https://github.com/PacificBiosciences/pbbioconda
---


# isoseq

## Overview
The `isoseq` toolset is the primary suite for analyzing PacBio long-read transcriptome data. It transforms raw circular consensus sequencing (CCS/HiFi) reads into high-quality, full-length transcript sequences. This skill provides guidance on the standard de novo discovery pipeline, including clustering, polishing, and transcript classification using the `pigeon` toolkit.

## Installation and Setup
Install via Bioconda to ensure all dependencies are met:
```bash
conda install -c bioconda isoseq
```

## Core Workflow Patterns

### 1. De Novo Clustering
The `cluster` command is used to group reads into isoforms and generate a consensus.
```bash
isoseq cluster unpolished.bam polished.bam --verbose
```
*   **Input**: Full-length, non-chimeric (FLNC) reads (typically from `lima`).
*   **Output**: High-quality consensus isoforms.

### 2. Collapsing Redundant Transcripts
After mapping isoforms to a reference genome (usually with `pbmm2`), use `collapse` to merge redundant transcripts based on genomic coordinates.
```bash
isoseq collapse mapped.bam collapsed.gff
```
*   **Tip**: Ensure the input BAM is sorted by coordinate.
*   **Key Parameter**: Use `--do-not-clobber` if you want to avoid overwriting existing outputs in a pipeline.

### 3. Transcript Classification (Pigeon)
The `pigeon` toolkit (part of the Iso-Seq ecosystem) is used for transcript classification and filtering.
```bash
# Classify transcripts against a reference
pigeon classify collapsed.gff reference.gtf genome.fa

# Filter based on classification results
pigeon filter classification.txt --isoforms collapsed.gff
```

## Expert Tips
- **HiFi Only**: Modern `isoseq` (v3+) is optimized for HiFi reads. Do not use it with subreads or low-quality CLR data.
- **Memory Management**: For large datasets, monitor memory usage during the `cluster` step. You can limit threads using `-j` to manage resource consumption.
- **Input Preparation**: Always ensure primers and barcodes have been removed using `lima` and polyA tails have been trimmed using `isoseq refine` before starting the clustering process.
- **Version Consistency**: Avoid mixing versions of `isoseq` and `pbmm2` within the same project to prevent metadata format conflicts in BAM headers.

## Reference documentation
- [Iso-Seq - Scalable De Novo Isoform Discovery](./references/anaconda_org_channels_bioconda_packages_isoseq_overview.md)
- [PacBio Secondary Analysis Tools on Bioconda](./references/github_com_PacificBiosciences_pbbioconda.md)