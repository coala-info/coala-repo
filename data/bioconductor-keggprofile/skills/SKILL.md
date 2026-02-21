---
name: bioconductor-keggprofile
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.8/bioc/html/KEGGprofile.html
---

# bioconductor-keggprofile

## Overview

The `KEGGprofile` package facilitates the integration of multi-omics data with KEGG pathway maps. Unlike standard enrichment tools that only identify significant pathways, `KEGGprofile` allows for the visualization of expression profiles (e.g., time-series or multi-group data) directly within the pathway diagrams. It supports mapping data as background colors in gene polygons or as line plots within the polygons to show trends across conditions.

## Core Workflow

### 1. Data Preparation and ID Conversion
KEGG uses NCBI (Entrez) Gene IDs. If your data uses UniProt or other identifiers, use `convertId`.

```r
library(KEGGprofile)

# Example conversion from UniProt to Entrez
temp <- matrix(rnorm(20), ncol=2)
rownames(temp) <- c("Q04837", "P0C0L4", "P0C0L5", "O75379", "Q13068")
colnames(temp) <- c("Exp1", "Exp2")

# Convert IDs
data_entrez <- convertId(temp, filters="uniprotswissprot", keepMultipleId=TRUE)
```

### 2. Pathway Enrichment Analysis
Identify pathways significantly enriched with genes of interest (e.g., differentially expressed genes).

```r
# Find enriched pathways for a vector of Entrez IDs
# Set download_latest = TRUE to bypass stale KEGG.db data
genes <- c("67040", "93683", "10001")
enriched <- find_enriched_pathway(genes, species='hsa', download_latest=TRUE)

# View top results
head(enriched[[1]])
```

### 3. Downloading KEGG Resources
The package requires KGML (XML) and PNG files for visualization.

```r
# Download files for a specific pathway (e.g., Cell Cycle '04110')
download_KEGGfile(pathway_id="04110", species="hsa")
```

### 4. Visualization

#### Method A: Background Color ("bg")
Best for single-type data across multiple time points. The gene polygon is divided into vertical slices representing each column in the data.

```r
# 1. Map expression values to colors
# Assuming 'expr_data' has columns for different time points
col <- col_by_value(expr_data, col=colorRampPalette(c("blue", "white", "red"))(1024), range=c(-2, 2))

# 2. Plot pathway
plot_pathway(expr_data, type="bg", bg_col=col, species="hsa", pathway_id="04110")
```

#### Method B: Line Plots ("lines")
Best for comparing different data types (e.g., Proteome vs. Phosphoproteome) across conditions.

```r
# 'groups' defines which columns belong to which data type
plot_pathway(multi_omics_data, 
             type="lines", 
             line_col=c("red", "green"), 
             groups=c(rep("Proteome", 6), rep("Phospho", 6)),
             species="hsa", 
             pathway_id="04110")
```

## Tips for Success
- **ID Matching**: Ensure `rownames` of your expression matrix are character strings of Entrez Gene IDs.
- **Color Scaling**: Use `col_by_value` to ensure consistent color mapping across different pathways.
- **Compound Data**: The package also supports mapping metabolite/compound data using KEGG Compound IDs.
- **Local Database**: Use the `database_dir` argument in `plot_pathway` to point to a specific folder where KGML/PNG files are stored to avoid redundant downloads.

## Reference documentation
- [KEGGprofile](./references/KEGGprofile.md)