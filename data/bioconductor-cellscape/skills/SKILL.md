---
name: bioconductor-cellscape
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/cellscape.html
---

# bioconductor-cellscape

name: bioconductor-cellscape
description: Visualization of single-cell phylogeny and genomic content (copy number or mutations) to display evolutionary progression and tumor heterogeneity. Use this skill when you need to create interactive CellScape or TimeScape visualizations in R using single-cell genomic data and phylogenetic tree structures.

# bioconductor-cellscape

## Overview
CellScape is an R/Bioconductor package designed to integrate single-cell phylogeny with genomic data. It produces interactive visualizations that map genomic profiles (Copy Number Variations or Variant Allele Frequencies) onto a phylogenetic tree, allowing researchers to explore clonal evolution and cellular heterogeneity. It can also optionally append a TimeScape view for longitudinal data.

## Installation
```r
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("cellscape")
library(cellscape")
```

## Core Function: cellscape()
The primary function is `cellscape()`. It requires genomic data (CNV or Mutations) and a phylogenetic tree structure.

### 1. Input Data Structures
You must provide at least one of the following genomic data types:

*   **CNV Data (`cnv_data`)**: Data frame with columns: `single_cell_id`, `chr`, `start`, `end`, `copy_number`.
*   **Mutation Data (`mut_data`)**: Data frame with columns: `single_cell_id`, `chr`, `coord`, `VAF`.
*   **Mutation Matrix (`mut_data_matrix`)**: Matrix where rows are cell IDs and columns are "chr:coord".

**Phylogenetic Tree (`tree_edges`)**:
A data frame defining the tree structure with columns: `source` (parent cell ID) and `target` (child cell ID). An optional `dist` column can be included for edge distances.

### 2. Basic Workflow
```r
# Load the package
library(cellscape)

# Example with CNV data
cellscape(cnv_data = my_cnv_df, 
          tree_edges = my_tree_df)

# Example with Mutation data
cellscape(mut_data = my_mut_df, 
          tree_edges = my_tree_df)
```

### 3. Integrating TimeScape (Optional)
To append a clonal prevalence view (TimeScape) at the bottom, provide:
*   `gtype_tree_edges`: Data frame of the genotype tree (`source`, `target`).
*   `sc_annot`: Data frame mapping cells to genotypes and timepoints (`single_cell_id`, `genotype`, `timepoint`).

```r
cellscape(cnv_data = my_cnv_df,
          tree_edges = my_tree_df,
          gtype_tree_edges = my_gtype_edges,
          sc_annot = my_annotations)
```

## Customization and Interactivity
*   **Colors**: Use `clone_colours` (data frame with `clone_id` and `colour` hex codes).
*   **Ordering**: Use `mut_order` (vector of "chr:coord") to manually sort mutations in the heatmap.
*   **Titles**: Customize via `timepoint_title`, `clone_title`, `xaxis_title`, and `yaxis_title`.
*   **Interactivity**: The resulting HTML widget supports mouseover synchronization between the tree and heatmap, branch flipping, re-rooting, and tree trimming.

## Data Preparation Tips
*   **CNV**: Use tools like HMMcopy or DNAcopy to generate segments. Ensure the `copy_number` column contains either integer states or segment medians.
*   **Mutations**: Calculate VAF as `variant_count / (variant_count + reference_count)`.
*   **Tree**: Ensure every `single_cell_id` present in the genomic data is also represented in the `tree_edges` data frame.

## Reference documentation
- [CellScape Vignette](./references/cellscape_vignette.md)