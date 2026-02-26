---
name: clustergrammer
description: Clustergrammer processes matrix data to generate interactive, web-based hierarchical clustering visualizations and heat maps. Use when user asks to perform hierarchical clustering on numerical matrices, filter large datasets for visualization, or export data to a JSON format for interactive heat map exploration.
homepage: https://github.com/MaayanLab/clustergrammer-py
---


# clustergrammer

## Overview

Clustergrammer is a Python module designed to bridge the gap between raw matrix data and interactive web-based visualizations. It provides a procedural workflow to load data, perform hierarchical clustering using various distance metrics, and apply filters to manage large-scale datasets. Use this skill to prepare biological data (like gene expression matrices) or any numerical table for exploration in a heat map format, ensuring the data is properly normalized and structured for the Clustergrammer.js library.

## Installation

Install the package via pip or conda:

```bash
pip install clustergrammer
# OR
conda install bioconda::clustergrammer
```

## Core Workflow

Follow these steps to generate a visualization JSON from a matrix file:

1.  **Initialize the Network**: Create a new `Network` instance.
2.  **Load Data**: Import a tab-separated matrix or a Pandas DataFrame.
3.  **Process and Cluster**: Calculate clustering and optional views (e.g., top variance).
4.  **Export**: Write the resulting visualization object to a JSON file.

```python
from clustergrammer import Network
net = Network()

# Load a TSV file
net.load_file('data.txt')

# Calculate clustering with specific views
net.make_clust(dist_type='cosine', views=['N_row_sum', 'N_row_var'])

# Export to JSON
net.write_json_to_file('viz', 'output_viz.json')
```

## Data Handling and Filtering

### Working with Pandas
If your data is already in a Pandas DataFrame, load it directly into the network state:
```python
net.df_to_dat(your_dataframe)
```

### Data Cleaning
Always handle missing values before clustering to avoid errors in distance calculations:
```python
net.swap_nan_for_zero()
```

### Permanent Filtering
Use these methods to reduce matrix size before running the clustering algorithm:
*   **By Sum**: `net.filter_sum('row', threshold=100)` — Keeps rows with a sum above 100.
*   **By Top N**: `net.filter_N_top('col', N_top=50, rank_type='var')` — Keeps the top 50 columns based on variance.
*   **By Threshold**: `net.filter_threshold('row', threshold=5, num_occur=3)` — Keeps rows where at least 3 values have an absolute value > 5.

## Clustering Configuration

The `make_clust()` method is the primary engine. Customize it using these parameters:

*   **dist_type**: Set the distance metric (default is `'cosine'`). Supports standard Scipy metrics.
*   **linkage_type**: Set the linkage method (default is `'average'`).
*   **views**: Provide a list of filtered views to include in the visualization (e.g., `['N_row_sum', 'N_row_var']`). This allows users to toggle between different data subsets in the front-end.
*   **run_clustering**: Set to `False` to visualize the matrix in its original order without hierarchical clustering.

## Expert Tips

*   **Large Matrices**: For matrices with >1000 rows/columns, always use `filter_N_top` to ensure the front-end visualization remains performant.
*   **Web Integration**: To quickly preview data without a local front-end, use `net.Iframe_web_app('data.txt')` to generate a link to the Clustergrammer web service.
*   **Z-Scoring**: Perform normalization before clustering if your rows have different scales to ensure the heat map colors are meaningful.

## Reference documentation
- [Clustergrammer-PY GitHub Repository](./references/github_com_MaayanLab_clustergrammer-py.md)
- [Bioconda Clustergrammer Overview](./references/anaconda_org_channels_bioconda_packages_clustergrammer_overview.md)