---
name: bioconductor-edda
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.6/bioc/html/EDDA.html
---

# bioconductor-edda

name: bioconductor-edda
description: Experimental Design in Differential Abundance analysis (EDDA). Use this skill to design and evaluate RNA-seq, Nanostring, RIP-seq, and Metagenomic experiments. It supports synthetic data generation (based on user parameters or pilot data), differential abundance testing (DAT) using multiple methods (DESeq, edgeR), and performance evaluation via AUC, ROC, and PRC metrics.

# bioconductor-edda

## Overview
EDDA is an R package designed to help researchers plan high-throughput sequencing experiments. It allows users to simulate count data that mimics real experimental characteristics and evaluate how different differential abundance testing (DAT) methods perform under specific experimental designs. This helps in making informed decisions about sample sizes, replicate numbers, and choice of statistical methods.

## Core Workflow

### 1. Data Generation
EDDA can generate synthetic data in three ways: using specified parameters, learning from pilot data, or using a model-free subsampling approach.

**From Parameters:**
```r
library(EDDA)
# Generate data with specific characteristics
data <- generateData(
  EntityCount = 1000, 
  SampleVar = "high", 
  ControlRep = 5, 
  CaseRep = 5,
  FC = "Unif(3,5)", 
  perDiffAbund = 0.1, 
  modelFile = "BP"
)
```

**From Pilot Data:**
```r
# inputCount is a matrix or file path; inputLabel is a vector of 0s and 1s
data <- generateData(
  inputCount = "count.txt", 
  inputLabel = c(rep(0, 10), rep(1, 5)),
  SimulType = "auto2" # Adjusts EntityCount/Replicates while keeping pilot properties
)
```

**Model-Free (Subsampling):**
```r
data <- generateData(
  SimulModel = "ModelFree", 
  inputCount = "count.txt", 
  inputLabel = x.label,
  modelFile = "SingleCell" # Optional: use specific single-cell characteristics
)
```

### 2. Differential Abundance Testing (DAT)
Run multiple testing methods on the generated or input data to compare results.
```r
# Test using DESeq and edgeR
test.obj <- testDATs(
  data, 
  DE.methods = c("DESeq", "edgeR"), 
  nor.methods = "default"
)
```

### 3. Performance Evaluation
Evaluate the accuracy of the methods using Area Under the Curve (AUC) and visualization.
```r
# Compute AUC for the tests
auc.obj <- computeAUC(test.obj)

# Plot performance metrics
plotROC(auc.obj) # Receiver Operating Characteristic
plotPRC(auc.obj) # Precision-Recall Curve
```

## Key Functions
- `generateData()`: Primary function for simulation. Parameters include `EntityCount` (number of genes/features), `ControlRep`/`CaseRep` (replicates), and `FC` (fold change).
- `testDATs()`: Wrapper to run various differential expression tools.
- `computeAUC()`: Calculates the performance of the DAT methods.
- `plotROC()` / `plotPRC()`: Visualizes the trade-off between sensitivity and specificity.

## Tips for Experimental Design
- **Sample Variation**: Use `SampleVar="high"` to simulate more heterogeneous biological samples.
- **Fold Change**: The `FC` parameter accepts distributions like `"Unif(2,4)"` to represent a range of effect sizes.
- **Pilot Data**: When available, always use `inputCount` to ensure the simulation captures the specific noise profile and abundance distribution of your actual biological system.

## Reference documentation
- [EDDA](./references/EDDA.md)