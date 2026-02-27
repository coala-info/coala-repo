---
name: bioconductor-splinetimer
description: This tool performs differential gene expression analysis of time-course data using natural cubic spline regression models. Use when user asks to analyze longitudinal gene expression experiments, compare expression trends between two treatment groups, reconstruct gene association networks, or perform pathway enrichment analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/splineTimeR.html
---


# bioconductor-splinetimer

name: bioconductor-splinetimer
description: Differential gene expression analysis of time-course data using natural cubic spline regression models. Use this skill for analyzing longitudinal gene expression experiments with two treatment groups, reconstructing time-dependent gene association networks, and performing pathway enrichment or scale-free network property analysis.

## Overview

The `splineTimeR` package is designed for the analysis of time-course gene expression data. It fits natural cubic spline regression models to characterize non-linear expression trends over time. It is particularly useful for two-way experimental designs (e.g., Control vs. Treated) where time is treated as a continuous variable. The package supports a full workflow from differential expression detection to network reconstruction and pathway enrichment.

## Data Preparation

The package requires data to be formatted as a Bioconductor `ExpressionSet` object.

- **Phenotypic Data (`pData`)**: Must contain three specific columns:
    - `SampleName`: Unique identifier for each sample.
    - `Time`: Numeric value representing the time point.
    - `Treatment`: Factor with two levels (e.g., "Control" and "Treated").
    - `Replicate` (Optional): To identify technical or biological replicates.
- **Time Points**: Should ideally be identical between the two treatment groups.

```r
library(splineTimeR)
# Example of checking required structure
head(pData(yourExpressionSet))
```

## Differential Expression Analysis

The core function `splineDiffExprs` compares the shapes of the fitted splines between two groups using empirical Bayes moderate F-statistics.

```r
diffExprs <- splineDiffExprs(
  eSetObject = yourExpressionSet, 
  df = 3,                        # Degrees of freedom (typically 3-5)
  cutoff.adj.pVal = 0.05,        # BH adjusted p-value threshold
  reference = "Control",         # Name of the reference treatment group
  intercept = TRUE               # TRUE includes the first time point in the F-test
)
```

- **Degrees of Freedom (`df`)**: Controls the flexibility of the spline. 3-5 is recommended.
- **Intercept**: Set to `FALSE` if you only want to detect differences in the *shape* of the response over time, ignoring differences at the initial time point.

## Visualization

Use `splinePlot` to generate PDF plots of the fitted spline curves for specific genes.

```r
splinePlot(
  eSetObject = yourExpressionSet, 
  df = 3, 
  reference = "Control", 
  toPlot = c("GENE1", "GENE2")
)
```

## Pathway Enrichment Analysis

The `pathEnrich` function uses a hypergeometric test (Fisher's Exact Test) to identify enriched pathways from `.gmt` files (e.g., MSigDB or Reactome).

```r
# geneSets should be loaded using GSEABase::getGmt()
enrichPath <- pathEnrich(
  geneList = rownames(diffExprs), 
  geneSets = geneSets, 
  universe = 6536  # Total number of genes probed in the experiment
)
```

## Network Reconstruction

`splineNetRecon` reconstructs gene association networks using partial correlation with a shrinkage approach.

```r
# Reconstruct network for a specific treatment group
igr <- splineNetRecon(
  eSetObject = yourExpressionSet, 
  treatmentType = "Treated", 
  probesForNR = rownames(diffExprs), 
  cutoff.ggm = 0.8,      # Probability threshold for edges
  method = "dynamic"     # "dynamic" or "static" shrinkage
)

# Plot the resulting igraph object
plot(igr, vertex.label = NA, vertex.size = 3)
```

## Network Properties

To evaluate if the reconstructed network follows scale-free properties (common in biological systems), use `networkProperties`.

```r
# Returns a table with nodes, edges, and degree_exponent
scaleFreeProp <- networkProperties(igr)
```

## Reference documentation

- [Using splineTimeR package](./references/splineTimeR.md)