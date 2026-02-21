---
name: bioconductor-dreamlet
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/dreamlet.html
---

# bioconductor-dreamlet

name: bioconductor-dreamlet
description: Perform differential expression analysis on single-cell/nucleus RNA-seq data using linear (mixed) models on pseudobulk counts. Use this skill for: (1) Aggregating single-cell data to pseudobulk, (2) Running voom-style normalization for complex study designs, (3) Performing variance partitioning to identify sources of expression variation, (4) Conducting differential expression analysis with random effects, (5) Gene set analysis using zenith, and (6) Bayesian borrowing of information across cell types with mashr.

## Overview

The `dreamlet` package provides a comprehensive workflow for analyzing large-scale single-cell datasets with complex study designs (e.g., repeated measures, multiple batches). It leverages the "dream" (Differential Expression for Repeated Measures) framework to apply linear mixed models to pseudobulk data. By summing counts within cell types and samples, `dreamlet` achieves high performance and statistical rigor, allowing for the inclusion of random effects to account for correlation structures in the data.

## Core Workflow

### 1. Data Preparation and Pseudobulk Aggregation
Start with a `SingleCellExperiment` (SCE) object. Ensure your `colData` contains variables for both the cell cluster (e.g., "cell_type") and the sample/individual ID.

```R
library(dreamlet)

# Create unique sample identifier if needed
sce$id <- paste0(sce$StimStatus, sce$ind)

# Aggregate to pseudobulk
pb <- aggregateToPseudoBulk(sce,
  assay = "counts",    # raw counts
  cluster_id = "cell", # cell type variable
  sample_id = "id",    # sample/donor variable
  verbose = FALSE
)
```

### 2. Normalization and Voom Transformation
Use `processAssays` to normalize counts and apply voom weights. This function handles the formula and filters genes/samples automatically.

```R
# Define formula (use (1|ID) for random effects)
form <- ~ StimStatus + (1|Batch)

# Process assays
res.proc <- processAssays(pb, form, min.count = 5)

# Visualize mean-variance trend
plotVoom(res.proc)
```

### 3. Variance Partitioning
Quantify how much variation is explained by each variable in your model.

```R
vp.lst <- fitVarPart(res.proc, form)
plotVarPart(vp.lst)
```

### 4. Differential Expression
Run the `dreamlet` function to fit the models across all cell types.

```R
res.dl <- dreamlet(res.proc, form)

# Extract results for a specific coefficient
topTable(res.dl, coef = "StimStatusstim")

# Volcano plot for a specific coefficient
plotVolcano(res.dl, coef = "StimStatusstim")
```

## Advanced Features

### Modeling Cell-Level Covariates
If you have continuous cell-level variables (e.g., mitochondrial rate), `dreamlet` can aggregate these using the mean value per cell type during the pseudobulk step. These are stored in `metadata(pb)$aggr_means` and used automatically in the regression.

### Bayesian Integration with mashr
To improve power by borrowing information across cell types and genes:

```R
# Run mashr on dreamlet results
res_mash = run_mash(res.dl, coef='StimStatusstim')

# Extract posterior means
library(mashr)
get_pm(res_mash$model)

# Visualize with forest plots
plotForest(res_mash, "ISG20")
```

### Gene Set Analysis with zenith
Perform competitive gene set testing (similar to `camera`) using the full spectrum of test statistics.

```R
library(zenith)
go.gs <- get_GeneOntology("BP", to = "SYMBOL")
res_zenith <- zenith_gsa(res.dl, coef = "StimStatusstim", go.gs)
plotZenithResults(res_zenith, 5, 1)
```

### Handling Large Datasets (H5AD)
For datasets too large for memory, use `zellkonverter` to read H5AD files as `DelayedArray` objects. `dreamlet` functions are optimized to work with these on-disk backends.

```R
library(zellkonverter)
sce <- readH5AD("data.h5ad", use_hdf5 = TRUE)
```

## Troubleshooting and Tips

- **Model Failures**: Use `details(res.dl)` to see how many genes failed in each assay. Use `seeErrors(res.dl)` to extract specific error messages.
- **Colinearity**: If a variable is dropped from the formula for a specific cell type, it is usually because that variable has no variation within the samples retained for that cell type.
- **Scaling**: If you see "predictor variables are on very different scales," wrap continuous variables in `scale()` within your formula.
- **Contrasts**: For complex comparisons, use the `contrasts` argument in `dreamlet()` (e.g., `contrasts = c(Diff = "GroupA - GroupB")`).

## Reference documentation

- [Modeling continuous cell-level covariates](./references/cell_covs.md)
- [Dreamlet analysis of single cell RNA-seq](./references/dreamlet.md)
- [Error handling](./references/errors.md)
- [Handling large H5AD datasets](./references/h5ad_on_disk.md)
- [mashr analysis after dreamlet](./references/mashr.md)
- [Testing non-linear effects](./references/non_lin_eff.md)