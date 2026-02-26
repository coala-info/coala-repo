---
name: lyner
description: Lyner is a command-line toolbox designed for chaining operations like filtering, normalizing, and visualizing dataframes through a pipe-based workflow. Use when user asks to read and transform data, filter by variability or name, perform clustering, transpose matrices, or generate interactive heatmaps and scatterplots.
homepage: https://github.com/tedil/lyner
---


# lyner

## Overview

`lyner` is a command-line "chaining" toolbox designed to streamline operations on dataframes. It operates on a "pipe" concept: a sequence of commands starts by reading a file into an internal `matrix` field, and each subsequent command modifies or utilizes that matrix. It is particularly effective for multi-step exploratory data analysis where you need to quickly filter, normalize, and visualize high-dimensional data.

## Command-Line Usage

### Basic Pipeline Structure
A standard `lyner` command follows this pattern:
`lyner [input] [transformations/filters] [analysis] [output/plot]`

### Core Commands
- **read**: Loads a `.csv` or `.tsv` file into the pipe's `matrix` field.
- **transform**: Applies mathematical operations (e.g., `log2`) to the matrix.
- **transpose (alias: T)**: Swaps rows and columns. This is essential because many filters and clustering operations are orientation-specific.
- **filter**: Removes data based on criteria:
  - `--prefix` / `--suffix`: Filter by row/column names.
  - `-v [float]`: Keep only the top percentage of most variable features (e.g., `-v 0.05` for top 5%).
- **normalise**: Adjusts data scales (e.g., `normalise unit` for [0, 1] scaling).
- **cluster**: Performs clustering. Use `-n` to specify the number of expected clusters.
- **store**: Saves the current selection or specific pipe fields to a file.
- **plot**: Generates interactive visualizations (e.g., `-m heatmap` or `-m scatter`).

## Expert Tips and Best Practices

### Managing the Pipe
`lyner` stores auxiliary data in specific fields. For example, clustering results are stored in `cluster_indices_samples` or `cluster_indices_features`. To save these results, you must explicitly select them:
`lyner read data.csv cluster -n 3 select cluster_indices_samples store clusters.txt`

### The Transpose Sandwich
Since `filter` and `cluster` often target features (columns), use the "transpose sandwich" to operate on samples (rows):
`lyner read data.csv T filter --prefix Control T`
This transposes the data to make samples the columns, filters them, and transposes back to the original orientation.

### Interactive Plotting
When using `plot -m heatmap`, you can pass configuration options using the `-c` flag:
`lyner read data.tsv normalise unit plot -m heatmap -c zmin=0,zmax=1 --with-annotation`

### Combining Annotations
Use `supplement` or `read-annotation` to merge metadata with your primary matrix. This is crucial for coloring scatterplots or adding sidebars to heatmaps:
`lyner read data.tsv supplement metadata.csv T decompose -m ICA -n 2 plot -m scatter`

## Reference documentation
- [lyner GitHub Repository](./references/github_com_tedil_lyner.md)
- [lyner Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_lyner_overview.md)