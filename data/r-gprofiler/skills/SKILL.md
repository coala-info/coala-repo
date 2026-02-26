---
name: r-gprofiler
description: The r-gprofiler package provides an R interface for functional enrichment analysis, gene identifier conversion, and ortholog mapping using the g:Profiler toolkit. Use when user asks to perform functional profiling of gene lists, convert between different gene ID formats, find homologous genes across species, or map SNPs to gene names.
homepage: https://cran.r-project.org/web/packages/gprofiler/index.html
---


# r-gprofiler

name: r-gprofiler
description: Functional enrichment analysis, gene identifier conversion, and ortholog mapping using the g:Profiler toolkit. Use this skill when performing bioinformatics workflows in R that require mapping gene lists to biological pathways (GO, KEGG, Reactome), converting between different gene ID formats (Ensembl, Entrez, RefSeq), or finding homologous genes across species. Note: This package is deprecated in favor of gprofiler2, but remains necessary for legacy codebases.

# r-gprofiler

## Overview
The `gProfileR` package provides an R interface to the g:Profiler web toolset. It is primarily used for functional profiling of gene lists, allowing researchers to identify significantly enriched biological categories, pathways, and protein complexes. It also includes utilities for ID mapping and orthology search.

**Important Note:** This package is deprecated. For new projects, the use of `gprofiler2` is recommended.

## Installation
To install the package from CRAN:
```R
install.packages("gProfileR")
```

## Main Functions

### Functional Enrichment (`gprofiler`)
The core function for finding enriched terms in a gene list.
```R
library(gProfileR)

# Basic enrichment analysis
genes <- c("TP53", "BRCA1", "APOE")
results <- gprofiler(query = genes, organism = "hsapiens")

# Common parameters:
# - organism: e.g., "hsapiens", "mmusculus"
# - ordered_query: TRUE if genes are ranked (e.g., by fold change)
# - significant: TRUE to return only statistically significant results
# - region_query: TRUE if input is genomic coordinates
```

### Gene ID Conversion (`gconvert`)
Converts a list of gene identifiers to a different database format.
```R
# Convert various IDs to Ensembl IDs
converted <- gconvert(query = c("TP53", "P53_HUMAN"), 
                     organism = "hsapiens", 
                     target = "ENSG")
```

### Ortholog Mapping (`gorth`)
Maps identifiers between different species.
```R
# Map human genes to mouse orthologs
mouse_genes <- gorth(query = c("TP53", "BRCA1"), 
                    source_organism = "hsapiens", 
                    target_organism = "mmusculus")
```

### SNP to Gene Mapping (`gsnpconvert`)
Converts SNP rs-IDs to gene names or genomic locations.
```R
snps <- gsnpconvert(query = c("rs123", "rs456"), organism = "hsapiens")
```

## Workflows

### Standard Enrichment Workflow
1. Define your gene list (character vector).
2. Run `gprofiler()` specifying the organism.
3. Filter the resulting data frame by `p.value` or `domain` (e.g., "BP" for Biological Process).
4. Visualize using external R plotting libraries like `ggplot2`.

### Handling Large Queries
For large gene lists, use `hier_filtering` to reduce redundancy in the output by selecting only the most specific terms in the GO hierarchy.

## Tips
- **Organism Names:** Use concatenated lowercase names like `hsapiens`, `mmusculus`, `rnorvegicus`, `dmelanogaster`.
- **Data Sources:** You can filter results by data source (e.g., GO:BP, KEGG, REAC) using the `src_filter` argument in `gprofiler()`.
- **Background:** Use the `custom_bg` argument to provide a "universe" of genes (e.g., all genes expressed in your experiment) for more accurate p-value calculation.

## Reference documentation
- [gProfileR Home Page](./references/home_page.md)