---
name: bioconductor-linkhd
description: LinkHD integrates multiple heterogeneous datasets sharing common observations using the STATIS-ACT framework to find a consensus structure. Use when user asks to integrate multi-omics data, perform sample clustering across multiple tables, identify key variables through biplot regression, or detect differentially abundant features.
homepage: https://bioconductor.org/packages/release/bioc/html/LinkHD.html
---

# bioconductor-linkhd

name: bioconductor-linkhd
description: Integration and exploration of heterogeneous datasets (e.g., multi-omics, environmental) using the STATIS-ACT framework. Use when analyzing multiple data tables sharing common observations to find a consensus structure, perform sample clustering, and identify key variables through biplot regression or differential abundance.

# bioconductor-linkhd

## Overview

LinkHD (Link Heterogeneous Data) is a framework for integrating multiple datasets measured on the same set of samples. It extends the STATIS method by using distance matrices, allowing it to handle continuous, categorical, and compositional data (like microbiome OTU tables). It provides tools for finding a "compromise" structure (consensus), clustering samples, and identifying the specific variables (genes, OTUs, metabolites) that drive the observed patterns.

## Core Workflow

### 1. Data Preparation
Input data should be a list of data frames or a `MultiAssayExperiment` object. Rows must represent the same observations (samples) across all tables.

```r
library(LinkHD)
# Example: list of data frames
data_list <- list(microbiome = df1, metabolomics = df2, clinical = df3)
```

### 2. Data Preprocessing
Use `DataProcessing` to handle different data types. For microbiome/compositional data, use "Compositional" (implements CLR transformation). For continuous data, use "Standard".

```r
# Transform compositional data
norm_data <- lapply(data_list, function(x) {
    DataProcessing(x, Method = "Compositional")
})
```

### 3. Integration (STATIS)
The `LinkData` function is the primary engine. It calculates distance matrices for each table and computes the consensus (compromise).

```r
# Distance can be "euclidean", "scalarproduct", "pearson", etc.
output <- LinkData(norm_data, 
                   Distance = c("euclidean", "euclidean", "euclidean"), 
                   Scale = FALSE, 
                   Center = FALSE, 
                   nCluster = 3)
```

### 4. Visualization
*   **Compromise Plot**: Shows the consensus sample distribution and quality of representation.
*   **Correlation Plot**: Shows the RV coefficient (similarity) between the input tables.
*   **Global Plot**: Projects individual tables into the compromise space to see how each dataset contributes.

```r
CompromisePlot(output)
CorrelationPlot(output)
GlobalPlot(output)
```

### 5. Variable Selection
LinkHD offers two main ways to identify important variables:
*   **Regression Biplot**: Projects variables onto the compromise space. Selection is based on $R^2$ (proportion of explained variance).
*   **Differential Abundance (dAB)**: Uses Kruskal-Wallis tests to find variables that differ significantly between the clusters identified in the compromise.

```r
# Biplot selection (top 5% of variables)
selection <- VarSelection(output, Data = norm_data, Crit = "Rsquare", perc = 0.95)

# Differential abundance selection
diff_vars <- dAB(output, Data = norm_data)
```

### 6. Taxonomic Aggregation
For microbiome data, `OTU2Taxa` aggregates selected OTUs to higher taxonomic levels (Family, Genus) and performs enrichment analysis using the hypergeometric distribution.

```r
enrichment <- OTU2Taxa(Selection = Variables(selection), 
                       TaxonInfo = taxa_df, 
                       tableName = "microbiome", 
                       AnalysisLev = "Family")
```

## Tips for Success
*   **Row Names**: Ensure all input tables have identical row names. The package will error if they do not match.
*   **Distance Selection**: If you have already performed a CLR transformation, using "euclidean" distance in `LinkData` is equivalent to the Aitchison distance.
*   **Clustering**: Use `compromise_coords(output)` to extract the coordinates and cluster assignments for external analysis (e.g., testing associations with phenotypes).
*   **Scaling**: If datasets have different scales/units and were not pre-processed, set `Scale = TRUE` in `LinkData`.

## Reference documentation
- [Link-HD: a versatile framework to explore and integrate heterogeneous data](./references/LinkHD.md)