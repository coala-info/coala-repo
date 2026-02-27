---
name: bioconductor-scde
description: The scde package provides statistical methods for analyzing single-cell RNA-seq data by modeling technical noise and drop-out events. Use when user asks to fit individual error models, perform differential expression analysis between cell groups, or run the PAGODA framework for pathway and gene set overdispersion analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/scde.html
---


# bioconductor-scde

name: bioconductor-scde
description: Single-cell RNA-seq analysis using the scde package. Use this skill for fitting individual error models to single-cell data, performing differential expression analysis between cell groups, and running the PAGODA framework for pathway and gene set overdispersion analysis to identify cell subpopulations.

# bioconductor-scde

## Overview
The `scde` package provides statistical methods for analyzing single-cell RNA-seq data, specifically addressing the high noise levels and "drop-out" events (where a gene is expressed but not detected) characteristic of single-cell protocols. It models read counts using a mixture of Negative Binomial (for detected signal) and Poisson (for background/drop-out) distributions. The package also includes the `pagoda` framework for characterizing transcriptional heterogeneity through pathway and gene set overdispersion analysis.

## Core Workflow: Differential Expression

### 1. Data Preparation
Clean the count matrix to remove poor quality cells and lowly expressed genes.
```r
library(scde)
# cd is a count matrix: rows=genes, cols=cells
cd <- clean.counts(counts, min.lib.size=1000, min.reads=1, min.detected=1)

# Define groups for comparison
sg <- factor(gsub("(MEF|ESC).*", "\\1", colnames(cd)), levels = c("ESC", "MEF"))
names(sg) <- colnames(cd)
```

### 2. Fitting Error Models
Fit cell-specific error models. This step is computationally intensive; use `n.cores` for parallelization.
```r
o.ifm <- scde.error.models(counts = cd, groups = sg, n.cores = 4, threshold.segmentation = TRUE)

# Filter out cells with poor fits (negative correlation)
valid.cells <- o.ifm$corr.a > 0
o.ifm <- o.ifm[valid.cells, ]
```

### 3. Expression Prior and Testing
Estimate the gene expression prior and test for differential expression.
```r
# Estimate prior
o.prior <- scde.expression.prior(models = o.ifm, counts = cd, length.out = 400)

# Run differential expression
ediff <- scde.expression.difference(o.ifm, cd, o.prior, groups = sg, n.randomizations = 100, n.cores = 4)

# Top upregulated genes
head(ediff[order(ediff$Z, decreasing = TRUE), ])
```

## Core Workflow: PAGODA (Pathway Analysis)

PAGODA identifies pathways or gene sets showing significant excess of coordinated variability.

### 1. Variance Normalization
```r
# Fit KNN error models for heterogeneous populations
knn <- knn.error.models(cd, k = ncol(cd)/4, n.cores = 4, min.count.threshold = 2)

# Normalize variance
varinfo <- pagoda.varnorm(knn, counts = cd, trim = 3/ncol(cd), max.adj.var = 5, n.cores = 4)

# Optional: control for sequencing depth
varinfo <- pagoda.subtract.aspect(varinfo, colSums(cd[, rownames(knn)]>0))
```

### 2. Evaluate Gene Sets
Test pre-defined (e.g., GO terms) or de novo gene sets.
```r
# Assuming go.env is an environment of gene sets
pwpca <- pagoda.pathway.wPCA(varinfo, go.env, n.components = 1, n.cores = 4)

# Evaluate significance
df <- pagoda.top.aspects(pwpca, return.table = TRUE, z.score = 1.96)
```

### 3. Visualization and App
```r
# Reduce redundancy and cluster cells
tam <- pagoda.top.aspects(pwpca, n.cells = NULL, z.score = qnorm(0.01/2, lower.tail = FALSE))
hc <- pagoda.cluster.cells(tam, varinfo)
tamr <- pagoda.reduce.loading.redundancy(tam, pwpca)
tamr2 <- pagoda.reduce.redundancy(tamr, distance.threshold = 0.9)

# View static heatmap
pagoda.view.aspects(tamr2, cell.clustering = hc)

# Create interactive browser app
app <- make.pagoda.app(tamr2, tam, varinfo, go.env, pwpca, cell.clustering = hc, title = "MyAnalysis")
show.app(app, "my_app", browse = TRUE, port = 1468)
```

## Key Functions
- `clean.counts()`: Filters the count matrix based on library size and detection limits.
- `scde.error.models()`: Fits the Poisson-NB mixture models to individual cells.
- `scde.expression.difference()`: Calculates Bayesian differential expression scores (Z-scores).
- `pagoda.varnorm()`: Normalizes gene expression variance relative to transcriptome-wide expectations.
- `pagoda.pathway.wPCA()`: Performs weighted PCA on gene sets to find overdispersed pathways.
- `scde.test.gene.expression.difference()`: Visualizes the posterior distribution for a specific gene.

## Reference documentation
- [Getting Started with scde](./references/diffexp.Rmd)
- [Pathway and Gene Set Overdispersion Analysis (PAGODA)](./references/pagoda.Rmd)
- [scde Reference Manual](./references/reference_manual.md)