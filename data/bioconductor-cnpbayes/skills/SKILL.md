---
name: bioconductor-cnpbayes
description: This tool performs Bayesian hierarchical Gaussian mixture modeling for copy number estimation and batch effect identification. Use when user asks to fit finite mixture models to genomic data, identify latent batch effects, map mixture components to integer copy number states, or integrate copy number uncertainty into association models.
homepage: https://bioconductor.org/packages/3.8/bioc/html/CNPBayes.html
---


# bioconductor-cnpbayes

name: bioconductor-cnpbayes
description: Bayesian hierarchical Gaussian mixture modeling for copy number estimation. Use this skill to identify latent batch effects, fit finite mixture models (SB, MB, SBP, MBP), map mixture components to integer copy number states, and integrate copy number uncertainty into association models.

# bioconductor-cnpbayes

## Overview
CNPBayes is designed for the analysis of copy number polymorphisms (CNPs) in large-scale studies. It uses a hierarchical Bayesian Gaussian mixture model to account for technical variation (batch effects) that can otherwise lead to false positives or poor separation of copy number states. The package supports four model types:
- **SB (Single Batch)**: Standard mixture model.
- **MB (Multi-Batch)**: Batch-specific means and variances.
- **SBP (Single Batch Pooled)**: Pooled variance across components.
- **MBP (Multi-Batch Pooled)**: Batch-specific variances pooled across components.

## Core Workflow

### 1. Data Preparation
Summarize genomic data (e.g., log R ratios from SNP arrays) into a single value per sample per region, typically using the median.

```r
library(CNPBayes)
# med.summary is a numeric vector of median log R ratios
# provisional_batch is a vector of batch surrogates (e.g., plate IDs)
```

### 2. Identifying Batches
Use `kolmogorov_batches` to group provisional batches with similar distributions to reduce model complexity.

```r
# Combine plates with similar eCDFs
batches <- kolmogorov_batches(dat = med.summary, batch = provisional_batch, alpha = 1e-6)
```

### 3. Model Fitting with `gibbs`
The `gibbs` function is the primary interface for fitting models. It automatically handles burn-in, thinning, and convergence diagnostics.

```r
mp <- McmcParams(nStarts = 5, burnin = 500, iter = 1000, thin = 1)

# Fit models across a range of components (k)
model.list <- gibbs(model = "MBP", 
                    dat = med.summary, 
                    batches = batches, 
                    k_range = c(1, 4), 
                    mp = mp)

# Models are sorted by marginal likelihood
best.model <- model.list[[1]]
```

### 4. Convergence and Goodness of Fit
Assess convergence using Gelman-Rubin diagnostics and visual inspection of chains.

```r
# Visual inspection of MCMC chains
chains <- ggChains(best.model)
print(chains[[1]]) # theta
print(chains[[2]]) # sigma

# Posterior predictive check
ggMixture(best.model)
```

### 5. Mapping to Copy Number
Mixture components do not always have a 1:1 mapping to copy number. Use `CopyNumberModel` to automate the mapping based on component overlap.

```r
cn.model <- CopyNumberModel(best.model)

# View mapping
mapping(cn.model)

# Get posterior probabilities for copy number states
probs <- probCopyNumber(cn.model)
```

## Advanced Features

### Handling Rare Homozygous Deletions
For rare variants, use `homdeldup_model` which employs data augmentation to ensure components are correctly assigned even in batches where the variant is absent.

```r
# Automated workflow for deletion/duplication polymorphisms
bayes.model <- homdeldup_model(multi_batch_object, mp)
```

### Big Data Downsampling
For very large datasets, fit the model on a representative subset and upsample to the full population.

```r
# Downsample
partial.data <- downSample(full.data, size = 1000)

# Fit model on partial.data...

# Upsample to full population
model.full <- upSample2(full.data, best.model)
```

## Reference documentation
- [Inspecting Convergence of a Model](./references/Convergence.md)
- [Implementation of Bayesian mixture models for copy number estimation](./references/Implementation.md)
- [Overview of CNPBayes package](./references/Overview.md)
- [CNPBayes: Bayesian copy number estimation and association in large-scale studies (Rmd)](./references/cnpbayes.Rmd)
- [CNPBayes: Bayesian copy number estimation and association in large-scale studies (md)](./references/cnpbayes.md)