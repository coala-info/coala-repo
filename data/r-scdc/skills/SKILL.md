---
name: r-scdc
description: SCDC is an R package that deconvolves bulk RNA-seq samples by integrating cell-type specific gene expressions from multiple single-cell RNA-seq reference datasets using an ensemble method. Use when user asks to deconvolve bulk RNA-seq data, estimate cell type proportions, or integrate multiple single-cell references to address batch effects.
homepage: https://cran.r-project.org/web/packages/scdc/index.html
---

# r-scdc

## Overview
SCDC (Scalable Deconvolution of Complex Bulk RNA-seq) is an R package that leverages cell-type specific gene expressions from multiple single-cell RNA-seq (scRNA-seq) reference datasets to deconvolve bulk RNA-seq samples. It uses an ENSEMBLE method to integrate results from different laboratories and platforms, implicitly addressing batch-effect confounding.

## Installation
Install the package from GitHub using `devtools`:

```R
if (!require("devtools")) install.packages("devtools")
devtools::install_github("meichendong/SCDC")

# Dependency 'xbioc' may require manual installation:
# remotes::install_github("renozao/xbioc")
```

## Core Workflow

### 1. Data Preparation
Ensure bulk and single-cell data are in consistent formats (typically raw counts). Data should be stored in `ExpressionSet` objects.

### 2. Quality Control and Basis Matrix Construction
Filter genes and clusters to build the reference basis matrix.
- For multiple subjects in a reference: Use `SCDC_qc()` and `SCDC_basis()`.
- For a single subject in a reference: Use `SCDC_qc_ONE()`.

### 3. Proportion Estimation
Perform deconvolution using one or more references.

**Single Reference Deconvolution:**
```R
# For multiple subjects in the reference
results <- SCDC_prop(bulk.eset = bulk_data, sc.eset = sc_data, 
                     ct.varname = "cell_type", sample.varname = "subject",
                     ct.sub = c("TypeA", "TypeB", "TypeC"))

# For a single subject in the reference
results_one <- SCDC_prop_ONE(bulk.eset = bulk_data, sc.eset = sc_data,
                             ct.varname = "cell_type", ct.sub = c("TypeA", "TypeB"))
```

**Multiple Reference (ENSEMBLE) Deconvolution:**
Integrate results from different scRNA-seq datasets to improve robustness.
```R
# Combine results from different references
ensemble_results <- SCDC_ensemble(bulk.eset = bulk_data, 
                                  prop.list = list(res1$prop.est, res2$prop.est),
                                  exp.list = list(res1$basis.m, res2$basis.m))
```

## Best Practices
- **Consistency:** Ensure bulk and single-cell data use the same gene identifiers and are in the same scale (raw counts are preferred).
- **Gene Filtering:** Filter out lowly expressed genes, ribosomal genes, and mitochondrial genes before analysis to reduce noise.
- **Cell Size Factors:** SCDC assumes the ratio of library sizes between cell types reflects the ratio of real cell sizes. If this is untrue for your data, manually input the cell size factor when constructing the basis matrix.
- **Missing Types:** If a major cell type present in the bulk sample is missing from the scRNA-seq reference, deconvolution accuracy will decrease significantly.

## Reference documentation
- [README.Rmd](./references/README.Rmd.md)
- [README.md](./references/README.md)
- [Articles](./references/articles.md)
- [Home Page](./references/home_page.md)