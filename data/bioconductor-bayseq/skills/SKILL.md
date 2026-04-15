---
name: bioconductor-bayseq
description: This tool performs empirical Bayesian analysis to identify patterns of differential expression in high-throughput sequencing count data. Use when user asks to perform differential expression analysis on RNA-seq or sRNA-seq data, evaluate complex experimental designs across multiple groups, or analyze paired genomic data using custom distribution models.
homepage: https://bioconductor.org/packages/release/bioc/html/baySeq.html
---

# bioconductor-bayseq

name: bioconductor-bayseq
description: Empirical Bayesian analysis for identifying patterns of differential expression in high-throughput sequencing count data. Use when Claude needs to perform differential expression (DE) analysis on RNA-seq, sRNA-seq, or other count-based genomic data, particularly for complex experimental designs, paired data, or when custom distribution models are required.

# bioconductor-bayseq

## Overview
The `baySeq` package implements empirical Bayesian methods to estimate the posterior likelihoods of various models of differential expression. Unlike methods restricted to pairwise comparisons, `baySeq` can evaluate any pattern of expression across multiple experimental groups by defining models as partitions of samples. It is particularly robust for small RNA-seq data and can be extended to custom distributions beyond the default Negative Binomial.

## Core Workflow

### 1. Data Preparation
Input data must be a matrix or data frame of integer counts where rows are genomic features and columns are samples.

```r
library(baySeq)
library(parallel)

# Optional: Set up parallel processing
cl <- makeCluster(4)

# Example data
data(simData)
replicates <- c("A", "A", "A", "A", "A", "B", "B", "B", "B", "B")
```

### 2. Defining Models (Groups)
Models are defined as a list of vectors. Each vector assigns samples to groups. Samples with the same number in a vector are assumed to have equivalent expression under that model.

```r
# NDE: No Differential Expression (all samples in group 1)
# DE: Differential Expression (first 5 in group 1, last 5 in group 2)
groups <- list(NDE = c(1,1,1,1,1,1,1,1,1,1),
               DE  = c(1,1,1,1,1,2,2,2,2,2))
```

### 3. Creating the countData Object
Initialize the container and estimate library scaling factors.

```r
CD <- new("countData", data = simData, replicates = replicates, groups = groups)
libsizes(CD) <- getLibsizes(CD)

# Optional: Add annotation
CD@annotation <- data.frame(name = paste0("feature_", 1:nrow(simData)))
```

### 4. Estimating Priors and Likelihoods
`baySeq` uses a two-step process: estimating the empirical prior distribution from a sample of the data, then calculating posterior likelihoods for all features.

```r
# Negative Binomial approach
CD <- getPriors.NB(CD, samplesize = 10000, estimation = "QL", cl = cl)
CD <- getLikelihoods(CD, cl = cl)
```

### 5. Inspecting Results
Use `topCounts` to retrieve features ranked by posterior likelihood for a specific model.

```r
# Get top 10 features for the 'DE' model
topCounts(CD, group = "DE", number = 10)

# View estimated proportions of each model in the data
CD@estProps
```

## Advanced Workflows

### Paired Data Analysis
For paired data (e.g., before/after treatment), the data should be provided as a 3D array `[features, samples, 2]`.

```r
# data is an array where dim 3 represents the pair members
pairCD <- new("countData", data = pairArray, replicates = c(1,1,2,2), 
              groups = list(NDE = c(1,1,1,1), DE = c(1,1,2,2)),
              densityFunction = bbDensity) # Often uses Beta-Binomial
pairCD <- getPriors(pairCD, cl = cl)
pairCD <- getLikelihoods(pairCD, cl = cl)
```

### Handling Null Data
If many features are likely unexpressed (null), use `nullData = TRUE` in `getLikelihoods` to improve estimation.

```r
CD <- getLikelihoods(CD, nullData = TRUE, cl = cl)
```

### Custom Distributions
You can define a `densityFunction` object to use distributions other than Negative Binomial (e.g., Normal, Zero-Inflated).

```r
normDensity <- new("densityFunction", density = function(x, obs, pars) {
  dnorm(x, mean = pars[[2]] * obs$libsizes, sd = pars[[1]], log = TRUE)
}, initiatingValues = c(0.1, 1), equalOverReplicates = c(TRUE, FALSE))

densityFunction(CD) <- normDensity
CD <- getPriors(CD, cl = cl)
CD <- getLikelihoods(CD, cl = cl)
```

## Visualization
*   **MA-plot**: `plotMA.CD(CD, samplesA = "A", samplesB = "B")`
*   **Posteriors**: `plotPosteriors(CD, group = "DE")`
*   **Null Priors**: `plotNullPrior(CD)` (to check for bimodality indicating unexpressed features).

## Tips
*   **Parallelization**: Always use a cluster (`makeCluster`) for large datasets as `baySeq` is computationally intensive.
*   **Sample Size**: While `samplesize = 1000` is fast for testing, use `10000` or more for publication-quality results.
*   **Library Sizes**: `getLibsizes` supports `estimationType = "total"` or `"quantile"`.

## Reference documentation
- [baySeq](./references/baySeq.md)
- [baySeq_generic](./references/baySeq_generic.md)