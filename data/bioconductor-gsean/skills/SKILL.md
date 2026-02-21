---
name: bioconductor-gsean
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/gsean.html
---

# bioconductor-gsean

name: bioconductor-gsean
description: Gene Set Enrichment Analysis (GSEA) integrated with biological networks. Use this skill to perform network-based functional enrichment analysis, where gene importance is weighted by network centrality (e.g., hub genes) or label propagation. It is particularly useful when you have gene expression data and want to incorporate topological information from biological networks to identify significant pathways.

## Overview

The `gsean` package extends traditional Gene Set Enrichment Analysis (GSEA) by incorporating network topology. Instead of treating all genes in a pathway as equally important, `gsean` uses network centrality measures (like degree centrality) or label propagation to weight genes. This approach helps identify pathways dominated by key "hub" genes and provides a more biologically nuanced view of enrichment than standard Over-Representation Analysis (ORA) or GSEA.

## Main Functions

- `gsean()`: The primary function to perform network-based GSEA. It integrates gene sets, a gene list or statistics, and expression data.
- `GSEA.barplot()`: Generates a bar plot of the GSEA results, typically showing Normalized Enrichment Scores (NES) and significance.

## Typical Workflows

### 1. GSEA based on Label Propagation (Gene List Input)
Use this when you have a discrete list of genes (e.g., recurrently mutated genes) and want to see which pathways they influence within a network context.

```R
library(gsean)

# Load provided KEGG data for Homo sapiens
load(system.file("data", "KEGG_hsa.rda", package = "gsean"))

# Inputs:
# gene_sets: List of pathways (e.g., KEGG_hsa)
# genes: Character vector of gene symbols/IDs
# expr: Gene expression matrix (rows = genes, cols = samples)
set.seed(1)
result <- gsean(KEGG_hsa, recur.mut.gene, exprs.data, threshold = 0.7)

# Visualize top 20 pathways by adjusted p-value
GSEA.barplot(result, category = 'pathway', score = 'NES', pvalue = 'padj', sort = 'padj', top = 20)
```

### 2. GSEA based on Degree Centrality (Statistic Input)
Use this when you have a continuous statistic (e.g., Wald statistics from DESeq2) for all genes. The network topology (centrality) is used to weight the importance of genes in the enrichment calculation.

```R
library(gsean)

# Load provided GO data for Drosophila melanogaster
load(system.file("data", "GO_dme.rda", package = "gsean"))

# Inputs:
# gene_sets: List of pathways (e.g., GO_dme)
# stats: Named numeric vector of statistics (names = gene IDs)
# expr: Gene expression matrix
set.seed(1)
result <- gsean(GO_dme, statistic_vector, exprs.pasilla)

# Visualize results
p <- GSEA.barplot(result, category = 'pathway', score = 'NES', top = 50, pvalue = 'padj')
```

## Tips and Interpretation

- **Network Construction**: The package constructs a network from the provided expression data. The `threshold` parameter in `gsean()` determines the similarity level required to consider two nodes as neighbors.
- **Centrality**: By default, the package uses degree centrality (node strength). This assumes that highly connected genes in the expression-derived network are more functionally significant.
- **Label Propagation**: When a simple gene list is provided, label propagation scores all nodes based on their proximity to the input genes in the network. This effectively converts a list into a ranked statistic for GSEA.
- **ID Matching**: Ensure that the gene identifiers used in your statistics/gene list, the expression matrix, and the gene sets (pathways) are consistent (e.g., all Entrez IDs or all Gene Symbols).
- **Warning Messages**: If you see warnings about ties in ranking, it often means many genes were not influenced by the seed genes in the label propagation step and thus share a baseline score.

## Reference documentation

- [Gene Set Enrichment Analysis with Networks](./references/gsean.md)