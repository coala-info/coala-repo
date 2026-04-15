---
name: bioconductor-reactomepa
description: ReactomePA performs pathway enrichment and gene set enrichment analysis using the Reactome database. Use when user asks to identify over-represented pathways, perform gene set enrichment analysis, or visualize biological pathways from genomic data.
homepage: https://bioconductor.org/packages/release/bioc/html/ReactomePA.html
---

# bioconductor-reactomepa

## Overview
ReactomePA is a Bioconductor package designed for Reactome pathway analysis. It provides functions for pathway enrichment analysis, gene set enrichment analysis (GSEA), and various visualization methods to interpret the biological significance of genomic data. It primarily uses Entrez Gene IDs as input and supports multiple organisms including human, rat, mouse, and zebrafish.

## Typical Workflow

### 1. Data Preparation
ReactomePA requires Entrez Gene IDs. If you have Gene Symbols or Ensembl IDs, use `clusterProfiler::bitr` or `org.Hs.eg.db` to convert them first.

```r
library(ReactomePA)
# Example: a vector of Entrez IDs
data(geneList, package="DOSE")
de <- names(geneList)[abs(geneList) > 1.5]
```

### 2. Pathway Enrichment Analysis
Use `enrichPathway` to identify over-represented Reactome pathways in a list of genes.

```r
x <- enrichPathway(gene = de, 
                   organism = "human", 
                   pvalueCutoff = 0.05, 
                   readable = TRUE)
head(x)
```

### 3. Gene Set Enrichment Analysis (GSEA)
Use `gsePathway` for a ranked list of genes (e.g., ranked by fold change).

```r
y <- gsePathway(geneList, 
                nPerm = 1000, 
                minGSSize = 120, 
                pvalueCutoff = 0.05, 
                verbose = FALSE)
head(y)
```

### 4. Visualization
ReactomePA leverages the visualization infrastructure of `enrichplot`.

*   **Bar Plot:** `barplot(x, showCategory=10)`
*   **Dot Plot:** `dotplot(x, showCategory=10)`
*   **Enrichment Map:** `emapplot(x)` (requires `enrichplot`)
*   **Category-Gene Network:** `cnetplot(x, categorySize="pvalue", foldChange=geneList)`
*   **GSEA Plot:** `gseaplot(y, geneSetID = 1)`
*   **Pathway View:** `viewPathway("Cell Cycle", readable=TRUE, foldChange=geneList)`

## Key Functions
*   `enrichPathway()`: Over-representation analysis.
*   `gsePathway()`: Gene set enrichment analysis.
*   `viewPathway()`: Visualize a specific Reactome pathway with gene expression data.
*   `getALLEG()`: Get all Entrez IDs of a specific organism in Reactome.
*   `getDb()`: Internal function to query the Reactome database.

## Tips
*   **Organisms:** Supported organisms include "human", "rat", "mouse", "zebrafish", "celegans", "fly", and "yeast".
*   **ID Mapping:** Set `readable = TRUE` in `enrichPathway` to automatically map Entrez IDs to Gene Symbols in the output table.
*   **Integration:** ReactomePA results are compatible with the `clusterProfiler` ecosystem for comparative analysis (e.g., `compareCluster`).

## Reference documentation
- [ReactomePA](./references/ReactomePA.md)