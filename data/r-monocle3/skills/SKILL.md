---
name: r-monocle3
description: This tool provides expert guidance for single-cell RNA-seq analysis using the monocle3 R package. Use when user asks to perform single-cell trajectory inference, conduct pseudotime analysis, cluster cells, or identify differential expression across developmental paths.
homepage: https://cran.r-project.org/web/packages/monocle3/index.html
---


# r-monocle3

name: r-monocle3
description: Expert guidance for single-cell RNA-seq analysis using the monocle3 R package. Use this skill when performing single-cell trajectory inference, pseudotime analysis, clustering, and differential expression testing. It covers the end-to-end workflow from CellDataSet (CDS) creation to identifying gene expression changes across developmental paths.

## Overview
Monocle 3 is an analysis toolkit for single-cell RNA-seq designed to help researchers understand cellular transitions. It excels at building single-cell trajectories to model how cells move through biological processes (pseudotime), clustering cells to identify subtypes, and performing statistically robust differential expression analysis to find marker genes or genes regulated during cell fate decisions.

## Installation
To install the package, use the following command in R:
```R
install.packages("monocle3")
```
Note: Monocle 3 often requires additional dependencies from Bioconductor (e.g., BiocGenerics, DelayedArray) and specific system libraries for UMAP and Louvain/Leiden clustering.

## Core Workflow

### 1. Data Preparation
Create a `cell_data_set` (CDS) object, which is the primary container for Monocle 3.
```R
# expression_matrix: genes x cells matrix
# cell_metadata: data frame with cell attributes
# gene_metadata: data frame with gene attributes (must have a 'gene_short_name' column)
cds <- new_cell_data_set(expression_matrix,
                         cell_metadata = cell_metadata,
                         gene_metadata = gene_metadata)
```

### 2. Preprocessing and Dimensionality Reduction
Standardize the data and project it into lower-dimensional space.
```R
cds <- preprocess_cds(cds, num_dim = 50)
cds <- reduce_dimension(cds, reduction_method = "UMAP")
```

### 3. Clustering
Group cells into clusters and partitions. Partitions are larger groups of cells that are potentially disconnected in the trajectory graph.
```R
cds <- cluster_cells(cds)
# Visualize
plot_cells(cds, color_cells_by = "cluster")
```

### 4. Trajectory Inference
Learn the principal graph of the data and order cells according to their progress along the trajectory.
```R
cds <- learn_graph(cds)
# order_cells opens an interactive window if no root_cells/root_nodes are provided
cds <- order_cells(cds) 
# Visualize pseudotime
plot_cells(cds, color_cells_by = "pseudotime")
```

### 5. Differential Expression
Find genes that vary across clusters or along a trajectory.
```R
# Find markers for clusters
marker_test_res <- top_markers(cds, group_cells_by="cluster", reference_cells=1000)

# Find genes that vary over pseudotime or across the graph
# Uses Moran's I spatial autocorrelation logic
pr_graph_test_res <- graph_test(cds, neighbor_graph="principal_graph", cores=4)
```

## Key Functions and Tips
- **`plot_cells()`**: The primary visualization tool. Use `color_cells_by` to toggle between "cluster", "partition", "pseudotime", or specific gene names.
- **`label_leaves` and `label_branch_points`**: Arguments in `plot_cells` to help identify trajectory landmarks.
- **`top_markers()`**: Efficiently identifies genes that are highly specific to certain cell groups.
- **`fit_models()`**: Used for more complex differential expression tasks, allowing for covariates like batch or treatment.
- **Memory Management**: For large datasets, Monocle 3 utilizes `DelayedArray` to handle data that doesn't fit in RAM. Ensure your input matrices are in a sparse format (e.g., `dgCMatrix`) when possible.

## Reference documentation
- [Monocle 3 Home](./references/home_page.md)