---
name: r-swamp
description: r-swamp analyzes and visualizes high-dimensional data to identify associations between principal components and sample annotations. Use when user asks to identify batch effects, perform principal component analysis associated with metadata, conduct hierarchical clustering with annotation bars, or adjust data to remove unwanted variation.
homepage: https://cran.r-project.org/web/packages/swamp/index.html
---


# r-swamp

name: r-swamp
description: Analyze and visualize high-dimensional data (e.g., genomics, proteomics) in relation to sample annotations. Use this skill to identify batch effects, perform principal component analysis (PCA) associated with metadata, conduct hierarchical clustering with annotation bars, and adjust data to remove unwanted variation or specific principal components.

## Overview
The `swamp` package provides a suite of tools to connect the underlying structure of high-dimensional data with sample-level information (annotations). It focuses on three main areas:
1. Linear modeling of principal components to identify drivers of variation.
2. Hierarchical clustering analysis (HCA) with integrated annotation visualization.
3. Analysis of associations between individual features and sample annotations.
It also includes methods for batch effect correction and the targeted removal of principal components.

## Installation
Install the package from CRAN:
```R
install.packages("swamp")
```
Note: `swamp` depends on `impute` (Bioconductor), `amap`, `gplots`, and `MASS`.

## Core Workflows

### 1. Principal Component Association (Prince)
Use the `prince` workflow to determine which sample annotations (e.g., batch, age, phenotype) are significantly associated with the variation captured by principal components.

- **Run Analysis**: Use `prince(g, o)` where `g` is the data matrix (features in rows, samples in columns) and `o` is a data frame of sample annotations.
- **Visualize**: Use `prince.plot(prince_object)` to generate a heatmap of p-values showing the strength of association between each PC and each annotation.
- **Screening**: This is the primary method for identifying batch effects or confirming that biological variables are the main drivers of variation.

### 2. Hierarchical Clustering with Annotations
Visualize how samples group together and how those groups align with metadata.

- **Plot HCA**: Use `hca.plot(g, o)` to create a dendrogram where the leaves are labeled with color bars representing the sample annotations in `o`.
- **Customization**: Adjust clustering methods (e.g., `meth="pearson"`) and distance metrics via the `amap` integration.

### 3. Analyzing Annotation Confounding
Before adjusting data, check if your sample annotations are correlated with each other (e.g., if "Batch" is confounded with "Treatment").

- **Check Confounding**: Use `confounding(o)` to calculate associations between all pairs of annotations in the data frame `o`.
- **Interpretation**: High correlation between a technical variable and a biological variable suggests that batch correction may remove biological signals.

### 4. Data Adjustment and Batch Correction
If unwanted variation is identified, use these functions to clean the data:

- **ComBat**: Use `combat(g, batch)` for a robust empirical Bayes approach to batch correction.
- **PC Removal**: Use `unspread(g, comps)` to reconstruct the data matrix after removing specific principal components (e.g., removing PC1 if it represents a known batch effect).
- **Feature Association**: Use `feature.assoc(g, y)` to find which specific features are associated with a particular annotation `y`.

## Usage Tips
- **Data Orientation**: Ensure your data matrix `g` has features (genes/probes) as rows and samples as columns.
- **Missing Values**: `swamp` functions often require complete data. Use `impute.knn` from the `impute` package if necessary before running `prince`.
- **Annotation Types**: The package handles both numeric and categorical annotations. Ensure categorical variables are factors in your annotation data frame.
- **Scaling**: Consider centering and scaling your data before PCA/Prince analysis if features have different scales.

## Reference documentation
- [swamp: Visualization, Analysis and Adjustment of High-Dimensional Data in Respect to Sample Annotations](./references/home_page.md)