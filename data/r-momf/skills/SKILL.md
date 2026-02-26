---
name: r-momf
description: The momf package deconvolutes bulk RNA-seq data using a multi-omics matrix factorization framework to estimate cell type proportions. Use when user asks to deconvolute bulk RNA-seq data, estimate cell type proportions, or integrate single-cell and bulk expression data.
homepage: https://cran.r-project.org/web/packages/momf/index.html
---


# r-momf

## Overview
The `momf` package provides an efficient and flexible method for deconvoluting bulk RNA-seq data. It utilizes a Multi-Omics Matrix Factorization framework to integrate bulk expression data with single-cell RNA-seq data to estimate the relative proportions of different cell types within the bulk samples.

## Installation
To install the package from GitHub (as it is primarily hosted there):

```R
if (!require("devtools")) install.packages("devtools")
devtools::install_github("sqsun/MOMF")
```

## Core Workflow

### 1. Prepare Reference Data
Before running the deconvolution, you must compute the cell-type-specific expression levels from your scRNA-seq data.

```R
library(MOMF)

# sc_counts: matrix (#cells x #genes)
# sc_cell_type: vector of cell type labels for each cell
priorU <- momf.computeRef(sc_counts, sc_cell_type)
```

### 2. Format Input Data
MOMF requires a list containing both the single-cell and bulk expression matrices. Note that the matrices should be transposed to (#genes x #observations).

```R
# sc_counts: #cells x #genes -> transposed to #genes x #cells
# bulk_counts: #individuals x #genes -> transposed to #genes x #individuals
GList <- list(X1 = t(sc_counts), X2 = t(bulk_counts))
```

### 3. Run Deconvolution
Use `momf.fit` to perform the deconvolution. The `method` parameter typically uses "KL" (Kullback-Leibler divergence).

```R
momf_res <- momf.fit(
  DataX = GList, 
  DataPriorU = priorU, 
  method = "KL", 
  rho = 2, 
  num_iter = 100
)
```

### 4. Extract Results
The estimated cell type proportions for the bulk samples are stored in the `cell.prop` element of the result object.

```R
cell_prop <- momf_res$cell.prop
# Visualize results
heatmap(cell_prop)
```

## Tips for Success
- **Gene Matching**: Ensure that the gene names (row names) in your bulk data match the gene names in your single-cell reference.
- **Normalization**: While the package handles internal factorization, ensure your input counts are appropriately pre-processed (e.g., library size normalized) if required by your specific experimental design.
- **Iteration**: If the model does not converge, consider increasing `num_iter`.

## Reference documentation
- [LICENSE.md](./references/LICENSE.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)