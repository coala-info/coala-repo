---
name: bioconductor-apeglm
description: This tool calculates empirical Bayes shrinkage estimators for effect sizes in generalized linear models using a heavy-tailed Cauchy prior. Use when user asks to shrink log fold changes, calculate posterior effect size estimates, or compute s-values for RNA-seq and other genomic data.
homepage: https://bioconductor.org/packages/release/bioc/html/apeglm.html
---


# bioconductor-apeglm

name: bioconductor-apeglm
description: Approximate Posterior Estimation for Generalized Linear Models (GLM). Use this skill to calculate empirical Bayes shrinkage estimators for effect sizes (Log Fold Changes) in RNA-seq and other GLM-based genomic data. It is primarily used as the default shrinkage method in DESeq2's lfcShrink function to provide more accurate effect size estimates and false sign rate (FSR) statistics.

## Overview
`apeglm` provides a robust method for shrinking effect size estimates (like log2 fold changes) towards zero, which is particularly useful for genes with low counts or high dispersion. It uses a heavy-tailed Cauchy prior to provide better shrinkage than normal-based priors. While it can be used standalone, it is most commonly accessed via the `DESeq2` package.

## Typical Workflow with DESeq2
The most efficient way to use `apeglm` is through the `lfcShrink` wrapper in `DESeq2`.

```R
library(DESeq2)
# Assuming dds has been run through DESeq()
# Check available coefficients
resultsNames(dds)

# Apply apeglm shrinkage to a specific coefficient
# Note: apeglm requires the 'coef' argument, not 'contrast'
res <- lfcShrink(dds, coef="condition_treated_vs_untreated", type="apeglm")
```

## Standalone Usage
If using `apeglm` outside of `DESeq2`, you must manually prepare the model matrix, MLE estimates, and dispersions. Note that `apeglm` works on the natural log scale, whereas `DESeq2` typically uses log2.

### Negative Binomial Data
For RNA-seq counts, use the optimized C++ implementations for speed.

```R
library(apeglm)

# Prepare inputs
x <- model.matrix(design(dds), colData(dds))
param <- dispersions(dds)
# Convert DESeq2 MLE to natural log scale
mle <- log(2) * cbind(res$log2FoldChange, res$lfcSE)
offset <- matrix(log(sizeFactors(dds)), ncol=ncol(dds), nrow=nrow(dds), byrow=TRUE)

# Run apeglm with the fast C++ interface (nbinomCR)
fit <- apeglm(Y=assay(dds), x=x, log.lik=NULL, param=param, 
              coef=ncol(x), mle=mle, offset=offset, method="nbinomCR")

# Results are in fit$map (coefficients) and fit$sd (posterior SD)
# Convert back to log2 for standard reporting
apeglm_lfc <- log2(exp(1)) * fit$map[, ncol(x)]
```

### Beta-Binomial Data (e.g., Allele-Specific Expression)
For ratio data, `apeglm` supports beta-binomial likelihoods.

```R
# x: model matrix, ase.cts: success counts, cts: total counts
# theta.hat: estimated dispersion
param <- cbind(theta.hat, cts)
fit <- apeglm(Y=ase.cts, x=x, log.lik=NULL, param=param,
              coef=2, method="betabinCR")
```

## Interpreting Results
- **MAP (Maximum A Posteriori):** The shrunken effect size estimates.
- **s-value:** Proposed by Stephens (2016), these bound the aggregate False Sign Rate (FSR). An s-value of 0.005 is a common stringent threshold.
- **FSR (Local False Sign Rate):** The probability that the sign of the estimate is incorrect.
- **Thresholding:** You can specify a `threshold` (on the natural log scale) to calculate the probability of "false-sign-or-small" (FSOS) events.

## Tips and Best Practices
1. **Scale Conversion:** Always remember that `apeglm` internal functions use natural logs. Multiply log2 values by `log(2)` before input, and multiply `apeglm` outputs by `log2(exp(1))` for log2 results.
2. **Method Selection:** 
   - `nbinomCR`: Best for Negative Binomial (RNA-seq) when posterior SD is needed.
   - `nbinomC`: Fastest if only MAP coefficients are needed.
   - `betabinCR`: Best for Beta-Binomial (ASE/Ratios).
3. **DESeq2 Integration:** When using `lfcShrink(type="apeglm")`, the coefficient must be specified by `coef` (index or name from `resultsNames(dds)`). It does not support the `contrast` character vector syntax.

## Reference documentation
- [Effect size estimation with apeglm](./references/apeglm.md)