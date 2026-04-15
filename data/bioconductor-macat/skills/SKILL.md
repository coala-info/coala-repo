---
name: bioconductor-macat
description: This tool performs statistical analysis of differential gene expression linked to chromosomal localization to identify significantly over- or under-expressed genomic regions. Use when user asks to identify differentially expressed chromosomal regions, smooth expression scores along chromosomes using kernels, or perform permutation tests on microarray data.
homepage: https://bioconductor.org/packages/3.5/bioc/html/macat.html
---

# bioconductor-macat

name: bioconductor-macat
description: Statistical analysis of differential gene expression linked to chromosomal localization. Use this skill to identify significantly differentially expressed chromosomal regions in microarray data using smoothing kernels (kNN, RBF) and permutation tests.

## Overview
The `macat` (MicroArray Chromosome Analysis Tool) package links differential gene expression to the chromosomal localization of genes. It allows researchers to identify large chromosomal regions that are significantly over- or under-expressed in specific tumor subtypes. The workflow involves preprocessing expression data with genomic coordinates, scoring differential expression using a regularized t-statistic, smoothing these scores along chromosomes using kernel functions, and assessing significance via permutation experiments.

## Typical Workflow

### 1. Data Loading and Preprocessing
MACAT requires a specific data format containing gene identifiers, chromosomal locations (chromosome, strand, coordinate), sample labels, and an expression matrix.

```r
library(macat)
# Load example data from the stjudem data package
# loaddatapkg("stjudem") # If available
data(stjude)

# Summary of the MACAT data object
summary(stjude)

# Accessing specific components
stjude$geneName[1:10]
unique(stjude$labels)
```

### 2. Exploratory Visualization
Visualize the sliding average of expression values for a specific sample along a chromosome.

```r
# Plot sliding average for chromosome 6, sample 3 using Radial Basis Function kernel
plotSliding(stjude, 6, sample = 3, kernel = rbf)
```

### 3. Parameter Evaluation
Before scoring, determine the optimal smoothing parameter (e.g., $k$ for kNN or $\gamma$ for RBF) using cross-validation to minimize the residual sum of squares.

```r
# Evaluate k-Nearest Neighbor (kNN) parameters for class "T" on chromosome 6
evalkNN6 = evaluateParameters(stjude, class = "T", chromosome = 6, kernel = kNN,
                             paramMultipliers = c(0.01, seq(0.1, 2.0, 0.1), 2.5))

# Find the best parameter
evalkNN6$best
plot(evalkNN6)
```

### 4. Scoring and Significance Testing
The `evalScoring` function is the core of the package. It computes the regularized t-statistic and performs permutations to establish significance boundaries.

```r
# Compute scores with 1000 permutations
# class: the target subtype to compare against all others
e1 = evalScoring(stjude, 
                 class = "T", 
                 chromosome = 6, 
                 nperms = 1000,
                 kernel = kNN, 
                 kernelparams = evalkNN6$best, 
                 cross.validate = FALSE)
```

### 5. Visualizing Results and Identifying Regions
Plot the results to see observed scores versus permutation-based confidence intervals.

```r
# Standard plot
plot(e1)

# Generate an HTML report with clickable LocusIDs for genes in significant regions
plot(e1, output = "html")
```

## Key Functions
- `buildMACAT` / `preprocessedLoader`: Integrates expression data with gene location data.
- `evaluateParameters`: Performs cross-validation to find optimal kernel smoothing parameters.
- `evalScoring`: Main analysis function; calculates statistics and performs permutations.
- `plot.MACATevalScoring`: Visualizes significant regions (yellow highlights) and permutation quantiles (grey lines).
- `plotSliding`: Simple visualization of expression levels along a chromosome.

## Kernel Types
- `kNN`: k-Nearest Neighbors. Averages the $k$ closest genes.
- `rbf`: Radial Basis Function. Weighted average based on distance (Gaussian-like).
- `bpd`: Base-Pair-Distance. Averages all genes within a fixed physical radius.

## Reference documentation
- [MACAT - MicroArray Chromosome Analysis Tool](./references/macat.md)