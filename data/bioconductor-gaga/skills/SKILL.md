---
name: bioconductor-gaga
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/gaga.html
---

# bioconductor-gaga

name: bioconductor-gaga
description: Analysis of gene expression data using GaGa and MiGaGa hierarchical models. Use this skill for differential expression analysis, class prediction (classification), and sample size calculations (fixed or sequential) in high-throughput genomics.

# bioconductor-gaga

## Overview

The `gaga` package implements the GaGa and MiGaGa (Mixture of Gamma-Gammas) hierarchical models for high-throughput data analysis. It is particularly effective for borrowing information across genes to improve the robustness of differential expression (DE) calls, fold-change estimates, and sample classification. It supports both constant and varying coefficients of variation (CV) across experimental groups.

## Core Workflow

### 1. Data Preparation and Model Specification
The package works with `ExpressionSet` objects or matrices. You must define the experimental groups and the expression patterns (hypotheses) to test.

```R
library(gaga)

# Define groups (e.g., 2 groups)
groups <- pData(xsim)$group 

# Define patterns: 0 = null (equal), 1 = alternative (different)
# Rows are hypotheses, columns are groups
patterns <- matrix(c(0,0, 0,1), nrow=2, byrow=TRUE)
colnames(patterns) <- c('Control', 'Treatment')
```

### 2. Fitting the Model
Use `fitGG` to estimate hyperparameters.
- `nclust=1`: Fits the GaGa model.
- `nclust > 1`: Fits the MiGaGa model (mixture of inverse gammas).
- `method`: Options include `'quickEM'` (fast, default), `'EM'`, `'Gibbs'`, or `'MH'`. Use `'Gibbs'` if credibility intervals are required.
- `equalcv`: Set to `TRUE` (default) for constant CV across groups, `FALSE` for varying CV.

```R
# Fit using quick EM
fit <- fitGG(data, groups, patterns=patterns, method='quickEM')

# Obtain posterior probabilities and parameter estimates
fit <- parest(fit, x=data, groups=groups)
```

### 3. Differential Expression Analysis
Identify DE genes by minimizing the False Negative Rate for a given False Discovery Rate (FDR) threshold.

```R
# Find genes with FDR < 0.05
de_results <- findgenes(fit, data, groups, fdrmax=0.05, parametric=TRUE)

# Access DE calls (1 = DE, 0 = Not DE)
is_de <- de_results$d
```

### 4. Fold Change and Classification
- **Fold Change**: Use `posmeansGG` to get posterior expected expression values, which are more stable than sample means for small sample sizes.
- **Classification**: Use `classpred` to predict the group of a new sample based on the fitted model.

```R
# Posterior means under the DE pattern
mpos <- posmeansGG(fit, x=data, groups=groups, underpattern=1)
log_fc <- mpos[,1] - mpos[,2]

# Predict class for new data
pred <- classpred(fit, xnew=new_sample_matrix, x=data, groups=groups, ngene=50)
```

### 5. Sample Size Calculation
`gaga` provides tools to determine how many additional samples are needed to discover more DE genes.
- `powfindgenes`: Evaluates expected new discoveries for a fixed additional batch size.
- `forwsimDiffExpr`: Performs forward simulation for sequential stopping rules.

## Diagnostics
Assess model fit using `checkfit`. It compares observed data against posterior predictive distributions for data values, shapes ($\alpha$), and means ($\lambda$).

```R
checkfit(fit, x=data, groups=groups, type='data')
checkfit(fit, x=data, groups=groups, type='shapemean')
```

## Reference documentation

- [Manual for the R gaga package](./references/gagamanual.md)