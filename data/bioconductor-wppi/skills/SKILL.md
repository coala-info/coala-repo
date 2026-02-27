---
name: bioconductor-wppi
description: This tool calculates context-specific functional scores for genes in a protein-protein interaction network by integrating functional annotations from Gene Ontology and Human Phenotype Ontology. Use when user asks to prioritize candidate genes, calculate gene functional similarity scores, or perform a random walk with restarts on a weighted protein-protein interaction network.
homepage: https://bioconductor.org/packages/release/bioc/html/wppi.html
---


# bioconductor-wppi

name: bioconductor-wppi
description: Calculate context-specific functional scores for genes in a protein-protein interaction (PPI) network neighborhood. Use this skill when you need to prioritize candidate genes based on their functional similarity to a set of genes of interest, integrating OmniPath PPI networks, Gene Ontology (GO), and Human Phenotype Ontology (HPO) data.

# bioconductor-wppi

## Overview

The `wppi` package implements a Random Walk with Restarts (RWR) algorithm on a weighted PPI network to prioritize genes. It is "context-specific" because it weights the network based on functional annotations (GO/HPO) relevant to the user's genes of interest or a specific disease context. The workflow typically involves retrieving network data, defining a subgraph around seed genes, weighting the edges based on shared neighbors and functional similarity, and running the random walk to generate scores.

## Core Workflow

### Single-Call Execution
For most use cases, the entire pipeline can be executed with one function.
```r
library(wppi)

# Define seed genes (Gene Symbols)
genes_interest <- c('ERCC8', 'AKT3', 'NOL3', 'TTK', 'GFI1B', 'CDC25A', 'TPX2', 'SHE')

# Run full prioritization
# Returns a tibble with: score, gene_symbol, uniprot
scores <- score_candidate_genes_from_PPI(genes_interest)
```

### Step-by-Step Customization
If you need to filter specific ontologies (e.g., only Diabetes-related HPO terms) or adjust network parameters:

1.  **Retrieve Data**: Use `wppi_data()` to fetch OmniPath, GO, and HPO data.
    ```r
    # Customize datasets (e.g., only literature curated 'omnipath')
    db <- wppi_data(datasets = 'omnipath')
    ```

2.  **Filter HPO (Optional)**: Narrow down the context.
    ```r
    HPO_data <- wppi_hpo_data()
    # Filter for a specific condition
    diabetes_terms <- unique(dplyr::filter(HPO_data, grepl('Diabetes', Name))$Name)
    ```

3.  **Build Subgraph**: Create an igraph object and extract the neighborhood.
    ```r
    graph_op <- graph_from_op(db$omnipath)
    # sub_level = 1 (direct neighbors), sub_level = 2 (neighbors of neighbors)
    graph_sub <- subgraph_op(graph_op, genes_interest, sub_level = 1)
    ```

4.  **Weight and Rank**:
    ```r
    # Calculate weights based on common neighbors and functional similarity
    w_adj <- weighted_adj(graph_sub, db$go, db$hpo)
    
    # Perform Random Walk with Restarts
    w_rw <- random_walk(w_adj)
    
    # Summarize scores
    final_scores <- prioritization_genes(graph_sub, w_rw, genes_interest)
    ```

## Key Functions

- `score_candidate_genes_from_PPI()`: The wrapper for the full automated pipeline.
- `wppi_data()`: Downloads all necessary database knowledge (OmniPath, GO, HPO, UniProt).
- `subgraph_op()`: Extracts a local neighborhood from the global PPI network.
- `weighted_adj()`: The core scoring engine that combines topology and ontology.
- `random_walk()`: Propagates scores across the weighted network.

## Tips for Success

- **Gene Identifiers**: The package primarily uses Gene Symbols. Ensure your input list is consistent.
- **Network Depth**: The `sub_level` argument in `subgraph_op` significantly impacts computation time. A level of 1 or 2 is usually sufficient for prioritization.
- **Context Filtering**: To make the scores truly "context-specific," filter the HPO or GO data frames before passing them to `weighted_adj()`.
- **Dependencies**: This package relies heavily on `OmnipathR` for data retrieval and `igraph` for network manipulation.

## Reference documentation

- [WPPI workflow](./references/wppi_workflow.Rmd)
- [WPPI workflow (Markdown)](./references/wppi_workflow.md)