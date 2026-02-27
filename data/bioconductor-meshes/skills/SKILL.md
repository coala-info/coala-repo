---
name: bioconductor-meshes
description: This tool performs MeSH enrichment analysis and calculates semantic similarity measures for genes and MeSH terms across various species. Use when user asks to identify over-represented MeSH terms, perform gene set enrichment analysis using MeSH, or calculate functional similarity between genes based on MeSH annotations.
homepage: https://bioconductor.org/packages/release/bioc/html/meshes.html
---


# bioconductor-meshes

name: bioconductor-meshes
description: Perform MeSH (Medical Subject Headings) enrichment analysis and semantic similarity measures for genes and MeSH terms. Use this skill when analyzing biomedical datasets to identify over-represented MeSH terms or to calculate functional similarity between genes based on MeSH annotations.

# bioconductor-meshes

## Overview

The `meshes` package facilitates enrichment analysis and semantic similarity measurement using Medical Subject Headings (MeSH). It supports over 70 species and allows for analysis across different MeSH categories (e.g., Anatomy, Diseases, Chemicals and Drugs). It integrates with the `clusterProfiler` ecosystem for visualization and interpretation.

## Installation and Setup

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("meshes")
# You also need the MeSH.db and species-specific MeSHDb packages
BiocManager::install("MeSH.db")
BiocManager::install("org.Hs.eg.db") # Example for Human
library(meshes)
```

## MeSH Enrichment Analysis

The package provides `enrichMeSH` for over-representation analysis (ORA) and `gseMeSH` for gene set enrichment analysis (GSEA).

### Over-Representation Analysis (ORA)
```r
data(geneList, package="DOSE")
de <- names(geneList)[abs(geneList) > 2]

# MeSH enrichment
me <- enrichMeSH(de, 
                 MeSHDb = "MeSH.Hsa.eg.db", 
                 database = "gtex", 
                 category = "A")

head(me)
```

### Gene Set Enrichment Analysis (GSEA)
```r
# gseMeSH requires a ranked named vector of fold changes
me_gsea <- gseMeSH(geneList, 
                   MeSHDb = "MeSH.Hsa.eg.db", 
                   database = "gtex", 
                   category = "C")
```

### Key Parameters
- `MeSHDb`: The MeSHDb package for the target species (e.g., "MeSH.Hsa.eg.db").
- `database`: The source of MeSH annotations (e.g., "gtex", "GLAD", "MeSHJP").
- `category`: MeSH descriptor categories (A: Anatomy, B: Organisms, C: Diseases, D: Chemicals and Drugs, etc.).

## Semantic Similarity Analysis

The `meshsim` function calculates semantic similarity between MeSH terms or genes.

```r
# Similarity between MeSH terms
meshsim("D000001", "D000002", 
        MeSHDb = "MeSH.Hsa.eg.db", 
        measure = "Wang")

# Similarity between genes based on MeSH annotations
geneSim("241", "251", 
        MeSHDb = "MeSH.Hsa.eg.db", 
        measure = "Wang", 
        category = "C")
```

## Visualization

Since `meshes` objects inherit from `enrichResult`, you can use `clusterProfiler` and `enrichplot` functions:

```r
library(enrichplot)
dotplot(me)
barplot(me)
upsetplot(me)
```

## Workflow Tips
1. **ID Mapping**: Ensure gene IDs are Entrez IDs, as MeSHDb packages primarily use Entrez mapping.
2. **Database Selection**: Use `MeSH.db` to explore available metadata and ensure the `database` and `category` arguments match the specific research context.
3. **Species Support**: Check Bioconductor for the specific `MeSH.XXX.eg.db` package corresponding to your organism.

## Reference documentation

- [MeSH Enrichment and Semantic Analyses](./references/meshes.md)