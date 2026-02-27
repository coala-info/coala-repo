---
name: bioconductor-pint
description: This tool performs probabilistic data integration to identify dependencies between different genomic data layers like gene expression and DNA copy number. Use when user asks to screen for functional dependencies between mRNA and aCGH data, identify cancer-associated chromosomal alterations, or find genes where copy number changes drive expression levels.
homepage: https://bioconductor.org/packages/3.6/bioc/html/pint.html
---


# bioconductor-pint

name: bioconductor-pint
description: Probabilistic data integration for functional genomics. Use this skill to identify dependencies between different genomic data layers (e.g., gene expression and DNA copy number) to discover functionally active chromosomal alterations and cancer-associated regions.

# bioconductor-pint

## Overview

The `pint` package provides tools for the integrative analysis of functional genomics data, specifically matching mRNA expression levels with DNA copy number (aCGH) measurements. It uses latent variable models, such as probabilistic canonical correlation analysis (pCCA), to identify chromosomal regions where alterations in copy number significantly drive changes in gene expression. This approach is particularly effective for discovering functionally active chromosomal regions in cancer studies.

## Typical Workflow

### 1. Data Preparation
The package expects two matched data sources (e.g., expression and copy number). Each source should be a list containing:
- `data`: A matrix with genes in rows and samples in columns.
- `info`: A data frame with genomic metadata: `loc` (location in bp), `chr` (chromosome), and `arm` (p or q).

```r
library(pint)
data(chromosome17)
# geneExp and geneCopyNum are the standard list structures
```

### 2. Screening for Dependencies
Use a sliding window approach to calculate dependency scores across a chromosomal arm.

```r
# Screen chromosome 17, long arm (q) with a window of 10 genes
models <- screen.cgh.mrna(geneExp, geneCopyNum, windowSize = 10, chr = 17, arm = "q")
```

### 3. Identifying Top Regions and Genes
Extract the genes or models showing the highest functional dependency.

```r
# Get the top 5 genes with highest dependency
top_genes <- topGenes(models, 5)

# Retrieve the model for the gene with the highest score
best_model <- topModels(models)
```

### 4. Visualization
Visualize the dependency scores across the chromosome or the contribution of specific samples and variables to a detected dependency.

```r
# Plot dependency scores across the chromosomal arm
plot(models, showTop = 10)

# Plot sample and variable effects for a specific model
plot(best_model, geneExp, geneCopyNum)
```

### 5. Summarization
Merge overlapping regions that exceed a dependency threshold to identify continuous functional alterations.

```r
# Join overlapping high-dependency regions
regions <- join.top.regions(models)

# Summarize parameters over a region
summary_params <- summarize.region.parameters(models, region)
```

## Key Functions

- `screen.cgh.mrna`: The primary screening function for expression and copy number integration.
- `topGenes` / `topModels`: Utilities to extract the most significant results from a screening run.
- `dependency.score`: Calculates the ratio of shared vs. data-set-specific signal.
- `join.top.regions`: Consolidates overlapping windows into distinct genomic regions.

## Tips
- **Data Scaling**: Ensure data is approximately Gaussian (e.g., log2 transformed microarrays).
- **Window Size**: The `windowSize` parameter is critical; it defines the number of neighboring genes included in the local dependency calculation.
- **Generic Integration**: While named for CGH and mRNA, `screen.cgh.mrna` can be used for any two matched genomic data types (e.g., methylation and expression) provided the input list structure is maintained.

## Reference documentation
- [Dependency Search and Modeling](./references/depsearch.md)