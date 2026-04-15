---
name: bioconductor-hilda
description: HiLDA performs statistical testing for changes in mutational signature burdens between two groups using a Bayesian framework. Use when user asks to test for differences in mutation exposure, perform global or local tests on mutational signatures, or visualize signature differences between experimental groups.
homepage: https://bioconductor.org/packages/release/bioc/html/HiLDA.html
---

# bioconductor-hilda

name: bioconductor-hilda
description: Statistical testing for changes in mutational signature burdens between two groups using a Bayesian framework. Use this skill when analyzing cancer mutation signatures to perform global or local tests for differences in mutation exposure, visualize signatures, and assess MCMC convergence.

# bioconductor-hilda

## Overview
HiLDA (Hierarchical Latent Dirichlet Allocation) is an R package designed to test whether the mutational burdens of specific signatures change between two experimental groups (e.g., treated vs. control, or different cancer types). It utilizes a Bayesian framework and is built upon the independent mutation model (Shiraishi model), which considers substitutions, flanking bases, and transcription direction.

## Prerequisites
HiLDA requires the external software **JAGS** (Just Another Gibbs Sampler) to be installed on the system to perform MCMC sampling.

## Workflow and Key Functions

### 1. Data Input
HiLDA uses the Mutation Position format (Sample, Chromosome, Position, Ref, Alt).
```r
library(HiLDA)
# Read mutation position files
# numBases: flanking bases (e.g., 5 for two 5' and two 3' bases)
# trDir: include transcription direction
G <- hildaReadMPFile("path/to/file.txt", numBases=5, trDir=TRUE)
```

### 2. Statistical Testing
You can perform either a **Global Test** (testing if any signature changes) or a **Local Test** (testing specific signatures).
```r
# refGroup: indices of samples in the reference group
# localTest: FALSE for global, TRUE for local
hildaResult <- hildaTest(inputG=G, 
                         numSig=3, 
                         refGroup=1:4, 
                         localTest=TRUE, 
                         nIter=1000)
```

### 3. Optimization with Initial Values
To speed up MCMC convergence, use `pmsignature` to generate initial values via the EM algorithm.
```r
# Get initial parameters
Param <- pmgetSignature(G, K = 3)

# Run HiLDA with initial values
hildaResult <- hildaTest(inputG=G, 
                         numSig=3, 
                         useInits = Param,
                         refGroup=1:4, 
                         nIter=1000)
```

### 4. Convergence Diagnostics
Always check the potential scale reduction factor (Rhat). Values should ideally be < 1.10.
```r
hildaRhat(hildaResult)
```

### 5. Visualization
HiLDA provides functions to visualize both the signatures themselves and the differences in exposure between groups.
```r
# Barplot of signatures and proportions
hildaPlots <- hildaBarplot(G, hildaResult, refGroup=1:4, sigOrder=c(1,2,3))
cowplot::plot_grid(hildaPlots$sigPlot, hildaPlots$propPlot, rel_widths = c(1,3))

# Plot 95% credible intervals for mean differences in exposures
hildaDiffPlots <- hildaDiffPlot(G, hildaResult, sigOrder=c(1,2,3))
cowplot::plot_grid(hildaDiffPlots$sigPlot, hildaDiffPlots$diffPlot, rel_widths = c(1,3))
```

## Tips
- If `hildaRhat` returns values > 1.1, increase `nIter` to ensure the MCMC chains have converged.
- The `sigOrder` parameter in plotting functions allows you to align signatures across different plots for easier comparison.
- HiLDA is specifically designed for the Shiraishi model; for standard 96-substitution triplet models (Alexandrov model), ensure the input data is formatted correctly for `hildaReadMPFile`.

## Reference documentation
- [HiLDA: a package for testing the burdens of mutational signatures](./references/HiLDA.Rmd)
- [HiLDA Vignette](./references/HiLDA.md)