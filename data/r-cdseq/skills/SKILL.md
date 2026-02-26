---
name: r-cdseq
description: CDSeq deconvolutes bulk RNA-seq data to simultaneously estimate cell-type-specific gene expression profiles and sample-specific cell-type proportions. Use when user asks to perform bulk RNA-seq deconvolution, estimate the number of cell types in a mixture, or annotate estimated cell types using single-cell reference data.
homepage: https://cran.r-project.org/web/packages/cdseq/index.html
---


# r-cdseq

## Overview
CDSeq is a computational method for dissecting bulk RNA-Seq data. It takes a gene-by-sample matrix of read counts and simultaneously estimates cell-type-specific gene expression profiles (GEPs) and sample-specific cell-type proportions. A key feature is its ability to estimate the number of cell types (T) automatically if a range of values is provided.

## Installation
Install the released version from CRAN:
```R
install.packages("CDSeq")
```

## Core Workflow

### 1. Basic Deconvolution (Known Number of Cell Types)
Use `CDSeq` when you have a specific number of cell types in mind.
```R
library(CDSeq)

# mixtureGEP: G x M matrix (genes x samples)
# gene_length: vector of gene lengths
result <- CDSeq(bulk_data = mixtureGEP,
               cell_type_number = 6,
               mcmc_iterations = 700, # Recommended: 700-2000
               gene_length = as.vector(gene_length),
               cpu_number = 1)

# Access results
est_geps <- result$estGEP   # Estimated GEPs (G x T)
est_props <- result$estProp # Estimated proportions (T x M)
```

### 2. Estimating the Number of Cell Types
Provide a vector to `cell_type_number`. CDSeq will evaluate each and identify the most likely number of cell types.
```R
result_vector <- CDSeq(bulk_data = mixtureGEP,
                      cell_type_number = 2:10,
                      mcmc_iterations = 700,
                      gene_length = as.vector(gene_length),
                      cpu_number = 4) # Use multiple cores for vector input
```

### 3. Cell Type Annotation with scRNA-seq
After deconvolution, use `cellTypeAssignSCRNA` to annotate the estimated cell types using a single-cell reference.
```R
annotated_result <- cellTypeAssignSCRNA(cdseq_gep = result$estGEP,
                                        cdseq_prop = result$estProp,
                                        sc_gep = sc_reference_data,
                                        sc_annotation = sc_labels,
                                        plot_umap = 1)
```

## Recommended Settings
| Parameter | Recommended Value | Description |
| :--- | :--- | :--- |
| `beta` | 0.5 | Prior for GEPs |
| `alpha` | 5 | Prior for proportions |
| `mcmc_iterations` | 700 - 2000 | Higher values improve convergence |
| `dilution_factor` | 2 - 10 | Downsampling factor to speed up MCMC |
| `gene_subset_size` | 200 - 500 | Number of genes per block |
| `block_number` | > 5 | Number of blocks for parallel processing |

## Tips
- **Input Format**: Ideally, use raw read counts similar to DESeq2 input.
- **Parallelization**: Set `cpu_number` to the length of your `cell_type_number` vector if resources allow.
- **Gene Length**: Providing `gene_length` is highly recommended for accurate GEP estimation.

## Reference documentation
- [NEWS.md](./references/NEWS.md)
- [README.Rmd.md](./references/README.Rmd.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [cran-comments.md](./references/cran-comments.md)
- [home_page.md](./references/home_page.md)