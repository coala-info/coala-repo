---
name: bioconductor-iclusterplus
description: This tool performs integrative clustering of multi-type genomic data using joint latent variable modeling across various statistical distributions. Use when user asks to identify disease subtypes, perform joint analysis of multi-omics data, or select driver features across mutation, copy number, and expression datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/iClusterPlus.html
---

# bioconductor-iclusterplus

name: bioconductor-iclusterplus
description: Integrative clustering of multi-type genomic data (e.g., somatic mutation, copy number, gene expression). Use this skill to perform joint latent variable modeling across different data distributions (Binomial, Gaussian, Poisson, Multinomial) to identify disease subtypes and driver features.

# bioconductor-iclusterplus

## Overview

The `iClusterPlus` package provides tools for the integrative clustering of multiple omics data types. It extends the original iCluster framework by allowing for different statistical distributions for different data types:
- **Binomial**: Somatic mutations (binary 0/1).
- **Gaussian**: Gene expression, DNA methylation, or segmented copy number (continuous).
- **Multinomial**: Categorical copy number states (e.g., -1, 0, 1).
- **Poisson**: Count data (e.g., RNA-seq counts).

The package includes two primary methods: `iClusterPlus` (penalized likelihood using Lasso) and `iClusterBayes` (a Bayesian approach that avoids grid searches for penalty parameters).

## Core Workflow

### 1. Data Pre-processing
Data must be organized as matrices where rows are samples and columns are features. Ensure all data types have the same samples in the same order.

- **Mutation data**: Filter for frequency (e.g., > 5% mutation rate).
- **Expression data**: Use top variable genes (variance filtering).
- **Copy Number**: Use segmented data. Use `CNregions()` to reduce dimensionality by defining non-redundant regions.

```R
# Example CN reduction
gbm.cn = CNregions(seg=gbm.seg, epsilon=0, adaptive=FALSE, rmCNV=TRUE, cnv=cnv_ref)
```

### 2. Model Tuning (iClusterPlus)
Use `tune.iClusterPlus` to find the optimal number of clusters ($K+1$) and penalty parameters ($\lambda$).

```R
# Parallel tuning across K=1 to 5
for(k in 1:5){
  cv.fit = tune.iClusterPlus(cpus=12, dt1=mut, dt2=cn, dt3=exp, 
                             type=c("binomial","gaussian","gaussian"), 
                             K=k, n.lambda=185)
  save(cv.fit, file=paste0("cv.fit.k", k, ".Rdata"))
}
```

### 3. Model Selection
Select the best model based on:
- **BIC**: Choose the $\lambda$ that minimizes BIC for a given $K$.
- **Deviance Ratio (% Explained Variation)**: Plot $K$ vs. PercentEV. Choose $K$ where the curve levels off (elbow method).

```R
# Extracting metrics
BIC = getBIC(output)
devR = getDevR(output)
clusters = getClusters(output)
```

### 4. Feature Selection
Identify features contributing to the clusters by examining the Lasso coefficient estimates (`beta`).

```R
# Select top 25% features for a specific data type
rowsum = apply(abs(best.fit$beta[[i]]), 1, sum)
upper = quantile(rowsum, prob=0.75)
sigfeatures = features[[i]][which(rowsum > upper)]
```

### 5. Bayesian Approach (iClusterBayes)
`iClusterBayes` is often faster for large datasets as it does not require a $\lambda$ grid search and provides posterior probabilities for feature importance.

```R
bayfit = tune.iClusterBayes(cpus=6, dt1=mut, dt2=cn, dt3=exp, 
                            type=c("binomial","gaussian","gaussian"), 
                            K=1:6, n.burnin=18000, n.draw=12000)
```

## Visualization
Use `plotHeatmap` to visualize the integrated clusters across all data types.

```R
plotHeatmap(fit=best.fit, datasets=list(mut, cn, exp), 
            type=c("binomial","gaussian","gaussian"), 
            sparse=c(T, F, T), cap=c(F, T, F))
```

## Tips
- **Scale Lambda**: If one data type (like mutations) yields no selected features, adjust `scale.lambda` (e.g., `0.05`) in `tune.iClusterPlus` to balance the penalty across different data scales.
- **K vs Clusters**: The parameter `K` refers to the number of latent variables. The number of clusters is $K+1$.
- **Reproducibility**: Always use `set.seed()` before tuning or Bayesian analysis.

## Reference documentation
- [iClusterPlus: integrative clustering of multiple genomic data sets](./references/iClusterPlus.md)
- [iManual: iClusterPlus User's Guide](./references/iManual.md)