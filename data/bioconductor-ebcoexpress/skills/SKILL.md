---
name: bioconductor-ebcoexpress
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/EBcoexpress.html
---

# bioconductor-ebcoexpress

name: bioconductor-ebcoexpress
description: Empirical Bayesian analysis for identifying differential co-expression (DC) in high-throughput genomic data. Use this skill to identify gene pairs with varying correlation structures across biological conditions, perform meta-analysis across multiple studies, and visualize co-expression networks.

# bioconductor-ebcoexpress

## Overview

EBcoexpress implements an empirical Bayesian framework to identify differentially co-expressed (DC) gene pairs. Unlike standard differential expression (DE) which looks at mean changes, DC identifies changes in the correlation between genes across conditions. The package uses a mixture of Normals prior and a modified EM algorithm (TCA-ECM) to calculate posterior probabilities for various co-expression classes, providing FDR-controlled results.

## Typical Workflow

### 1. Data Preparation
The package requires three primary inputs:
*   **Expression Matrix**: An $m \times n$ matrix (genes by samples). Data should be normalized (median correction recommended; avoid quantile normalization as it disrupts correlation).
*   **Conditions Array**: A vector of length $n$ indicating the condition (e.g., `1, 1, 2, 2`).
*   **Pattern Object**: Defines the Equivalent Co-expression (EC) and Differential Co-expression (DC) classes.

```r
library(EBcoexpress)
library(EBarrays) # Required for ebPatterns

# Example for 2 conditions
tinyCond <- c(rep(1, 100), rep(2, 25))
tinyPat <- ebPatterns(c("1,1", "1,2"))
```

### 2. Calculate Correlation Matrix (D)
Generate the $p \times K$ matrix of intra-group correlations for all $p = m(m-1)/2$ gene pairs.

```r
# useBWMC=TRUE uses robust biweight midcorrelation (recommended)
# useBWMC=FALSE uses Pearson correlation (faster for large m)
D <- makeMyD(expressionMatrix, tinyCond, useBWMC=TRUE)
```

### 3. Initialize Hyperparameters
Estimate starting values for the EM algorithm using `Mclust`.

```r
set.seed(3)
# For large p, use subsize = p/1000 to speed up initialization
initHP <- initializeHP(D, tinyCond, subsize = NULL)
```

### 4. Run EM Computations
Choose between three versions of the TCA-ECM algorithm. The "One-Step" version is generally recommended for balancing speed and accuracy.

```r
# One-Step (Recommended)
oout <- ebCoexpressOneStep(D, tinyCond, tinyPat, initHP)

# Full EM (Most rigorous)
fout <- ebCoexpressFullTCAECM(D, tinyCond, tinyPat, initHP)

# Zero-Step (Fastest, uses initial estimates only)
zout <- ebCoexpressZeroStep(D, tinyCond, tinyPat, initHP)
```

### 5. Identify DC Pairs
Extract posterior probabilities and apply a threshold.

```r
# Extract posterior probabilities (Column 1 is EC)
probEC <- oout$POSTPROBS[, 1]
probDC <- 1 - probEC

# Soft thresholding for FDR control (e.g., 5% FDR)
threshold <- crit.fun(probEC, 0.05)
dcPairs <- names(probDC)[probDC >= threshold]

# Rank genes by how many DC pairs they participate in (Hub genes)
hubs <- rankMyGenes(oout, thresh = 0.95)
```

## Meta-Analysis
To combine multiple studies, estimate hyperparameters for each study individually, then use `ebCoexpressMeta`.

```r
hpEstsList <- list(study1_out$MODEL$HPS, study2_out$MODEL$HPS)
metaResults <- ebCoexpressMeta(DList, conditionsList, tinyPat, hpEstsList)
```

## Visualization

### Network Plots
Visualize co-expression networks using `igraph` integration.

```r
# Show network for a subset of genes
showNetwork(geneNames, D, condFocus = 1, hidingThreshold = 0.3)
```

### Pairwise Expression
Plot the expression of two genes against each other, colored by condition.

```r
showPair("GeneA~GeneB", expressionMatrix, tinyCond, useBWMC=TRUE)
```

## Important Considerations
*   **Gene Limit**: Performance is quadratic $O(m^2)$. It is recommended to limit analysis to 10,000 genes or fewer.
*   **Subsampling**: For large datasets, use the `subsize` option in EM functions to estimate hyperparameters on a subset of pairs (e.g., `subsize = p/1000`) to significantly reduce runtime with minimal impact on accuracy.
*   **Diagnostics**: Use `priorDiagnostic(D, tinyCond, output, condition)` to check if the model fit matches the empirical distribution. If the fit is poor, consider manually initializing a more complex prior (increasing $G$).

## Reference documentation
- [EBcoexpressVignette](./references/EBcoexpressVignette.md)