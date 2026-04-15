---
name: gmm-demux
description: GMM-Demux is a Gaussian-Mixture-Model-based tool used to clean and validate barcoded single-cell datasets by identifying multiplets. Use when user asks to demultiplex cell-hashing data, remove multi-sample multiplets, estimate same-sample multiplet rates, or verify if cell clusters are technical artifacts.
homepage: https://github.com/CHPGenetics/GMM-demux
metadata:
  docker_image: "quay.io/biocontainers/gmm-demux:0.2.2.3--pyh7e72e81_1"
---

# gmm-demux

## Overview

GMM-Demux is a Gaussian-Mixture-Model-based tool designed to clean and validate barcoded single-cell datasets. It excels at distinguishing between singlets (droplets with one cell) and multiplets (droplets with multiple cells). Specifically, it identifies Multi-Sample Multiplets (MSMs) which contain cells from different samples, and provides statistical estimates for Same-Sample Multiplets (SSMs) which are otherwise indistinguishable from singlets. Use this skill to improve the purity of your single-cell data and to verify if specific cell clusters are biological realities or technical artifacts known as "phony cell types."

## Command Line Usage

The primary command for the tool is `GMM-demux`. It requires the path to the HTO (Hashtag Oligonucleotide) count matrix and a comma-separated list of the HTO names.

### Basic Demultiplexing
To remove MSMs and extract Same-Sample Droplets (SSDs):

```bash
GMM-demux <cell_hashing_path> <HTO_names>
```

*   `<cell_hashing_path>`: Path to the directory containing the MTX files (e.g., `matrix.mtx.gz`, `features.tsv.gz`, `barcodes.tsv.gz`). This should follow the CellRanger v3 output format.
*   `<HTO_names>`: A list of sample tags separated by commas without any whitespace (e.g., `HTO_1,HTO_2,HTO_3`).

### Generating Statistical Summaries
To compute MSM and SSM rates, use the `-u` flag. This requires an estimate of the total number of cells loaded into the assay.

```bash
GMM-demux <cell_hashing_path> <HTO_names> -u <ESTIMATED_TOTAL_CELLS>
```

### Specifying Output
By default, results are stored in a folder named `SSD_mtx`. You can override this using the `-o` flag:

```bash
GMM-demux <cell_hashing_path> <HTO_names> -o /path/to/custom_output_folder
```

## Best Practices and Expert Tips

*   **HTO Name Verification**: Before running the tool, check the `features.tsv` file in your input directory to ensure the HTO names match exactly. Case sensitivity and underscores matter.
*   **No Whitespace**: Ensure there are no spaces in your comma-separated HTO list (e.g., use `HTO1,HTO2` not `HTO1, HTO2`).
*   **Phony Type Validation**: If you observe a cluster expressing markers from two different samples (e.g., CD3+ and CD19+), use GMM-Demux to check the MSM percentage in that cluster. A high MSM percentage typically indicates a "phony" or fake cell type induced by multiplets.
*   **Input Format**: The tool is optimized for CellRanger v3 output. If using older versions or different pipelines, ensure the directory contains the standard `matrix.mtx`, `barcodes.tsv`, and `features.tsv` (or `genes.tsv`) files.
*   **Terminology Clarification**:
    *   **MSM**: Multi-Sample Multiplet (identifiable).
    *   **SSM**: Same-Sample Multiplet (estimated statistically).
    *   **SSD**: Same-Sample Droplet (the "clean" output containing both singlets and SSMs).

## Reference documentation
- [GMM-Demux GitHub Repository](./references/github_com_CHPGenetics_GMM-Demux.md)
- [GMM-Demux Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_gmm-demux_overview.md)