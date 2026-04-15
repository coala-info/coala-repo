---
name: bioconductor-clusterprofiler
description: This tool performs functional enrichment analysis and biological theme comparison to interpret gene lists. Use when user asks to perform over-representation analysis, conduct gene set enrichment analysis, convert gene identifiers, or compare functional profiles across multiple gene clusters.
homepage: https://bioconductor.org/packages/release/bioc/html/clusterProfiler.html
---

# bioconductor-clusterprofiler

name: bioconductor-clusterprofiler
description: Use this skill when performing functional enrichment analysis, gene set enrichment analysis (GSEA), or biological theme comparisons in R. This skill is essential for interpreting gene lists from transcriptomic, proteomic, or genomic studies using Gene Ontology (GO), KEGG pathways, Reactome, and MSigDb.

# bioconductor-clusterprofiler

## Overview
The `clusterProfiler` package is a comprehensive tool for functional taxonomy. It automates the process of mapping gene identifiers to biological terms and provides statistical frameworks for Over-Representation Analysis (ORA) and Gene Set Enrichment Analysis (GSEA). It is particularly powerful for comparing functional profiles across multiple gene clusters and visualizing complex biological data.

## Core Workflows

### 1. Gene ID Conversion
Most enrichment functions require Entrez IDs. Use the `bitr` function to convert between formats (e.g., SYMBOL, ENSEMBL, ENTREZID).
```r
library(clusterProfiler)
library(org.Hs.eg.db) # Use appropriate OrgDb for your species

gene_ids <- bitr(gene_list, fromType="SYMBOL", toType="ENTREZID", OrgDb="org.Hs.eg.db")
```

### 2. Over-Representation Analysis (ORA)
Use ORA to determine if biological themes are enriched in a specific list of genes (e.g., differentially expressed genes) compared to a background "universe."
- **GO Enrichment**: `enrichGO(gene, OrgDb, ont="BP", pvalueCutoff=0.05)` (ont can be "BP", "MF", or "CC").
- **KEGG Enrichment**: `enrichKEGG(gene, organism="hsa", pvalueCutoff=0.05)`.
- **Universal Enrichment**: Use `enricher()` for custom annotations (MSigDb, etc.).

### 3. Gene Set Enrichment Analysis (GSEA)
Use GSEA for ranked gene lists (e.g., sorted by log2 fold change) to identify coordinated changes in biological pathways without arbitrary thresholds.
- **GO GSEA**: `gseGO(geneList, OrgDb, ont="BP")`.
- **KEGG GSEA**: `gseKEGG(geneList, organism="hsa")`.
- **Note**: The input `geneList` must be a numeric vector sorted in decreasing order with gene IDs as names.

### 4. Biological Theme Comparison
To compare functional profiles of multiple gene lists (e.g., different time points or treatments), use `compareCluster`.
```r
ck <- compareCluster(geneCluster = list_of_gene_vectors, fun = "enrichGO", OrgDb = "org.Hs.eg.db")
dotplot(ck)
```

## Visualization
`clusterProfiler` integrates with `enrichplot` for high-quality visualizations:
- **barplot() / dotplot()**: Standard summary of enriched terms.
- **cnetplot()**: Visualizes the linkage of genes and biological concepts (gene-concept network).
- **emapplot()**: Enrichment map that clusters redundant terms.
- **gseaplot2()**: Detailed view of GSEA running scores and gene rankings.
- **upsetplot()**: Shows the overlap between different gene sets.

## Best Practices
- **Species Selection**: Ensure the correct `organism` code for KEGG (e.g., "hsa" for human, "mmu" for mouse) and the correct `OrgDb` for GO.
- **P-value Adjustment**: Always check the `p.adjust` method (default is "BH").
- **Readable Labels**: Use `setReadable()` after enrichment to convert Entrez IDs back to Gene Symbols for easier interpretation of plots.
- **Online Data**: `enrichKEGG` and `gseKEGG` use the latest online KEGG data; ensure an active internet connection or use cached data.

## Reference documentation
- [clusterProfiler](./references/clusterProfiler.md)