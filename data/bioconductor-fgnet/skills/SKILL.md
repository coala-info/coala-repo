---
name: bioconductor-fgnet
description: FGNet transforms functional enrichment analysis results into functional networks by grouping genes and terms into clusters. Use when user asks to perform functional enrichment analysis, generate HTML reports of enrichment results, create gene-term incidence matrices, or visualize functional networks and molecular modules.
homepage: https://bioconductor.org/packages/release/bioc/html/FGNet.html
---


# bioconductor-fgnet

## Overview
FGNet is a Bioconductor package designed to transform Functional Enrichment Analysis (FEA) results into functional networks. Instead of viewing enrichment as a simple list of terms, FGNet groups genes and terms into clusters or "metagroups" based on shared annotations. This allows for the discovery of molecular machines or functional modules. The package supports multiple FEA backends (TopGO, GAGE, DAVID, GeneTerm Linker) and provides tools for visualizing these relationships through static or interactive networks.

## Core Workflow

### 1. Perform Functional Enrichment Analysis (FEA)
FGNet provides wrapper functions for several FEA tools. Each returns a list object containing the enrichment results.

```r
library(FGNet)

# Example gene list (Yeast)
genes <- c("ADA2", "APC1", "APC11", "APC2", "APC4", "APC5", "APC9", "CDC16")

# 1. TopGO (No internet required)
fea_results <- fea_topGO(genes, geneIdType="GENENAME", organism="Sc")

# 2. GAGE (Requires expression set)
# fea_results <- fea_gage(eset, refSamples, compSamples, ...)

# 3. Import DAVID results (from website download)
# fea_results <- format_david("path/to/david_results.txt")
```

### 2. Generate HTML Reports
The quickest way to get an overview of the analysis is the `FGNet_report()` function, which generates an HTML file with networks and statistics.

```r
# Optional: named vector with 1 (UP) or -1 (DOWN) for node coloring
geneExpr <- setNames(c(1, 1, -1, 1, -1, -1, 1, 1), genes)

FGNet_report(fea_results, geneExpr=geneExpr)
```

### 3. Create and Customize Networks
To manipulate networks manually, first convert FEA results into an incidence matrix, then plot.

```r
# Create incidence matrix (Gene-based by default)
incidMat <- fea2incidMat(fea_results)

# Plot functional network
# plotType: "default" (genes/terms) or "bipartite" (nodes linked to clusters)
functionalNetwork(incidMat, geneExpr=geneExpr, plotType="default")

# Create Term-based network
incidMat_terms <- fea2incidMat(fea_results, key="Terms")
functionalNetwork(incidMat_terms, plotOutput="dynamic") # Opens interactive tkplot
```

## Advanced Usage

### Filtering Clusters
You can filter the network based on cluster properties (e.g., Enrichment Score, number of genes) using `fea2incidMat`.

```r
# Filter by a specific attribute found in fea_results$clusters
incidMatFiltered <- fea2incidMat(fea_results, 
                                 filterAttribute="nGenes", 
                                 filterOperator=">", 
                                 filterThreshold=20)
```

### Network Analysis and Hubs
Use `analyzeNetwork()` to find central genes (hubs) based on degree and betweenness within the global network or specific clusters.

```r
stats <- analyzeNetwork(incidMat)

# Get global hubs (top 75% betweenness)
global_hubs <- stats$hubsList$Global

# Get betweenness matrix for all nodes across clusters
bw_matrix <- stats$betweennessMatrix
```

### Visualizing GO Ancestors
To see the hierarchy of enriched GO terms:

```r
goIds <- getTerms(fea_results, returnValue="GO")[[1]]
plotGoAncestors(goIds, ontology="BP")
```

## Tips for Success
- **Gene Identifiers**: Ensure gene IDs match the expected format for the `organism` argument (e.g., "Sc" for Yeast, "Hs" for Human).
- **Interactive Plots**: Use `plotOutput="dynamic"` in `functionalNetwork()` to manually arrange nodes. You can save the layout using `tkplot.getcoords(id)` and reuse it in static plots via the `vLayout` argument.
- **Bipartite Networks**: Use `plotType="bipartite"` to see "Intersection Networks," which simplify the view by showing only nodes shared between multiple clusters.
- **Custom FEA**: If using a tool not directly supported, use `format_results()` or `readGeneTermSets()` to import text-based enrichment results.

## Reference documentation
- [FGNet](./references/FGNet.md)