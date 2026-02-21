---
name: bioconductor-kimod
description: the package is to use these techniques to omic data analysis, it includes an example data from four different microarray platforms (i.e.,Agilent, Affymetrix HGU 95, Affymetrix HGU 133 and Affymetrix HGU 133plus 2.0) on the NCI-60 cell lines.NCI60_4arrays is a list containing the NCI-60 microarray data with only few hundreds of genes randomly selected in each platform to keep the size of the package small. The data are the same that the package omicade4 used to implement the co-inertia analysis. The references in packages follow the style of the APA-6th norm.
homepage: https://bioconductor.org/packages/3.6/bioc/html/kimod.html
---

# bioconductor-kimod

name: bioconductor-kimod
description: Integration of multiple Omics datasets using K-tables (STATIS) methodology. Use this skill to perform multi-table multivariate analysis, generate compromise configurations of biological samples, project variables (genes) onto consensus spaces using Biplot regressions, and perform bootstrap-based stability analysis for omic data.

# bioconductor-kimod

## Overview

The `kimod` package implements the STATIS (Structuration des Tableaux à Trois Indices de la Statistique) methodology for integrating multiple data tables (K-tables) collected on the same set of observations. It is specifically optimized for "omic" data integration (e.g., multiple microarray platforms). Key features include the ability to handle mixed data types via various distance metrics, bootstrap resampling for confidence ellipses, and Biplot regressions to project variables onto the compromise space for gene selection and clustering.

## Core Workflow

### 1. Data Preparation
Data should be organized as a `list` of matrices or data frames where each element represents a different platform or study. All tables must have the same observations (rows) in the same order.

```r
library(kimod)
data(NCI60Selec_ESet) # Example dataset: list of 4 microarray platforms

# Verify dimensions (Samples must match across list elements)
lapply(NCI60Selec_ESet, dim)
```

### 2. STATIS Analysis (Interstructure and Compromise)
The `DiStatis` function is the primary entry point. It calculates the interstructure (relationship between tables) and the compromise (consensus configuration).

```r
# Run STATIS
Z1 <- DiStatis(NCI60Selec_ESet)

# Plot the contribution of each table to the compromise
RVPlot(Z1)

# Plot the projection of observations (samples) on the compromise
CompPlot(Z1, colObs = my_colors, pch = 15)
```

### 3. Stability Analysis (Bootstrap)
To assess the reliability of the sample projections, use bootstrap resampling on the residual matrix.

```r
# Generate bootstrap replicates
B <- Bootstrap(Z1)

# Plot confidence regions for observations
BootPlot(B, Points = FALSE, col = my_colors)

# Check significant differences between observations
Comparisions.Boot(B)
```

### 4. Variable Selection and Biplot Projection
Since STATIS typically focuses on observations, `kimod` uses Biplot regression to project variables (genes) back onto the consensus space.

```r
# Select variables based on goodness of fit (e.g., Adjusted R2)
# perc = 0.95 selects the top 5% of variables
M1 <- SelectVar(Z1, Crit = "R2-Adj", perc = 0.95)

# Visualize variables and observations together
Biplot(M1, colObs = my_colors, Type = "SQRT")
```

### 5. Clustering Variables
Group selected variables that share similar expression profiles across the integrated datasets.

```r
# Cluster variables into 4 groups using Ward's method
A1 <- GroupProj(M1, method = "ward", metric = "euclidean", NGroups = 4)

# View which genes belong to which cluster
Groups(A1)

# Check over/under expression of clusters relative to tissues
head(SortList(A1)[[1]])
```

## Key Functions Reference

- `DiStatis()`: Performs the multi-table analysis. Returns a `DiStatis` S4 object.
- `RVPlot()`: Visualizes the Vectorial Correlation (RV) between studies.
- `CompPlot()`: Plots the consensus configuration of observations.
- `Bootstrap()`: Computes bootstrap replicates for stability analysis.
- `SelectVar()`: Fits linear regressions to project variables onto the compromise.
- `GroupProj()`: Performs cluster analysis on the projected variables.

## Tips for Omics Integration
- **Distance Metrics**: While Euclidean is default, `DiStatis` supports different metrics for mixed data types.
- **Gene Selection**: Use `Crit = "P-Value"` or `Crit = "AIC"` in `SelectVar` for more statistically rigorous gene filtering.
- **Interpretation**: In the Biplot, the projection of an observation onto a variable vector predicts the expression level of that gene in that sample.

## Reference documentation

- [kimod A K-tables approach to integrate multiple Omics-Data in R](./references/kimod-vignette.md)