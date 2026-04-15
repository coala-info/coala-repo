---
name: bioconductor-specond
description: This tool identifies condition-specific genes in gene expression data by fitting a mixture of normal distributions to detect outliers. Use when user asks to identify genes significantly up- or down-regulated in a small number of conditions, detect tissue-specific expression patterns, or perform outlier detection on an ExpressionSet or log2 expression matrix.
homepage: https://bioconductor.org/packages/release/bioc/html/SpeCond.html
---

# bioconductor-specond

name: bioconductor-specond
description: Detect condition-specific genes (outliers) in gene expression data using mixture of normal distributions. Use this skill when you need to identify genes significantly up- or down-regulated in a small number of conditions (tissues, environmental states, etc.) from an ExpressionSet or log2 expression matrix.

## Overview

SpeCond identifies condition-specific genes by fitting a mixture of normal distributions to expression values. It treats condition-specific expression as outliers relative to a "null" distribution of general expression. The process involves two steps: capturing isolated outliers with a prior (Step 1) and refining the null distribution by excluding those outliers (Step 2).

## Typical Workflow

### 1. Data Preparation
Input data must be an `ExpressionSet` or a log2-transformed expression matrix (genes in rows, conditions in columns).

```R
library(SpeCond)
data(expressionSpeCondExample)
Mexp <- expressionSpeCondExample  # Matrix
# Or use an ExpressionSet
data(expSetSpeCondExample)
```

### 2. Full Analysis with SpeCond()
The `SpeCond()` function performs the entire pipeline.

```R
# Default analysis
generalResult <- SpeCond(Mexp, 
                         multitest.correction.method = "BY", 
                         prefix.file = "MyAnalysis")

# Extract specific results
specificResult <- generalResult$specificResult
```

If using an `ExpressionSet`, specify how to handle replicates:
```R
generalResult <- SpeCond(expSetSpeCondExample,
                         condition.factor = expSetSpeCondExample$Tissue,
                         condition.method = "mean")
```

### 3. Parameter Tuning
Adjusting parameters is critical for sensitivity. Use `createParameterMatrix()` to modify defaults.

*   **mlk (minimum log-likelihood):** Higher values make outlier detection more stringent (clusters must be better separated).
*   **rsd (standard deviation ratio):** Lower values make detection more stringent (clusters must be more spread out).
*   **per (percentage):** Maximum fraction of conditions a gene can be specific in.

```R
# Increase stringency for Step 2
new_params <- createParameterMatrix(mlk.2 = 10, rsd.2 = 0.2)
result <- SpeCond(Mexp, param.detection = new_params)
```

### 4. Stepwise Analysis
For large datasets, run steps separately to avoid re-fitting models when tuning detection thresholds.

```R
# Step 1: Fit with prior and detect initial outliers
fit1 <- fitPrior(Mexp)
outliers1 <- getSpecificOutliersStep1(Mexp, fit = fit1$fit1)

# Step 2: Fit without outliers and get final results
fit2 <- fitNoPriorWithExclusion(Mexp, specificOutlierStep1 = outliers1)
finalResult <- getSpecificResult(Mexp, fit = fit2, specificOutlierStep1 = outliers1)
```

## Output and Visualization

### Text Output
```R
# Write results to text files
writeSpeCondResult(finalResult$L.specific.result, 
                   file.name.profile = "specific_profile.txt")
```

### HTML Reports
SpeCond generates comprehensive HTML visualizations.
```R
# Full summary page
getFullHtmlSpeCondResult(SpeCondResult = generalResult, 
                         expressionMatrix = Mexp)

# Individual gene pages (first 10 genes)
getGeneHtmlPage(Mexp, specificResult, gene.html.ids = c(1:10))
```

## Key Functions
- `SpeCond()`: Wrapper for the complete analysis.
- `getDefaultParameter()`: Returns the default parameter matrix.
- `getMatrixFromExpressionSet()`: Helper to collapse replicates in ExpressionSets.
- `getProfile()`: Extracts the 1 (up), -1 (down), 0 (not specific) matrix.

## Reference documentation
- [Condition-specific detection with SpeCond](./references/SpeCond.md)