---
name: bioconductor-easycelltype
description: This tool automates cell type annotation for single-cell RNA-seq data by comparing marker gene lists against curated databases like CellMarker, PanglaoDB, or ClusterMole. Use when user asks to annotate cell clusters from a Seurat object, perform cell type enrichment analysis using GSEA or Fisher's exact test, or visualize annotation results with dot plots and bar plots.
homepage: https://bioconductor.org/packages/release/bioc/html/EasyCellType.html
---

# bioconductor-easycelltype

name: bioconductor-easycelltype
description: Automated cell type annotation for single-cell RNA-seq data using marker gene databases. Use this skill when you need to annotate cell clusters from an R Seurat object or a marker list using databases like CellMarker, PanglaoDB, or ClusterMole. It supports both GSEA and Fisher's exact test approaches for enrichment analysis.

## Overview

EasyCellType is a Bioconductor package that automates the annotation of cell types by comparing input marker gene lists against curated databases. It provides a streamlined workflow to convert gene symbols to Entrez IDs, perform enrichment analysis (GSEA or Fisher), and visualize the results through dot plots and bar plots.

## Core Workflow

### 1. Data Preparation
The input must be a data frame with three specific columns: Entrez ID, Cluster ID, and Expression Score (e.g., log fold change). Genes within each cluster should be sorted by their expression score.

```r
library(EasyCellType)
library(org.Hs.eg.db)
library(dplyr)

# Assuming 'markers' is a data frame from Seurat::FindAllMarkers()
# 1. Convert Symbols to Entrez IDs
markers$entrezid <- mapIds(org.Hs.eg.db,
                           keys = markers$gene,
                           column = "ENTREZID",
                           keytype = "SYMBOL",
                           multiVals = "first")

# 2. Format for EasyCellType
input.d <- markers %>%
  filter(!is.na(entrezid)) %>%
  group_by(cluster) %>%
  arrange(desc(avg_log2FC)) %>%
  select(gene = entrezid, cluster, score = avg_log2FC) %>%
  as.data.frame()
```

### 2. Cell Type Annotation
Use the `easyct()` function to perform the annotation.

```r
# Run annotation using GSEA
annot_results <- easyct(input.d, 
                        db = "cellmarker", 
                        species = "Human",
                        tissue = c("Blood", "Peripheral blood"), 
                        p_cut = 0.3,
                        test = "GSEA") # or "fisher"
```

**Parameters:**
- `db`: "cellmarker", "panglao", or "clustermole".
- `species`: "Human" or "Mouse".
- `test`: "GSEA" (uses clusterProfiler) or "fisher" (modified Fisher's exact test).
- `tissue`: Character vector of target tissues. Use `data(cellmarker_tissue)` to see available options for the chosen database.

### 3. Visualization
The package provides dedicated functions to visualize the top annotation candidates.

```r
# Dot plot of results
plot_dot(annot_results, test = "GSEA")

# Bar plot of results
plot_bar(annot_results, test = "GSEA")
```

## Tips and Best Practices

- **Entrez IDs**: The package strictly requires Entrez IDs. Always use `AnnotationDbi` to map your gene symbols before running `easyct`.
- **Tissue Selection**: Providing specific tissues significantly improves annotation accuracy. If unsure of the exact string, load the tissue metadata: `data("cellmarker_tissue")`.
- **Mouse Data**: For mouse samples, ensure you use `org.Mm.eg.db` for ID mapping and set `species = "Mouse"` in the `easyct` function.
- **Ranking**: For GSEA, the order of genes in the input data frame matters. Ensure they are sorted by expression score (descending) within each cluster.

## Reference documentation

- [EasyCellType: an example workflow](./references/my-vignette.md)