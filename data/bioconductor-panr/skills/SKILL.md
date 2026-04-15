---
name: bioconductor-panr
description: This tool infers Posterior Association Networks and functional gene modules from high-dimensional phenotypic data using Bayesian beta-mixture modeling. Use when user asks to quantify gene associations, fit beta-mixture models to phenotypic screens, infer posterior association networks, or identify enriched functional modules.
homepage: https://bioconductor.org/packages/release/bioc/html/PANR.html
---

# bioconductor-panr

name: bioconductor-panr
description: Inferring Posterior Association Networks (PAN) and enriched functional gene modules from rich phenotypes of gene perturbations (e.g., RNAi screens, cell morphology, gene expression). Use this skill when you need to quantify gene associations using Bayesian beta-mixture modeling, incorporate prior knowledge (like PPIs), and identify functional modules using multiscale bootstrap resampling.

## Overview

The `PANR` package provides a pipeline for analyzing high-dimensional phenotypic data from genetic screens. It addresses the challenge of selecting significant interactions from dense networks by modeling association densities (typically cosine similarities) as a mixture of three beta distributions: positive association (+), negative association (-), and lack of association (x). It allows for the incorporation of prior biological knowledge through stratified modeling and identifies robust gene modules via hierarchical clustering with bootstrap resampling.

## Typical Workflow

### 1. Data Preparation and Initialization
Input data should be a numeric matrix where rows are genes (or treatment conditions) and columns are phenotypes/replicates.

```R
library(PANR)
# Load example data
data(Bakal2007)

# Initialize the BetaMixture object
# metric: "cosine" (recommended) or "correlation"
# model: "global" or "stratified" (if using prior knowledge)
bm <- new("BetaMixture", pheno=Bakal2007, metric="cosine", model="global", order=1)
```

### 2. Beta-Mixture Modeling
The process involves fitting a NULL distribution (lack of association) and then fitting the full three-component mixture model.

```R
# Fit NULL distribution using permutations
bm <- fitNULL(bm, nPerm=10, thetaNULL=c(alphaNULL=4, betaNULL=4), 
              sumMethod="median", permMethod="all")

# Fit the full Beta-Mixture model (BM)
# thetaInit: initial shape parameters for Neg, NULL, and Pos components
bm <- fitBM(bm, para=list(zInit=NULL, 
                          thetaInit=c(alphaNeg=2, betaNeg=4, 
                                      alphaNULL=bm@result$fitNULL$thetaNULL[["alphaNULL"]],
                                      betaNULL=bm@result$fitNULL$thetaNULL[["betaNULL"]],
                                      alphaPos=4, betaPos=2), 
                          gamma=NULL),
            ctrl=list(fitNULL=FALSE, tol=1e-1))

# Visualize results
view(bm, "fitBM")
summarize(bm, what="ALL")
```

### 3. Inferring the Posterior Association Network (PAN)
Convert the mixture model results into a network by calculating posterior odds or Signal-to-Noise Ratios (SNR).

```R
pan <- new("PAN", bm1=bm)

# Infer edges using SNR (Posterior odds of signal vs noise)
# cutoff: log(5) is a common threshold for 'substantial' evidence
pan <- infer(pan, para=list(type="SNR", log=TRUE, sign=TRUE, cutoff=log(5)), filter=FALSE)

# Build the graph object (igraph or RedeR engine)
pan <- buildPAN(pan, engine="igraph")
```

### 4. Searching for Enriched Modules
Use multiscale bootstrap resampling to find statistically significant clusters.

```R
library(pvclust)
# Search for modules (supports parallel computing via 'snow' package)
pan <- pvclustModule(pan, nboot=1000, metric="cosine", hclustMethod="average")

# Retrieve significant modules
# pValCutoff: significance level (e.g., 0.01)
inds <- sigModules(pan, pValCutoff=0.01, minSize=3, maxSize=100)

# Visualize specific modules
viewPAN(pan, what="pvclustModule", moduleID=inds[1])
```

## Key Functions and Parameters

- `new("BetaMixture", ...)`: Creates the core container. Use `model="stratified"` and provide a `partition` vector if you have prior knowledge (e.g., PPI vs non-PPI pairs).
- `fitNULL()`: Estimates the parameters for the "noise" component. `permMethod="replicate"` is more conservative than `"all"`.
- `fitBM()`: Performs Maximum A Posteriori (MAP) estimation via the EM algorithm.
- `infer()`: Filters the dense network into a sparse PAN. `type="SNR"` is the standard metric for edge weighting.
- `pvclustModule()`: Uses the `pvclust` algorithm to assign p-values to clusters.

## Tips for Success

- **Cosine Similarity**: `PANR` prefers cosine similarity (uncentered correlation) because it captures both magnitude and direction of phenotypic changes.
- **Prior Knowledge**: If you have a list of known interactions (e.g., from STRING), use the stratified model. This allows the EM algorithm to learn different mixing proportions for known vs. unknown pairs.
- **Visualization**: For complex networks, the `RedeR` engine is recommended over `igraph` for its ability to handle nested containers and hierarchical layouts.
- **Parallelization**: `pvclustModule` can be slow. Use `options(cluster=makeCluster(n, "SOCK"))` to speed up the bootstrap process.

## Reference documentation

- [PANR : Posterior association network and enriched functional gene modules inferred from rich phenotypes of gene perturbations](./references/PANR-Vignette.md)