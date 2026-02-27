---
name: bioconductor-sigsquared
description: This tool parameterizes and applies gene signatures based on linear signaling pathways to predict survival outcomes. Use when user asks to train model thresholds for signaling networks, perform cross-validation for survival prediction, or apply gene signatures to transcriptomic datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/sigsquared.html
---


# bioconductor-sigsquared

name: bioconductor-sigsquared
description: Expert guidance for the sigsquared R package to parameterize and apply gene signatures based on linear signaling pathways. Use this skill when you need to train model parameters (thresholds) for a specific signaling network, perform cross-validation to predict differential survival outcomes (e.g., metastasis-free survival), or apply existing gene signatures to transcriptomic datasets.

## Overview

The `sigsquared` package implements a strategy for generating gene signatures from known linear signaling pathways. Unlike general network inference, it uses a simple threshold-based model for each node in a pathway. It determines if alternate signaling states (e.g., the repression of one gene leading to the de-repression of another) can significantly predict survival outcomes. The package uses Nelder-Mead optimization and k-fold cross-validation to find optimal expression thresholds for a set of genes within a cohort.

## Core Workflow

### 1. Define the Signaling Environment
You must first define the genes involved and their regulatory directionality. Directionality is encoded as a vector of `-1` (down-regulated/inhibited) and `1` (up-regulated/activated).

```r
library(sigsquared)
library(Biobase)
library(survival)

# Initialize a new geneSignature object
gs <- new("geneSignature")

# Define genes and their expected directions in the "aberrant" state
# Example: RKIP is low (-1), while others are high (1)
genes <- c("RKIP", "HMGA2", "SPP1", "CXCR4", "MMP1", "MetaLET7", "MetaBACH1")
directions <- c(-1, 1, 1, 1, 1, 1, 1)

gs <- setGeneSignature(gs, direct=directions, genes=genes)
```

### 2. Train Thresholds (Optimization)
The `analysisPipeline` function performs k-fold cross-validation to find the optimal thresholds. 
- `dataSet`: An `ExpressionSet` object containing transcript data and survival metadata.
- `iterPerK`: Number of optimizations per fold. For publication-quality results, at least 2,500 is recommended.
- `k`: Number of folds for cross-validation.

```r
# Load example data (BrCa443)
data(BrCa443)

# Run the optimization pipeline
gs <- analysisPipeline(dataSet=BrCa443, geneSig=gs, iterPerK=50, k=2, rand=FALSE)
```

### 3. Apply and Validate the Model
Once thresholds are set, use `ensembleAdjustable` to classify patients in a dataset based on the signature. This returns a vector indicating which patients match the signaling state.

```r
# Apply the signature to the dataset
s <- ensembleAdjustable(dataSet=BrCa443, geneSig=gs)

# Validate using Survival Analysis (Kaplan-Meier)
# Assumes 'MFS' (time) and 'met' (event) are in pData(BrCa443)
fit <- survfit(Surv(MFS, met) ~ s, data=pData(BrCa443))
plot(fit, col=c("black", "red"), xlab="Time", ylab="Survival Probability")
```

## Key Functions

- `new("geneSignature")`: Constructor for the signature object.
- `setGeneSignature(gs, direct, genes)`: Configures the genes and their expected directions.
- `analysisPipeline(...)`: The main training function using Nelder-Mead optimization.
- `ensembleAdjustable(dataSet, geneSig)`: Applies the trained signature to a dataset to generate patient groupings.

## Implementation Tips

- **Data Requirements**: Input data must be an `ExpressionSet`. Ensure that the gene names in your signature match the feature names (or a specific annotation column) in the `ExpressionSet`.
- **Optimization Depth**: The `iterPerK` parameter significantly impacts the robustness of the thresholds. Low values (e.g., 50) are only suitable for testing code; use higher values for actual discovery.
- **Directionality**: The `direct` vector is critical. It represents the "high-risk" or "aberrant" state you are trying to detect.

## Reference documentation

- [sigsquared](./references/sigsquared.md)