---
name: rgt
description: The Regulatory Genomics Toolbox is a suite of Python-based tools for analyzing regulatory genomics data, including transcription factor footprinting and differential peak calling. Use when user asks to identify transcription factor footprints, perform motif enrichment analysis, detect differential peaks in ChIP-seq data, or visualize genomic tracks.
homepage: http://www.regulatory-genomics.org
---


# rgt

## Overview
The Regulatory Genomics Toolbox (RGT) is a specialized suite of Python-based tools designed for the analysis of regulatory genomics data. It excels at identifying active regulatory regions and transcription factor binding sites through chromatin accessibility and histone modification patterns. Key functionalities include digital genomic footprinting, motif enrichment analysis, and the integration of multiple data types to reconstruct regulatory networks.

## Core Toolsets and CLI Patterns

### HINT (HMM-based Identification of TF footprints)
Used for detecting transcription factor footprints in ATAC-seq or DNase-seq data.
- **Footprinting**: `rgt-hint footprinting --atac-seq --organism=hg38 input.bam peaks.bed`
- **Differential Analysis**: Use `rgt-hint differential` to compare footprints between two conditions (e.g., Control vs. Treatment).
- **Note**: Always ensure the `--organism` flag matches your reference genome (e.g., hg19, hg38, mm10).

### MotifAnalysis
Used for finding motif occurrences and calculating enrichment.
- **Matching**: `rgt-motifanalysis matching --organism=hg38 --input-files regions.bed`
- **Enrichment**: `rgt-motifanalysis enrichment --organism=hg38 --input-files regions.bed --background-files background.bed`

### THOR (Differential Peak Calling)
A HMM-based approach to detect differential peaks in ChIP-seq data without the need for prior normalization.
- **Execution**: `rgt-THOR config.config`
- **Requirement**: Requires a configuration file specifying BAM files for both conditions and their respective replicates.

### Visualization and Data Management
- **GenomeBrowser**: Create high-quality tracks for visualization using `rgt-genomebrowser`.
- **Data Configuration**: RGT relies on a data path configuration. If genomic data (bitset files, etc.) is missing, use the `rgt-viz` or manual path setup to point to the RGT data folder.

## Expert Tips
- **Data Setup**: Before running analysis, ensure the RGT data folder is correctly populated with the required genome data for your specific organism.
- **BAM Indexing**: All input BAM files must be sorted and indexed (`samtools index`) for HINT and THOR to function correctly.
- **Memory Management**: For large ATAC-seq datasets, HINT footprinting can be memory-intensive; ensure sufficient RAM is allocated when processing high-depth libraries.

## Reference documentation
- [RGT Overview](./references/anaconda_org_channels_bioconda_packages_rgt_overview.md)
- [Regulatory Genomics Toolbox Home](./references/www_regulatory-genomics_org_index.md)