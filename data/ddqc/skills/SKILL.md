---
name: ddqc
description: The ddqc tool provides a data-driven framework for performing dynamic quality control in scRNA-seq pipelines by calculating filtering thresholds based on specific cell clusters. Use when user asks to perform quality control on single-cell data, calculate dynamic filtering thresholds, or filter cells based on mitochondrial and ribosomal content.
homepage: https://github.com/ayshwaryas/ddqc
metadata:
  docker_image: "quay.io/biocontainers/ddqc:1.0--pyh7e72e81_0"
---

# ddqc

## Overview
The `ddqc` tool provides a data-driven framework for quality control in scRNA-seq pipelines. Unlike traditional methods that apply rigid, arbitrary cutoffs (e.g., a flat 5% mitochondrial read limit) across an entire dataset, `ddqc` calculates thresholds dynamically based on the distribution of metrics within specific cell clusters. This ensures that biologically distinct cell types with naturally higher metabolic or transcriptional activity are not erroneously filtered out. It is designed to work seamlessly with the Pegasus ecosystem.

## Installation
Install via Bioconda or from the source repository:
```bash
conda install bioconda::ddqc
# OR
pip install .
```

## Core Workflow
The tool expects a `pegasusio` MultimodalData object as input. The QC step must be performed **before** data normalization.

### 1. Data Loading
Use `pegasusio` to load various formats (h5ad, h5, mtx, csv, loom):
```python
import pegasusio as io
import ddqc

# Load a single sample
data = io.read_input("sample_path.h5ad", genome='hg19')
```

### 2. Running ddqc Metrics
The primary function is `ddqc_metrics`. By default, it performs initial clustering and calculates thresholds for genes, counts, and mitochondrial/ribosomal content.
```python
# Basic execution
ddqc.ddqc_metrics(data)
```

### 3. Handling Aggregated Data
For experiments with multiple samples, aggregate them into a single object before running `ddqc`:
```python
# aggregate_matrices requires a CSV with 'Sample' and 'Location' columns
data = io.aggregate_matrices("samples_list.csv")
ddqc.ddqc_metrics(data)
```

## Expert Tips and Parameters

### Customizing Thresholds
If the automated "mad" (Median Absolute Deviation) method is too strict or too loose, you can overwrite specific thresholds:
- `threshold_counts`: Manual cutoff for total UMI counts.
- `threshold_genes`: Manual cutoff for number of genes.
- `threshold_mito`: Manual cutoff for mitochondrial percentage.
- `threshold_ribo`: Manual cutoff for ribosomal percentage.

### Tuning Clustering
Since `ddqc` relies on initial clustering to determine local thresholds, you can tune the clustering behavior:
- `clustering_method`: Choose the algorithm for initial grouping.
- `K`: Number of nearest neighbors for the manifold.
- `n_components`: Number of principal components to use.

### Inspecting Results
After running `ddqc_metrics`, the input object's `obs` field is updated with:
- `passed_qc`: Boolean indicating if the cell survived filtering.
- `n_counts`, `n_genes`, `percent_mito`, `percent_ribo`: Calculated metrics for each cell.

To understand exactly why cells were filtered, request the QC dataframe:
```python
df_qc = ddqc.ddqc_metrics(data, return_df_qc=True)
# df_qc contains metric_lower_co and metric_upper_co for each cluster
```

### Species-Specific Prefixes
Ensure your mitochondrial and ribosomal gene prefixes match your data (e.g., `MT-` for human, `mt-` for mouse). If the defaults fail to identify these genes, check the `mito_prefix` and `ribo_prefix` parameters.

## Reference documentation
- [ddqc GitHub Repository](./references/github_com_ayshwaryas_ddqc.md)
- [Bioconda ddqc Overview](./references/anaconda_org_channels_bioconda_packages_ddqc_overview.md)