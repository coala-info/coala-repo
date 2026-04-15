---
name: bioconductor-parglms
description: This tool fits generalized linear models on large, dispersed datasets using parallel evaluation. Use when user asks to fit GLMs on datasets too large for memory, perform parallelized model estimation on chunked data, or analyze large-scale genomic datasets stored in BatchJobs registries.
homepage: https://bioconductor.org/packages/release/bioc/html/parglms.html
---

# bioconductor-parglms

name: bioconductor-parglms
description: Fitting generalized linear models (GLMs) on large, dispersed datasets using parallel evaluation. Use this skill when working with Bioconductor datasets that are too large for memory and are stored in chunks (e.g., BatchJobs registries or geuvStore2), requiring scalable GLM estimation.

## Overview

The `parglms` package provides a scalable approach to fitting Generalized Linear Models (GLMs). It decomposes the model-fitting process—specifically the calculation of sufficient statistics—into parts that fit in memory. These parts are processed in parallel using `BiocParallel`, making it ideal for large-scale genomic studies like eQTL analysis where data is dispersed across multiple files or nodes.

## Core Workflow

### 1. Data Preparation (Dispersal)
Data must be organized into chunks, typically using a `BatchJobs` registry.

```r
library(BatchJobs)
library(parglms)

# Create a registry and map data into chunks
myr = makeRegistry("my_analysis", file.dir=tempfile())
chs = chunk(1:nrow(large_data), n.chunks=10)
f = function(x) large_data[x,]
batchMap(myr, f, chs)
submitJobs(myr)
waitForJobs(myr)
```

### 2. Fitting the Model
The `parGLM` function is the primary interface. It requires a formula, the registry object, and standard GLM parameters.

```r
# Fit a Gaussian model
model = parGLM(
  formula = Postwt ~ Treat + Prewt, 
  registry = myr,
  family = gaussian, 
  binit = c(0, 0, 0, 0), # Initial values for coefficients
  maxit = 10, 
  tol = .001
)

# Fit a Binomial model (e.g., GWAS hit status)
model_bin = parGLM(
  isGwasHit ~ hmmState, 
  registry = prst,
  family = binomial, 
  binit = rep(0, 13)
)
```

### 3. Extracting Results
The resulting object contains coefficients and variance estimates. Use `summaryPG` for a quick overview.

```r
# View coefficients
model$coefficients

# Get summary statistics (coefficients, SE, z-scores)
summaryPG(model)

# Access other components
model$eff.variance    # Effective variance
model$converged       # Convergence status
model$N               # Total number of observations
```

## Advanced Usage with geuvStore2
When working with specialized stores like `geuvStore2`, you must define an `extractor` function for the registry to transform the stored chunks into a format suitable for the GLM (usually a `data.frame`).

```r
# Define an extractor that processes GRanges into data.frame
prst$extractor = function(store, i) {
  chunk_data = loadResult(store, i)[[1]]
  # Perform transformations/decorations here
  return(as.data.frame(chunk_data))
}

# Run parallel GLM on the store
p1 = parGLM(isGwasHit ~ hmmState, prst, family=binomial)
```

## Tips and Best Practices
- **Parallel Backend**: `parGLM` uses `BiocParallel`. Ensure a parallel backend is registered (e.g., `register(MulticoreParam(4))`) to actually achieve speedups; otherwise, it defaults to sequential execution.
- **Initial Values**: Providing a good `binit` (initial beta vector) can significantly improve convergence speed for complex models.
- **Memory Management**: Ensure that the individual chunks defined in your registry are small enough to fit comfortably in the memory of a single worker node.

## Reference documentation
- [parglms](./references/parglms.md)