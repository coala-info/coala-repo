---
name: bioconductor-attract
description: This tool identifies gene expression modules and attractor states that drive cellular phenotypes by analyzing differential expression and pathway-level synexpression groups. Use when user asks to identify core pathway modules that discriminate between cell types, find synexpression groups within pathways, or discover correlated gene partners across the genome.
homepage: https://bioconductor.org/packages/release/bioc/html/attract.html
---


# bioconductor-attract

name: bioconductor-attract
description: Use this skill to identify gene expression modules (attractor states) that drive cellular phenotypes using the Bioconductor package 'attract'. This skill is appropriate for analyzing differential expression between cell types or experimental groups, finding synexpression groups (genes with similar expression profiles), and identifying correlated gene partners across the genome.

## Overview
The `attract` package implements a framework based on Stuart Kauffman's attractor landscape hypothesis. It identifies core pathway modules (from KEGG, Reactome, or MSigDB) that discriminate between different cell types. It then decomposes these pathways into "synexpression groups"—clusters of genes within a pathway that share highly similar expression profiles—and allows for the discovery of additional genes across the genome that correlate with these core drivers.

## Typical Workflow

### 1. Data Preparation
The package operates on `ExpressionSet` objects. If starting with RNA-seq data, use `filterDataSet` to remove low-expression genes.

```R
library(attract)
# For RNA-seq: remove genes where >75% of samples are 0, then log2(x+1)
filteredData <- filterDataSet(raw_counts, filterPerc=0.75)

# Create ExpressionSet (example with loring data)
data(exprs.dat)
data(samp.info)
loring.eset <- new("ExpressionSet")
# ... (standard ExpressionSet construction)
```

### 2. Finding Attractor States
Use `findAttractors` to identify pathways that show significant differential expression changes across groups.

```R
# Using KEGG for microarray data
attractor.states <- findAttractors(loring.eset, 
                                  "celltype", 
                                  annotation = "illuminaHumanv1.db", 
                                  database = "KEGG", 
                                  analysis = "microarray")

# Using MSigDB (requires specifying gene formats)
# Use columns() and keytypes() on your annotation DB to find valid formats
attractor.states.custom <- findAttractors(loring.eset, 
                                         "celltype", 
                                         annotation = "illuminaHumanv1.db", 
                                         database = "path/to/msigdb.gmt", 
                                         analysis = "microarray",
                                         databaseGeneFormat = "ENTREZID", 
                                         expressionSetGeneFormat = "PROBEID")
```

### 3. Removing Uninformative Genes
Filter out genes that do not change significantly across the experimental groups using a LIMMA-based approach.

```R
remove.these.genes <- removeFlatGenes(loring.eset, 
                                      "celltype", 
                                      contrasts = NULL, 
                                      limma.cutoff = 0.05)
```

### 4. Identifying Synexpression Groups
Decompose a specific pathway (e.g., KEGG ID "04010") into groups of genes that share the same expression trajectory.

```R
# For a single pathway
mapk.syn <- findSynexprs("04010", attractor.states, "celltype", remove.these.genes)

# For the top 5 ranked pathways (returns an environment)
top5.syn <- findSynexprs(attractor.states@rankedPathways[1:5, 1], 
                         attractor.states, "celltype", 
                         removeGenes = remove.these.genes)
```

### 5. Visualization and Extrapolation
Visualize the profiles and find genes outside the pathways that share the same expression patterns.

```R
# Plotting
plotsynexprs(mapk.syn, tickMarks = c(6, 28, 47, 60), 
             tickLabels = c("ESC", "PRO", "NSC", "TER"), 
             index = 1, main = "Synexpression Group 1")

# Finding correlated partners (extrapolating to the whole genome)
mapk.cor <- findCorrPartners(mapk.syn, loring.eset, remove.these.genes)

# Functional enrichment of these partners
mapk.func <- calcFuncSynexprs(mapk.syn, attractor.states, "CC", 
                              annotation = "illuminaHumanv1.db")
```

## Key Objects and Slots
- **AttractorModuleSet**: Returned by `findAttractors`.
    - `@rankedPathways`: Data frame of pathways ranked by significance.
    - `@incidenceMatrix`: Mapping of genes to pathways.
- **SynExpressionSet**: Returned by `findSynexprs`.
    - `@groups`: List of gene IDs in each synexpression cluster.
    - `@profiles`: Matrix of average expression profiles per group.

## Tips
- When using **RNA-seq** data, the `analysis` argument in `findAttractors` should be set appropriately, and `expressionSetGeneFormat` (e.g., "ENSEMBL") must be declared.
- The number of synexpression groups is determined automatically using an informativeness metric.
- Use `cor.cutoff` in `findCorrPartners` (default 0.85) to adjust the stringency of genome-wide extrapolation.

## Reference documentation
- [attract](./references/attract.md)