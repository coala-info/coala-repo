---
name: rnachipintegrator
description: RnaChipIntegrator is a bioinformatics tool that automates the analysis of genomic proximity between two sets of features, such as linking transcriptomic data with epigenomic regions. Use when user asks to find genes near peaks, find peaks near genes, or perform proximity analysis between genomic features.
homepage: https://github.com/fls-bioinformatics-core/RnaChipIntegrator
---


# rnachipintegrator

## Overview
RnaChipIntegrator is a bioinformatics utility that automates the process of linking transcriptomic data with epigenomic regions. While originally developed for RNA-Seq and ChIP-Seq integration, it serves as a general-purpose tool for any two sets of genomic features where proximity analysis is required. The tool performs dual-mode analysis: "peak-centric" (finding genes near peaks) and "gene-centric" (finding peaks near genes), providing a comprehensive view of potential regulatory interactions based on genomic distance.

## Installation and Setup
The tool is available via Conda or PyPI. Version 3.0.0+ is recommended for the latest features, including Transcription End Site (TES) distance support.

```bash
# Via Conda (recommended)
conda install -c bioconda rnachipintegrator

# Via Pip
pip install RnaChipIntegrator
```

## Basic Usage
The program requires two tab-delimited input files: one containing genomic features (genes) and one containing regions (peaks).

```bash
RnaChipIntegrator GENES_FILE PEAKS_FILE
```

### Input File Requirements
- **Genes/Features File**: Must contain at least chromosome, start, end, and a unique ID.
- **Peaks/Regions File**: Must contain at least chromosome, start, and end coordinates.
- **Format**: Files must be tab-separated.

## Command Line Patterns and Options
RnaChipIntegrator provides several flags to refine how "nearest" is defined and to filter results.

### Distance Metrics
By default, the tool often calculates distances relative to the Transcription Start Site (TSS).
- `--edge`: Use this flag to calculate distances from the edges of the features rather than just the start sites.
- **TES Support**: In version 3.0.0, the tool supports distances to the Transcription End Site (TES), which is useful for identifying 3' UTR regulatory elements or termination-related peaks.

### Filtering and Output
- **Distance Cutoffs**: You can limit the analysis to features within a specific base-pair range (e.g., 100kb).
- **Number of Neighbors**: Specify how many "nearest" items to report (e.g., the top 3 nearest genes for every peak).

## Expert Tips and Best Practices
- **Beyond Genes**: Use the tool for non-canonical features. You can treat CpG islands, enhancers, or conserved elements as the "gene" file to find their proximity to peaks.
- **Strand Awareness**: Ensure your gene input file includes strand information if you are performing TSS/TES-centric analysis, as the "start" and "end" positions are relative to the direction of transcription.
- **Data Pre-processing**: While the tool handles basic tab-delimited files, ensure your chromosome naming conventions (e.g., "chr1" vs "1") are consistent between both the gene and peak files to avoid empty results.
- **Analysis Direction**: 
    - Use **Peak-centric** output to annotate a list of peaks with the most likely regulated genes.
    - Use **Gene-centric** output to determine which genes in a differentially expressed set have nearby binding events.

## Reference documentation
- [RnaChipIntegrator Main Repository](./references/github_com_fls-bioinformatics-core_RnaChipIntegrator.md)
- [RnaChipIntegrator Wiki](./references/github_com_fls-bioinformatics-core_RnaChipIntegrator_wiki.md)
- [Version 3.0.0 Updates and TES Support](./references/github_com_fls-bioinformatics-core_RnaChipIntegrator_commits_devel.md)