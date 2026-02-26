---
name: bioconductor-delocal
description: DELocal identifies differentially expressed genes by comparing their expression patterns to those of their chromosomal neighbors. Use when user asks to identify differentially expressed genes using genomic co-localization, analyze gene expression relative to neighboring genes, or detect subtle expression changes in datasets with small sample sizes.
homepage: https://bioconductor.org/packages/release/bioc/html/DELocal.html
---


# bioconductor-delocal

## Overview

DELocal is an R package designed to identify differentially expressed genes by leveraging the expression patterns of neighboring genes. Unlike traditional methods that rely solely on the expression levels of the gene of interest, DELocal assumes that genomic co-localization is generally not linked to co-expression. Therefore, a gene's departure from the expression trend of its chromosomal neighborhood can be a strong indicator of differential expression. It is particularly useful for datasets with small sample sizes or subtle expression changes.

## Core Workflow

### 1. Data Preparation
DELocal requires a `SummarizedExperiment` object containing:
- **Assays**: A count matrix (RNA-seq or microarray).
- **rowData**: Gene location information (must include `start_position` and `chromosome_name`).
- **colData**: Experimental design/condition metadata.

```r
library(DELocal)
library(SummarizedExperiment)

# Create SummarizedExperiment
smrExpt <- SummarizedExperiment(
  assays = list(counts = count_matrix),
  rowData = gene_location, 
  colData = colData
)
```

### 2. Identifying DE Genes
The primary function is `DELocal()`. It compares each gene against its $N$ nearest neighbors.

```r
# Basic execution
# nearest_neighbours: number of adjacent genes to use as reference
# pDesign: formula for the experimental design (e.g., ~ condition)
results <- DELocal(
  pSmrExpt = smrExpt,
  nearest_neighbours = 5,
  pDesign = ~ condition,
  pValue_cut = 0.05
)

# Results are returned sorted by adj.P.Val
head(results)
```

### 3. Visualizing Neighborhood Expression
To validate a DE gene, you can plot its expression relative to its neighbors across conditions.

```r
# Plot median expressions for a specific gene and its neighbors
plot_data <- plotNeighbourhood(
  pSmrExpt = smrExpt, 
  pGene_id = "ENSMUSG00000059401", 
  pNearest_neighbours = 5, 
  pDesign = ~ condition
)
plot_data$plot
```

## Advanced Usage: Dynamic Neighborhoods

Instead of using a fixed number of nearest neighbors based on rank, you can define specific chromosomal boundaries (e.g., Topologically Associating Domains - TADs) for each gene.

To use this, the `rowData` of your `SummarizedExperiment` must contain:
- `neighbors_start`: The start coordinate of the neighborhood.
- `neighbors_end`: The end coordinate of the neighborhood.

```r
# Ensure rowData has neighbors_start and neighbors_end columns
# Then run DELocal as usual
results_tad <- DELocal(
  pSmrExpt = smrExpt_dynamic,
  pDesign = ~ condition,
  pLogFold_cut = 0
)
```

## Implementation Tips

- **Gene Locations**: If you lack location data, use `biomaRt` to fetch `ensembl_gene_id`, `start_position`, and `chromosome_name` for your specific organism.
- **Filtering**: For large datasets, consider filtering for specific chromosomes or high-variance genes to reduce computation time.
- **Interpretation**: A low p-value in DELocal indicates that the gene's expression change across conditions is significantly different from the trend observed in its immediate chromosomal neighbors.

## Reference documentation

- [DELocal](./references/DELocal.Rmd)