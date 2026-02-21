---
name: bioconductor-caomicsv
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.8/bioc/html/caOmicsV.html
---

# bioconductor-caomicsv

name: bioconductor-caomicsv
description: Visualizing multidimensional cancer genomic data in R using the caOmicsV package. Use this skill to create integrated visualizations of genomic data (expression, methylation, copy number, mutations) using heatmap-like matrix layouts (bioMatrix) or circular network layouts (bioNetCircos).

# bioconductor-caomicsv

## Overview

The `caOmicsV` package is designed for the integrative visualization of multi-dimensional cancer genomic datasets. It supports two primary visualization styles:
1.  **bioMatrix**: A heatmap-like layout that aligns multiple data types (clinical, expression, binary, and categorical) for a set of genes and samples.
2.  **bioNetCircos**: A circular layout where genomic data is superimposed on biological networks (graphs), allowing for the visualization of relationships between genes and samples in a systems biology context.

## Data Preparation

The core of `caOmicsV` is the "Plot Data Set," a structured list containing all data to be visualized. Use `getPlotDataSet()` to construct this object.

### Required Inputs
- `sampleNames`: Character vector of sample IDs.
- `geneNames`: Character vector of gene symbols.
- `sampleData`: Data frame where the first column is sample names, followed by clinical/phenotype features.
- `heatmapData`: List of up to 2 data frames (e.g., RNASeq, miRNASeq). Rows = genes, Columns = samples.
- `categoryData`: List of up to 2 data frames (e.g., Methylation status).
- `binaryData`: List of up to 3 data frames (e.g., Mutation status, CNV).
- `summaryData`: List of up to 2 data frames for gene or sample summaries.

```r
library(caOmicsV)
# Example of creating a plot data set
plotDataSet <- getPlotDataSet(sampleNames, geneNames, sampleData, 
                              heatmapData, categoryData, binaryData)
```

## bioMatrix Layout

The `bioMatrix` layout is best for comparing multiple genomic features across samples for a specific gene list.

### High-level Plotting
```r
# Plot the matrix
plotBioMatrix(plotDataSet, summaryType="text")

# Add legend
bioMatrixLegend(heatmapNames=c("RNASeq", "miRNASeq"),
                categoryNames=c("Methyl H", "Methyl L"),
                binaryNames=c("CN LOSS", "CN Gain"),
                heatmapMin=-3, heatmapMax=3, colorType="BlueWhiteRed")
```

### Manual Customization
For finer control, use the initialization and specific plotting functions:
- `initializeBioMatrixPlot()`: Set dimensions and margins.
- `plotBioMatrixSampleData()`: Plot phenotype bars.
- `plotBioMatrixHeatmap()`: Add expression data.
- `plotBioMatrixCategoryData()`: Add categorical outlines.
- `plotBioMatrixBinaryData()`: Add points for binary events.

## bioNetCircos Layout

This layout requires `igraph` and `bc3net`. It maps genomic data onto a network graph.

### High-level Plotting
```r
# Plot the network with circular tracks
plotBioNetCircos(plotDataSet)

# Add legend
dataNames <- c("Tissue Type", "RNASeq", "miRNASeq", "Methylation", "CNV")
bioNetLegend(dataNames, heatmapMin=-3, heatmapMax=3)
```

### Manual Workflow
1.  **Initialize**: `initializeBioNetCircos(network, numOfSamples, ...)`
2.  **Label Nodes**: `labelBioNetNodeNames()`
3.  **Plot Tracks**: Use `bioNetCircosPlot()` with different `plotType` arguments:
    - `polygon`: For clinical/phenotype data.
    - `heatmap`: For continuous data.
    - `bar`: For categorical data.
    - `point`: For binary data.
4.  **Links**: Use `linkBioNetSamples()` to draw lines between samples within a node.

## Tips and Best Practices
- **Data Alignment**: Ensure that the first column of every data frame in your lists contains gene names that match your `geneNames` vector exactly.
- **Color Schemes**: Use `getCaOmicsVColors()` to retrieve the default color palette or `getCaOmicsVPlotTypes()` to see supported track types.
- **Network Layout**: If the default `plotBioNetCircos` layout is cluttered, use `showBioNetNodesLayout()` to identify node indices and manually place labels using `labelBioNetNodeNames`.

## Reference documentation
- [Introduction to caOmicsV](./references/Introduction_to_caOmicsV.md)