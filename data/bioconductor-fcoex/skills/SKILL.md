---
name: bioconductor-fcoex
description: The package structure is based on the CEMiTool package.
homepage: https://bioconductor.org/packages/3.10/bioc/html/fcoex.html
---

# bioconductor-fcoex

## Overview

The `fcoex` package provides a framework for generating modular co-expression networks specifically designed for single-cell data. It utilizes a discretization approach followed by the Fast Correlation-Based Filter (FCBF) algorithm to identify "header" genes and build modules around them. A unique feature of `fcoex` is the ability to "re-cluster" cells into Header-Positive (HP) and Header-Negative (HN) populations based on these modules, allowing for the discovery of biological patterns that might be masked in standard clustering.

## Core Workflow

### 1. Object Initialization
`fcoex` requires a normalized expression matrix (genes in rows, cells in columns) and a target factor (e.g., cluster labels).

```r
library(fcoex)
# exprs: data.frame of normalized counts
# target: factor of cell labels (e.g., from Seurat or SingleCellExperiment)
fc <- new_fcoex(exprs, target)
```

### 2. Discretization
The expression data must be discretized (typically binarized) to calculate Symmetrical Uncertainty.
```r
# number_of_bins = 2 results in binarization (low/high)
fc <- discretize(fc, number_of_bins = 8)
```

### 3. Module Detection
The `find_cbf_modules` function identifies header genes and builds modules.
```r
# n_genes: number of top genes ranked by correlation to target to consider
fc <- find_cbf_modules(fc, n_genes = 200, verbose = FALSE, is_parallel = FALSE)
```

### 4. Visualization and Enrichment
Generate network plots and perform Over-Representation Analysis (ORA).
```r
# Generate and show networks
fc <- get_nets(fc)
show_net(fc)[["GENE_NAME"]]

# ORA using a GMT file
gmt_fname <- system.file("extdata", "pathways.gmt", package = "CEMiTool")
gmt_in <- pathwayPCA::read_gmt(gmt_fname)
fc <- mod_ora(fc, gmt_in)
fc <- plot_ora(fc)

# Save all plots to a directory
save_plots(name = "my_analysis", fc, directory = "./Plots")
```

### 5. Re-clustering
Create new cell labels based on the expression of module headers.
```r
fc <- recluster(fc)

# Access new labels (Header-Positive vs Header-Negative)
new_labels <- idents(fc)$GENE_NAME
```

## Integration Tips

### With SingleCellExperiment
```r
target <- colData(sce)$clusters
exprs <- as.data.frame(assay(sce, 'logcounts'))
fc <- new_fcoex(exprs, target)
```

### With Seurat
```r
exprs <- data.frame(GetAssayData(seurat_obj, slot = "data"))
target <- Idents(seurat_obj)
fc <- new_fcoex(exprs, target)
```

## Key Functions Reference
- `new_fcoex()`: Constructor for the fcoex object.
- `discretize()`: Converts continuous expression to discrete bins.
- `find_cbf_modules()`: Core algorithm for feature selection and module extraction.
- `get_nets()` / `show_net()`: Create and retrieve network visualizations.
- `recluster()`: Generates binary classifications for cells based on module headers.
- `mod_ora()`: Performs pathway enrichment on modules.

## Reference documentation
- [fcoex: co-expression for single-cell data](./references/fcoex.md)