---
name: bioconductor-erma
description: The erma package provides a streamlined interface for accessing and visualizing Roadmap Epigenomics project data, specifically focusing on the 25-state ChromImpute model. Use when user asks to access epigenomic metadata, map chromatin states to specific cell types, or visualize chromatin state profiles across different tissues in the context of gene models.
homepage: https://bioconductor.org/packages/3.8/bioc/html/erma.html
---


# bioconductor-erma

## Overview

The `erma` (Epigenomics Road Map Adventures) package provides a streamlined interface to the Roadmap Epigenomics project data. It specifically focuses on the 25-state ChromImpute model outputs by Ernst and Kellis. It allows users to map chromatin states to specific cell types and visualize how these states vary across different tissues or cell lines in the context of gene models.

## Key Workflows

### 1. Accessing Metadata
To explore available cell types and chromatin state definitions:

```r
library(erma)

# Get sample metadata (Epigenome ID, Anatomy, Type, etc.)
meta <- mapmeta()
head(meta[, c("Epigenome.ID..EID.", "Standardized.Epigenome.name", "ANATOMY")])

# View the 25-state model definitions and colors
data(states_25)
print(states_25)
```

### 2. Managing ErmaSet Objects
An `ErmaSet` is the primary container for managing access to the imputed chromatin state BED files.

```r
# Initialize the set of available roadmap data
ermaset <- makeErmaSet()

# List available cell types
types <- cellTypes(ermaset)

# Subset the ErmaSet for specific cell types
sub_set <- ermaset[, 1:5]
```

### 3. Gene-Centric Analysis
You can extract genomic ranges for specific genes and find the chromatin states in their vicinity.

```r
# Get a GRanges object for a specific gene symbol
gene_gr <- genemodel("IL33")

# Define a region of interest (e.g., 50kb upstream of the gene)
roi <- flank(resize(range(gene_gr), 1), width=50000)

# Assign the ROI to the ErmaSet to prepare for data extraction
rowRanges(ermaset) <- roi
```

### 4. Visualizing Chromatin State Profiles
The `csProfile` function is the primary tool for visualizing state variation across cell types.

```r
# Static plot for a specific gene symbol across a subset of cell types
csProfile(ermaset[, 1:10], symbol = "CD28", useShiny = FALSE)

# Interactive visualization (requires Shiny)
# csProfile(ermaset, symbol = "IL33", useShiny = TRUE)
```

## Tips and Best Practices
- **Genome Build**: The roadmap data in this package typically targets `hg19`. Ensure your other genomic coordinates or `GRanges` objects match this build.
- **Parallel Processing**: When querying states across many cell types manually (using `reduceByFile`), use `BiocParallel` to speed up the import process.
- **State Mnemonics**: The `states_25` dataset is essential for interpreting the `name` column in imported BED data (e.g., "1_TssA", "25_Quies").
- **Memory Management**: `ErmaSet` objects point to remote or local files; they do not load all data into memory at once. Use subsetting (`ermaset[range, columns]`) to keep memory usage low.

## Reference documentation
- [erma: epigenomics road map adventures](./references/erma.md)