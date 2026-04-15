---
name: bioconductor-mia
description: The bioconductor-mia package provides tools for the analysis and manipulation of microbiome data using the TreeSummarizedExperiment framework. Use when user asks to load microbiome data, agglomerate by taxonomic rank, transform abundance assays, or calculate alpha and beta diversity indices.
homepage: https://bioconductor.org/packages/release/bioc/html/mia.html
---

# bioconductor-mia

## Overview
The `mia` (Microbiome Analysis) package is a Bioconductor tool designed for the analysis of microbiome data. It leverages the `TreeSummarizedExperiment` infrastructure to store taxonomic information, phylogenetic trees, and sample metadata alongside abundance data. This skill provides guidance on data loading, taxonomic manipulation, and ecological index calculation.

## Core Workflow

### 1. Data Loading and Conversion
`mia` supports various input formats, converting them into `TreeSummarizedExperiment` (TSE) objects.

```r
library(mia)

# Load example data
data(GlobalPatterns, package = "mia")
tse <- GlobalPatterns

# Convert from phyloseq
library(phyloseq)
data(esophagus, package = "phyloseq")
tse_esophagus <- convertFromPhyloseq(esophagus)

# Load from external files (BIOM, QIIME2, DADA2)
# ?loadFromBiom, ?loadFromQiime2, ?makeTreeSummarizedExperimentFromDADA2
```

### 2. Taxonomic Manipulation
Taxonomic data is stored in `rowData`. Use `taxonomyRanks()` to identify available levels.

*   **Agglomeration:** Collapse data to a specific taxonomic rank.
```r
# Agglomerate to Family level
tse_fam <- agglomerateByRank(tse, rank = "Family", empty.rm = TRUE)

# Agglomerate all ranks and store as alternative experiments
tse <- agglomerateByRanks(tse)
altExp(tse, "Family") # Access specific rank
```
*   **Labels:** Generate clean taxonomic labels.
```r
head(getTaxonomyLabels(tse))
```

### 3. Assay Transformations
Transform abundance data for downstream analysis. Results are stored as new assays.

```r
# Log10 transformation with pseudocount
tse <- transformAssay(tse, method = "log10", pseudocount = 1)

# Rarefaction (sub-sampling to equal depth)
tse_rare <- rarefyAssay(tse, sample = 60000, name = "subsampled")
```

### 4. Diversity Analysis
Calculate community indices and store them in `colData`.

*   **Alpha Diversity:**
```r
# Add Shannon index to colData
tse <- addAlpha(tse, index = "shannon")
# View results
colData(tse)$shannon
```

*   **Beta Diversity:**
Use `runMDS` (from `scater`) or `addNMDS` with `getDissimilarity`.
```r
library(scater)
tse <- runMDS(tse, 
              FUN = getDissimilarity, 
              method = "bray", 
              name = "BrayCurtis",
              assay.type = "counts")
```

### 5. Utility Functions
*   **Top Taxa:** Identify the most abundant features.
```r
top_taxa <- getTop(tse, method = "mean", top = 10)
```
*   **Tidy Data:** Convert to long format for `ggplot2` or `tidyverse`.
```r
molten_df <- meltAssay(tse, assay.type = "counts", add.row = TRUE, add.col = TRUE)
```

## Tips for Success
*   **Alternative Experiments:** Use `altExp(tse, "rank_name")` to keep different taxonomic resolutions in a single object. This ensures sample subsetting is synchronized across all levels.
*   **Case Sensitivity:** `mia` functions generally recognize taxonomic column names (e.g., "Phylum" vs "phylum") case-insensitively.
*   **Tree Integration:** If your TSE contains a `rowTree`, functions like `agglomerateByRank` can optionally merge the tree nodes (`agglomerateTree = TRUE`).

## Reference documentation
- [mia: Microbiome analysis tools](./references/mia.md)