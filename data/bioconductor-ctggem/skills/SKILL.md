---
name: bioconductor-ctggem
description: The ctgGEM package provides a unified interface to run multiple pseudotime trajectory inference algorithms and generate cell-state hierarchies from gene expression matrices. Use when user asks to build cell trees, perform trajectory inference using Monocle, TSCAN, Sincell, or destiny, and export results to SIF format.
homepage: https://bioconductor.org/packages/3.11/bioc/html/ctgGEM.html
---


# bioconductor-ctggem

## Overview

The `ctgGEM` (Cell Tree Generator for Gene Expression Matrices) package provides a unified interface to several popular pseudotime trajectory inference tools. It streamlines the process of building cell-state hierarchies by allowing users to run different algorithms using a single data object and a consistent function call. It also facilitates downstream analysis by exporting results in the SIF (Simple Interaction Format) file format.

## Core Workflow

### 1. Data Preparation
The package uses the `ctgGEMset` class, which extends `SummarizedExperiment`. You must provide three components:
- `exprsData`: Numeric matrix (genes as rows, cells as columns).
- `phenoData`: Data frame of cell attributes (rows match cells).
- `featureData`: Data frame of gene attributes (rows match genes).

```r
library(ctgGEM)
# Construct the object
toyGEMset <- ctgGEMset(exprsData = HSMM_expr_matrix,
                       phenoData = HSMM_sample_sheet,
                       featureData = HSMM_gene_annotation)
```

### 2. Configuring Algorithm-Specific Parameters
Before generating the tree, set parameters for the specific method using the appropriate helper functions.

**Monocle (`monocleInfo`):**
- Requires `gene_id` (column name in featureData) and `ex_type` ("UMI", "TC", "FPKM", "TPM", etc.).
- Semi-supervised mode: Set `cell_id_1` and `cell_id_2` with marker gene names.
```r
monocleInfo(toyGEMset, "gene_id") <- "gene_short_name"
monocleInfo(toyGEMset, "ex_type") <- "FPKM"
# Optional: semi-supervised
monocleInfo(toyGEMset, "cell_id_1") <- "MYF5"
```

**TSCAN (`TSCANinfo`):**
- Supply a specific gene row name to generate a gene-vs-pseudotime plot.
```r
TSCANinfo(toyGEMset) <- "ENSG00000000003.10"
```

**Sincell (`sincellInfo`):**
- Set `method` (e.g., "pearson", "PCA", "tSNE") and `clust.method` (e.g., "knn", "k-medoids").
```r
sincellInfo(toyGEMset, "method") <- "classical-MDS"
sincellInfo(toyGEMset, "clust.method") <- "k-medoids"
```

### 3. Generating the Tree
Use `generate_tree` to execute the algorithm. This function updates the object and saves outputs (SIF files and PNG plots) to the specified directory.

```r
# treeType can be "monocle", "TSCAN", "sincell", or "destiny"
toyGEMset <- generate_tree(dataSet = toyGEMset, treeType = "monocle", outputDir = "my_results")
```

### 4. Accessing Results
- **Original Objects:** Access the native output of the underlying package via `originalTrees(toyGEMset)`.
- **Igraph Objects:** Access simplified graph versions via `treeList(toyGEMset)`.
- **Files:** Check the `CTG-Output` folder for `.SIF` files (in `/SIFs`) and `.png` visualizations (in `/Plots`).

## Tips and Best Practices
- **Data Transformation:** `destiny` performs best with variance-stabilized data (log or rlog). `monocle` and `TSCAN` require strictly non-negative values.
- **Unsupervised vs. Semi-supervised:** For `monocle`, if you do not set `cell_id_1` and `cell_id_2`, the package defaults to unsupervised mode.
- **Visualization:** If you need to tweak plots after generation, use the `plot_tree` function on the updated `ctgGEMset` object.

## Reference documentation
- [Using ctgGEM](./references/ctgGEM-Vignette.md)