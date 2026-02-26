---
name: bioconductor-dominosignal
description: This tool analyzes intra- and intercellular signaling in single-cell RNA sequencing data by linking transcription factor activation to receptor-ligand interactions. Use when user asks to build domino objects, establish transcription factor-receptor-ligand linkages, or visualize communication networks between cell clusters.
homepage: https://bioconductor.org/packages/release/bioc/html/dominoSignal.html
---


# bioconductor-dominosignal

name: bioconductor-dominosignal
description: Analysis of intra- and intercellular signaling in single-cell RNA sequencing (scRNAseq) data based on transcription factor (TF) activation. Use this skill to build domino objects, establish TF-receptor-ligand linkages, and visualize communication networks between cell clusters.

# bioconductor-dominosignal

## Overview

`dominoSignal` is an R package designed to infer cell-cell communication by linking transcription factor (TF) activity to receptor expression and ligand availability. Unlike methods that rely solely on transcript levels, `dominoSignal` uses TF activation (often derived from SCENIC) to identify active intracellular signaling pathways and then connects these to extracellular signals.

## Core Workflow

### 1. Data Preparation

The package requires several inputs, typically derived from a `SingleCellExperiment` or `Seurat` object:
- **Counts & Z-scores**: Gene expression matrices. Z-scores must be calculated across all genes of interest.
- **TF Activation Scores**: A matrix (TFs x Cells) of activity scores (e.g., SCENIC AUC).
- **Regulons**: A list where names are TFs and values are vectors of target genes.
- **Clusters**: A named factor vector of cell cluster assignments.

```r
# Example extraction from SingleCellExperiment
counts <- assay(sce, "counts")
logcounts <- assay(sce, "logcounts")
z_scores <- t(scale(t(logcounts[rowSums(logcounts) > 0, ])))
clusters <- factor(sce$cell_type)
names(clusters) <- colnames(sce)
```

### 2. Loading Reference Databases

You must create a receptor-ligand map (`rl_map`). The package provides a helper for CellPhoneDB:

```r
rl_map <- create_rl_map_cellphonedb(genes, proteins, interactions, complexes)
```

### 3. Building the Domino Object

The analysis proceeds in two main steps: initialization and network construction.

```r
# Step 1: Initialize and calculate correlations/DE
dom <- create_domino(
  rl_map = rl_map,
  features = auc_matrix, # TF activity
  counts = counts,
  z_scores = z_scores,
  clusters = clusters,
  tf_targets = regulon_list,
  use_clusters = TRUE
)

# Step 2: Build the network with thresholds
dom <- build_domino(
  dom = dom,
  min_tf_pval = 0.001,
  rec_tf_cor_threshold = 0.25,
  min_rec_percentage = 0.1
)
```

## Accessing Data

Use the `dom_` prefix functions to interact with the S4 object:
- `dom_clusters(dom)`: Get cluster names or labels.
- `dom_linkages(dom, link_type = "incoming-ligand", by_cluster = TRUE)`: View ligands targeting a cluster.
- `dom_signaling(dom)`: Get the global signaling strength matrix.
- `dom_de(dom)`: Access TF differential expression p-values.

## Visualization

### Heatmaps
- `feat_heatmap(dom)`: Visualize TF activation across clusters.
- `cor_heatmap(dom)`: Show correlations between receptors and TFs.
- `incoming_signaling_heatmap(dom, rec_clust = "cluster_name")`: View ligands activating a specific cluster.

### Network Plots
- `signaling_network(dom)`: Global cluster-to-cluster communication graph.
- `gene_network(dom, clust = "target_cluster")`: Detailed L-R-TF linkages for a specific cluster.
- `circos_ligand_receptor(dom, receptor = "CD74")`: Chord diagram of ligands for a specific receptor.

## Tips and Best Practices

- **Gene Filtering**: Ensure all ligands and receptors of interest are present in your `z_scores` matrix. Many pipelines filter for highly variable genes, which may exclude critical signaling components.
- **TF Names**: If using SCENIC, clean TF names (e.g., removing "(+)" or "...") to ensure they match gene names in the expression matrices.
- **Complexes**: Set `use_complexes = TRUE` in `create_domino` to account for heteromeric receptors, which requires a majority of components to be correlated with the TF.
- **Thresholding**: If results are too sparse, lower the `rec_tf_cor_threshold` (default 0.25) or `min_rec_percentage`.

## Reference documentation

- [Get Started with dominoSignal](./references/dominoSignal.md)
- [Interacting with domino Objects](./references/domino_object_vignette.md)
- [Plotting Functions and Options](./references/plotting_vignette.md)