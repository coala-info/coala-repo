---
name: bioconductor-netomics
description: The netOmics package provides a framework for constructing, integrating, and exploring multi-omics networks through inference, database retrieval, and layer merging. Use when user asks to build multi-omics networks, perform network inference, merge omics layers via correlations or interactions, or conduct Random Walk with Restart analysis.
homepage: https://bioconductor.org/packages/3.14/bioc/html/netOmics.html
---

# bioconductor-netomics

## Overview
The `netOmics` package provides a framework for the construction and exploration of multi-omics networks. It is designed to go beyond simple data integration by providing tools for biological interpretation. It is particularly powerful when used with `timeOmics` for longitudinal data, allowing users to build sub-networks based on kinetic clusters. Key capabilities include network inference (ARACNe), database-driven interaction retrieval (BioGrid), layer merging via shared nodes or expression correlations, and propagation-based analysis (RWR) to identify missing biological functions or regulatory molecules.

## Core Workflow

### 1. Network Building
Networks are built layer-by-layer. You can create inference-based networks from expression data or interaction-based networks from databases.

```r
library(netOmics)
library(timeOmics)
library(igraph)

# Inference Network (GRN)
# cluster.info is typically from timeOmics::getCluster()
graph.rna <- get_grn(X = rna_data, cluster = cluster.info_rna)

# Interaction from Databases
# X can be a list of molecules per cluster
graph.prot <- get_interaction_from_database(X = prot_list, 
                                            db = biogrid_df, 
                                            type = "PROT", 
                                            user.ego = TRUE)

# Check network stats
get_graph_stats(graph.rna)
```

### 2. Layer Merging
Combine different omics layers into a unified multi-omics network.

*   **Via Interactions:** Use shared vertices or a known interaction table (e.g., TF-target).
*   **Via Correlations:** Use when no prior interaction knowledge exists.

```r
# Merging with known interactions
full.graph <- combine_layers(graph1 = graph.rna, graph2 = graph.prot)
full.graph <- combine_layers(graph1 = full.graph, graph2 = tf_interaction_df)

# Merging with correlations (e.g., connecting Gut Microbiome to RNA)
interaction_df_corr <- get_interaction_from_correlation(X = omic_data_list, 
                                                        Y = other_data_list, 
                                                        threshold = 0.99)
full.graph <- combine_layers(graph1 = full.graph, 
                             graph2 = graph.gut, 
                             interaction.df = interaction_df_corr$All)
```

### 3. Adding Supplemental Knowledge
Enrich the network with Over Representation Analysis (ORA) or external disease/pathway databases.

```r
# Add GO terms via ORA
graph.go <- get_interaction_from_ORA(query = mol_list,
                                     sources = "GO",
                                     organism = "hsapiens",
                                     signif.value = TRUE)
full.graph <- combine_layers(graph1 = full.graph, graph2 = graph.go)
```

### 4. Network Exploration (RWR)
Use Random Walk with Restart (RWR) to rank nodes by proximity to "seed" molecules of interest.

```r
# Run RWR from specific seeds (e.g., a gene or GO term)
seeds <- c("ZNF263")
rwr_res <- random_walk_restart(full.graph$All, seed = seeds)

# Find closest nodes of a specific type (e.g., find functions for a gene)
rwr_find_closest_type(rwr_res, seed = "ZNF263", attribute = "type", 
                      value = "GO", top = 5)

# Identify seeds that reach different omics types within k steps
rwr_type_k15 <- rwr_find_seeds_between_attributes(X = rwr_res, 
                                                  attribute = "type", k = 15)

# Visualize subnetwork around a seed
plot_rwr_subnetwork(rwr_type_k15$`GO:0005737`, legend = TRUE)
```

## Tips and Best Practices
*   **Longitudinal Data:** Always perform clustering with `timeOmics` first. `netOmics` functions are designed to handle the resulting cluster lists automatically to build cluster-specific sub-networks.
*   **Graph Cleaning:** Use a custom cleaning function to assign attributes like `type` (RNA, PROT, etc.) and `mode` (core vs. extended) to nodes. This is essential for effective RWR filtering.
*   **RWR Performance:** Running RWR with all vertices as seeds can be computationally expensive. Start with specific biological seeds (e.g., the multi-omics signature identified by `timeOmics`).
*   **Database Format:** `get_interaction_from_database` expects a data frame with `from` and `to` columns.

## Reference documentation
- [netOmics Vignette](./references/netOmics.md)
- [netOmics R Markdown Source](./references/netOmics.Rmd)