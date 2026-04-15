---
name: bioconductor-gcmap
description: This tool performs differential expression analysis and gene set enrichment analysis to compare transcriptomic profiles across experiments. Use when user asks to compare gene expression profiles, perform connectivity mapping, create gene set collections, or run enrichment algorithms like Fisher's exact test and Wilcoxon rank-sum.
homepage: https://bioconductor.org/packages/3.8/bioc/html/gCMAP.html
---

# bioconductor-gcmap

name: bioconductor-gcmap
description: Perform differential expression analysis and gene set enrichment analysis (GSEA) using the gCMAP package. Use this skill to compare gene expression profiles, perform connectivity mapping (CMap), and run various enrichment algorithms (Fisher's exact test, Wilcoxon rank-sum, limma-based camera/romer/mroast) on transcriptomic data.

## Overview

The `gCMAP` package provides a unified framework for comparing gene sets across differential expression experiments. It introduces the `CMAPCollection` class for efficient storage of large gene set libraries and the `CMAPResults` class for standardized output across different statistical methods. It is particularly useful for "connectivity mapping," where a query profile is compared against a database of reference perturbations.

## Key Workflows

### 1. Preparing Differential Expression Data

Use `generate_gCMAP_NChannelSet` to process raw or normalized data into a standardized format containing z-scores, p-values, and fold changes.

```r
library(gCMAP)
# For a list of ExpressionSets (microarray) or CountDataSets (RNA-seq)
cde <- generate_gCMAP_NChannelSet(
  eset.list,
  uids = 1:length(eset.list),
  control_perturb_col = "condition",
  control = "Control",
  perturb = "Treatment",
  platform.annotation = "Entrez"
)
# Resulting channels: "exprs", "log_fc", "p", "z"
```

### 2. Creating Gene Set Collections

`CMAPCollection` objects store gene sets as sparse incidence matrices. You can create them from existing `GeneSet` objects or by thresholding expression data.

```r
# Induce gene sets from an NChannelSet based on z-score thresholds
cmap_coll <- induceCMAPCollection(cde, element = "z", lower = -2, higher = 2)

# Check if sets are signed (up/down regulated)
signed(cmap_coll) 
```

### 3. Running Enrichment Queries

`gCMAP` supports multiple algorithms depending on the input type (gene lists vs. full profiles).

#### Comparing Gene Lists (Fisher's Exact Test)
Use when you have a set of differentially expressed genes and want to find similar sets in a collection.
```r
results <- fisher_score(query_gene_set, target_cmap_collection, universe = all_genes)
```

#### Comparing a Score Profile (Wilcoxon or JG Score)
Use when you have a continuous vector of scores (e.g., z-scores) for all genes.
```r
# Wilcoxon rank-sum test
w_res <- wilcox_score(z_vector, target_cmap_collection)

# Parametric t-statistic summary (Jiang & Gentleman)
jg_res <- gsealm_jg_score(z_vector, target_cmap_collection)
```

#### Differential Expression of Gene Sets (limma wrappers)
Use when comparing groups (Case vs. Control) directly using gene sets.
```r
# Competitive GSEA using limma's camera
cam_res <- camera_score(expression_matrix, cmap_coll, predictor = group_factor)

# Self-contained GSEA using limma's mroast
mro_res <- mroast_score(expression_matrix, cmap_coll, predictor = group_factor)
```

### 4. Interpreting Results

All methods return a `CMAPResults` object.

```r
# View the summary table
cmapTable(results)

# Extract specific metrics
pval(results)
zscores(results)
effect(results) # Effect size (e.g., Log Odds Ratio or JG score)

# Visualization
plot(results) # Generates density plots of effect sizes and heatmaps of ranks
```

### 5. Retrieving Gene-Level Information

To see which specific genes contributed to the enrichment:

```r
# Run analysis with keep.scores = TRUE
res <- gsealm_score(y, cmap, predictor = pred, keep.scores = TRUE)

# Extract scores for a specific set
set_scores <- geneScores(res)[["set_name"]]
```

## Tips for Large Datasets

*   **BigMatrix Support**: For very large collections, `generate_gCMAP_NChannelSet` can store data on disk using the `big.matrix` parameter to save memory.
*   **Sparse Matrices**: `CMAPCollection` uses sparse matrices by default; avoid converting them to dense matrices if the gene universe is large.
*   **Parallelization**: Many scoring functions can be computationally intensive; ensure the `parallel` package is configured if processing thousands of gene sets.

## Reference documentation

- [Primer: Preparing NChannelSet objects with differential expression scores](./references/diffExprAnalysis.md)
- [Gene set analyses with the gCMAP package](./references/gCMAP.md)