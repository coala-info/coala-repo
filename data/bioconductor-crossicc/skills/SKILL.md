---
name: bioconductor-crossicc
description: CrossICC identifies robust biological subtypes across multiple datasets using an iterative consensus clustering strategy. Use when user asks to identify consensus clusters across different platforms, perform meta-analysis of cancer datasets, or predict subtypes in new expression data.
homepage: https://bioconductor.org/packages/3.10/bioc/html/CrossICC.html
---

# bioconductor-crossicc

## Overview

CrossICC (Cross-platform Iterative Consensus Clustering) is an R package designed to identify robust biological subtypes across multiple datasets. Unlike traditional clustering methods that often require extensive batch correction or normalization when combining data from different platforms, CrossICC uses an iterative strategy to derive an optimal gene set and cluster number directly from a consensus similarity matrix. This makes it particularly effective for meta-analysis of cancer datasets where platform-specific biases are common.

## Core Workflow

### 1. Data Preparation
CrossICC expects input as a `list` of expression matrices (genes in rows, samples in columns).

```r
library(CrossICC)

# Option 1: Load from CSV files in a directory
files <- list.files(path = "path/to/data", pattern = ".csv")
crossicc_input <- CrossICCInput(files)

# Option 2: Manual list creation
# data_list <- list(study1 = matrix1, study2 = matrix2)
```

### 2. Running the Iterative Clustering
The main function `CrossICC()` performs the iterative selection of features and clusters.

```r
# Basic execution
# skip.mfs = TRUE skips merging, filtering, and scaling if data is already pre-processed
crossicc_res <- CrossICC(crossicc_input, 
                         skip.mfs = FALSE, 
                         use.shiny = FALSE, 
                         output.dir = tempdir())
```

**Key Parameters:**
- `max.iter`: Maximum number of iterations (default is usually sufficient for convergence).
- `filter.cutoff`: Threshold for gene filtering.
- `use.shiny`: Set to `TRUE` to launch an interactive web interface for result exploration after the run.

### 3. Downstream Analysis

#### Subtype Prediction
You can use the centroids identified by CrossICC to predict subtypes in a new, independent dataset.

```r
# predicted will contain correlation scores and assigned clusters
predicted_subtypes <- predictor(new_expression_matrix, crossicc_res)
```

#### Pathway Analysis (ssGSEA)
Generate GSEA-like ranked eigenvalue matrices to compare samples based on pathway information.

```r
# Extract cluster assignments
clusters <- paste0("K", crossicc_res$clusters$clusters[[1]])

# Run ssGSEA
gs_results <- ssGSEA(x = crossicc_input[[1]], 
                     gene.signature = crossicc_res$gene.signature, 
                     geneset2gene = crossicc_res$unioned.genesets, 
                     cluster = clusters)
```

## Tips for Success

- **Gene Identifiers:** Ensure that gene symbols or IDs are consistent across all datasets in the input list. CrossICC relies on the intersection of features across platforms.
- **Convergence:** The algorithm typically converges when the gene set stabilizes. Monitor the console output to see the number of genes engaged in each iteration.
- **Visualization:** If `use.shiny = TRUE` was not used during the initial run, you can load the generated `.rds` file into the Shiny app later for interactive visualization of the consensus matrix and cluster stability.
- **Memory:** For very large datasets, ensure your R session has sufficient memory, as consensus clustering involves generating large similarity matrices.

## Reference documentation

- [CrossICC](./references/CrossICC.md)