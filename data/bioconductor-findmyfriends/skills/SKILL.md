---
name: bioconductor-findmyfriends
description: the package is assisting in the creation of pangenome matrices where genes from related organisms are grouped by similarity, as well as the analysis of these data. FindMyFriends provides many novel approaches to doing pangenome analysis and supports a gene grouping algorithm that scales linearly, thus making the creation of huge pangenomes feasible.
homepage: https://bioconductor.org/packages/3.6/bioc/html/FindMyFriends.html
---

# bioconductor-findmyfriends

name: bioconductor-findmyfriends
description: Expert guidance for the FindMyFriends R package to perform microbial pangenome analysis. Use this skill when you need to create pangenome matrices, group genes by similarity using linear-scaling algorithms (K-mer based), perform neighborhood-based refinement, or visualize pangenome evolution and chromosomal organization.

# bioconductor-findmyfriends

## Overview

FindMyFriends is a high-performance framework for microbial comparative genomics. It specializes in creating pangenomes—collections of genes across related organisms grouped by homology. Unlike traditional BLAST-based methods that scale quadratically, FindMyFriends uses alignment-free K-mer decomposition and cosine similarity to achieve linear scaling, making it suitable for very large datasets. It emphasizes a two-step grouping process: a coarse initial clustering followed by a refinement step that considers both sequence similarity and chromosomal neighborhood (synteny).

## Core Workflow

### 1. Data Initialization
Load gene data from FASTA files into a `Pangenome` object. Providing gene location data is highly recommended for neighborhood-based refinement.

```r
library(FindMyFriends)

# Create pangenome object
# geneLocation can be 'prodigal' or a custom data.frame/function
mycoPan <- pangenome(fastaFiles, 
                     translated = TRUE, 
                     geneLocation = 'prodigal', 
                     lowMem = FALSE)

# Add organism metadata
mycoPan <- addOrgInfo(mycoPan, metadata_df)
```

### 2. Pangenome Calculation
The standard pipeline involves coarse grouping followed by neighborhood splitting.

```r
# Step 1: Coarse grouping (CD-Hit is the recommended fast approach)
mycoPan <- cdhitGrouping(mycoPan, kmerSize = 5, cdhitIter = TRUE)

# Step 2: Refinement using synteny and sequence similarity
# This splits groups that are similar in sequence but differ in genomic context
mycoPan <- neighborhoodSplit(mycoPan, lowerLimit = 0.8)
```

### 3. Post-processing and Paralogue Handling
FindMyFriends keeps paralogues (genes from the same genome) in separate groups by default. You can link or collapse them if needed.

```r
# Link groups with high similarity across genomes
mycoPan <- kmerLink(mycoPan, lowerLimit = 0.8)

# Optional: Collapse paralogues into single groups
mycoPan_collapsed <- collapseParalogues(mycoPan, combineInfo = 'largest')
```

## Analysis and Visualization

### Data Extraction
Extract the pangenome matrix for downstream statistical analysis.

```r
# Get pangenome matrix (Presence/Absence)
pg_matrix <- as(mycoPan, 'matrix')

# Get as ExpressionSet for Bioconductor compatibility
pg_eset <- as(mycoPan, 'ExpressionSet')

# Extract sequences
all_genes <- genes(mycoPan, split = 'group')
```

### Statistics and Plotting
FindMyFriends provides several built-in functions to assess pangenome quality and biology.

- `groupStat(mycoPan)` / `orgStat(mycoPan)`: Summary statistics for gene groups or organisms.
- `plotEvolution(mycoPan)`: Rarefaction curves showing core vs. accessory gene counts as genomes are added.
- `plotSimilarity(mycoPan)`: Heatmap of organism similarity based on gene content or K-mer counts.
- `plotTree(mycoPan)`: Dendrogram of organisms.
- `plotNeighborhood(mycoPan, group = ID)`: Visualizes the genomic context of a specific gene group.

### Panchromosomal Analysis
Analyze the pangenome as a graph where vertices are gene groups and edges represent chromosomal adjacency.

```r
# Create the panchromosomal graph
pg_graph <- pcGraph(mycoPan)

# Identify regions of high variability (e.g., insertion sites)
var_regions <- variableRegions(mycoPan, flankSize = 6)
```

## Tips for Success
- **Memory Management**: For very large datasets, set `lowMem = TRUE` in the `pangenome()` constructor to keep sequences on disk.
- **Synteny Matters**: Always try to provide `geneLocation` data. The `neighborhoodSplit` function is the package's primary strength for distinguishing between orthologues and paralogues.
- **K-mer Size**: A `kmerSize` of 5 is generally effective for protein sequences; larger sizes increase specificity but require more memory.

## Reference documentation
- [Creating pangenomes using FindMyFriends](./references/FindMyFriends_intro.Rmd)