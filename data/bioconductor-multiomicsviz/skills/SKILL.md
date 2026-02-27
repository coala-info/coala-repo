---
name: bioconductor-multiomicsviz
description: This package identifies and visualizes significant correlations between different layers of omics data across genomic coordinates. Use when user asks to calculate correlations between multi-omics datasets, visualize the genomic impact of one omics layer on another, or generate heatmaps of significant molecular associations.
homepage: https://bioconductor.org/packages/3.5/bioc/html/multiOmicsViz.html
---


# bioconductor-multiomicsviz

## Overview
The `multiOmicsViz` package is designed to identify and visualize significant correlations between different layers of omics data. Its primary strength lies in its ability to map these correlations onto a genomic coordinate system, allowing researchers to see how a source variable (like Copy Number Alteration) influences target variables (like mRNA or protein expression) across the genome.

## Core Functions

### multiOmicsViz
The main function for calculating correlations and generating visualizations.

```r
multiOmicsViz(sourceOmics, sourceOmicsName, chrome_sourceOmics, 
              targetOmicsList, targetOmicsName, chrome_targetOmics, 
              fdrThr, outputfile, nThreads = 1, legend = TRUE)
```

**Key Arguments:**
*   `sourceOmics`: Matrix, data.frame, or SummarizedExperiment (Rows = Genes, Cols = Samples).
*   `sourceOmicsName`: String label for the source data (e.g., "CNA").
*   `chrome_sourceOmics`: Chromosome(s) to extract from source (e.g., "1", `c("1","2")`, or "All").
*   `targetOmicsList`: A list containing up to 5 target omics datasets.
*   `targetOmicsName`: Vector of names for the target datasets.
*   `chrome_targetOmics`: Chromosome(s) to extract from targets.
*   `fdrThr`: FDR threshold for significance (e.g., 0.01).
*   `outputfile`: Path and prefix for the output PDF/image.

### calculateCorForTwoMatrices
A utility function to identify significant correlations between two matrices without generating the full genomic heatmap.

```r
sig_matrix <- calculateCorForTwoMatrices(matrix1, matrix2, fdr = 0.01)
```
*   Returns a matrix where `1` is a significant positive correlation, `-1` is a significant negative correlation, and `0` is non-significant.

## Typical Workflow

### 1. Data Preparation
Ensure your data frames have gene symbols as row names and sample IDs as column names. There must be at least 6 overlapping samples between the source and each target.

```r
library(multiOmicsViz)

# Load source data (e.g., Copy Number)
sourceData <- read.table("cna.txt", header=TRUE, sep="\t", check.names=FALSE)

# Load target data (e.g., mRNA) into a list
target1 <- read.table("mrna.txt", header=TRUE, sep="\t", check.names=FALSE)
targetList <- list(target1)
```

### 2. Running the Visualization
Generate a heatmap showing the impact of the source omics on the target omics.

```r
output <- "my_multiOmics_plot"
multiOmicsViz(sourceOmics = sourceData, 
              sourceOmicsName = "CNA", 
              chrome_sourceOmics = "All", 
              targetOmicsList = targetList, 
              targetOmicsName = "mRNA", 
              chrome_targetOmics = "All", 
              fdrThr = 0.001, 
              outputfile = output)
```

## Interpreting Results
*   **Heatmap X-axis**: Genes in the source omics data, ordered by chromosomal location.
*   **Heatmap Y-axis**: Genes in the target omics data, ordered by chromosomal location.
*   **Colors**: Red dots indicate significant positive correlations; Blue dots indicate significant negative correlations.
*   **Multi-target Analysis**: If multiple targets are provided, the package generates individual heatmaps and bar charts comparing specific vs. common significant correlations across the targets.

## Tips
*   **Parallel Computing**: For 2 or 3 target datasets, use the `nThreads` argument to speed up calculation.
*   **Memory Management**: If working with "All" chromosomes and very large matrices, ensure sufficient RAM is available as the correlation matrix can become quite large.
*   **Gene Mapping**: Ensure row names (Gene Symbols) are consistent across all input matrices to allow for proper overlapping.

## Reference documentation
- [multiOmicsViz](./references/multiOmicsViz.md)