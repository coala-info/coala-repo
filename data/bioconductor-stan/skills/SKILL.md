---
name: bioconductor-stan
description: This tool performs genomic state annotation and genome segmentation using Hidden Markov Models to integrate multivariate genomic data. Use when user asks to learn and annotate genomic states, integrate strand-specific and non-strand-specific data, or perform genome segmentation using various emission distributions.
homepage: https://bioconductor.org/packages/3.6/bioc/html/STAN.html
---

# bioconductor-stan

name: bioconductor-stan
description: Genomic state annotation using (bidirectional) Hidden Markov Models (HMMs). Use this skill to integrate multivariate genomic data (ChIP-seq, RNA-seq, DNase-seq) to learn and annotate genomic states like promoters, enhancers, or transcription cycles. It supports various emission distributions (Poisson, Negative Binomial, Gaussian, etc.) and can handle strand-specific data.

# bioconductor-stan

## Overview

The `STAN` (Genomic STate ANnotation) package provides a framework for genome segmentation using Hidden Markov Models. It is particularly powerful because it supports a wide variety of probability distributions for different data types and implements bidirectional HMMs (bdHMMs) to integrate strand-specific (e.g., RNA) and non-strand-specific (e.g., ChIP) data.

## Core Workflow

The standard workflow for genome segmentation in `STAN` involves four primary steps: initialization, fitting, state path calculation, and conversion to genomic ranges.

### 1. Data Preparation
Data should be a list of matrices where rows are genomic positions (bins) and columns are experiments/tracks.

```R
library(STAN)
data(trainRegions) # Example data list
data(pilot.hg19)    # Corresponding GRanges

# Optional: Calculate size factors for sequencing depth normalization
celltypes = list("K562"=grep("E123", names(trainRegions)), 
                 "GM12878"=grep("E116", names(trainRegions)))
sizeFactors = getSizeFactors(trainRegions, celltypes)
```

### 2. Model Initialization (`initHMM` / `initBdHMM`)
Choose an emission distribution based on your data type:
*   `NegativeBinomial` or `PoissonLogNormal`: Recommended for overdispersed sequencing count data.
*   `Poisson`: For count data without overdispersion.
*   `Bernoulli`: For binarized (presence/absence) data.
*   `IndependentGaussian`: For log-transformed/continuous data.
*   `Gaussian`: For multivariate continuous data.

```R
# Standard HMM
nStates = 10
hmm = initHMM(trainRegions, nStates, "NegativeBinomial", sizeFactors)

# Bidirectional HMM (for strand-specific data)
# dirobs: 0 = non-strand-specific, 1 = strand-specific pair
dirobs = as.integer(c(rep(0, 10), 1, 1)) 
bdhmm = initBdHMM(trainRegions, dStates=6, method="Gaussian", directedObs=dirobs)
```

### 3. Model Fitting (`fitHMM`)
Optimizes model parameters using the Expectation-Maximization (EM) algorithm.

```R
# Increase maxIters for production (default is often low for speed)
hmm_fitted = fitHMM(trainRegions, hmm, sizeFactors=sizeFactors, maxIters=50)
```

### 4. State Annotation (`getViterbi`)
Calculates the most likely state path (Viterbi path) for the given observations.

```R
viterbi_path = getViterbi(hmm_fitted, trainRegions, sizeFactors=sizeFactors)
```

### 5. Results and Visualization
Convert the state path into `GRanges` for downstream analysis or visualization with `Gviz`.

```R
# Convert to GRanges
# binSize must match the resolution of your input data
viterbi_gr = viterbi2GRanges(viterbi_path, regions=pilot.hg19, binSize=200)

# Calculate mean signal per state for biological interpretation
avg_signal = getAvgSignal(viterbi_path, trainRegions)
```

## Distribution-Specific Tips

*   **Negative Multinomial**: Requires an extra data track representing the sum of counts for each bin.
    ```R
    data_nmn = lapply(trainRegions, function(x) cbind(apply(x,1,sum), x))
    hmm_nmn = initHMM(data_nmn, nStates, "NegativeMultinomial")
    ```
*   **Gaussian/Continuous**: If using sequencing data with Gaussian models, apply a transformation (e.g., `asinh` or `log(x+1)`) and consider setting `sharedCov=TRUE` in `initHMM` to avoid singularities in zero-inflated regions.
*   **Bernoulli**: Use `binarizeData(trainRegions)` to convert counts to binary format before initializing with the "Bernoulli" method.

## Reference documentation
- [The genomic STate ANnotation package](./references/STAN.md)