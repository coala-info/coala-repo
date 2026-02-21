---
name: bioconductor-ggkegg
description: The package supports visualizing KEGG information using ggplot2 and ggraph through using the grammar of graphics. The package enables the direct visualization of the results from various omics analysis packages.
homepage: https://bioconductor.org/packages/release/bioc/html/ggkegg.html
---

# bioconductor-ggkegg

name: bioconductor-ggkegg
description: Visualizing KEGG pathways, modules, and networks using the grammar of graphics (ggplot2/ggraph). Use this skill when the user needs to: (1) Import and parse KEGG data into tidy graph formats, (2) Create customizable KEGG pathway maps with specific layouts, (3) Highlight omics results (e.g., from DESeq2 or clusterProfiler) on KEGG maps, (4) Analyze KEGG module completeness and structure, or (5) Overlay raw KEGG images with custom ggplot2 layers.

# bioconductor-ggkegg

## Overview

The `ggkegg` package provides a framework for analyzing and visualizing KEGG (Kyoto Encyclopedia of Genes and Genomes) data within the R tidyverse ecosystem. It converts KEGG PATHWAY, MODULE, and NETWORK data into `tbl_graph` objects (via `tidygraph`), allowing users to manipulate biological networks using `dplyr` verbs and visualize them using `ggraph` and `ggplot2`. This approach offers significantly more flexibility than traditional KEGG visualization tools by allowing layer-by-layer customization of nodes, edges, and aesthetics.

## Core Workflows

### 1. Visualizing KEGG Pathways
The primary workflow involves fetching a pathway, manipulating the graph, and plotting with `ggraph`.

```r
library(ggkegg)
library(tidygraph)
library(ggraph)
library(dplyr)

# 1. Obtain pathway as a tbl_graph
# Use layout="manual" with x=x, y=y to preserve original KEGG coordinates
graph <- pathway("hsa04110", use_cache = TRUE)

# 2. Optional: Manipulate with tidygraph/dplyr
graph <- graph %>%
  activate(nodes) %>%
  mutate(label = strsplit(graphics_name, ",") %>% vapply("[", 1, FUN.VALUE="a"))

# 3. Plot using ggraph
ggraph(graph, layout = "manual", x = x, y = y) +
  geom_edge_parallel(aes(color = subtype_name), 
                     arrow = arrow(length = unit(1, "mm")),
                     end_cap = circle(5, "mm")) +
  geom_node_rect(aes(fill = I(bgcolor), filter = type == "gene"), color = "black") +
  geom_node_text(aes(label = label, filter = type == "gene"), size = 2) +
  theme_void()
```

### 2. Identifier Conversion and Highlighting
Use `convert_id` to map KEGG IDs to gene symbols and `highlight_set_nodes` to mark specific genes of interest (e.g., hits from a differential expression analysis).

```r
graph <- graph %>%
  activate(nodes) %>%
  mutate(symbol = convert_id("hsa"),
         is_hit = highlight_set_nodes(c("hsa:7157", "hsa:1026")))

# Use the new columns for aesthetics
ggraph(graph, layout = "manual", x = x, y = y) +
  geom_node_rect(aes(fill = is_hit), filter = type == "gene") +
  scale_fill_manual(values = c("TRUE" = "red", "FALSE" = "white"))
```

### 3. Overlaying Raw KEGG Maps
To maintain the familiar look of KEGG while adding custom data layers, use `overlay_raw_map()`.

```r
ggkegg("hsa04110") +
  geom_node_rect(aes(fill = my_numeric_data), filter = type == "gene", alpha = 0.5) +
  overlay_raw_map() +
  scale_fill_viridis_c()
```

### 4. KEGG Modules and Networks
`ggkegg` can parse and visualize functional modules.

*   **Text-based:** `module("M00002") %>% module_text() %>% plot_module_text()`
*   **Network-based:** `module("M00002") %>% obtain_sequential_module_definition() %>% plot_module_blocks()`

## Key Functions

*   `pathway(id)`: Downloads and parses a KEGG pathway into a `tbl_graph`.
*   `ggkegg(id)`: A high-level wrapper that returns a `ggraph` object for pathways, modules, or networks.
*   `convert_id(org)`: Helper for `mutate()` to convert KEGG IDs to symbols/names.
*   `highlight_set_nodes(ids)`: Helper for `mutate()` to create logical vectors for specific nodes.
*   `overlay_raw_map()`: A ggplot layer that adds the original KEGG PNG background.

## Tips for Success

*   **Coordinate System:** KEGG uses a coordinate system where the Y-axis is often inverted compared to standard Cartesian planes. `ggkegg` handles this, but always use `layout = "manual", x = x, y = y` in `ggraph` to ensure nodes align with the pathway map.
*   **Tidygraph Activation:** Remember to use `activate(nodes)` or `activate(edges)` before applying `dplyr` verbs to the graph object.
*   **Integration:** `ggkegg` objects are compatible with `patchwork` for multi-panel figures and `ggfx` for advanced visual effects.
*   **Caching:** Set `use_cache = TRUE` in `pathway()` or `module()` to avoid redundant API calls to KEGG.

## Reference documentation

- [ggkegg](./references/usage_of_ggkegg.md)
- [ggkegg Rmd](./references/usage_of_ggkegg.Rmd)