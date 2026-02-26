---
name: bioconductor-kegglincs
description: This package expands KEGG pathway nodes and edges to allow for granular mapping and visualization of experimental data like LINCS L1000. Use when user asks to expand KEGG pathways, map experimental data to individual pathway edges, or visualize expanded pathways in Cytoscape.
homepage: https://bioconductor.org/packages/release/bioc/html/KEGGlincs.html
---


# bioconductor-kegglincs

## Overview

The `KEGGlincs` package allows for a more granular exploration of KEGG pathways by "expanding" nodes and edges. In standard KEGG representations, paralogous genes or grouped entries are often collapsed into a single node. `KEGGlincs` unrolls these groupings so that experimental data (such as LINCS L1000 knock-out data) can be explicitly mapped to individual edges without needing to summarize across gene families. It integrates with Cytoscape via `igraph` for high-quality, conditionally formatted visualizations.

## Core Workflows

### 1. Basic Pathway Expansion and Visualization
Use this workflow to see the "hidden" complexity of a KEGG pathway without adding external data.

```r
library(KEGGlincs)

# 1. Download and parse KGML (e.g., FoxO signaling pathway)
pathway_id <- "hsa04068"
kgml_data <- get_KGML(pathway_id)

# 2. Expand nodes and edges (converts KEGG IDs to symbols)
# Note: convert_KEGG_IDs = FALSE is much faster for large pathways
mappings <- expand_KEGG_mappings(kgml_data)
expanded_edges <- expand_KEGG_edges(kgml_data, mappings)

# 3. Prepare for visualization
node_info <- node_mapping_info(mappings)
edge_info <- edge_mapping_info(expanded_edges)

# 4. Create igraph object and send to Cytoscape
go <- get_graph_object(node_info, edge_info)
cyto_vis(go, "Expanded FoxO Pathway")
```

### 2. Mapping Experimental Data to Edges
This workflow overlays specific data (like LINCS L1000) onto the expanded pathway topology.

```r
# 1. Get expanded objects
kgml <- get_KGML("hsa04115") # p53 pathway
mappings <- expand_KEGG_mappings(kgml)
edges <- expand_KEGG_edges(kgml, mappings)

# 2. Generate edge attributes from LINCS data (e.g., for PC3 cell line)
# Requires the KOdata package
edge_data <- overlap_info(kgml, mappings, "PC3")

# 3. Add data to the edge set
# data_column_no specifies which columns from edge_data to append
final_edges <- add_edge_data(edges, mappings, edge_data, 
                             only_mapped = TRUE, 
                             data_column_no = c(3, 10, 12))

# 4. Visualize with significance markup
edge_map <- edge_mapping_info(final_edges, data_added = TRUE, significance_markup = TRUE)
node_map <- node_mapping_info(mappings)
go <- get_graph_object(node_map, edge_map)
cyto_vis(go, "p53 Pathway - PC3 Data")
```

### 3. Using the Master Function
The `KEGG_lincs` function wraps the entire process into a single call.

```r
# Simple expansion
KEGG_lincs("hsa04068")

# Expansion with cell-line data mapping
KEGG_lincs("hsa04115", "PC3")

# Fast expansion (no ID conversion)
KEGG_lincs("hsa04068", convert_KEGG_IDs = FALSE)
```

## Key Functions and Tips

- **`get_KGML(pathway_id)`**: Fetches the most recent XML representation of a pathway from KEGG.
- **`expand_KEGG_mappings()`**: The most computationally expensive step. It maps KEGG gene IDs to symbols. If performance is an issue, set `convert_KEGG_IDs = FALSE`.
- **`path_genes_by_cell_type()`**: Useful for identifying which cell lines in the LINCS dataset have the best coverage for a specific pathway.
- **`cyto_vis()`**: Requires Cytoscape to be running locally with the CyREST API enabled.
- **Edge Color Coding**:
    - **Red/Blue**: Significant relationships (based on Fisher's Exact Test if data is added).
    - **Orange/Purple**: Non-significant relationships.
    - **Solid vs Dashed**: Direct vs Indirect effects.

## Reference documentation

- [KEGGlincs Workflows](./references/Example-workflow.md)