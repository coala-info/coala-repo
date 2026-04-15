---
name: bioconductor-isogenegui
description: This tool analyzes dose-response microarray experiments using order-restricted statistical methods to identify and cluster gene expression trends. Use when user asks to perform trend testing, conduct model selection with GORIC, or cluster genes based on dose-response profiles.
homepage: https://bioconductor.org/packages/3.8/bioc/html/IsoGeneGUI.html
---

# bioconductor-isogenegui

name: bioconductor-isogenegui
description: Analysis of dose-response microarray experiments using order-restricted statistical methods. Use this skill to perform trend testing (LRT, SAM, Permutation), model selection (GORIC), and clustering (ORCME, ORIClust) on gene expression data with monotonic or non-monotonic dose-response profiles.

## Overview

The `IsoGeneGUI` package provides a comprehensive suite of tools for analyzing microarray data from dose-response studies. While it is primarily known for its Tcl/Tk graphical user interface, the underlying logic integrates several specialized Bioconductor/CRAN packages (IsoGene, GORIC, ORCME, ORIClust, and orQA) to test for monotone trends and cluster genes based on their expression profiles across dose levels.

## Core Workflow

### 1. Data Preparation
The package expects two primary inputs:
- **Expression Matrix**: A matrix or data frame where rows are genes and columns are arrays/samples.
- **Dose Vector**: A numeric vector containing dose levels corresponding to the columns of the expression matrix.

```r
library(IsoGeneGUI)

# Example data structure (dopamine2)
# data(dopamine2) 
# expr_data <- dopamine2$expression
# doses <- dopamine2$dose
```

### 2. Exploratory Analysis (IsoPlot)
Visualize the data points, sample means, and the isotonic regression line for specific genes.

```r
# Note: In the GUI, this is handled via Plots > IsoPlot
# For R-based exploration, use the underlying IsoGene functions:
# IsoPlot(doses, expr_data[row_index, ], main="Gene Name")
```

### 3. Statistical Testing for Trends
Identify genes with significant dose-response relationships using various statistics (E2, Williams, Marcus, M, or Likelihood Ratio Tests).

- **Asymptotic LRT (E2)**: Fast calculation using exact p-values for the E2 statistic.
- **Permutation Testing**: Used for calculating p-values when asymptotic assumptions don't hold or for other statistics (Williams, Marcus, etc.).
- **SAM (Significance Analysis of Microarrays)**: A regularized approach to handle small variance genes and control False Discovery Rate (FDR).

### 4. Model Selection (GORIC)
The Generalized Order Restricted Information Criterion (GORIC) evaluates the posterior probability of specific monotone models. Due to computational intensity, it is typically applied to a subset of interesting genes.

### 5. Clustering Profiles
- **ORCME**: Clusters genes based on isotonic means (monotone profiles) using a delta-clustering method.
- **ORIClust**: Uses Information Criterion (ORICC) to cluster genes into various profiles, including monotone and umbrella shapes.

## Key Functions and GUI Triggers

| Task | GUI Menu Path | Underlying Package/Method |
| :--- | :--- | :--- |
| Start Interface | `IsoGeneGUI()` | tcltk |
| Trend Test (Exact) | Analysis > LRT (E2): Asymptotic | IsoGene |
| Trend Test (Perm) | Analysis > Permutation | IsoGene / orQA |
| SAM Analysis | Analysis > SAM | IsoGene (SAM-specific) |
| Model Selection | Analysis > GORIC | goric |
| Monotone Clustering| Clustering > ORCME | ORCME |
| Profile Clustering | Clustering > ORIClust | ORIClust |

## Tips for Success
- **Seed Setting**: Always use `Analysis > Set seed` before running permutation-based tests or GORIC to ensure reproducibility.
- **Multiplicity**: When performing LRT or Permutation tests, ensure you select an appropriate adjustment method (e.g., BH, BY, or Bonferroni) to control the family-wise error rate or FDR.
- **Performance**: For E2 statistics, the `orQA` implementation is significantly faster than the standard `IsoGene` permutation function.
- **Data Export**: Results from the GUI can be saved back to the R Workspace as `.RData` files for further custom downstream analysis.

## Reference documentation
- [IsoGeneGUI Package Vignette](./references/IsoGeneGUI.md)