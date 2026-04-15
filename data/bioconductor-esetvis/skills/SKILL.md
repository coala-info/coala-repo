---
name: bioconductor-esetvis
description: This package visualizes Bioconductor containers using Spectral Mapping, t-SNE, and LDA dimensionality reduction techniques. Use when user asks to visualize ExpressionSet or SummarizedExperiment data, perform Spectral Mapping, run t-SNE or LDA, create biplots, or label top genes and samples.
homepage: https://bioconductor.org/packages/release/bioc/html/esetVis.html
---

# bioconductor-esetvis

## Overview

The `esetVis` package provides wrapper functions to visualize Bioconductor containers (`ExpressionSet` or `SummarizedExperiment`) through three primary dimensionality reduction techniques: Spectral Mapping, t-SNE, and LDA. It excels at creating "biplots" where samples are represented as points and genes are represented as a background cloud (hexbin) or specific labels.

## Core Workflows

### 1. Data Preparation
The package assumes data is already log-transformed. If using `SummarizedExperiment`, the functions internally handle the conversion of `colData`, `rowData`, and `assay`.

```r
library(esetVis)
# For ExpressionSet: uses exprs(), pData(), fData()
# For SummarizedExperiment: uses assay(), colData(), rowData()
```

### 2. Spectral Mapping (Unsupervised)
Spectral mapping is the default visualization for identifying global structures.

```r
# Basic static plot
esetSpectralMap(eset = ALL)

# Advanced plot with aesthetics mapped to phenoData
esetSpectralMap(eset = ALL,
                colorVar = "BT", 
                shapeVar = "sex",
                sizeVar = "age", 
                alphaVar = "remissionType",
                topGenes = 10, topGenesVar = "SYMBOL",
                topSamples = 5)
```

### 3. t-SNE (Unsupervised)
Used for non-linear dimensionality reduction. Note that gene labels are not typically mapped in t-SNE plots within this package.

```r
esetTsne(eset = ALL, 
         colorVar = "BT", 
         Rtsne.args = list(perplexity = 30))
```

### 4. Linear Discriminant Analysis (Semi-supervised)
Requires a grouping variable (`ldaVar`) to maximize variance between groups.

```r
esetLda(eset = ALL, ldaVar = "BT", colorVar = "BT")
```

## Key Parameters and Customization

### Aesthetic Mapping
For `color`, `shape`, `size`, and `alpha`, use the following pattern:
*   `[aes]Var`: The column name in `phenoData`/`colData`.
*   `[aes]`: The specific palette or vector of values (e.g., `color = c("red", "blue")`).
*   `sizeRange` / `alphaRange`: Numeric range for continuous variables.

### Labeling Outliers
The package identifies "top" elements based on the distance (sum of squared coordinates) from the origin.
*   `topSamples`, `topGenes`, `topGeneSets`: Number of elements to label.
*   `top[Element]Var`: The column used for the label text (e.g., `topGenesVar = "SYMBOL"`).
*   `packageTextLabel`: Set to `"ggrepel"` (default) to avoid overlapping text.

### Gene Set Annotation
To display biological pathways:
1.  Generate a list of gene sets using `getGeneSetsForPlot`.
2.  Pass the list to the plotting function.

```r
geneSets <- getGeneSetsForPlot(entrezIdentifiers = fData(ALL)$ENTREZID, 
                               species = "Human", 
                               geneSetSource = 'GOBP')

esetSpectralMap(eset = ALL, geneSets = geneSets, topGeneSets = 5)
```

### Interactivity
Switch from static `ggplot2` to interactive `plotly` or `ggvis`:
*   `typePlot = "interactive"`
*   `packageInteractivity = "plotly"` (recommended) or `"ggvis"`
*   `interactiveTooltipExtraVars`: Character vector of metadata columns to show on hover.

## Tips for Large Datasets
*   **Gene Cloud**: By default, genes are shown as a hexbin cloud. Control this with `cloudGenes = TRUE/FALSE` and `cloudGenesNBins`.
*   **Subsetting**: Use the `psids` argument to run the analysis on a specific subset of feature IDs to save time.
*   **Pre-transformation**: For t-SNE, use `fctTransformDataForInputTsne` to pass a custom distance matrix (e.g., `as.dist((1 - cor(mat))/2)`).

## Reference documentation
- [Vignette of the esetVis package](./references/esetVis-vignette.md)