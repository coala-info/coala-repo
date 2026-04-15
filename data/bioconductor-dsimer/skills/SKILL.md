---
name: bioconductor-dsimer
description: The dSimer package provides a framework for measuring and visualizing similarity between diseases using feature-based, functional, and network-based methods. Use when user asks to calculate disease similarity scores, integrate gene ontology or protein interaction networks into disease analysis, and visualize disease-disease association networks or heatmaps.
homepage: https://bioconductor.org/packages/3.6/bioc/html/dSimer.html
---

# bioconductor-dsimer

## Overview

The `dSimer` package provides a comprehensive framework for measuring similarity between diseases. It integrates nine distinct methods, ranging from standard cosine similarity of feature vectors to complex function-based methods utilizing Gene Ontology (GO) and Protein-Protein Interaction (PPI) networks. The package also includes built-in biological datasets and visualization tools to explore disease-disease association networks.

## Core Workflows

### 1. Data Preparation
Most methods require disease-gene or disease-feature associations. `dSimer` provides several built-in datasets:
- `data(d2g_fundo_symbol)`: Disease-gene associations (symbols).
- `data(d2s_hsdn)`: Disease-symptom co-occurrences.
- `data(interactome)` or `data(PPI_HPRD)`: Protein interaction networks.

To convert custom data frames to the required list format, use:
```R
# Convert data.frame to list
d2g_list <- x2y_df2list(my_df, xcol = 1, ycol = 2)
```

### 2. Calculating Disease Similarity
Choose a method based on available data:

*   **Feature-based (Cosine):** Uses co-occurrence data (e.g., symptoms).
    ```R
    sim_matrix <- CosineDFV(D1 = diseases1, D2 = diseases2, d2f = d2s_hsdn_sample)
    ```
*   **Annotation-based (BOG, Sun_annotation):** Uses disease-gene associations.
    ```R
    sim_matrix <- BOG(D1, D2, d2g = d2g_separation)
    sim_matrix <- Normalize(sim_matrix)
    ```
*   **Functional/GO-based (PSB, Sun_function):** Uses GO term associations.
    ```R
    # First get disease-GO associations via Hypergeometric test
    d2go <- HypergeometricTest(d2g = d2g_fundo_symbol, go2g = go2g_sample)
    sim_matrix <- PSB(D1, D2, d2go = d2go, go2g = go2g_sample)
    ```
*   **Network-based (Separation, ICod, Sun_topology):** Uses PPI networks.
    ```R
    # Separation method
    sep_matrix <- Separation(D1, D2, d2g_separation, graph_object)
    sim_matrix <- Separation2Similarity(sep_matrix)
    ```

### 3. Visualization
`dSimer` provides three primary ways to visualize results:

*   **Heatmaps:** Best for similarity matrices.
    ```R
    plot_heatmap(sim_matrix, color.high = "red")
    ```
*   **Networks:** Best for symmetric similarity matrices.
    ```R
    plot_net(sim_matrix, cutoff = 0.2)
    ```
*   **Bipartite Graphs:** Visualizes associations between diseases and genes/GO terms.
    ```R
    plot_bipartite(d2g_list)
    ```
*   **Topological Plots:** Shows how two gene sets (diseases) overlap in a PPI network.
    ```R
    plot_topo(geneset1, geneset2, graph_object)
    ```

## Tips and Best Practices
- **Normalization:** Many methods (like BOG or PSB) produce raw scores. Always apply `Normalize()` to bring scores into a 0-1 range for better comparison.
- **ID Consistency:** Ensure gene IDs match between your association lists and network objects (e.g., all Entrez IDs or all Symbols).
- **HumanNet:** The `FunSim` method specifically requires the `LLSn2List` conversion of HumanNet scores.
- **Graph Objects:** Network-based functions require `igraph` objects. Create them using `graph.data.frame(PPI_data, directed=FALSE)`.

## Reference documentation
- [dSimer Reference Manual](./references/reference_manual.md)