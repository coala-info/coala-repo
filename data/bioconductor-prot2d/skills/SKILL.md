---
name: bioconductor-prot2d
description: This tool performs statistical analysis and normalization of 2D Gel Electrophoresis volume data to identify differentially expressed proteins. Use when user asks to normalize 2D gel data, visualize intensity ratios, perform differential expression analysis using various statistical tests, or simulate 2D gel datasets.
homepage: https://bioconductor.org/packages/3.6/bioc/html/prot2D.html
---


# bioconductor-prot2d

name: bioconductor-prot2d
description: Statistical analysis of 2D Gel Electrophoresis (2DE) volume data. Use this skill to normalize 2D gel data, visualize intensity ratios, and identify differentially expressed proteins using various statistical tests (t-test, moderate t-test, SAM, etc.) and FDR corrections.

## Overview
The `prot2D` package provides tools for the analysis of volume data from 2D Gel Electrophoresis. It bridges the gap between proteomics and transcriptomics by adapting established statistical methods (like those from `limma` and `samr`) to protein spot data. The workflow typically involves data visualization, quantile or VSN normalization, and differential expression analysis.

## Typical Workflow

### 1. Data Preparation
Input data should be a dataframe where rows are spots and columns are gels (replicates). A separate factor dataframe is required to define experimental conditions.

```R
library(prot2D)
data(pecten)      # Volume data: 766 spots x 12 gels
data(pecten.fac)  # Metadata: Gels as rownames, "Condition" column
```

### 2. Visualization and Normalization
Use Ratio-Intensity (RI) plots to identify systemic variations. Quantile normalization is generally recommended for 2D gel data.

```R
# Visualize raw data
RIplot(pecten, n1=6, n2=6)

# Perform Quantile Normalization
# n1 and n2 are the number of replicates for condition 1 and 2
pecten.norm <- Norm.qt(pecten, n1=6, n2=6, plot=TRUE)
```

### 3. Creating an ExpressionSet
The package uses the `ExpressionSet` class to store normalized data and metadata for downstream analysis.

```R
# Coerce to ExpressionSet
# f is the dataframe containing experimental conditions
ES.p <- ES.prot(pecten.norm, n1=6, n2=6, f=pecten.fac)
```

### 4. Differential Expression Analysis
`prot2D` offers several statistical tests. The moderate t-test (`modT.Prot`) with Benjamini-Hochberg (`BH`) correction is the recommended default.

```R
# Find differentially expressed proteins
# fdr.thr: False Discovery Rate threshold
# Fold2=TRUE: Filter for absolute ratio > 2
ES.diff <- modT.Prot(ES.p, plot=TRUE, fdr.thr=0.1, method.fdr="BH", Fold2=FALSE)

# Retrieve results
featureNames(ES.diff) # Names of significant spots
fData(ES.diff)        # Log2 ratios
exprs(ES.diff)        # Normalized volume data
```

Available test functions:
- `ttest.Prot`: Classical Student's t-test.
- `modT.Prot`: Moderate t-test (Smyth, 2004).
- `samT.Prot`: Significance Analysis of Microarrays (SAM).
- `efronT.Prot`: Efron's t-test.
- `shrinkT.Prot`: Shrinkage t-statistic.

FDR methods (`method.fdr`): `"BH"`, `"local"`, or `"robust"`.

## Simulation of 2D Data
You can simulate realistic 2D gel datasets to test the performance of different statistical methods.

```R
# nsp: number of spots, nr: number of replicates, p0: proportion of DE spots
Sim.data <- Sim.Prot.2D(data=pecten, nsp=700, nr=10, p0=0.1)

# Identify which spots were simulated as significant
notes(Sim.data)$SpotSig
```

## Reference documentation
- [prot2D](./references/prot2D.md)