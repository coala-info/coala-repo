---
name: bioconductor-scbubbletree
description: The scBubbletree package visualizes large-scale scRNA-seq data by grouping cells into clusters and organizing them into a hierarchical tree structure. Use when user asks to cluster single-cell data into bubbles, generate hierarchical tree visualizations of cell clusters, calculate bootstrap support for cluster relationships, or annotate bubbletrees with gene expression and metadata.
homepage: https://bioconductor.org/packages/release/bioc/html/scBubbletree.html
---

# bioconductor-scbubbletree

## Overview

The `scBubbletree` package provides a workflow for visualizing large-scale scRNA-seq data by grouping transcriptionally similar cells into "bubbles" (clusters) and organizing them into a hierarchical tree. This approach offers a transparent, quantitative alternative to standard 2D embeddings like UMAP or t-SNE, allowing for better interpretation of cluster relationships and robustness through bootstrap support.

## Typical Workflow

### 1. Data Preparation
The package is agnostic to the upstream pipeline but requires a low-dimensional projection matrix (e.g., PCA embeddings).

```r
library(scBubbletree)

# A: matrix with n cells (rows) and f features (columns, e.g., PCA)
# m: metadata dataframe for cells
# e: matrix of normalized gene expressions
data("d_ccl", package = "scBubbletree")
A <- d_ccl$A 
```

### 2. Determining Clustering Resolution
Before clustering, identify the optimal number of clusters ($k$) or resolution ($r$).

*   **For Louvain ($r$):** Use `get_r()` to calculate Gap statistics.
    ```r
    b_r <- get_r(x = A, rs = 10^seq(-4, 0.5, by = 0.5), B_gap = 5)
    # Look for the "elbow" in the Gap curve
    ```
*   **For k-means ($k$):** Use `get_k()`.
    ```r
    b_k <- get_k(x = A, ks = 1:10, B_gap = 5)
    ```

### 3. Generating the Bubbletree
This step performs clustering and hierarchical grouping simultaneously. It uses bootstrapping to calculate branch support.

*   **Using Louvain:**
    ```r
    l <- get_bubbletree_graph(x = A, r = 0.1, B = 300, N_eff = 200)
    plot(l$tree)
    ```
*   **Using k-means:**
    ```r
    k <- get_bubbletree_kmeans(x = A, k = 5, B = 300)
    ```
*   **Using External Clustering:** If you already have cluster assignments (e.g., from Seurat or PAM), use `get_bubbletree_dummy()`.
    ```r
    d <- get_bubbletree_dummy(x = A, cs = my_clusters, B = 200)
    ```

### 4. Visualization and Annotation
Adorn the bubbletree with cell features using `patchwork` for layout.

*   **Categorical Features (e.g., Cell Lines):**
    ```r
    # integrate_vertical = TRUE shows distribution of a feature across bubbles
    w1 <- get_cat_tiles(btd = l, f = m$cell_line, integrate_vertical = TRUE)
    l$tree | w1$plot
    ```
*   **Numeric Features (e.g., Gene Expression):**
    ```r
    # Heatmap of means
    w3 <- get_num_tiles(btd = l, fs = e, summary_function = "mean")
    # Violin plots of distributions
    w4 <- get_num_violins(btd = l, fs = e)
    (l$tree | w3$plot | w4$plot)
    ```
*   **Individual Cell Features:**
    ```r
    g_cell <- get_num_cell_tiles(btd = l, f = e[, "ALDH1A1"])
    l$tree | g_cell$plot
    ```

### 5. Quality Metrics
*   **Gini Impurity:** Quantify cluster purity based on labels.
    ```r
    # GI close to 0 indicates high purity
    gini_results <- get_gini(labels = m$cell_line, clusters = l$cluster)
    ```
*   **Comparison:** Compare two different bubbletree topologies (e.g., Louvain vs k-means).
    ```r
    cp <- compare_bubbletrees(btd_1 = l, btd_2 = k)
    plot(cp$comparison)
    ```

## Tips for Success
*   **Bootstrap Support:** Red labels on tree branches indicate robustness (0 to B). Low values suggest unstable cluster relationships.
*   **Bubble Size:** Radii scale linearly with the number of cells in that cluster.
*   **Matrix Input:** Ensure the input matrix `x` is the reduced dimension space (PCA/LSI), not the raw count matrix, to ensure computational efficiency.

## Reference documentation
- [User_manual.md](./references/User_manual.md)