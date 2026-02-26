---
name: bioconductor-gopro
description: This tool identifies characteristic Gene Ontology terms for groups of genes with similar expression profiles across multiple cohorts. Use when user asks to find overrepresented biological functions, group genes by expression patterns using Tukey's test or hierarchical clustering, or analyze gene expression data across different cohorts.
homepage: https://bioconductor.org/packages/release/bioc/html/GOpro.html
---


# bioconductor-gopro

## Overview
The `GOpro` package provides a streamlined workflow for interpreting gene expression data across multiple cohorts. It identifies significantly differentially expressed genes and groups them based on their expression profiles. Finally, it identifies the most characteristic biological functions (GO terms) for each group using Fisher's exact test.

## Core Workflow

The primary function in the package is `findGO()`. It integrates gene selection, grouping, and functional annotation into a single call.

### 1. Data Preparation
Input data should ideally be a `MultiAssayExperiment` object. Genes must be named with gene aliases and arranged in the same order for each cohort.

```r
library(GOpro)
# Example data provided by the package
data(exrtcga)
```

### 2. Finding Characteristic GO Terms
The `findGO` function performs three main steps:
1.  **ANOVA**: Selects significantly different genes across cohorts.
2.  **Grouping**: Clusters genes using either Tukey's pairwise comparisons or hierarchical clustering.
3.  **Fisher's Test**: Finds overrepresented GO terms for each group.

#### Basic Usage (Tukey Grouping)
By default, `findGO` uses Tukey's test to group genes by their expression "profiles" (e.g., `cohortA = cohortB < cohortC`).

```r
# Run with default parameters
results <- findGO(exrtcga)

# Get descriptive results (includes GO terms, definitions, and ontology)
results_ext <- findGO(exrtcga, extend = TRUE)
```

#### Hierarchical Clustering
To group genes based on dissimilarity measures rather than profile patterns:

```r
# Group by clustering and find top 2 GO terms per node
results_clust <- findGO(exrtcga, topGO = 2, grouped = 'clustering')

# Plot with overrepresentation domain info on the dendrogram
findGO(exrtcga, topGO = 2, grouped = 'clustering', over.rep = TRUE)
```

### 3. Key Parameters
- `topAOV`: Maximum number of significantly different genes to select via ANOVA.
- `sig.levelAOV`: Significance level for ANOVA (with BH correction).
- `grouped`: Method for grouping genes: `'tukey'` (default) or `'clustering'`.
- `sig.levelTUK`: Significance level for Tukey's test.
- `onto`: GO domains to search: `'MF'` (Molecular Function), `'BP'` (Biological Process), or `'CC'` (Cellular Component).
- `minGO` / `maxGO`: Range of gene counts for GO terms to filter out very rare or very common terms.
- `topGO`: Number of top GO terms to return for each group.

## Tips for Analysis
- **Gene Aliases**: Ensure your input matrices use standard gene symbols/aliases, as the package searches `org.Hs.eg.db` internally.
- **Interpreting Profiles**: In the output, a profile like `bladder=colon<leukemia` indicates that expression is statistically similar in bladder and colon samples but significantly higher in leukemia.
- **Clustering Metrics**: When using `grouped = 'clustering'`, you can customize the distance measure and agglomeration method using `clust.metric` and `clust.method`.

## Reference documentation
- [GOpro: Determine groups of genes and find their most characteristic GO term](./references/GOpro_vignette.md)
- [GOpro Vignette Source](./references/GOpro_vignette.Rmd)