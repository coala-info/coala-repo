---
name: bioconductor-glmsparsenet
description: This R package fits sparse generalized linear models by incorporating biological network information to penalize genes based on their connectivity. Use when user asks to perform network-based regularization, identify biomarkers in survival or classification tasks, or penalize hub and orphan genes in transcriptomic data.
homepage: https://bioconductor.org/packages/release/bioc/html/glmSparseNet.html
---


# bioconductor-glmsparsenet

## Overview

`glmSparseNet` is an R package that extends the `glmnet` framework by incorporating biological network information into the regularization process. It is particularly useful for transcriptomic data where genes do not act in isolation. The package provides heuristics to penalize "hubs" (highly connected nodes) or "orphans" (isolated nodes) differently, helping to identify more biologically relevant biomarkers in survival and classification tasks.

## Core Workflow

### 1. Data Preparation
The package expects a feature matrix `xdata` (samples as rows, genes as columns) and a response object `ydata`.
- For **Classification**: `ydata` is a factor or numeric vector.
- For **Survival**: `ydata` is a `survival::Surv` object containing time and status.

It is highly recommended to scale your data before fitting:
```r
xdata <- scale(xdataRaw)
```

### 2. Defining the Network
You can provide a custom adjacency matrix or use the package's built-in correlation-based network generation.
- **Correlation Network**: Set `network = "correlation"` in the fitting function.
- **External Network (e.g., STRING)**: Use `stringDBhomoSapiens()` and `buildStringNetwork()` to create a sparse matrix of interactions.

### 3. Fitting Models with Network Penalization
The two primary functions are `cv.glmHub` (penalizes based on high connectivity) and `cv.glmOrphan` (penalizes based on low connectivity).

**Example: Survival Analysis (Cox)**
```r
library(glmSparseNet)
library(survival)

# Fit model using correlation network and hub-based penalization
fitted <- cv.glmHub(xdata, Surv(ydata$time, ydata$status),
    family  = "cox",
    network = "correlation",
    options = networkOptions(cutoff = 0.6, minDegree = 0.2)
)

# Plot cross-validation results
plot(fitted)
```

**Example: Classification (Binomial)**
```r
fitted_class <- cv.glmHub(xdata, ydata_factor,
    family  = "binomial",
    network = "correlation"
)
```

### 4. Interpreting Results
Extract coefficients for the optimal model (usually `lambda.min` or `lambda.1se`):
```r
# Get non-zero coefficients
coefs <- coef(fitted, s = "lambda.min")
active_genes <- coefs[coefs[,1] != 0, , drop=FALSE]
```

### 5. Survival Visualization
Use `separate2GroupsCox` to validate the model by splitting samples into high and low-risk groups based on the calculated prognostic index.

```r
# Extract coefficients as a vector
betas <- as.vector(active_genes)
names(betas) <- rownames(active_genes)

# Generate Kaplan-Meier plot
res <- separate2GroupsCox(betas, xdata[, names(betas)], ydata)
print(res$plot)
print(res$pvalue)
```

## Key Functions and Options

- `networkOptions()`: Configures how the network is processed.
    - `cutoff`: Correlation threshold for edge creation.
    - `minDegree`: Minimum degree percentile to consider a node a "hub".
- `geneNames()`: Helper to convert Ensembl IDs to external gene symbols using BioMart.
- `balancedCvFolds()`: Useful for creating cross-validation folds that maintain the ratio of events in survival data or classes in classification.

## Tips for Success
- **Memory Management**: When using large networks like STRING, ensure you use sparse matrices (class `dgCMatrix`) to avoid memory exhaustion.
- **Feature Matching**: Ensure the column names of `xdata` match the node names in your network matrix.
- **Comparison**: It is often useful to run a standard `glmnet` model as a baseline to see if network-based penalization improves interpretability or performance.

## Reference documentation

- [Example for Classification Data – Breast Invasive Carcinoma](./references/example_brca_logistic.md)
- [Breast survival dataset using network from STRING DB](./references/example_brca_protein-protein-interactions_survival.md)
- [Example for Survival Data – Breast Invasive Carcinoma](./references/example_brca_survival.md)
- [Example for Survival Data – Prostate Adenocarcinoma](./references/example_prad_survival.md)
- [Example for Survival Data – Skin Melanoma](./references/example_skcm_survival.md)
- [Separate 2 groups in Cox regression](./references/separate2GroupsCox.md)