---
name: bioconductor-consica
description: The consICA package provides a robust framework for performing consensus Independent Component Analysis on omics data to decompose gene expression matrices into stable metagenes and metasamples. Use when user asks to perform consensus ICA, extract significant features from independent components, correlate components with experimental factors, or conduct survival and enrichment analysis on omics signals.
homepage: https://bioconductor.org/packages/release/bioc/html/consICA.html
---

# bioconductor-consica

## Overview

The `consICA` package provides a robust framework for Independent Component Analysis (ICA) of omics data, specifically designed for modern multicore systems. It decomposes a gene expression matrix (X) into statistically independent signals (metagenes, S) and their weights across samples (metasamples, M). This allows for the separation of biological processes from technical noise, feature engineering for classification, and clinical outcome prediction.

## Installation

Install the package using BiocManager:

```r
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("consICA")
library(consICA)
```

## Core Workflow

### 1. Data Preparation
The package accepts `SummarizedExperiment` objects or standard R matrices. Ensure your data is normalized (e.g., log-transformed transcriptomics data).

```r
# Using a SummarizedExperiment object
library(SummarizedExperiment)
data("samples_data")

# Extract expression matrix and metadata
X <- assay(samples_data)
metadata <- as.data.frame(colData(samples_data))
survival_data <- metadata[, c("time", "event")]
```

### 2. Running Consensus ICA
Use `consICA()` to perform the deconvolution. Key parameters include `ncomp` (number of components) and `ntry` (number of iterations to ensure stability).

```r
set.seed(2022)
cica_res <- consICA(samples_data, 
                    ncomp = 20, 
                    ntry = 10, 
                    ncores = parallel::detectCores() - 1, 
                    show.every = 0)

# Inspect results
# cica_res$S: Metagene matrix (Features x Components)
# cica_res$M: Weight matrix (Components x Samples)
```

### 3. Extracting Significant Features
Identify genes that contribute most significantly to each independent component (IC).

```r
# Extract features with FDR < 0.05
features <- getFeatures(cica_res, alpha = 0.05, sort = TRUE)

# View top positive and negative contributors for IC 1
head(features$ic.1$pos)
head(features$ic.1$neg)
```

### 4. Variance and Visualization
Estimate how much variance is captured by the components.

```r
var_explained <- estimateVarianceExplained(cica_res)
plotICVarianceExplained(cica_res)

# Plot gene involvement for a specific component
plot(sort(cica_res$S[, 1]), type="l", main="Metagene #1 Involvement")
```

## Downstream Analysis

### Linking to Experimental Factors (ANOVA)
Use `anovaIC()` to determine if component weights correlate with metadata (e.g., gender, tumor stage, batch).

```r
# Run ANOVA for IC 1 against all metadata factors
res_anova <- anovaIC(cica_res, metadata, icomp = 1, plot = TRUE)
```

### Enrichment Analysis
Perform Gene Ontology (GO) enrichment on the metagenes to interpret their biological meaning.

```r
# Search for Biological Process (BP) terms
cica_res <- getGO(cica_res, alpha = 0.05, db = "BP")
```

### Survival Analysis
Link component weights to patient survival using Cox partial hazard regression. The function calculates a Risk Score (RS) based on significant components.

```r
# Perform survival analysis
rs_results <- survivalAnalysis(cica_res, surv = survival_data)

# View hazard scores for significant components
rs_results$hazard.score
```

### Automatic Reporting
Generate a comprehensive PDF report containing all analyses (ICA, ANOVA, GO, and Survival).

```r
saveReport(cica_res, Var = metadata, surv = survival_data, file = "ICA_Analysis_Report.pdf")
```

## Tips for Success
- **Component Selection**: Choosing `ncomp` is critical. If unknown, start with a value between 20 and 50, or use stability metrics (`cica_res$stab`) to evaluate consistency.
- **Parallelization**: Always set `ncores` to utilize multicore processing, as consensus ICA is computationally intensive.
- **Orientation**: ICA components have arbitrary signs. Use `getFeatures` to see both positive and negative poles, as both can represent distinct biological signals.

## Reference documentation
- [The consICA package: User’s manual](./references/ConsICA.md)
- [The consICA package: User’s manual (Rmd source)](./references/ConsICA.Rmd)