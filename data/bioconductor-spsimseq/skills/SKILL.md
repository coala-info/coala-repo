---
name: bioconductor-spsimseq
description: This tool performs semi-parametric simulation of bulk and single-cell RNA-seq data by modeling gene-wise distributions and correlation structures from real source datasets. Use when user asks to generate synthetic RNA-seq counts, simulate single-cell data with realistic zero-count patterns, or create datasets with specified differential expression and group configurations.
homepage: https://bioconductor.org/packages/release/bioc/html/SPsimSeq.html
---

# bioconductor-spsimseq

name: bioconductor-spsimseq
description: Semi-parametric simulation of bulk and single-cell RNA-seq data using the SPsimSeq package. Use this skill to generate realistic synthetic RNA-seq datasets that retain the characteristics of real source data, including gene-wise distributions, between-gene correlation structures, and zero-count patterns.

## Overview

SPsimSeq is a semi-parametric procedure for simulating RNA-seq data. Unlike fully parametric models, it estimates gene-wise distributions using log-linear model-based density estimation and maintains correlation structures via Gaussian copulas. It is particularly effective for single-cell data because it explicitly models the relationship between zero probability, mean expression, and library size.

## Core Workflow

The primary function is `SPsimSeq()`. It requires a source dataset (count matrix) to use as a template for the simulation.

### 1. Data Preparation
Ensure your source data is a count matrix and you have a grouping variable (e.g., treatment vs. control). It is recommended to filter out genes with extremely low expression before simulation to avoid estimation errors.

```r
library(SPsimSeq)
data("zhang.data.sub")
zhang.counts <- zhang.data.sub$counts
MYCN.status  <- zhang.data.sub$MYCN.status
```

### 2. Simulating Bulk RNA-seq
For bulk data, `model.zero.prob` is typically set to `FALSE`.

```r
sim.bulk <- SPsimSeq(
  n.sim = 1, 
  s.data = zhang.counts,
  group = MYCN.status, 
  n.genes = 3000, 
  batch.config = 1,
  group.config = c(0.5, 0.5), 
  tot.samples = ncol(zhang.counts), 
  pDE = 0.1, 
  lfc.thrld = 0.5, 
  result.format = "list"
)
```

### 3. Simulating Single-Cell RNA-seq
For single-cell data, set `model.zero.prob = TRUE` to account for high sparsity. You can also return the result as a `SingleCellExperiment` object.

```r
library(SingleCellExperiment)
data("scNGP.data")

sim.sc <- SPsimSeq(
  n.sim = 1, 
  s.data = scNGP.data,
  group = scNGP.data$characteristics..treatment, 
  n.genes = 4000, 
  model.zero.prob = TRUE,
  result.format = "SCE"
)
```

## Key Parameters

- `s.data`: Source data (matrix or SummarizedExperiment).
- `n.sim`: Number of independent datasets to simulate.
- `n.genes`: Number of genes to simulate.
- `tot.samples`: Total number of samples/cells in the simulated data.
- `group.config`: A vector of proportions for each group (e.g., `c(0.5, 0.5)` for two equal groups).
- `pDE`: Proportion of differentially expressed (DE) genes.
- `lfc.thrld`: Log-fold-change threshold used to identify candidate DE genes from the source data.
- `result.format`: Either `"list"` or `"SCE"` (SingleCellExperiment).
- `return.details`: If `TRUE`, returns density estimates and other internal parameters.

## Accessing Results

If `result.format = "list"`, the output contains a list of simulated datasets. Each entry includes:
- `counts`: The simulated count matrix.
- `colData`: Sample metadata (Batch, Group, Library Size).
- `rowData`: Gene metadata (DE indicator, source gene ID).

```r
# Accessing the first simulation
sim_res <- sim.bulk$sim.data.list[[1]]
counts <- sim_res$counts
gene_info <- sim_res$rowData
```

## Tips for Success

- **Seed Setting**: Always use `set.seed()` before running `SPsimSeq` to ensure reproducibility of the stochastic simulation process.
- **Library Sizes**: By default, SPsimSeq uses the library sizes from the source data. Use the `variable.lib.size` argument if you need to model library size variation differently.
- **Insufficient DE Genes**: If the source data has fewer DE genes than requested by `pDE`, the package will sample candidate genes with replacement and issue a warning.
- **Density Evaluation**: If `return.details = TRUE`, use `evaluateDensities(sim.object, newData = "GeneName")` to inspect the estimated distributions for specific genes.

## Reference documentation

- [Manual for the SPsimSeq package: semi-parametric simulation for bulk and single cell RNA-seq data](./references/SPsimSeq.md)
- [SPsimSeq Vignette Source](./references/SPsimSeq.Rmd)