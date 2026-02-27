---
name: bioconductor-puma
description: This tool performs probabilistic analysis of Affymetrix GeneChip data by propagating measurement uncertainty through the analysis pipeline. Use when user asks to perform summarization, differential expression detection using PPLR, principal component analysis, or clustering while accounting for probe-level measurement error.
homepage: https://bioconductor.org/packages/release/bioc/html/puma.html
---


# bioconductor-puma

name: bioconductor-puma
description: Analysis of Affymetrix GeneChip data (3' arrays, exon, and HTA 2.0) using uncertainty propagation. Use when Claude needs to perform summarization, differential expression detection (PPLR), clustering, or PCA while accounting for probe-level measurement error and standard errors in expression estimates.

# bioconductor-puma

## Overview

The **puma** (Propagating Uncertainty in Microarray Analysis) package provides a suite of probabilistic methods for Affymetrix GeneChip data. Unlike standard methods (RMA, MAS5.0) that provide only point estimates, puma calculates the uncertainty (standard error) associated with gene expression levels and propagates this information to downstream analyses like Differential Expression (DE), PCA, and clustering.

## Core Workflow

### 1. Data Import
Data should be imported using the `oligo` package to create an `ExpressionFeatureSet`.

```r
library(oligo)
library(puma)

# List and read CEL files
celFiles <- list.celfiles()
raw_data <- read.celfiles(celFiles)

# Add phenotype data (essential for automatic design/contrast matrices)
pData(raw_data) <- data.frame(
  condition = c("A", "A", "B", "B"),
  row.names = sampleNames(raw_data)
)
```

### 2. Summarization (Calculating Expression and Uncertainty)
Use `mmgmos` for standard 3' arrays. This produces an `ExpressionSet` containing both expression values (`exprs`) and standard errors (`se.exprs`).

```r
# Standard 3' arrays
eset <- mmgmos(raw_data)

# Exon arrays (requires pumadata package)
# eset_exon <- gmoExon(raw_data, exontype="Human")

# HTA 2.0 arrays
# eset_hta <- gmhta(raw_data)

# Accessing uncertainty
expression_values <- exprs(eset)
standard_errors <- assayDataElement(eset, "se.exprs")
```

### 3. Quality Control and Normalization
`pumaPCA` uses uncertainty to provide more robust principal component analysis.

```r
# PCA with uncertainty propagation
p_pca <- pumaPCA(eset)
plot(p_pca)

# Normalization (if not done during mmgmos)
eset_norm <- pumaNormalize(eset)
```

### 4. Differential Expression (PPLR Method)
The Probability of Positive Log Ratio (PPLR) method identifies DE genes by combining replicates and calculating the probability of a change.

```r
# 1. Combine replicates (calculates condition-level uncertainty)
# Use pumaCombImproved for faster execution on large datasets
eset_comb <- pumaComb(eset_norm)

# 2. Calculate Differential Expression
# puma automatically creates contrasts if pData is present
de_results <- pumaDE(eset_comb)

# 3. Get top genes for a specific contrast (e.g., contrast 1)
top_genes <- topGenes(de_results, contrast=1)
```

### 5. Visualization
Use `plotErrorBars` to visualize expression levels alongside their calculated uncertainty. This is the primary way to validate if a DE call is robust or driven by high-noise probes.

```r
# Compare a specific probe set across conditions with error bars
plotErrorBars(eset_norm, probesetID = "12345_at")
```

### 6. Clustering
`pumaClust` and `pumaClustii` perform clustering while accounting for measurement error. `pumaClustii` is more robust as it uses a Student’s t mixture model and handles replicates.

```r
# Basic clustering
clusters <- pumaClust(eset, clusters=7)

# Robust clustering with replicates
# r is a vector of replicate labels
cl <- pumaClustii(exprs(eset), assayDataElement(eset, "se.exprs"), mincls=5, maxcls=10, reps=r)
```

## Parallel Processing
Many puma functions (especially `pumaComb`, `gmoExon`, and `gmhta`) are computationally intensive but parallelizable via the `snow` package.

```r
library(snow)
cl <- makeCluster(4, type = "SOCK") # Use 4 cores
eset_comb <- pumaComb(eset_norm, cl=cl)
stopCluster(cl)
```

## Tips for Success
- **Phenotype Data**: Always populate the `pData` slot of your object before running `pumaComb`. Puma uses this to automatically generate design and contrast matrices.
- **Memory**: `mmgmos` and `pumaComb` can be memory-intensive. For large datasets, use `pumaCombImproved`.
- **Exporting**: Use `write.reslts(eset, file="output")` to save expression levels, standard errors, and confidence intervals into CSV files.

## Reference documentation
- [puma User Guide](./references/puma.md)