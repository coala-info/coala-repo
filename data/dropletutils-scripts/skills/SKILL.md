---
name: dropletutils-scripts
description: This tool provides command-line interfaces for processing single-cell droplet data using the DropletUtils Bioconductor library. Use when user asks to import 10x Genomics data, perform barcode rank analysis, distinguish real cells from empty droplets using EmptyDrops, or downsample UMI matrices.
homepage: https://github.com/ebi-gene-expression-group/dropletutils-scripts
---

# dropletutils-scripts

## Overview
The `dropletutils-scripts` package provides a suite of R-based command-line interfaces for the `DropletUtils` Bioconductor library. It is designed to bridge the gap between interactive R sessions and automated bioinformatics pipelines. This skill enables the execution of core droplet processing tasks—such as distinguishing real cells from ambient RNA and normalizing library sizes via downsampling—directly from the terminal using serialized `SingleCellExperiment` (.rds) objects.

## Core Workflows

### 1. Importing 10x Genomics Data
Convert raw 10x Genomics output directories into a serialized `SingleCellExperiment` object.
```bash
dropletutils-read-10x-counts.R \
    -s <data_dir1,data_dir2> \
    -c TRUE \
    -o output_sce.rds
```
*   **Expert Tip**: Use `-c TRUE` to ensure column names in the resulting matrix match the cell barcodes, which is essential for downstream merging or annotation.

### 2. Barcode Rank Analysis (Knee Plots)
Calculate barcode ranks to visualize the distribution of UMI counts and identify the "knee" and "inflection" points.
```bash
dropletutils-barcoderanks.R \
    -i input_sce.rds \
    -l 100 \
    -o ranked_sce.rds \
    -p barcode_ranks_plot.png
```
*   **Parameters**: `-l` (lower) sets the UMI threshold below which barcodes are guaranteed to be empty.

### 3. Cell Calling (EmptyDrops)
Distinguish genuine cells from empty droplets containing ambient RNA using the `emptyDrops` algorithm.
```bash
dropletutils-empty-drops.R \
    -i input_sce.rds \
    -l 100 \
    -f TRUE \
    -d 0.01 \
    -o filtered_cells.rds \
    -t empty_drops_stats.txt
```
*   **Filtering**: Setting `-f TRUE` will automatically return a `SingleCellExperiment` object containing only the detected cells based on the FDR threshold (`-d`).
*   **Statistical Power**: Increase `-n` (default iterations) if you have a very large number of barcodes to improve the precision of the p-value estimates.

### 4. Matrix Downsampling
Normalize library sizes across cells or samples by downsampling the UMI matrix.
```bash
dropletutils-downsample-matrix.R \
    -i input_sce.rds \
    -p 0.5 \
    -o downsampled_sce.rds
```
*   **Flexible Proportions**: The `-p` flag accepts either a single numeric value (0-1) for global downsampling or a path to a file containing specific proportions for every column in the matrix.

## Best Practices
*   **Input/Output**: All scripts primarily consume and produce `.rds` files containing `SingleCellExperiment` objects. Ensure your upstream and downstream tools are compatible with this Bioconductor standard.
*   **Memory Management**: Droplet processing can be memory-intensive. When running `empty-drops.R` on large datasets, ensure the environment has sufficient RAM to hold the sparse matrix and the null distribution calculations.
*   **Validation**: Always generate the PNG output in `barcoderanks.R` to manually verify that the automated knee/inflection points align with the visual profile of your library.



## Subcommands

| Command | Description |
|---------|-------------|
| /usr/local/bin/dropletutils-empty-drops.R | Identify empty droplets from UMI count data. |
| /usr/local/bin/dropletutils-read-10x-counts.R | Reads data from 10X Genomics single-cell RNA-seq experiments. |
| dropletutils-barcoderanks.R | R script for barcode ranking in droplet-based single-cell experiments. |
| dropletutils-downsample-matrix.R | Downsamples a SingleCellExperiment object by a specified proportion. |

## Reference documentation
- [Wrapper scripts for components of the DropletUtils package](./references/github_com_ebi-gene-expression-group_dropletutils-scripts_blob_develop_README.md)
- [Barcode Ranks Script Details](./references/github_com_ebi-gene-expression-group_dropletutils-scripts_blob_develop_dropletutils-barcoderanks.R.md)
- [Empty Drops Script Details](./references/github_com_ebi-gene-expression-group_dropletutils-scripts_blob_develop_dropletutils-empty-drops.R.md)
- [Downsample Matrix Script Details](./references/github_com_ebi-gene-expression-group_dropletutils-scripts_blob_develop_dropletutils-downsample-matrix.R.md)