---
name: biscuit
description: The `biscuit` (BISulfite-seq CUI Toolkit) skill provides a specialized workflow for processing epigenetic sequencing data.
homepage: https://github.com/huishenlab/biscuit
---

# biscuit

## Overview
The `biscuit` (BISulfite-seq CUI Toolkit) skill provides a specialized workflow for processing epigenetic sequencing data. It streamlines the transition from raw reads to methylation calls and genetic variants by combining alignment, duplicate marking, and pileup procedures into a standards-compliant pipeline. This skill is particularly useful for handling bulk and single-cell bisulfite data while maintaining high efficiency and accuracy in simultaneous genetic and epigenetic inference.

## Installation and Dependencies
Ensure the environment is configured with the necessary tools for the full pipeline:
- **Core Tool**: `conda install bioconda::biscuit`
- **Required Utilities**: `samtools`, `bedtools`, `bgzip`, `tabix`, and `GNU awk`.
- **Recommended Add-on**: `dupsifter` is highly recommended for marking duplicate reads during the alignment phase to ensure accurate methylation levels.

## Common CLI Patterns

### 1. Alignment and Processing
The primary entry point for raw data is the alignment phase. It is best practice to pipe the output directly to sorting and duplicate marking to save disk space and I/O.
- Use `biscuit align` to map bisulfite-treated reads to a reference genome.
- Integrate `dupsifter` immediately after alignment to handle PCR duplicates.

### 2. Methylation and Variant Calling
Once aligned and sorted, use the following subcommands for data extraction:
- **`pileup`**: The standard method for extracting DNA methylation and genetic information from the BAM file.
- **`epiread`**: Used for extracting methylation information at the read level, useful for allele-specific analysis or methylation heterogeneity studies.
- **`cinread`**: A specialized command for specific read-level analysis (refer to the latest command-line help for specific flag updates).

### 3. Quality Control (QC)
Quality control is critical in bisulfite sequencing to ensure high conversion efficiency and library complexity.
- **`QC.sh`**: The primary wrapper script for generating comprehensive QC reports. It utilizes `qc_coverage` to assess depth and breadth of coverage across the genome.
- **`qc_coverage`**: Can be run independently to generate detailed coverage statistics.
- **`build_biscuit_QC_assets.pl`**: Used to prepare the necessary reference assets for the QC pipeline.

### 4. Data Manipulation
- **`bsconv`**: Useful for conversion-related tasks. When using tab-printing modes, ensure you check if the BAM header is required; recent updates allow for suppressing headers in specific output formats.
- **`flip_pbat_strands.sh`**: Specifically for PBAT (Post-Bisulfite Adapter Tagging) libraries to correct strand orientation.

## Expert Tips
- **Memory Management**: For large datasets, monitor memory usage during the `pileup` phase. Ensure your environment has sufficient overhead for high-depth regions.
- **Speed Optimization**: If `htslib` is compiled with `libdeflate`, `biscuit` will see significant performance improvements in reading and writing compressed files.
- **Reference Consistency**: Always ensure the SAM header chromosome order matches your reference genome exactly to avoid downstream processing errors in tools like `samtools` or `bedtools`.

## Reference documentation
- [biscuit GitHub Repository](./references/github_com_huishenlab_biscuit.md)
- [Bioconda biscuit Overview](./references/anaconda_org_channels_bioconda_packages_biscuit_overview.md)