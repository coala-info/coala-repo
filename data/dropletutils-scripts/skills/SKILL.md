---
name: dropletutils-scripts
description: The `dropletutils-scripts` package provides a suite of R-based command-line wrappers for the Bioconductor package `DropletUtils`.
homepage: https://github.com/ebi-gene-expression-group/dropletutils-scripts
---

# dropletutils-scripts

## Overview
The `dropletutils-scripts` package provides a suite of R-based command-line wrappers for the Bioconductor package `DropletUtils`. This skill allows for the execution of critical early-stage single-cell analysis tasks—such as ambient RNA removal and data ingestion—directly from the terminal without writing R code. It is particularly useful for building reproducible bioinformatics pipelines that require language-agnostic execution of R-specific functions.

## Core CLI Workflows

### 1. Data Ingestion (10x Genomics)
Convert raw 10x Genomics output directories into a serialized SingleCellExperiment (SCE) object.
- **Command**: `dropletutils-read-10x-counts.R`
- **Key Arguments**:
    - `-s`: Comma-separated list of 10x directories (containing `matrix.mtx`, `barcodes.tsv`, and `features.tsv`).
    - `-c`: Logical (`TRUE`/`FALSE`) to name columns by barcode.
    - `-o`: Output path for the `.rds` file.

### 2. Identifying Empty Droplets
Distinguish between droplets containing cells and those containing only ambient RNA using the `emptyDrops` algorithm.
- **Command**: `dropletutils-empty-drops.R`
- **Key Arguments**:
    - `-i`: Input `.rds` file (SCE object).
    - `-l`: Lower bound for total UMI counts; droplets below this are assumed to be empty (default is often 100).
    - `-f`: Logical to filter the output object to keep only identified cells.
    - `-d`: FDR threshold (e.g., 0.01) to define a droplet as a cell.
    - `-o`: Output path for the filtered SCE object.
    - `-t`: Output path for a text file containing the statistics.

### 3. Barcode Ranking and Knee Plots
Calculate barcode ranks to visualize the "knee" and "inflection" points, helping to determine the threshold for cell-containing droplets.
- **Command**: `dropletutils-barcoderanks.R`
- **Key Arguments**:
    - `-i`: Input `.rds` file.
    - `-p`: Path to save the barcode rank plot (e.g., `knee_plot.png`).
    - `-o`: Output path for the SCE object with rank metadata.

### 4. Matrix Downsampling
Simulate lower sequencing depth by downsampling the count matrix.
- **Command**: `dropletutils-downsample-matrix.R`
- **Key Arguments**:
    - `-p`: A single proportion (0 to 1) or a file containing one value per column.
    - `-c`: Logical; if `TRUE`, downsampling is performed by column.

## Best Practices and Tips
- **Input Format**: Ensure that 10x directories follow the standard structure. For newer 10x versions, the script expects `features.tsv.gz` rather than `genes.tsv`.
- **Memory Management**: Processing large sparse matrices in R can be memory-intensive. Ensure the execution environment has sufficient RAM, especially when running `emptyDrops` with a high number of iterations (`-n`).
- **FDR Thresholding**: When using `dropletutils-empty-drops.R`, the default FDR is often strict. If you expect a high number of small cells, you may need to inspect the text output (`-t`) before applying the filter (`-f`).
- **Serialization**: All scripts primarily output `.rds` files. These are serialized R objects that can be loaded into an R session using `readRDS()` for further downstream analysis with Seurat or Scater.

## Reference documentation
- [DropletUtils Scripts Overview](./references/anaconda_org_channels_bioconda_packages_dropletutils-scripts_overview.md)
- [DropletUtils GitHub Repository](./references/github_com_ebi-gene-expression-group_dropletutils-scripts.md)