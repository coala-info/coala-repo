---
name: bioconductor-inetgrate
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/iNETgrate.html
---

# bioconductor-inetgrate

name: bioconductor-inetgrate
description: Integration of DNA methylation and gene expression data into a single gene network for module identification and survival analysis. Use this skill when you need to build correlation networks where nodes are genes, identify biological signatures (eigengenes), and use these signatures for patient risk classification or survival modeling in R.

# bioconductor-inetgrate

## Overview

The `iNETgrate` package facilitates the integration of multi-omic data (specifically DNA methylation and gene expression) to identify robust biological signatures. It builds a correlation network where genes are nodes, and connections are defined by both data types. The package identifies gene modules (clusters) and represents them as "eigengenes," which serve as features for downstream survival analysis and patient stratification.

## Core Workflow

### 1. Data Preparation and Cleaning
The package requires gene expression matrices, DNA methylation beta values, and clinical survival data.

```r
library(iNETgrate)

# Use the wrapper to clean and preprocess all data types
cleaned_data <- cleanAllData(
  genExpr = raw_expression,
  genExprSampleInfo = expr_metadata,
  rawDnam = raw_methylation,
  clinical = clinical_df,
  savePath = "results/",
  riskCatCol = "risk_category_column",
  riskFactorCol = "cytogenetics_column",
  riskHigh = "High",
  riskLow = "Low"
)
```

### 2. Feature Selection
Select genes that correlate with survival/vital status across both platforms.

```r
elected <- electGenes(
  genExpr = cleaned_data$genExpr,
  dnam = cleaned_data$dnam,
  survival = cleaned_data$survival,
  savePath = "results/",
  locus2gene = cleaned_data$locus2gene
)
```

### 3. Network Construction and Eigengene Computation
Build the integrated network using the `mu` parameter to balance expression vs. methylation (0 = expression only, 1 = methylation only).

```r
# 1. Compute eigenloci (weighted average of methylation per gene)
eloci <- computEigenloci(
  dnam = cleaned_data$dnam,
  locus2gene = cleaned_data$locus2gene,
  geNames = elected$unionGenes,
  Labels = patient_labels,
  Label1 = "Low", Label2 = "High"
)

# 2. Build the network
net <- makeNetwork(
  genExpr = cleaned_data$genExpr,
  eigenloci = eloci$eigenloci,
  geNames = colnames(eloci$eigenloci),
  mus = c(0.6), # Weighting factor
  outPath = "net_output/"
)

# 3. Compute module eigengenes
egs <- computEigengenes(
  genExpr = cleaned_data$genExpr,
  eigenloci = eloci$eigenloci,
  netPath = "net_output/",
  mus = c(0.6),
  mu2modules = net$mu2modules
)
```

### 4. Survival Analysis
Perform Cox regression and Accelerated Failure Time (AFT) modeling to identify the best predictive modules.

```r
surv_results <- analyzeSurvival(
  survival = cleaned_data$survival,
  mus = 0.6,
  netPath = "net_output/",
  outPath = "surv_output/",
  favRisk = "High"
)
```

## Key Functions and Parameters

- `iNETgrate()`: The master wrapper function that runs the entire pipeline from cleaning to survival analysis.
- `mu`: The integration parameter. `mu = 0.5` gives equal weight to expression and methylation.
- `computEigenloci()`: Collapses multiple methylation probes into a single representative value per gene using PCA.
- `inferEigengenes()`: Used to project the learned signatures onto a new validation dataset.
- `plotKM()`: Generates Kaplan-Meier survival plots based on predicted risk groups.

## Tips for Success

- **Sample Matching**: Ensure patient IDs match across expression, methylation, and clinical data. Use `findTcgaDuplicates()` if working with TCGA data to handle multiple samples per patient.
- **Memory Management**: Network construction (especially TOM calculation) is memory-intensive. Set `doRemoveTOM = TRUE` in `makeNetwork` to save disk space.
- **Validation**: When using `inferEigengenes` for validation, the input expression matrix must have genes as columns and samples as rows.

## Reference documentation

- [iNETgrate Reference Manual](./references/reference_manual.md)