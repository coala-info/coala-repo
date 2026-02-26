---
name: bioconductor-geneplast
description: This tool performs evolutionary analysis of orthologous groups using the Bridge algorithm to infer gene roots and calculate evolutionary plasticity indices. Use when user asks to determine the evolutionary root of genes, calculate evolutionary plasticity indices, or map ancestral information onto protein-protein interaction and regulatory networks.
homepage: https://bioconductor.org/packages/release/bioc/html/geneplast.html
---


# bioconductor-geneplast

name: bioconductor-geneplast
description: Evolutionary analysis of orthologous groups using the Bridge algorithm. Use this skill to determine the evolutionary root of genes in a species tree, calculate evolutionary plasticity indices (EPI), and assess the diversity and abundance of orthologous groups. Suitable for large-scale genomic queries, protein-protein interaction (PPI) network analysis, and regulatory network (regulon) evolutionary mapping.

## Overview

The `geneplast` package provides tools for high-throughput evolutionary analysis. It primarily implements the **Bridge algorithm** to infer the evolutionary root of genes (the Last Common Ancestor or LCA where a gene likely originated) and calculates metrics for **Evolutionary Plasticity**, which describe how orthologous groups (OGs) are distributed across a species tree.

## Core Workflows

### 1. Evolutionary Plasticity (Diversity and Abundance)
This workflow calculates how "plastic" an orthologous group is based on its abundance (paralogs per species) and diversity (distribution across the tree).

```R
library(geneplast)
data(gpdata.gs)

# 1. Preprocess: Checks consistency of cogdata, species IDs, and OG IDs
ogp <- gplast.preprocess(cogdata=cogdata, sspids=sspids, cogids=cogids)

# 2. Run Analysis: Calculates abundance, diversity, and plasticity index (EPI)
ogp <- gplast(ogp)

# 3. Retrieve Results
res <- gplast.get(ogp, what="results")
# Returns a dataframe with abundance, diversity, and plasticity columns
```

### 2. Evolutionary Rooting (Bridge Algorithm)
This workflow determines the ancestral node (root) for genes of a reference species.

```R
# 1. Preprocess: Requires cogdata, a phylo object, and a reference species ID (e.g., "9606" for Human)
ogr <- groot.preprocess(cogdata=cogdata, phyloTree=phyloTree, spid="9606")

# 2. Run Rooting: nPermutations should be 1000 for publication-quality results
set.seed(1)
ogr <- groot(ogr, nPermutations=1000)

# 3. Retrieve Results: Returns Root node, Dscore (stability), and P-values
root_res <- groot.get(ogr, what="results")

# 4. Visualization
groot.plot(ogr, whichOG="NOG40170") # Plot specific OG rooting
groot.plot(ogr, plot.lcas = TRUE)   # Plot LCAs of the reference species
```

### 3. Mapping to Networks
You can map rooting results onto `igraph` objects for PPI or regulatory network analysis.

```R
# Map OGR results to an igraph object (requires matching IDs like ENTREZ)
g <- ogr2igraph(ogr, cogdata, my_igraph_network, idkey = "ENTREZ")

# The 'Root' information is added as a vertex attribute: V(g)$Root
```

## Key Functions and Terms

- `gplast.preprocess()` / `groot.preprocess()`: Essential setup functions that create `OGP` or `OGR` objects.
- `Dscore`: A consistency score estimating the stability of the inferred root.
- `Abundance (Dα)`: Number of orthologous genes divided by the number of species.
- `Diversity (Hα)`: Normalized Shannon’s diversity; high values indicate homogeneous distribution across the tree.
- `Plasticity (EPI)`: A combined metric of abundance and diversity.

## Tips for Success

- **Species IDs**: Ensure `spid` and `sspids` match the format in your `cogdata` (often STRING database IDs).
- **Permutations**: The `groot` function relies on permutation analysis for p-values. Use `nPermutations = 1000` for final analyses, but lower values (e.g., 100) for quick testing.
- **Data Sources**: While `gpdata.gs` is provided for examples, use the `geneplast.data.string.v91` package or `AnnotationHub` for full-scale analyses.
- **Root Enumeration**: Roots are numbered from the most recent to the most ancestral node relative to the reference species' lineage.

## Reference documentation

- [Geneplast: large-scale evolutionary analysis of orthologous groups](./references/geneplast.md)
- [Supporting Material for Trefflich2019](./references/geneplast_Trefflich2019.md)