---
name: methpipe
description: MethPipe is a specialized computational suite for processing bisulfite sequencing data.
homepage: https://github.com/smithlabcode/methpipe
---

# methpipe

## Overview
MethPipe is a specialized computational suite for processing bisulfite sequencing data. It provides a complete workflow from aligned reads (SAM/BAM) to the identification of complex methylation patterns. It is particularly useful for researchers working with WGBS or RRBS data who need to move beyond simple methylation calling into identifying biologically significant domains like PMDs or AMRs.

## Installation and Setup
The most efficient way to deploy MethPipe is via Bioconda:
```bash
conda install bioconda::methpipe
```
If building from source, ensure `htslib`, `gsl`, and `zlib` are installed. MethPipe 5.0.1+ requires a C++11 compliant compiler (GCC 5.8+ recommended).

## Core Workflow Patterns

### 1. Read Preprocessing
For version 5.0.1 and later, the legacy `.mr` format is deprecated. Use `format_reads` to process SAM files.
- **Paired-end data**: Use `format_reads` to merge mates and standardize the SAM format based on your mapper.
- **Deduplication**: Always run `duplicate_remover` on your formatted reads to account for PCR artifacts before calling methylation.

### 2. Estimating Methylation Levels
The primary tool for cytosine-level estimation is `methcounts`.
- **Input**: Standardized SAM files (post-deduplication).
- **Output**: A methylation levels file used as input for all downstream feature-finding tools.

### 3. Identifying Genomic Features
MethPipe excels at identifying higher-level methylation structures:
- **HMR (Hypo-methylated Regions)**: Use for identifying active regulatory elements.
- **PMD (Partially Methylated Domains)**: Use for identifying large-scale repressive regions, common in specific cell types or cancer.
- **AMR (Allele-specific Methylated Regions)**: Use for identifying genomic imprinting or sequence-dependent allele-specific methylation.
- **HyperMR**: Use for identifying regions of localized hyper-methylation.

### 4. Differential Methylation
Use the `radmeth` suite within MethPipe for multi-sample differential methylation analysis. It is designed to handle complex experimental designs.

## Expert Tips and Version Constraints
- **Format Shift**: If you are following older protocols that reference `.mr` files or the `to-mr` program, you must either use MethPipe version 5.0.0 or update your workflow to use `format_reads` with SAM files.
- **Library Dependencies**: If you encounter "header not found" errors during manual compilation, explicitly point to `htslib` using:
  `../configure CPPFLAGS='-I /path/to/htslib/headers' LDFLAGS='-L/path/to/htslib/lib'`
- **Memory Management**: For large WGBS datasets, ensure your environment has sufficient RAM for `methcounts` and `radmeth` processing, as these tools load significant genomic data into context.

## Reference documentation
- [github_com_smithlabcode_methpipe.md](./references/github_com_smithlabcode_methpipe.md)
- [anaconda_org_channels_bioconda_packages_methpipe_overview.md](./references/anaconda_org_channels_bioconda_packages_methpipe_overview.md)