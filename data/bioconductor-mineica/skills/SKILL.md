---
name: bioconductor-mineica
description: MineICA provides a framework for the biological interpretation and mining of Independent Component Analysis results applied to transcriptomic data. Use when user asks to identify contributing genes, test associations between components and sample metadata, perform gene enrichment analysis, or compare ICA results across different datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/MineICA.html
---

# bioconductor-mineica

## Overview
MineICA provides a framework for the biological interpretation of Independent Component Analysis (ICA) applied to transcriptomic data. It uses the `IcaSet` class (extending `Biobase::eSet`) to store the mixing matrix (sample contributions) and source matrix (gene projections). The package facilitates "mining" these components by testing their association with sample metadata, identifying contributing genes, and visualizing results through heatmaps and correlation graphs.

## Core Workflow

### 1. Object Initialization
To use MineICA, you must first define analysis parameters and then wrap your ICA results into an `IcaSet`.

```r
library(MineICA)

# 1. Define parameters (output path, selection thresholds)
params <- buildMineICAParams(resPath="results/", selCutoff=3, pvalCutoff=0.05)

# 2. Create IcaSet
# A: mixing matrix (samples x components)
# S: source matrix (features x components)
# dat: original expression matrix
icaSet <- buildIcaSet(params=params, A=as.data.frame(A_mat), S=as.data.frame(S_mat), 
                      dat=exprs_mat, pData=clinical_df, 
                      annotation="hgu133a.db", typeID=typeID_list)
```

### 2. Identifying Contributing Genes
Contributing genes are those with high absolute projection values (typically >3 standard deviations).

```r
# Extract contributing genes for all components
contribs <- selectContrib(icaSet, cutoff=3, level="genes")

# Get specific component data (projections and sample contributions)
comp2 <- getComp(icaSet, level="genes", ind=2)
```

### 3. Association with Sample Variables
Test if components correlate with clinical or pathological data.

```r
# Qualitative variables (Wilcoxon/Kruskal-Wallis tests)
resQual <- qualVarAnalysis(params=params, icaSet=icaSet, 
                           keepVar=c("ER_status", "Grade"), typePlot="boxplot")

# Quantitative variables (Pearson/Spearman correlation)
resQuant <- quantVarAnalysis(params=params, icaSet=icaSet, keepVar="Age", typeCor="pearson")
```

### 4. Biological Interpretation (Enrichment)
Use `GOstats` to find biological processes enriched in the contributing genes of each component.

```r
resEnrich <- runEnrich(params=params, icaSet=icaSet, dbs="GO", ontos="BP")
```

### 5. Comparing ICA Results Across Datasets
Compare components from different studies to find reproducible biological signals.

```r
resGraph <- runCompareIcaSets(icaSets=list(set1, set2), 
                              labAn=c("Study1", "Study2"), 
                              type.corr="pearson", level="genes", tkplot=TRUE)
```

## Key Functions
- `runICA`: Wrapper to run ICA algorithms like JADE or fastICA.
- `clusterFastICARuns`: Runs fastICA multiple times and clusters results to ensure stability (similar to Icasso).
- `runAn`: A "master" function that runs a full suite of analyses (projections, variable associations, heatmaps) and writes results to HTML files.
- `writeProjByComp`: Generates HTML reports describing the top contributing genes for each component using `biomaRt` for annotation.
- `plot_heatmapsOnSel`: Visualizes the expression of contributing genes across samples, often revealing sample clusters.

## Tips for Success
- **Data Centering**: Features should be mean-centered before running ICA (e.g., `t(apply(exprs, 1, scale, scale=FALSE))`).
- **Witness Genes**: MineICA automatically selects "witness genes" (representative contributors) to help define the direction/sign of a component.
- **Two Levels**: `IcaSet` manages both "feature" (e.g., probe IDs) and "gene" (e.g., Symbols) levels. Use `level="genes"` in functions to work with annotated data.
- **Bimodality**: Sample contributions in the mixing matrix `A` are often bimodal. Use `plotAllMix` to visualize Gaussian mixtures and cluster samples based on component activity.

## Reference documentation
- [MineICA](./references/MineICA.md)