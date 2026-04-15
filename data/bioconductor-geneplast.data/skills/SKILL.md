---
name: bioconductor-geneplast.data
description: This package provides datasets and utility functions for geneplast evolutionary pipelines, including species trees and orthology relationships. Use when user asks to access pre-processed orthology data, create custom phylogenetic trees, or format data for evolutionary rooting analysis.
homepage: https://bioconductor.org/packages/release/data/annotation/html/geneplast.data.html
---

# bioconductor-geneplast.data

name: bioconductor-geneplast.data
description: Provides datasets and utility functions for geneplast evolutionary pipelines, including species trees, orthology relationships (STRING, OMA, OrthoDB), and tools to create custom phylogenetic trees and ortholog data frames. Use when performing large-scale evolutionary plasticity or rooting analysis in R.

# bioconductor-geneplast.data

## Overview

The `geneplast.data` package serves as the data provider for the `geneplast` evolutionary analysis framework. It facilitates access to pre-processed orthology datasets via `AnnotationHub` and provides utility functions to format custom orthology data and phylogenetic trees for rooting analysis.

## Core Workflows

### 1. Accessing Pre-processed Data
The easiest way to get started is by retrieving validated datasets from AnnotationHub.

```r
library(AnnotationHub)
library(geneplast.data)

# Query for geneplast resources
ah <- AnnotationHub()
meta <- query(ah, "geneplast")

# Load a specific dataset (e.g., STRING v11.0)
# This typically loads: cogdata, phyloTree, cogids, and sspids
load(meta[["AH83116"]])
```

### 2. Creating Custom Input Objects
If not using AnnotationHub, you must prepare a `cogdata` data frame and a `phyloTree` object.

#### Formatting Ortholog Data (cogdata)
`cogdata` must contain: `protein_id`, `cog_id` (Orthologous Group ID), and `ssp_id` (NCBI Taxonomy ID).

```r
# Option A: Manual creation from a data frame
# Ensure ssp_id contains NCBI Taxonomy IDs
head(cogdata)

# Option B: Parse OrthoFinder/standard TSV outputs
cogdata <- geneplast.data::make.cogdata(file = "path/to/orthogroups.tsv")
```

#### Building the Phylogenetic Tree (phyloTree)
The `phyloTree` must be a `phylo` object where tip labels match the `ssp_id` values in `cogdata`.

```r
# Option A: Build from a list of NCBI Taxonomy IDs
# This merges TimeTree and NCBI Taxonomy databases
my_sspids <- c("9606", "9598", "10116") 
phyloTree <- make.phyloTree(sspids = my_sspids)

# Option B: Load from a Newick file
phyloTree <- make.phyloTree(newick = "path/to/tree.nwk")
```

## Integration with geneplast
Once data is loaded or created, it is passed to the `geneplast` analysis functions:

```r
library(geneplast)

# 1. Preprocessing
# spid is the reference species ID (e.g., "9606" for Human)
ogr <- groot.preprocess(cogdata = cogdata, phyloTree = phyloTree, spid = "9606")

# 2. Rooting Analysis
ogr <- groot(ogr, nPermutations = 100)
```

## Tips and Best Practices
- **Taxonomy IDs**: Always use NCBI Taxonomy IDs for `ssp_id` to ensure compatibility with the internal tree-building functions.
- **Memory Management**: Datasets from OrthoDB or OMA can be large. Ensure you have sufficient RAM (16GB+ recommended) when running `groot` on these datasets.
- **Tree Consistency**: Ensure that every `ssp_id` present in your `cogdata` is also represented as a tip label in your `phyloTree`.

## Reference documentation

- [Supporting data for geneplast evolutionary analyses](./references/geneplastdata.md)