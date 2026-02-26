---
name: bioconductor-assign
description: ASSIGN quantifies pathway activity in genomic data using a Bayesian factor analysis approach to adapt signatures to specific biological contexts. Use when user asks to evaluate pathway activation status, adapt gene signatures to specific tissue types, or perform Bayesian factor analysis for pathway deregulation scoring.
homepage: https://bioconductor.org/packages/release/bioc/html/ASSIGN.html
---


# bioconductor-assign

name: bioconductor-assign
description: Adaptive Signature Selection and InteGratioN (ASSIGN) for signature-based profiling of biological pathways. Use this skill to evaluate pathway activation status in genomic data, adapt signatures to specific contexts, and perform Bayesian factor analysis for pathway deregulation scoring.

## Overview
ASSIGN is a computational tool that quantifies pathway activity in individual samples using a Bayesian factor analysis approach. It is particularly effective for adapting pathway signatures (derived from perturbation experiments or literature) to specific tissue types or disease states. It handles multiple pathways simultaneously, accounts for cross-talk, and regularizes signature strength to ensure biological interpretability.

## Core Workflow

### 1. Data Preparation
ASSIGN requires a test dataset (genomic measurements) and optionally a training dataset (perturbation experiments) or a predefined gene list.

```r
library(ASSIGN)

# Load example data
data(trainingData1)
data(testData1)
data(geneList1)

# Define training labels (control vs experimental indices)
trainingLabel1 <- list(control = list(bcat=1:10, e2f3=1:10, myc=1:10, ras=1:10, src=1:10),
                       bcat = 11:19, e2f3 = 20:28, myc= 29:38, ras = 39:48, src = 49:55)
```

### 2. All-in-One Analysis
The `assign.wrapper` function is the recommended entry point for most users. It handles preprocessing, MCMC sampling, and output generation.

```r
assign.wrapper(trainingData=trainingData1, 
               testData=testData1,
               trainingLabel=trainingLabel1, 
               geneList=geneList1, 
               adaptive_B=TRUE, # Adapt background
               adaptive_S=FALSE, # Adapt signature
               mixture_beta=TRUE, # Regularization
               outputDir="output_results",
               iter=2000, burn_in=1000)
```

### 3. Step-by-Step Analysis
For more control, use the individual component functions:

*   **Preprocessing**: `assign.preprocess` selects signature genes and prepares matrices.
*   **MCMC Sampling**: `assign.mcmc` runs the Bayesian model.
*   **Convergence Check**: `assign.convergence` generates trace plots to ensure model stability.
*   **Summary**: `assign.summary` computes posterior means of pathway activity.
*   **Output**: `assign.output` and `assign.cv.output` generate CSVs and plots.

```r
# Example step-by-step
processed <- assign.preprocess(trainingData=trainingData1, testData=testData1, 
                               trainingLabel=trainingLabel1, n_sigGene=rep(200,5))

mcmc_chain <- assign.mcmc(Y=processed$testData_sub, Bg=processed$B_vector, 
                          X=processed$S_matrix, Delta_prior_p=processed$Pi_matrix, 
                          iter=2000, adaptive_B=TRUE, adaptive_S=FALSE)

results <- assign.summary(test=mcmc_chain, burn_in=1000, iter=2000)
```

## Key Parameters and Features

*   **Adaptive Background (`adaptive_B`)**: Set to `TRUE` when training and test samples come from different platforms or tissue types.
*   **Adaptive Signature (`adaptive_S`)**: Set to `TRUE` if the training data is unavailable or if you want the signature magnitudes to be refined based on the test data.
*   **Anchor/Exclude Genes**: Use `anchorGenes` to force specific genes to remain in the signature and `excludeGenes` to remove known noise genes.
*   **Pathway Activity Scores**: The primary output is a score representing the extent to which a sample matches the pathway activation signature.

## Optimization
If the optimal gene list length is unknown, use `optimizeGFRN` to run ASSIGN across multiple lengths and correlate results with external data (e.g., proteomics) to find the best fit.

## Reference documentation
- [Introduction to the ASSIGN Package](./references/ASSIGN.vignette.md)
- [ASSIGN Vignette Source](./references/ASSIGN.vignette.Rmd)