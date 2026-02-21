---
name: bioconductor-eds
description: the package is predominantly for simplifying package dependency graph for other Bioconductor packages.
homepage: https://bioconductor.org/packages/release/bioc/html/eds.html
---

# bioconductor-eds

## Overview

The `eds` package is a specialized, low-level utility designed to read Alevin's **Efficient single cell binary Data Storage (EDS)** format. It provides a memory-efficient way to load single-cell feature-count matrices into R as sparse matrices (using the `Matrix` package). While `eds` is often used as a backend dependency for higher-level packages like `tximport` or `tximeta`, it can be used directly for custom data loading workflows where minimal dependencies are required.

## Core Workflow

To read EDS data, you must provide the path to the compressed count matrix and the dimensions (number of cells and genes) derived from the associated barcode and gene files.

### 1. Prepare File Paths
Identify the three core files produced by Alevin:
- `quants_mat.gz`: The binary count data.
- `quants_mat_rows.txt`: The cell barcodes (rows).
- `quants_mat_cols.txt`: The gene/feature names (columns).

### 2. Determine Matrix Dimensions
The `readEDS` function requires explicit dimensions. Read the row and column files to determine these counts:

```r
library(eds)

# Define paths
barcode_file <- "path/to/alevin/quants_mat_rows.txt"
gene_file <- "path/to/alevin/quants_mat_cols.txt"
matrix_file <- "path/to/alevin/quants_mat.gz"

# Get dimensions
cell_names <- readLines(barcode_file)
gene_names <- readLines(gene_file)

num_cells <- length(cell_names)
num_genes <- length(gene_names)
```

### 3. Import the Sparse Matrix
Use `readEDS` to generate a `dgCMatrix`:

```r
mat <- readEDS(
    numOfGenes = num_genes,
    numOfOriginalCells = num_cells,
    countMatFilename = matrix_file
)

# Assign names for usability
rownames(mat) <- cell_names
colnames(mat) <- gene_names
```

## Usage Tips

- **Memory Efficiency**: The resulting object is a sparse matrix from the `Matrix` package, which is significantly more memory-efficient than a standard dense R matrix.
- **Higher-level Alternatives**: If the goal is to create a `SingleCellExperiment` object or perform standard transcript quantification imports, consider using `tximeta` or `tximport` respectively, as they handle metadata and coordinate systems automatically.
- **Dependency Management**: Use `eds` directly if you are developing a package and want to keep the dependency footprint small while still supporting Alevin EDS formats.

## Reference documentation

- [eds: Low-level reader function for Alevin EDS format](./references/eds.Rmd)
- [eds: Low-level reader function for Alevin EDS format (Markdown)](./references/eds.md)