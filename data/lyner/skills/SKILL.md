---
name: lyner
description: lyner is a command-line chaining toolbox designed for efficient dataframe processing and high-dimensional data analysis through piped command sequences. Use when user asks to read tabular data, transpose matrices, filter by variance or labels, normalize values, perform clustering or dimensionality reduction, and generate interactive heatmaps or scatter plots.
homepage: https://github.com/tedil/lyner
---

# lyner

## Overview
lyner is a command-line "chaining toolbox" designed for efficient dataframe processing. It operates on a "pipe" concept where data is loaded into a `matrix` field and passed through a series of consecutive commands. This allows for complex data science workflows—from raw file reading to interactive heatmap generation—to be expressed as a single, readable command string. It is particularly well-suited for bioinformatics and high-dimensional data analysis where row/column orientation and iterative filtering are common.

## Command-Line Usage Patterns

### The Chaining Logic
Every lyner command sequence typically follows this structure:
`lyner <input_command> <processing_commands> <output_command>`

- **Input**: Usually `read <file.csv>` or `read <file.tsv>`.
- **Processing**: Commands like `transform`, `filter`, `normalise`, `cluster`, or `decompose`.
- **Output**: Commands like `plot` or `store`.

### Core CLI Commands
- **read**: Loads a tabular file into the pipe's `matrix` field.
- **transpose (alias: T)**: Swaps rows and columns. Essential because many commands (like `filter` or `cluster`) are orientation-specific.
- **transform**: Applies mathematical operations (e.g., `transform log2`).
- **filter**: 
  - By label: `filter --prefix <string>` or `filter --suffix <string>`.
  - By variance: `filter -v 0.05` (retains the top 5% most variable features).
- **normalise**: Adjusts data scales (e.g., `normalise unit` for [0, 1] scaling).
- **cluster**: Performs clustering. Use `-n` to specify the number of clusters.
- **decompose**: Performs dimensionality reduction (e.g., `decompose -m ICA -n 2`).
- **plot**: Generates interactive visualizations.
  - `-m`: Mode (e.g., `heatmap`, `scatter`).
  - `-o`: Output filename (e.g., `output.html`).
  - `-c`: Specific configuration parameters (e.g., `-c zmin=0,zmax=1`).

### Working with Auxiliary Data
lyner stores metadata in specific pipe fields. For example, clustering results are stored in `cluster_indices_samples` or `cluster_indices_features`.
- To save these results: `[...] cluster -n 3 select cluster_indices_samples store clusters.txt`
- To use annotations in plots: `read data.csv read-annotation labels.csv plot -m heatmap --with-annotation`

## Expert Tips
- **Orientation Awareness**: If a filter isn't working as expected, you likely need to insert a `T` (transpose) command. lyner often defaults to feature-based operations; transpose to operate on samples.
- **In-Place Transformations**: Most transform and normalization commands modify the `matrix` field in-place within the pipe.
- **Interactive Plots**: lyner uses Plotly for its `plot` command. Always specify an `.html` output with `-o` to preserve interactivity.
- **Annotation Supplementing**: Use the `supplement` command to merge external metadata into the current pipe before transposing or decomposing.



## Subcommands

| Command | Description |
|---------|-------------|
| lyner astype | Convert data to a specified type. |
| lyner center | Center the matrix. |
| lyner cluster | Cluster cells based on their expression profiles. |
| lyner cluster-agglomerative | Agglomerative clustering of cells |
| lyner cluster-from | Cluster sequences from a file. |
| lyner cluster-hierarchical | Hierarchical clustering of samples. |
| lyner compose | Compose a pipeline from a list of transformations. |
| lyner correlate | Calculate pairwise Pearson correlation coefficients between columns of a matrix. |
| lyner decompose | Decompose a matrix into its constituent parts. |
| lyner dendro | Plot a dendrogram from a distance matrix. |
| lyner design | Description of the experiment. Expects 2-column tsv (Sample, Class). |
| lyner dist-graph | Generates a distance graph from a distance matrix. |
| lyner estimate | Estimate gene expression levels from RNA-Seq data. |
| lyner filter | Filter data according to selected option. |
| lyner frequent-sets | Find frequent itemsets in a binary matrix. |
| lyner pairwise-distances | Compute pairwise distances between samples. |
| lyner read | Read abundance/count matrix from MATRIX (tsv format). |
| lyner read-annotation | Reads annotation from given file and stores it in `annotation`. |
| lyner reindex | Reindex the matrix. |
| lyner seed | Try "lyner seed --help" for help. |
| lyner select | Select a datum based on its name (e.g. 'matrix' or 'estimate'), making it the target of commands such as `show`, `save` and `plot`. |
| lyner show | Show the content of a lyner pipe. |
| lyner sort | Sorts the matrix by columns. |
| lyner sort-index | Sorts and indexes a matrix. |
| lyner summarise | Summarise a lyner matrix |
| lyner supplement | Supply additional data which may be used for plot colors, for example. |
| lyner targets | Specify targets for lyner |
| lyner threshold | Set \|data\| < value to 0, data >= value to 1, -data >= value to -1. |
| lyner transpose | Transpose a matrix or a selection of columns from a matrix. |
| lyner uncluster | Uncluster sequences |

## Reference documentation
- [Main README and Examples](./references/github_com_tedil_lyner_blob_master_README.md)
- [Project Metadata and Dependencies](./references/github_com_tedil_lyner_blob_master_setup.py.md)