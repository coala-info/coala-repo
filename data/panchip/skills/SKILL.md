---
name: panchip
description: "PanChIP analyzes protein colocalization by comparing genomic intervals against a large library of ChIP-seq peak sets. Use when user asks to initialize the reference library, perform peak set analysis, or filter the library for quality control."
homepage: https://github.com/hanjunlee21/PanChIP
---


# panchip

## Overview

PanChIP is a computational tool designed for the large-scale analysis of protein colocalization using ChIP-seq peak sets. It allows researchers to compare their specific genomic intervals against a vast library of existing ChIP-seq data to identify significant overlaps and associations. Currently optimized for the hg38 genome assembly, the tool streamlines the process of determining how a protein of interest relates to the broader landscape of chromatin-bound factors.

## Usage Instructions

### Environment Setup
PanChIP requires Python 3 and BEDTools to be installed in the environment.

```bash
# Installation via Bioconda (recommended)
conda install bioconda::panchip

# Installation via PyPI
pip3 install panchip
```

### 1. Library Initialization
Before running analyses, you must initialize the PanChIP library. This process downloads the necessary reference data.
*   **Requirement**: Ensure at least 14 GB of disk space is available.
*   **Command**: `panchip init <library_directory>`

### 2. Peak Set Analysis
This command compares a set of input BED files against the initialized library.
*   **Input**: A directory containing only 6-column BED files (.bed6).
*   **Format**: Files must have numeric scores in the 5th column.
*   **Command**:
    ```bash
    panchip analysis <library_directory> <input_directory> <output_directory> -t <threads> -r <repeats>
    ```
*   **Parameters**:
    *   `-t`: Number of threads (default: 1). Increase this for faster processing on multi-core systems.
    *   `-r`: Number of repeats to perform (default: 1).

### 3. Quality Control Filtering
Use the filter command to perform quality control on the library based on a specific input file.
*   **Command**:
    ```bash
    panchip filter <library_directory> <input_file> <output_directory> -t <threads>
    ```

## Best Practices and Expert Tips

*   **BED Format Consistency**: PanChIP strictly requires the BED6 format. If your peaks are in BED3 or BED4, you must expand them to 6 columns.
*   **The 5th Column (Score)**: For optimal results, use constant non-zero values in the 5th column (e.g., 1, 500, or 1000) if specific enrichment scores are not required for your colocalization logic.
*   **Input Directory Hygiene**: When running `panchip analysis`, the input directory must contain *only* the .bed files you wish to analyze. Hidden files or metadata files in this directory may cause execution errors.
*   **Resource Management**: Since the library is large (>13GB), store it on a high-speed drive (SSD) if possible to reduce I/O wait times during the analysis phase.
*   **Genome Assembly**: Ensure your input coordinates are strictly hg38. Using hg19 or other assemblies will result in incorrect colocalization data.

## Reference documentation
- [PanChIP Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_panchip_overview.md)
- [PanChIP GitHub Repository](./references/github_com_hanjunlee21_PanChIP.md)