---
name: emptydrops
description: The `emptydrops` skill provides a specialized workflow for filtering droplet-based single-cell data.
homepage: https://pypi.org/project/emptydrops/
---

# emptydrops

## Overview
The `emptydrops` skill provides a specialized workflow for filtering droplet-based single-cell data. It is particularly useful when working with raw gene-barcode matrices where a simple UMI threshold is insufficient to separate true cells from background noise (ambient RNA). This tool allows for more sensitive detection of small cells or cells with low RNA content by statistically testing whether a droplet's expression profile differs significantly from the ambient pool.

## Usage Instructions

### Installation
The tool can be installed via conda or pip:
```bash
conda install -c bioconda emptydrops
# OR
pip install emptydrops
```

### Basic Command Line Usage
The primary way to interact with the tool is through the CLI. It typically requires a path to a directory containing the raw matrix files (matrix.mtx, genes.tsv/features.tsv, barcodes.tsv).

```bash
# Basic execution on a CellRanger output directory
emptydrops --input <path_to_raw_feature_bc_matrix> --output <output_directory>
```

### Key Parameters and Best Practices
*   **Input Format**: Ensure the input directory follows the standard 10X Genomics format.
*   **FDR Threshold**: The default False Discovery Rate (FDR) is usually set to 0.01. If you are recovering too few cells, consider inspecting the distribution, but avoid raising the FDR too high to prevent including empty droplets.
*   **Ambient Profile**: The algorithm estimates the ambient RNA profile from droplets with very low UMI counts (typically < 100). Ensure your dataset has enough low-count droplets to provide a stable background estimate.
*   **Filtering**: After running `emptydrops`, the output will typically include a probability or a boolean flag indicating which barcodes are likely cells. Use this to subset your raw matrix for downstream analysis in Scanpy or Seurat.

## Reference documentation
- [emptydrops Overview](./references/anaconda_org_channels_bioconda_packages_emptydrops_overview.md)
- [PyPI Project Page](./references/pypi_org_project_emptydrops.md)