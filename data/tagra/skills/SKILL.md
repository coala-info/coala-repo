---
name: tagra
description: TaGra (Tabular to Graph) is a specialized tool designed to bridge the gap between structured tables and graph-based data structures.
homepage: https://github.com/davidetorre92/TaGra
---

# tagra

## Overview

TaGra (Tabular to Graph) is a specialized tool designed to bridge the gap between structured tables and graph-based data structures. It streamlines the transition from raw data to network analysis by automating data cleaning, feature scaling, and categorical encoding before applying graph construction algorithms. Use this skill to quickly generate adjacency structures from rows of data, where each row becomes a node and edges are defined by mathematical relationships between their features.

## Installation

TaGra can be installed via pip or conda:

```bash
# Via pip
pip install tagra

# Via bioconda
conda install bioconda::tagra
```

## Command Line Usage

TaGra primarily operates through a execution script (typically `go.py`) using either direct flags or a JSON configuration file.

### Quick Execution
For rapid graph generation without a full configuration file, use the `-d` (dataframe) and `-a` (attribute/target) flags:

```bash
python3 go.py -d path/to/data.csv -a target_column_name
```
*This performs default preprocessing and constructs a K-Nearest Neighbors (KNN) graph.*

### Configuration-Based Execution
For complex workflows, use a JSON configuration file:

```bash
python3 go.py -c path/to/config.json
```

## Configuration Best Practices

The JSON configuration file controls the pipeline. Below are the high-utility parameters for expert control:

### 1. Data Specification
*   **input_dataframe**: Supports `.csv`, `.xlsx`, `.pickle`, `.json`, `.parquet`, `.hdf`, `.h5`.
*   **unknown_column_action**: Set to `"infer"` to allow TaGra to automatically detect numeric vs. categorical types based on the `numeric_threshold`.

### 2. Preprocessing Logic
*   **numeric_scaling**: Use `"standard"` (Z-score) for most algorithms or `"minmax"` if you need features bounded between 0 and 1.
*   **categorical_encoding**: Choose `"one-hot"` for nominal data or `"label"` for ordinal data.
*   **nan_action**: Options include `"drop row"`, `"drop column"`, or `"infer"`. Use `nan_threshold` to control the sensitivity of column dropping.

### 3. Graph Construction Methods
TaGra supports three primary ways to define edges:
*   **knn**: Connects each node to its `k` closest neighbors. Best for ensuring a connected or semi-connected graph.
*   **distance_threshold**: Connects nodes if Euclidean distance is below a specific value. Useful for spatial or density-based clusters.
*   **similarity**: Connects nodes if cosine similarity exceeds a `similarity_threshold`. Best for high-dimensional text or feature vectors.

### 4. Manifold Learning
To reduce noise or dimensionality before building the graph, configure the manifold section:
*   **manifold_method**: Set to `"Isomap"` to project data into a lower-dimensional space.
*   **manifold_dimension**: Define the target dimensionality (e.g., 2 or 3 for visualization).

## Expert Tips

*   **Graph Visualization**: If `graph_visualization_filename` is set to `null`, the tool skips plotting, which significantly speeds up processing for large datasets.
*   **Target Columns**: Always specify `target_columns`. These are not used to build the graph (to avoid data leakage) but are used for "Neighborhood class probability" analysis and graph coloring.
*   **Memory Management**: For very large tables, prefer `.parquet` or `.hdf` formats over `.csv` for faster I/O.
*   **Validation**: Check the generated `degree_distribution_filename` plot to ensure your `k` or `distance_threshold` isn't creating a graph that is too sparse or too dense.

## Reference documentation
- [TaGra GitHub Repository](./references/github_com_davidetorre92_TaGra.md)
- [Bioconda TaGra Package](./references/anaconda_org_channels_bioconda_packages_tagra_overview.md)