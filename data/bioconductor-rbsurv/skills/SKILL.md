---
name: bioconductor-rbsurv
description: This tool performs robust likelihood-based survival modeling to identify gene sets associated with patient survival from high-dimensional transcriptomic data. Use when user asks to select survival-associated genes, perform cross-validated forward selection using Cox proportional hazards models, or identify predictive gene signatures while accounting for clinical covariates.
homepage: https://bioconductor.org/packages/release/bioc/html/rbsurv.html
---


# bioconductor-rbsurv

name: bioconductor-rbsurv
description: Robust likelihood-based survival modeling for gene selection. Use this skill when analyzing high-throughput transcriptomic data (like ExpressionSets) to identify survival-associated genes using a cross-validated forward selection algorithm based on Cox proportional hazards models.

# bioconductor-rbsurv

## Overview

The `rbsurv` package implements a robust method for selecting survival-associated genes from high-dimensional data. It uses a cross-validation approach where samples are repeatedly split into training and validation sets. The algorithm fits Cox proportional hazards models on training data and evaluates them using the partial likelihood on validation data. This process helps identify stable, predictive gene sets while minimizing overfitting.

Key features include:
- Forward selection of genes based on mean negative log-likelihood.
- Automated model selection using AIC.
- Support for incorporating clinical risk factors (e.g., age, gender) as covariates.
- Sequential runs to discover "masked" genes by removing previously selected genes.

## Typical Workflow

### 1. Data Preparation
The package requires a gene expression matrix (genes in rows, samples in columns), survival times, and censoring status.

```r
library(rbsurv)

# Example using the built-in glioma dataset
data(gliomaSet)

# Extract expression data (log-transform if necessary)
x <- log2(exprs(gliomaSet))

# Extract survival metadata
time <- gliomaSet$Time
status <- gliomaSet$Status

# Optional: Clinical risk factors (must be a matrix)
z <- cbind(Age = gliomaSet$Age, Gender = gliomaSet$Gender)
```

### 2. Running the Selection Algorithm
The `rbsurv` function is the primary interface. It is computationally intensive; for large datasets, use `max.n.genes` to pre-filter genes via univariate Cox models.

```r
# Basic run with default parameters
fit <- rbsurv(time = time, 
              status = status, 
              x = x, 
              method = "efron", 
              max.n.genes = 20)

# Advanced run with clinical covariates and sequential modeling
fit_adv <- rbsurv(time = time, 
                  status = status, 
                  x = x, 
                  z = z, 
                  alpha = 0.05,   # Significance level for risk factors
                  n.seq = 3,      # Generate 3 sequential models
                  n.iter = 100,   # Number of CV iterations
                  n.fold = 3)     # 3-fold cross-validation
```

### 3. Interpreting Results
The output object contains a `model` data frame showing the selection order, negative log-likelihood, and AIC.

```r
# View the selection steps and AIC
print(fit$model)

# Identify selected genes (marked with '*' in the 'Selected' column)
selected_genes <- fit$model[fit$model$Selected == "*", ]
```

## Key Arguments

- `time` / `status`: Survival time and event indicator (1=event, 0=censored).
- `x`: Expression matrix (Rows=Genes, Cols=Samples).
- `z`: Matrix of clinical covariates to include in the model.
- `alpha`: P-value threshold to include covariates from `z`. Set to 1 to force-include all.
- `max.n.genes`: Limits the initial pool of genes using univariate Cox p-values to speed up the forward selection.
- `n.iter`: Number of random training/validation splits per step.
- `n.seq`: Number of times to repeat the entire selection process after removing previously selected genes.

## Tips for Success
- **Computational Time**: Forward selection is $O(N \times G)$ where $N$ is iterations and $G$ is genes. Always use `max.n.genes` (e.g., 100-200) if your starting feature set is in the thousands.
- **Ties**: Use `method = "efron"` (default) or `"breslow"` for handling tied survival times.
- **Reproducibility**: Set a `seed` within the `rbsurv` function call to ensure consistent results across runs, as the sample partitioning is random.

## Reference documentation
- [rbsurv](./references/rbsurv.md)