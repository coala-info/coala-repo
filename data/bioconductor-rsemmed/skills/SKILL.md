---
name: bioconductor-rsemmed
description: This tool provides a programmatic interface to explore and analyze biomedical concept networks from the Semantic MEDLINE database. Use when user asks to find biomedical concepts, identify shortest paths between biological entities, summarize semantic relationships, or expand concept networks using SemMedDB data.
homepage: https://bioconductor.org/packages/release/bioc/html/rsemmed.html
---


# bioconductor-rsemmed

name: bioconductor-rsemmed
description: Explore connections between biological concepts in the Semantic MEDLINE database (SemMedDB). Use this skill to find biomedical concepts (nodes), identify shortest paths between ideas, and expand concept networks using graph-based representations of subject-predicate-object triples (predications).

# bioconductor-rsemmed

## Overview

The `rsemmed` package provides a programmatic interface to the Semantic MEDLINE database (SemMedDB). It represents biomedical information as a directed multigraph where nodes are concepts (e.g., "Sickle Cell Anemia") and edges are predicates (e.g., "CAUSES", "INTERACTS_WITH"). This skill facilitates literature exploration by finding paths between disparate biological entities and summarizing the semantic relationships between them.

## Core Workflow

### 1. Loading Data
The package typically operates on an `igraph` object. A small sample graph `g_small` is included for practice.

```r
library(rsemmed)
data(g_small)
# The full graph is usually named 'g' if loaded from external sources
```

### 2. Finding and Pruning Nodes
Use `find_nodes()` to locate specific concepts using regular expressions or semantic types.

```r
# Search by pattern (case-insensitive)
nodes_malaria <- find_nodes(g_small, pattern = "malaria")

# Search by exact name
node_sickle <- find_nodes(g_small, names = "Sickle Cell Anemia")

# Filter by semantic type (e.g., 'dsyn' for Disease or Syndrome)
disease_nodes <- find_nodes(g_small, pattern = "malaria") %>%
    find_nodes(semtypes = "dsyn")

# Prune unwanted nodes (match = FALSE)
clean_nodes <- nodes_malaria %>%
    find_nodes(pattern = "vaccine", match = FALSE)
```

### 3. Connecting Concepts (Pathfinding)
Use `find_paths()` to find all shortest undirected paths between two sets of nodes.

```r
paths <- find_paths(graph = g_small, from = nodes_sickle, to = nodes_malaria)

# Display results
text_path(g_small, paths[[1]][[1]]) # Textual detail of predicates
plot_path(g_small, paths[[1]][[1]]) # Visual subgraph
```

### 4. Refining Paths with Weights
Shortest paths often pass through high-degree, uninformative nodes (e.g., "Infant", "Human"). Use `make_edge_weights()` to discourage these.

```r
# 1. Get edge features
e_feat <- get_edge_features(g_small)

# 2. Create weights to exclude specific semantic types or names
w <- make_edge_weights(g_small, e_feat, 
                       node_semtypes_out = c("humn", "popg"),
                       node_names_out = c("Child", "Woman"))

# 3. Re-run pathfinding with weights
weighted_paths <- find_paths(g_small, from = nodes_sickle, to = nodes_malaria, weights = w)
```

### 5. Summarizing Results
When dealing with many paths, use summary functions to see dominant patterns.

```r
# Tabulate semantic types in the middle of paths
summarize_semtypes(g_small, weighted_paths)

# Tabulate predicates (relationships) between nodes
summarize_predicates(g_small, weighted_paths)
```

### 6. Expanding Networks
Use `grow_nodes()` to find all nodes directly connected (distance 1) to your starting set.

```r
nbrs <- grow_nodes(g_small, nodes_sickle)
# Use summarize_semtypes(..., is_path = FALSE) to inspect the neighborhood
summarize_semtypes(g_small, nbrs, is_path = FALSE)
```

## Key Semantic Types (semtypes)
- `gngm`: Gene or Genome
- `aapp`: Amino Acid, Peptide, or Protein
- `dsyn`: Disease or Syndrome
- `phsu`: Pharmacologic Substance
- `humn`: Human (Often filtered out to find biological mechanisms)

## Reference documentation
- [The rsemmed User's Guide](./references/rsemmed_user_guide.md)
- [The rsemmed User's Guide (Rmd)](./references/rsemmed_user_guide.Rmd)