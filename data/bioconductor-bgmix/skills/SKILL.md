---
name: bioconductor-bgmix
description: bioconductor-bgmix performs Bayesian mixture modeling to identify differentially expressed genes across various experimental designs. Use when user asks to identify over-expressed or under-expressed genes, perform MCMC-based estimation for gene expression, or calculate false discovery rates using posterior probabilities.
homepage: https://bioconductor.org/packages/3.5/bioc/html/BGmix.html
---

# bioconductor-bgmix

name: bioconductor-bgmix
description: Bayesian mixture modeling for differential gene expression analysis. Use this skill to identify over-expressed, under-expressed, and non-differentially expressed genes using fully Bayesian hierarchical models (BGmix). It supports unpaired, paired, and multi-class experimental designs, MCMC-based estimation, and predictive model checking.

# bioconductor-bgmix

## Overview

BGmix implements a fully Bayesian mixture model approach for detecting differential gene expression. It typically uses a 3-component mixture (under-expressed, null, over-expressed) to classify genes. The package handles various experimental designs by utilizing a design matrix and allows for flexible gene-specific variance structures. Key features include MCMC estimation, false discovery rate (FDR) calculation based on posterior probabilities, and predictive p-values for model checking.

## Data Preparation

BGmix requires three primary inputs:
- `ybar`: A matrix of sample means (rows = genes, columns = conditions).
- `ss`: A matrix of unbiased sample variances (divide by $n-1$).
- `nreps`: A vector containing the number of replicates for each condition.

Data should be log-transformed or shifted-log transformed to satisfy normality assumptions.

## Core Workflow

### 1. Running the Model
The `BGmix` function executes the MCMC. It returns the name of the output directory where results are stored.

```R
library(BGmix)
data(ybar, ss)

# Basic unpaired differential expression (default design)
outdir <- BGmix(ybar, ss, nreps=c(8,8), niter=1000, nburn=1000)
```

### 2. Experimental Design Configuration
You can customize the design using the following parameters:
- `xx`: Design matrix (no. effects x no. conditions).
- `jstar`: Index of the effect with the mixture prior (0-indexed). Set to -1 for no mixture (fixed effects).
- `ntau`: Number of variance parameters per gene.
- `indtau`: Vector mapping conditions to variance groups.

**Common Designs:**
- **Unpaired DE:** `xx = matrix(c(1,1,-0.5,0.5), 2, 2, byrow=T)`, `jstar = 1`.
- **Paired DE:** `xx = 1`, `jstar = 0`, `ntau = 1`, `indtau = 0`.
- **Multi-class (Fixed Effects):** `xx = diag(nconds)`, `jstar = -1`.

### 3. Extracting and Plotting Results
Use `ccParams` to load posterior means and classification probabilities from the output directory.

```R
# Load parameters
params <- ccParams(file = outdir)

# Basic plots for DE models (smoothing and classification)
plotBasic(params, ybar, ss)

# Calculate and plot FDR
fdr <- calcFDR(params)
plotFDR(fdr)
```

### 4. Model Checking
Predictive p-values help assess if the model fits the data.

```R
# Read predictive p-values
pred <- ccPred(file = outdir)

# Plot histograms of predictive p-values for mixture components
plotPredChecks(pred$pval.ybar.mix2, params$pc, probz = 0.8)
```

### 5. Tail Posterior Probability (Unstructured Priors)
For designs without a mixture prior (`jstar = -1`), use the Tail Posterior Probability method.

```R
# Requires trace output
res_trace <- ccTrace(outdir)
tpp_res <- TailPP(res_trace, nreps=c(8,8), params, p.cut = 0.7)

# Plot results
histTailPP(tpp_res)
FDRplotTailPP(tpp_res)
```

## Model Options

- **Mixture Prior (`move.choice.bz`):**
  - `1`: Null point mass, alternatives Uniform.
  - `4`: Null point mass, alternatives Gamma (Default).
  - `5`: Null small Normal, alternatives Gamma.
- **Gene Variance Prior (`move.choice.tau`):**
  - `1`: Inverse Gamma.
  - `2`: Log Normal.

## Reference documentation

- [BGmix](./references/BGmix.md)