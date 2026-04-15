---
name: graph_embed
description: This tool transforms data matrices into 2D visualizations by constructing a supervised force-directed graph embedding. Use when user asks to generate 2D embeddings, visualize class separation in datasets, or create graph-based data visualizations.
homepage: https://github.com/fabriziocosta/GraphEmbed
metadata:
  docker_image: "quay.io/biocontainers/graphclust-wrappers:0.6.0--pl526_1"
---

# graph_embed

## Overview
The `graph_embed` tool transforms complex data matrices into 2D visualizations by constructing a graph where nodes represent instances. It utilizes two specific edge types: 'knn' edges (connecting to the nearest neighbor of the same class) and 'k_shift' edges (connecting to denser neighbors of different classes). This approach allows for a supervised layout that emphasizes class separation and density-based relationships, resulting in a force-directed graph embedding.

## Installation and Setup
The tool requires `graphviz` (or `pygraphviz`) as a non-pip dependency.
```bash
# Install dependencies
conda install pygraphviz

# Install graph_embed
pip install graphembed
```

## Common CLI Patterns

### Basic Execution
To generate a standard embedding, provide the input data and the target class labels in CSV format.
```bash
graph_embed.py -i data.csv -t labels.csv
```

### Adjusting Class Separation
The `-c` (class confidence) parameter is the primary lever for controlling how tightly instances of the same class are grouped.
*   **Clean Data (0.5 - 1.0):** Use for well-separated clusters.
*   **Noisy Data (5.0 - 30.0):** Use to force separation in overlapping datasets.
```bash
graph_embed.py -i data.csv -t labels.csv -c 15.0
```

### Handling Outliers and Neighbors
*   **-k N**: Number of links to the closest neighbors of the same class (default: 3).
*   **-l N**: Number of mutual nearest neighbors required to avoid being flagged as an outlier (default: 3).
*   **-z N**: Horizon for searching denser neighbors of different classes (default: 5).

### Data Preprocessing Flags
Use these flags to improve embedding quality depending on the input distribution:
*   `--normalization`: Normalizes the data matrix.
*   `--correlation_transformation`: Converts the data matrix into a correlation coefficient matrix.
*   `--feature_selection`: Automatically selects the most discriminative features before embedding.

## Output Files
By default, the tool creates an output directory (suffixed with a timestamp) containing:
*   `2D_coords.txt`: Raw 2D coordinates for each instance.
*   `img_1_clean.pdf`: The standard 2D embedding visualization.
*   `img_2_edges.pdf`: Visualization showing red (knn) and blue (k-shift) edges.
*   `img_4_hull.pdf`: Visualization including class convex hulls.

## Expert Tips
*   **Disable Timestamps**: If running in an automated pipeline where you need predictable directory names, use the `--do_not_add_timestamp` flag.
*   **Reproducibility**: Always set `--random_state=N` to ensure the force-directed layout remains consistent across multiple runs.
*   **Visual Tuning**: Use `--figure_size` and `--cmap_name` (e.g., `viridis`, `magma`) to customize the output PDF aesthetics directly from the CLI.

## Reference documentation
- [GraphEmbed GitHub Repository](./references/github_com_fabriziocosta_GraphEmbed.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_graph_embed_overview.md)