---
name: bioconductor-mircomp
description: This tool provides a benchmarking framework for evaluating microRNA expression estimation methods using qPCR data. Use when user asks to benchmark miRNA expression estimation methods, assess quality scores, determine limit of detection, or evaluate accuracy and precision.
homepage: https://bioconductor.org/packages/release/bioc/html/miRcomp.html
---

# bioconductor-mircomp

## Overview
The `miRcomp` package provides a benchmarking framework for microRNA (miRNA) expression estimation methods, specifically targeting LifeTechnologies OpenArray qPCR data. It utilizes a specialized dilution/mixture experimental design to assess the performance of algorithms that convert raw amplification curves into expression estimates (e.g., Ct, Cq, or Crt values).

## Core Data Structure
Methods are evaluated using a list object containing two matrices:
- `ct`: A matrix of expression estimates (miRNAs in rows, samples in columns).
- `qc`: A matrix of quality scores (e.g., AmpScore or R-squared values) corresponding to the `ct` matrix.

The package includes two built-in datasets for comparison: `lifetech` and `qpcRdefault`.

## Typical Workflow

### 1. Loading Data
```r
library(miRcomp)
data(lifetech)
data(qpcRdefault)
```

### 2. Quality Assessment
Evaluate the relationship between quality scores and expression estimates.
```r
# Scatter plot of quality vs expression
qualityAssessment(lifetech, plotType="scatter", label1="LifeTech AmpScore")

# Compare two methods
qualityAssessment(lifetech, object2=qpcRdefault, plotType="boxplot", label1="LT", label2="qpcR")
```

### 3. Feature Completeness
Determine how many miRNAs are consistently detected across all samples given a quality threshold.
```r
# Single method assessment
completeFeatures(lifetech, qcThreshold1=1.25)

# Comparison of two methods
completeFeatures(lifetech, qcThreshold1=1.25, object2=qpcRdefault, qcThreshold2=0.99)
```

### 4. Limit of Detection (LOD)
Estimate the minimum signal that can be reliably detected using low-input samples.
```r
# Returns a matrix of LOD estimates based on different thresholds
lods <- limitOfDetection(lifetech, qcThreshold=1.25, plotType="MAplot")
```

### 5. Titration Response
Check for monotonic increases in expression in response to increasing RNA input.
```r
titrationResponse(lifetech, qcThreshold1=1.25)
```

### 6. Accuracy and Precision
- **Accuracy**: Calculated via "signal detect slope" (observed vs. expected expression). A slope of 1 is ideal.
- **Precision**: Evaluated using within-replicate standard deviation (SD) or coefficient of variation (CV).

```r
# Accuracy assessment
accuracy(lifetech, qcThreshold1=1.25)

# Precision assessment (Standard Deviation)
precision(lifetech, qcThreshold1=1.25, statistic="sd")

# Precision assessment (Coefficient of Variation on log scale)
precision(lifetech, qcThreshold1=1.25, statistic="cv", scale="log10")
```

## Working with New Methods
To assess a custom algorithm, you must process raw data from the `miRcompData` package:
1. Load raw data: `data(miRcompData, package="miRcompData")`.
2. Apply your algorithm to generate `ct` and `qc` matrices.
3. Ensure row names (miRNA IDs) and column names (Sample IDs) match the `lifetech` dataset.
4. Wrap them in a list: `my_method <- list(ct = my_ct_matrix, qc = my_qc_matrix)`.
5. Pass `my_method` into the assessment functions listed above.

## Reference documentation
- [Assessment and comparison of miRNA expression estimation methods (miRcomp)](./references/miRcomp.md)