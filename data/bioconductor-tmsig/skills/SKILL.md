---
name: bioconductor-tmsig
description: This package provides high-performance tools for preparing, analyzing, and visualizing molecular signatures and gene sets. Use when user asks to read GMT files, filter or cluster gene sets, perform fast matrix-based CAMERA-PR enrichment analysis, or create bubble heatmaps for differential expression results.
homepage: https://bioconductor.org/packages/release/bioc/html/TMSig.html
---

# bioconductor-tmsig

name: bioconductor-tmsig
description: Tools for preparing, analyzing, and visualizing molecular signatures (gene/kinase sets). Use when needing to read GMT files, filter/cluster/invert/decompose sets, perform fast matrix-based CAMERA-PR gene set enrichment analysis, or create bubble heatmaps for differential expression results.

# bioconductor-tmsig

## Overview

The `TMSig` package provides high-performance, memory-efficient tools for handling named lists of sets, specifically tailored for molecular signatures like gene sets. It excels at reducing redundancy in gene set collections through clustering and decomposition, and it implements a fast matrix-based version of the Correlation Adjusted MEan RAnk (CAMERA-PR) gene set test.

## Core Workflows

### 1. Data Preparation and Filtering

Load gene sets from GMT files and filter them based on size or experimental background.

```r
library(TMSig)

# Read GMT file
geneSets <- readGMT("path/to/file.gmt")

# Filter sets by size and background genes
# background should be the vector of genes quantified in your experiment
geneSetsFilt <- filterSets(
    x = geneSets,
    background = quantified_genes,
    min_size = 10,
    max_size = 500
)
```

### 2. Set Similarity and Redundancy Reduction

Identify and remove redundant sets using similarity metrics (Jaccard, Overlap/Simpson, or Otsuka).

```r
# Calculate similarity matrix (default is Jaccard)
sim_mat <- similarity(x = geneSetsFilt, type = "jaccard")

# Cluster sets to identify groups of highly similar terms
clusterDF <- clusterSets(
    x = geneSetsFilt,
    type = "jaccard",
    cutoff = 0.85,
    h = 0.9
)

# Keep only the most representative set from each cluster
keepSets <- clusterDF$set[!duplicated(clusterDF$cluster)]
geneSetsClean <- geneSetsFilt[keepSets]
```

### 3. Set Operations

Invert sets (genes to sets) or decompose overlapping sets into disjoint components.

```r
# Invert: find which sets contain specific genes
inverted <- invertSets(geneSetsClean)
sets_with_gene <- inverted[["GENE_SYMBOL"]]

# Decompose: break overlapping sets A and B into (A-B), (B-A), and (A&B)
decomp <- decomposeSets(geneSetsClean, overlap = 10)
```

### 4. Fast CAMERA-PR Enrichment

Perform competitive gene set testing using the matrix-based `cameraPR` implementation, which is significantly faster than the default `limma` version when handling multiple contrasts.

```r
# Requires a matrix of statistics (e.g., z-scores from limma)
# Rows = genes, Columns = contrasts
res <- cameraPR(statistic = modz_matrix, index = geneSetsClean)
```

### 5. Visualization with Bubble Heatmaps

Create "enrichmaps" (bubble heatmaps) to visualize differential expression or enrichment results.

```r
# For Gene Set Enrichment results
enrichmap(
    x = res,
    set_column = "GeneSet",
    statistic_column = "ZScore",
    contrast_column = "Contrast",
    padj_column = "FDR",
    padj_cutoff = 0.05,
    n_top = 20
)
```

## Tips for Success

- **Incidence Matrices**: Use `sparseIncidence(x)` to create a sparse matrix representation of your sets. This is the foundation for similarity and enrichment functions.
- **Background Selection**: Always provide a `background` vector to `filterSets` that matches your experimental data to ensure enrichment statistics are valid.
- **Redundancy**: If your enrichment results are dominated by many similar GO terms, use `clusterSets` or `decomposeSets` to simplify the output.
- **Matrix Statistics**: `cameraPR` in this package expects a matrix of statistics. If you have a single contrast, ensure it is still passed as a matrix with one column.

## Reference documentation

- [An Introduction to TMSig](./references/TMSig.md)
- [TMSig Vignette Source](./references/TMSig.Rmd)