---
name: bioconductor-flowworkspace
description: This package manages and manipulates gated flow cytometry data using hierarchical GatingSet objects in R. Use when user asks to import gating workspaces, build gating trees, perform transformations and compensations, merge GatingSets, or extract population statistics.
homepage: https://bioconductor.org/packages/release/bioc/html/flowWorkspace.html
---


# bioconductor-flowworkspace

name: bioconductor-flowworkspace
description: Specialized R package for managing and manipulating gated flow cytometry data. Use this skill when you need to work with GatingSet, GatingHierarchy, cytoframe, or cytoset objects in R. It supports importing workspaces (via CytoML), building gating trees from scratch, merging GatingSets with different structures, performing transformations/compensations, and extracting population statistics or indices.

# bioconductor-flowworkspace

## Overview
The `flowWorkspace` package is a core Bioconductor tool designed to store, represent, and exchange gated flow cytometry data. It replaces the traditional `flowFrame`/`flowSet` with more efficient reference-based classes (`cytoframe`/`cytoset`) and provides a hierarchical structure (`GatingSet`) to manage complex gating trees across multiple samples.

## Core Workflows

### 1. Initializing a GatingSet
You can build a `GatingSet` from a `flowSet` or a `cytoset`.
```r
library(flowWorkspace)
library(flowCore)
data(GvHD)
fs <- GvHD[1:2]
gs <- GatingSet(fs)
```

### 2. Compensation and Transformation
Apply compensation matrices and transformations (e.g., logicle, biexponential) to the `GatingSet`.
```r
# Compensation
comp <- compensation(comp.mat)
gs <- compensate(gs, comp)

# Transformation
transList <- transformerList(c("FL1-H", "FL2-H"), asinhtGml2_trans())
gs <- transform(gs, transList)
```

### 3. Manual Gating
Add gates to the hierarchy and recompute to apply them to the data.
```r
# Add a rectangle gate to root
rg <- rectangleGate("FSC-H"=c(200,400), "SSC-H"=c(250, 400), filterId="NonDebris")
gs_pop_add(gs, rg, parent = "root")

# Add a quadGate to the new node
qg <- quadGate("FL1-H"= 0.2, "FL2-H"= 0.4)
gs_pop_add(gs, qg, parent = "NonDebris")

# Always recompute after adding gates
recompute(gs)
```

### 4. Data Extraction and Statistics
Retrieve population counts, gates, or underlying event data.
```r
# Get population paths (use path = "auto" for shortest unique names)
nodes <- gs_get_pop_paths(gs, path = "auto")

# Get stats
stats <- gs_pop_get_stats(gs)

# Get gated data for a specific node
cs_sub <- gs_pop_get_data(gs, "NonDebris")
```

### 5. Merging GatingSets
When merging multiple `GatingSet` objects with slightly different structures:
1. Use `gs_split_by_tree(gs_list)` to group by structure.
2. Use `gs_check_redundant_nodes(groups)` to find leaf nodes that prevent merging.
3. Use `gs_pop_set_visibility(gs, node, FALSE)` to hide non-leaf nodes that differ.
4. Use `gs_remove_redundant_nodes(groups, toRemove)` to prune trees for consistency.
5. Merge using `merge_list_to_gs(gs_list)`.

## Key Classes and Methods
- **GatingSet**: The container for multiple samples and their gating trees.
- **GatingHierarchy**: A single sample's gating tree (accessed via `gs[[1]]`).
- **cytoframe/cytoset**: Reference-class versions of `flowFrame`/`flowSet`. 
  - **Warning**: `cs[[1]]` returns a reference. Modifying it changes the original data. Use `realize_view()` for a deep copy.
- **Visualization**: Use `plot(gs)` for the tree structure and `autoplot(gs, "node")` (requires `ggcyto`) for gate plots.

## Best Practices
- **Memory Management**: `GatingSet` uses external pointers. Use `save_gs()` and `load_gs()` for persistence; standard R `save()` will not work.
- **Cloning**: Use `gs_clone(gs)` for a full copy or `gs_copy_tree_only(gs)` for a lightweight copy that shares the same underlying data.
- **Node Referencing**: Prefer `path = "auto"` in `gs_get_pop_paths` to ensure scripts are robust to minor changes in the full gating path.

## Reference documentation
- [How to merge/standardize GatingSets](./references/HowToMergeGatingSet.md)
- [flowWorkspace Introduction](./references/flowWorkspace-Introduction.md)