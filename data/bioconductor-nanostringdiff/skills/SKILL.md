---
name: bioconductor-nanostringdiff
description: NanoStringDiff performs differential expression analysis of NanoString nCounter data using a generalized linear model based on the negative binomial distribution. Use when user asks to normalize raw NanoString counts, estimate normalization factors using control genes, or perform differential expression analysis for complex experimental designs.
homepage: https://bioconductor.org/packages/release/bioc/html/NanoStringDiff.html
---


# bioconductor-nanostringdiff

## Overview

NanoStringDiff is a Bioconductor package specifically designed for differential expression analysis of NanoString nCounter data. It utilizes a generalized linear model (GLM) of the negative binomial family. A key feature is its integrated normalization framework, which uses positive controls, negative controls, and housekeeping genes to estimate size factors and background noise directly within the model. It supports complex experimental designs, including multi-factor experiments and interactions.

## Core Workflow

### 1. Data Preparation
NanoStringDiff requires **raw counts**. Do not use pre-normalized data.

**From CSV:**
Create a CSV where the first three columns are `CodeClass`, `Name`, and `Accession`. The `CodeClass` must label genes as "Positive", "Negative", "Housekeeping", or "Endogenous".
```r
library(NanoStringDiff)
designs <- data.frame(group = c("Control", "Control", "Tumor", "Tumor"))
# path points to your combined CSV file
NanoStringData <- createNanoStringSetFromCsv(path, header = TRUE, designs)
```

**From Matrices:**
If data is already in R as separate matrices:
```r
NanoStringData <- createNanoStringSet(endogenous, positive, negative, housekeeping, designs)
```

### 2. Normalization
Estimate factors for positive controls, background noise (negative controls), and housekeeping genes.
```r
NanoStringData <- estNormalizationFactors(NanoStringData)

# View estimated factors
positiveFactor(NanoStringData)
negativeFactor(NanoStringData)
housekeepingFactor(NanoStringData)
```

### 3. Differential Expression Analysis
The package uses a Likelihood Ratio Test (LRT).

**Two-Group Comparison:**
```r
pheno <- pData(NanoStringData)
design.full <- model.matrix(~0 + pheno$group)
# Contrast for 'Tumor' vs 'Control' (assuming group order is Control, Tumor)
result <- glm.LRT(NanoStringData, design.full, contrast = c(-1, 1))
```

**Multi-Group/Pairwise Comparison:**
You can use specific coefficients (Beta) instead of a contrast vector if the design matrix includes an intercept.
```r
design.full <- model.matrix(~group, data = pheno)
# Test the second coefficient (e.g., Group B vs Baseline Group A)
result <- glm.LRT(NanoStringData, design.full, Beta = 2)
```

**Multi-Factor Design:**
```r
design.full <- model.matrix(~group + gender + group:gender, data = pheno)
# Test for gender effect in a specific group or interaction
result <- glm.LRT(NanoStringData, design.full, Beta = 4:5)
```

### 4. Interpreting Results
The result object contains a `table` with log-fold change, likelihood ratio statistics, p-values, and BH-adjusted q-values.
```r
head(result$table)
# Columns: logFC, lr, pvalue, qvalue
```

## Usage Tips
- **Positive Controls:** Ensure there are exactly six positive control genes ordered by concentration (high to low) as per NanoString specifications.
- **Housekeeping Genes:** While the package works with fewer, NanoString recommends at least three housekeeping genes for stable normalization.
- **Log Fold Change:** The `logFC` returned is $log_2$ based.
- **Design Matrices:** When using `~0 + group`, the contrast vector must sum to 0. When using an intercept (`~group`), use the `Beta` parameter to specify which coefficient to test against the null.

## Reference documentation
- [NanoStringDiff](./references/NanoStringDiff.md)