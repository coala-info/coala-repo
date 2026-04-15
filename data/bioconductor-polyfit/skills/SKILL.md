---
name: bioconductor-polyfit
description: Polyfit corrects p-value distributions in discrete count data analysis to ensure non-differentially expressed genes follow a uniform distribution. Use when user asks to smooth p-value spikes, level p-value histograms, or calculate more accurate false discovery rates for two-condition differential expression tests.
homepage: https://bioconductor.org/packages/3.5/bioc/html/Polyfit.html
---

# bioconductor-polyfit

## Overview

Polyfit is an extension for the `DESeq` package designed to ensure that p-values for non-differentially expressed (DE) genes follow a uniform distribution. In discrete count data analysis, p-value distributions often exhibit "flagpoles" (singularities, typically at p=1) or non-uniform shapes due to parameter estimation biases. Polyfit addresses this by:
1. Smoothing discrete p-value spikes using a continuous redistribution method.
2. Applying a modified Storey-Tibshirani procedure with polynomial fitting to "level" the p-value histogram and provide more accurate q-values (FDR).

## Workflow and Usage

### 1. Data Preparation
Polyfit works with `CountDataSet` objects from the `DESeq` package. You must first estimate size factors and dispersions using standard `DESeq` workflows.

```r
library(Polyfit)
# Assuming 'cds' is your CountDataSet
cds <- estimateSizeFactors(cds)
cds <- estimateDispersions(cds)
```

### 2. Generating Smoothed P-Values
Replace the standard `DESeq::nbinomTest` with `pfNbinomTest`. This function redistributes the probability mass of discrete counts to create a continuous p-value distribution, removing the spike at p=1.

```r
# Standard DESeq call (for comparison)
# nbT <- nbinomTest(cds, "ConditionA", "ConditionB")

# Polyfit replacement
nbTPolyfit <- pfNbinomTest(cds, "ConditionA", "ConditionB")
pValuesPF <- nbTPolyfit$pval
```

### 3. Levelling and FDR Calculation
Use `levelPValues` to correct the p-value distribution and calculate adjusted p-values (q-values). This function fits a polynomial to the p-value spectrum to estimate the proportion of null genes ($\pi_0$).

```r
# Correct p-values and calculate q-values
lP <- levelPValues(pValuesPF, plot = TRUE)

# Extract results
corrected_p <- lP$pValueCorr      # Levelled p-values
corrected_q <- lP$qValueCorr      # Adjusted p-values (Polyfit method)
bh_q <- lP$qValueCorrBH           # Benjamini-Hochberg on levelled p-values
```

### 4. Interpreting Results
The `levelPValues` function returns a list containing:
- `pValueCorr`: The corrected p-values.
- `qValueCorr`: The q-values calculated via the Polyfit variant of the Storey-Tibshirani procedure.
- `qValueCorrBH`: q-values calculated using the standard Benjamini-Hochberg procedure applied to the *corrected* p-values.
- `pi0`: The estimated proportion of genes that are not differentially expressed.

## Tips and Best Practices
- **Diagnostic Plots**: Always set `plot=TRUE` in `levelPValues` to visualize the p-value spectrum before and after correction. A successful correction should result in a flat distribution for the higher p-value range.
- **Dependencies**: Loading `Polyfit` automatically loads `DESeq` and `edgeR`.
- **Two-Class Only**: This package is specifically designed for two-class (two-condition) comparisons.
- **Comparison**: It is often useful to compare `qValueCorr` with `qValueCorrBH` to see how the polynomial fit affects your significance calls compared to the linear BH assumption.

## Reference documentation
- [Polyfit Vignette](./references/polyfit.md)