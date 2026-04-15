---
name: bioconductor-cormotif
description: The Cormotif package fits Bayesian hierarchical models to identify shared and study-specific differential expression patterns across multiple microarray experiments. Use when user asks to discover correlation motifs, analyze differential expression across multiple studies, or handle missing data in cross-platform gene expression comparisons.
homepage: https://bioconductor.org/packages/release/bioc/html/Cormotif.html
---

# bioconductor-cormotif

## Overview

The `Cormotif` package implements a Bayesian hierarchical model to identify differential expression (DE) patterns across multiple microarray studies. Instead of analyzing studies separately or assuming all studies must be concordant, `Cormotif` discovers a small number of latent "correlation motifs." These motifs represent the major patterns of DE across studies, allowing for information sharing while maintaining the flexibility to detect study-specific genes. It is particularly robust for handling data from different platforms and datasets with missing values.

## Core Workflow

### 1. Data Preparation

The package requires three main inputs for the `cormotiffit` function:

*   **exprs**: A matrix of normalized (log2 scale) gene expression data. Rows are genes; columns are samples.
*   **groupid**: A vector identifying the group label (experimental condition) for each sample.
*   **compgroup**: A matrix defining the study design. Each row represents a study, and the two columns specify which `groupid` labels are being compared (e.g., Condition 1 vs. Condition 2).

```r
library(Cormotif)

# Example structure for compgroup (4 studies, comparing group pairs)
# Study 1 compares group 1 vs 2, Study 2 compares group 3 vs 4, etc.
simu2_compgroup <- matrix(c(1,3,5,7, 2,4,6,8), ncol=2)
colnames(simu2_compgroup) <- c("Cond1", "Cond2")
```

### 2. Model Fitting

Use `cormotiffit` to fit the model. It is recommended to test a range of motif numbers (`K`) and use BIC or AIC to select the optimal model.

```r
# Fit models with 1 to 5 motifs
motif.fitted <- cormotiffit(exprs.simu2, simu2_groupid, simu2_compgroup, 
                            K=1:5, max.iter=1000, BIC=TRUE)

# Check BIC values to find the best K
motif.fitted$bic
plotIC(motif.fitted)
```

### 3. Visualizing and Interpreting Motifs

Once the best model is selected, visualize the discovered motifs (the probability of DE in each study for each motif) and their frequencies.

```r
# Plot the motif patterns and their gene frequencies
plotMotif(motif.fitted)

# Access the prior probability of each motif
motif.fitted$bestmotif$motif.prior
```

### 4. Identifying Differentially Expressed Genes

Extract posterior probabilities for each gene in each study.

```r
# Get posterior probabilities of DE
prob_matrix <- motif.fitted$bestmotif$p.post

# Identify DE genes using a 0.5 cutoff
de_patterns <- (prob_matrix > 0.5)

# Rank genes by DE probability for each study
top_genes <- generank(prob_matrix)
```

## Handling Missing Data

`Cormotif` handles missing values (`NA`) automatically. This is useful when merging studies from different platforms where some genes are not measured in all studies. Simply include `NA` in the expression matrix where data is missing; the model will still utilize the available information across other studies to inform the motif assignment.

## Alternative Fit Methods

While `cormotiffit` is the primary function, specialized variants exist:
*   `cormotiffitall`: Assumes genes are DE in either all studies or none (concordance model).
*   `cormotiffitsep`: Fits a mixture model to each study independently.
*   `cormotiffitfull`: Fits all $2^D$ possible binary DE patterns (where $D$ is the number of studies).

## Reference documentation

- [Correlation Motif Vignette](./references/CormotifVignette.md)