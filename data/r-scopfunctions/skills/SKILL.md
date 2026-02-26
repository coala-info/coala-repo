---
name: r-scopfunctions
description: This R package provides specialized tools for single-cell omics analysis that extend Seurat workflows for demultiplexing, differential expression, and visualization. Use when user asks to demultiplex HTO data, infer intra-hash doublets, perform MAST-based differential expression with random effects, calculate geneset activity scores, or generate advanced cluster and gene network visualizations.
homepage: https://cran.r-project.org/web/packages/scopfunctions/index.html
---


# r-scopfunctions

name: r-scopfunctions
description: Specialized R package for single-cell omics analysis that integrates with Seurat workflows. Use this skill for HTO demultiplexing, intra-hash doublet inference, MAST-based differential expression with random effects, geneset activity embedding, and advanced visualizations like violin grids and co-expression networks.

# r-scopfunctions

## Overview
The `scopfunctions` package provides a suite of tools designed to extend Seurat-based single-cell analysis. It specializes in handling Cell Hashing (HTO) data, performing robust differential expression using MAST with random effects, and generating publication-quality visualizations for cluster distributions and gene networks.

## Installation
To install the package, use the following command:
install.packages("r-scopfunctions")

Note: As this is a GitHub-hosted package, the standard installation is:
devtools::install_github("CBMR-Single-Cell-Omics-Platform/SCOPfunctions")

## Core Workflows

### 1. HTO Preprocessing and Demultiplexing
Optimize hashtag oligonucleotide (HTO) demultiplexing by visualizing quantile thresholds and inferring intra-hash doublets.

```r
# 1. Visualize proportion of singlets/doublets across quantiles
p_quantile <- SCOPfunctions::prep_HTO_q_area_plot(
  seurat_obj = pbmc.hashtag,
  vec_range_quantile = seq(0.8, 0.99, 0.01)
)

# 2. Demultiplex and infer intra-hash doublets
pbmc.hashtag <- Seurat::HTOdemux(pbmc.hashtag, assay = "HTO", positive.quantile = 0.98)
pbmc.hashtag <- SCOPfunctions::prep_intrahash_doub(
  seurat_obj = pbmc.hashtag,
  assay = "RNA",
  npcs = 20
)
```

### 2. Differential Expression (MAST with Random Effects)
Perform DE testing while accounting for batch effects or sample-level variation using random effects.

```r
df_DE <- SCOPfunctions::DE_MAST_RE_seurat(
  object = pbmc.hashtag,
  random_effect.vars = "hash.ID",
  test.use = "MAST",
  ident.1 = "0",
  group.by = "seurat_clusters"
)
```

### 3. Geneset Activity Embedding
Calculate activity scores for specific gene sets or lists of gene sets.

```r
# Single geneset embedding
pbmc.hashtag$geneset_score <- SCOPfunctions::geneset_embed(
  mat_datExpr = as.matrix(GetAssayData(pbmc.hashtag, slot="scale.data", assay="SCT")),
  vec_geneWeights = vec_geneWeights,
  min_feats_present = 5
)

# Batch embedding for multiple genesets
pbmc.hashtag <- SCOPfunctions::geneset_embed_list_seurat(
  seurat_obj = pbmc.hashtag,
  list_vec_geneWeights = list_vec_geneWeights,
  assay = "SCT",
  slot = "scale.data"
)
```

### 4. Advanced Visualization
Generate specialized plots for cluster proportions and feature distributions.

```r
# Cluster distribution bar plot
SCOPfunctions::plot_barIdentGroup(
  seurat_obj = pbmc.hashtag,
  var_ident = "sample_ID",
  var_group = "seurat_clusters"
)

# Violin plot grid for multiple features
SCOPfunctions::plot_vlnGrid(
  seurat_obj = pbmc.hashtag,
  var_group = "seurat_clusters",
  vec_features = c("Gene1", "Gene2", "Gene3")
)

# Co-expression network plot
SCOPfunctions::plot_network(
  mat_datExpr = as.matrix(GetAssayData(seurat_obj, slot="data")),
  vec_geneImportance = vec_geneImportance,
  n_max_genes = 50
)
```

## Tips for Success
- **HTO Quantiles**: Use `prep_HTO_q_area_plot` before `HTOdemux` to find the "elbow" where singlet identification is maximized before doublet rates climb too high.
- **Random Effects**: When using `DE_MAST_RE_seurat`, ensure the `random_effect.vars` (e.g., `sample_ID` or `batch`) has enough levels to justify a random effect model.
- **Memory Management**: For large datasets, set `n_cores_max` in parallelized functions to balance speed and RAM usage.

## Reference documentation
- [LICENSE.md](./references/LICENSE.md)
- [README.Rmd.md](./references/README.Rmd.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)