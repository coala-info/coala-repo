---
name: bioconductor-lefser
description: The bioconductor-lefser package identifies metagenomic biomarkers by combining statistical significance tests with linear discriminant analysis effect size estimation. Use when user asks to find differentially abundant features in microbiome data, perform LEfSe analysis, or visualize taxonomic biomarkers with LDA scores.
homepage: https://bioconductor.org/packages/release/bioc/html/lefser.html
---

# bioconductor-lefser

## Overview
The `lefser` package is an R/Bioconductor implementation of the Linear Discriminant Analysis (LDA) Effect Size (LEfSe) method. It is designed to discover metagenomic biomarkers by combining statistical significance (Kruskal-Wallis and Wilcoxon tests) with biological consistency (subclass analysis) and effect size estimation (LDA).

## Core Workflow

### 1. Data Preparation
`lefser` operates on `SummarizedExperiment` objects. The input data must be **relative abundances**.

```r
library(lefser)
library(SummarizedExperiment)

# 1. Filter to terminal nodes (e.g., species level) to avoid collinearity
# rownames should be taxonomic paths (e.g., k__...|s__...)
terminal_nodes <- get_terminal_nodes(rownames(se_object))
se_filtered <- se_object[terminal_nodes, ]

# 2. Convert to relative abundance
se_ra <- relativeAb(se_filtered)
```

### 2. Running the Analysis
The `lefser` function identifies biomarkers based on a primary class and an optional subclass for consistency checks.

```r
set.seed(1234) # Recommended for reproducibility
res <- lefser(
  relab_se, 
  classCol = "group_column",      # Primary comparison (e.g., Case vs Control)
  subclassCol = "subgroup_column" # Optional: ensures effect is consistent across subgroups
)

# Results are returned as a data.frame with 'features' and 'scores' (LDA score)
head(res)
```

### 3. Visualization
Use `lefserPlot` to create a bar chart of the LDA scores, which helps visualize which features are enriched in which group.

```r
lefserPlot(res)
```

## Interoperability Tips

### Working with Phyloseq
If using `phyloseq`, convert the object to a `SummarizedExperiment` before running `lefser`:

```r
library(phyloseq)
# Extract tables
counts <- as(otu_table(ps), "matrix")
coldata <- as(sample_data(ps), "data.frame")

# Create SummarizedExperiment
se <- SummarizedExperiment(assays = list(counts = counts), colData = coldata)
```

### Handling Collinearity
If you encounter the error `variables are collinear`, it is usually because the dataset contains both parent nodes (e.g., Genus) and child nodes (e.g., Species). Always use `get_terminal_nodes()` to subset your data to the most specific taxonomic level available.

## Reference documentation
- [lefser: a metagenomic biomarker discovery tool](./references/lefser.md)