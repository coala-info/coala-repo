---
name: hypercluster
description: Hypercluster automates the search for optimal clustering parameters by benchmarking multiple algorithms and evaluation metrics. Use when user asks to optimize clustering parameters, compare different clustering algorithms, or evaluate clustering performance with visualizations.
homepage: https://github.com/liliblu/hypercluster
metadata:
  docker_image: "quay.io/biocontainers/hypercluster:0.1.13--0"
---

# hypercluster

---

## Overview
The `hypercluster` skill enables the automated search for optimal clustering parameters across various algorithms. It simplifies the process of fitting multiple models, calculating evaluation metrics (both with and without ground truth), and generating visualizations to identify the most effective clustering strategy for a specific dataset. Use this skill when you need to move beyond manual parameter tuning and require a systematic way to benchmark clustering performance.

## Installation
Install the package via conda (recommended for bioinformatics environments) or pip:

```bash
conda install -c conda-forge -c bioconda hypercluster
# OR
pip install hypercluster
```

## Command Line Usage via Snakemake
The native way to run `hypercluster` as a pipeline is through its provided Snakemake workflow. This allows for scalable execution on clusters or local machines.

### Basic Execution
Run the workflow by pointing to the `hypercluster.smk` file and defining input parameters directly in the command line:

```bash
snakemake -s hypercluster.smk --config input_data_files=your_dataset_prefix input_data_folder=/path/to/data
```

### Common CLI Arguments
- `-s`: Path to the `hypercluster.smk` file.
- `--config`: Overrides or sets configuration variables.
    - `input_data_files`: A list of file prefixes to process.
    - `input_data_folder`: The directory containing the input files.
    - `read_csv_kwargs`: (Advanced) Pass specific pandas reading arguments.

## Python-Based CLI Scripting
For custom workflows, `hypercluster` is frequently used within Python scripts that are executed via the command line.

### Single Algorithm Optimization
Use `AutoClusterer` to optimize a specific algorithm (e.g., KMeans) over a range of parameters.

```python
import hypercluster
import pandas as pd

data = pd.read_csv("data.csv", index_col=0)
clusterer = hypercluster.AutoClusterer()
clusterer.fit(data).evaluate(methods=hypercluster.constants.inherent_metrics)
clusterer.visualize_evaluations()
```

### Multi-Algorithm Comparison
Use `MultiAutoClusterer` to compare different algorithms (e.g., Spectral Clustering vs. HDBSCAN) simultaneously.

```python
multi_clusterer = hypercluster.MultiAutoClusterer()
multi_clusterer.fit(data).evaluate(
    methods=hypercluster.constants.inherent_metrics + hypercluster.constants.need_ground_truth,
    gold_standard=labels
)
```

## Expert Tips and Best Practices
- **Metric Selection**: Use `hypercluster.constants.inherent_metrics` (e.g., Silhouette, Calinski-Harabasz) when you do not have labels. Use `hypercluster.constants.need_ground_truth` (e.g., Adjusted Rand Index) only when a gold standard is available.
- **Visualization**: Always call `visualize_evaluations()` to generate heatmaps. These are essential for identifying "stability regions" in your hyperparameter space where clustering results remain consistent.
- **Channel Priority**: If installing via Conda, ensure your channel priority is set to `conda-forge > bioconda > defaults` to avoid dependency conflicts with `scikit-learn` and `hdbscan`.
- **Memory Management**: When running large grids via Snakemake, use the `--resources mem_mb=XXXX` flag to prevent the scheduler from overloading nodes, as clustering large matrices is memory-intensive.

## Reference documentation
- [hypercluster Overview](./references/anaconda_org_channels_bioconda_packages_hypercluster_overview.md)
- [GitHub Repository and Quickstart](./references/github_com_liliblu_hypercluster.md)