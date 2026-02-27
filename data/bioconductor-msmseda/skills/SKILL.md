---
name: bioconductor-msmseda
description: This tool performs exploratory data analysis and batch effect correction for LC-MS/MS proteomics data based on spectral counts. Use when user asks to identify batch effects, visualize sample clustering through PCA or hierarchical clustering, generate heatmaps, or analyze overdispersion in MSnSet objects.
homepage: https://bioconductor.org/packages/release/bioc/html/msmsEDA.html
---


# bioconductor-msmseda

name: bioconductor-msmseda
description: Exploratory Data Analysis (EDA) for LC-MS/MS proteomics data using spectral counts. Use this skill to identify batch effects, visualize sample clustering (PCA, HC), generate heatmaps, and perform batch effect correction or dispersion analysis on MSnSet objects.

## Overview
The `msmsEDA` package provides tools for the exploratory analysis of label-free proteomics datasets based on spectral counts (SpC). It is specifically designed to detect confounding factors, batch effects, and outliers before proceeding to differential expression analysis. It operates primarily on `MSnSet` objects from the `MSnbase` package.

## Typical Workflow

### 1. Data Pre-processing
Clean the spectral counts matrix by removing NAs (replacing with 0) and filtering out artefactual identifications (e.g., proteins ending in "-R").

```r
library(msmsEDA)
# Assuming msms.dataset is an MSnSet object
e <- pp.msms.data(msms.dataset)
```

### 2. Spectral Count Distribution
Assess the quality of the experiment by checking the distribution of counts across samples.

```r
# Summary statistics: proteins, total counts, and quartiles
stats <- count.stats(e)
print(stats)

# Visualizations
layout(matrix(1:2, ncol=1))
# Barplots of total SpC scaled to median
spc.barplots(exprs(e), fact=pData(e)$treat)
# Boxplots of log2 SpC (filtering low signal proteins)
spc.boxplots(exprs(e), fact=pData(e)$treat, minSpC=2)
# Density plots
spc.densityplots(exprs(e), fact=pData(e)$treat, minSpC=2)
```

### 3. Unsupervised Clustering (PCA & HC)
Identify if samples cluster by biological condition (treatment) or by technical factors (batch).

```r
# Principal Components Analysis
pcares <- counts.pca(e, facs=pData(e)$treat, do.plot=TRUE)
summary(pcares$pca)

# Hierarchical Clustering
counts.hc(e, facs=pData(e)[, "treat", drop=FALSE])
counts.hc(e, facs=pData(e)[, "batch", drop=FALSE])
```

### 4. Heatmaps
Visualize protein expression profiles. `counts.heatmap` generates a standard view and a high-resolution PDF for protein identification.

```r
counts.heatmap(e, etit="Experiment_Name", fac=pData(e)$treat)
```

### 5. Batch Effect Correction
If PCA/HC shows clustering by batch, use mean-centering to neutralize the effect for visualization purposes.

```r
# Neutralize batch effects
spcm_adj <- batch.neutralize(exprs(e), pData(e)$batch, half=TRUE, sqrt.trans=TRUE)

# Update object and re-plot PCA to verify improvement
exprs(e) <- spcm_adj
counts.pca(e, facs=pData(e)$treat, do.plot=TRUE)
```

### 6. Dispersion and Informative Features
Analyze overdispersion to choose appropriate GLM models (Poisson vs. Negative Binomial) and identify proteins with high signal and fold change.

```r
# Dispersion analysis
dsp <- disp.estimates(e)

# Scatterplot of informative features (minLFC = log fold change threshold)
spc.scatterplot(exprs(e), pData(e)$treat, trans="sqrt", minSpC=2, minLFC=1)
```

## Tips
- **MSnSet Compatibility**: Ensure your data is in an `MSnSet` object. Use `pData(obj)` to manage metadata factors like `treat` and `batch`.
- **minSpC Parameter**: Many functions use `minSpC` to filter out low-count noise. Setting this to 2 or higher often yields cleaner visualizations.
- **Batch Neutralization**: `batch.neutralize` is primarily for EDA visualization; for formal differential expression, include the batch as a blocking factor in your statistical model (e.g., in `edgeR` or `DESeq2`).

## Reference documentation
- [msmsData-Vignette](./references/msmsData-Vignette.md)