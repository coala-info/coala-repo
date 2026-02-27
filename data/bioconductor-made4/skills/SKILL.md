---
name: bioconductor-made4
description: This tool provides functions for multivariate analysis and graphical visualization of large-scale biological datasets using ordination and classification techniques. Use when user asks to perform principal component analysis, conduct between group analysis for supervised classification, or integrate multiple datasets using coinertia analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/made4.html
---


# bioconductor-made4

## Overview
The `made4` package provides a suite of functions for multivariate analysis and graphical visualization of large-scale biological datasets, such as gene expression data. It acts as a user-friendly wrapper for the `ade4` library, specifically tailored for Bioconductor objects. Key capabilities include dimension reduction, supervised classification (BGA), and the integration of multiple datasets (CIA) to identify common structures.

## Data Input and Preparation
`made4` is flexible with input formats. It can process `SummarizedExperiment`, `ExpressionSet`, `data.frame`, and `matrix` objects.

- Use `isDataFrame(data)` to ensure your input is in a format suitable for `ade4` functions.
- Rows should represent variables (genes) and columns should represent cases (samples).
- Use `overview(data, classvec=groups)` for an initial look at the data via boxplots, histograms, and hierarchical clustering.

## Ordination (PCA and COA)
The `ord` function is the primary entry point for unsupervised dimension reduction.

```r
# Run Correspondence Analysis (COA)
k.coa <- ord(k.data, type="coa")

# Run Principal Component Analysis (PCA)
k.pca <- ord(k.data, type="pca")

# Plot results (eigenvalues, genes, and samples)
plot(k.coa, classvec=k.class)
```

## Supervised Analysis (Between Group Analysis)
Between Group Analysis (BGA) is used when samples belong to known classes (e.g., tumor types). It ordinates the groups rather than individual samples to find discriminating features.

```r
# Perform BGA
k.bga <- bga(k.data, type="coa", classvec=k.class)

# Visualize group separation
between.graph(k.bga, ax=1)

# Project new (test) data onto BGA axes
# suppl(k.bga, test.data)
```

## Data Integration (Coinertia Analysis)
Coinertia Analysis (CIA) is used to compare two datasets (e.g., different platforms or omics types) that share the same samples.

```r
# Perform CIA on two datasets
coin <- cia(dataset1, dataset2)

# Check the RV coefficient (global similarity, 0 to 1)
coin$coinertia$RV

# Plot the match between datasets
plot(coin, classvec=common.classes)
```

## Interpreting and Visualizing Results
`made4` provides specialized functions to extract biological meaning from ordination axes.

- **Top Genes**: Use `topgenes(k.coa, axis=1, n=10)` to identify the most influential genes at the ends of an axis.
- **Gene Labels**: Use `plotgenes(k.coa, n=10, genelabels=gene.symbs)` to label specific genes in a plot.
- **Sample Plots**: Use `plotarrays(k.coa, arraylabels=k.class)` to visualize sample clusters.
- **3D Visualization**: Use `do3d(k.coa$ord$co, classvec=k.class)` for interactive or static 3D scatterplots.

## Tips for Success
- **Preprocessing**: Ensure data is normalized and preprocessed before using `made4`.
- **Gene Symbols**: Ordination plots often use row names (e.g., Probe IDs). Pass a vector of gene symbols to the `genelabels` argument in plotting functions for better readability.
- **Axis Selection**: Check the eigenvalue plot (part of the standard `plot()` output) to determine how many axes are informative.

## Reference documentation
- [Introduction to Multivariate Analysis of Gene Expression Data using MADE4](./references/introduction.md)