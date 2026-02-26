---
name: bioconductor-hyper
description: The hypeR package performs geneset enrichment analysis, visualization, and reporting using multiple statistical tests like hypergeometric, Kolmogorov-Smirnov, and GSEA. Use when user asks to perform enrichment analysis, visualize geneset results with dot plots or enrichment maps, and export analysis reports to Excel or RMarkdown.
homepage: https://bioconductor.org/packages/release/bioc/html/hypeR.html
---


# bioconductor-hyper

## Overview
The `hypeR` package is a comprehensive tool for geneset enrichment analysis, focusing on the downstream analysis, visualization, and reporting of results. It supports multiple statistical tests (hypergeometric, Kolmogorov-Smirnov, and GSEA) and is particularly powerful for handling hierarchical ontologies and relational genesets.

## Installation
```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("hypeR")
```

## Core Workflow

### 1. Prepare the Signature
`hypeR` accepts three types of signatures depending on the desired test:
*   **Hypergeometric:** A character vector of gene symbols.
*   **KS-Test:** A ranked character vector of gene symbols.
*   **GSEA:** A ranked named numerical vector (weights).

```r
# Example: Hypergeometric signature
signature <- c("BRCA1", "TP53", "MYC")

# Example: Weighted signature for GSEA
weighted_sig <- c("BRCA1"=1.5, "TP53"=1.2, "MYC"=0.8)
```

### 2. Define or Download Genesets
You can use custom lists or fetch curated sets using `msigdb_gsets()`.

```r
# Custom geneset
genesets <- list("MY_PATHWAY" = c("GENE1", "GENE2"), "OTHER" = c("GENE3"))

# Download from MSigDB (requires internet)
kegg_gsets <- msigdb_gsets(species="Homo sapiens", collection="C2", subcollection="CP:KEGG_LEGACY")
```

### 3. Perform Enrichment
The primary function is `hypeR()`. It automatically detects the test type based on the signature provided.

```r
# Returns a 'hyp' object
hyp_obj <- hypeR(signature, kegg_gsets, background=23467)
```

### 4. Visualization and Export
`hypeR` provides several methods to explore the `hyp` object:

```r
# Interactive table
hyp_show(hyp_obj)

# Visualization
hyp_dots(hyp_obj)  # Dot plot
hyp_emap(hyp_obj)  # Enrichment map (network of overlapping genesets)
hyp_hmap(hyp_obj)  # Hierarchy map for relational genesets

# Exporting
hyp_to_excel(hyp_obj, file_path="results.xlsx")
hyp_to_rmd(hyp_obj, file_path="report.rmd", title="Enrichment Analysis")
```

## Tips for Success
*   **Background Size:** For hypergeometric tests, ensure the `background` parameter reflects the total number of genes assayed (default is ~23,467 for human).
*   **Relational Genesets:** Use `hyp_hmap()` when working with ontologies that have parent-child relationships to visualize biological resolution.
*   **Reproducibility:** The `hyp_obj$info` slot contains all metadata, parameters, and versioning info used for the specific analysis.

## Reference documentation
- [hypeR Vignette (Rmd)](./references/hypeR.Rmd)
- [hypeR Documentation (MD)](./references/hypeR.md)