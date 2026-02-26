---
name: checkatlas
description: Checkatlas performs automated quality control and benchmarking of single-cell datasets by calculating metrics for clustering, annotation, and dimensionality reduction. Use when user asks to assess the quality of single-cell atlases, compare multiple datasets, or generate a MultiQC report for .h5ad and .rds files.
homepage: https://checkatlas.readthedocs.io/
---


# checkatlas

## Overview
The `checkatlas` skill provides a streamlined workflow for assessing the quality of single-cell datasets. Instead of manually running QC scripts for different file formats, `checkatlas` crawls a specified directory, identifies supported atlas files, and applies a battery of metrics—including clustering stability, annotation accuracy, and dimensionality reduction quality. It is particularly useful for bioinformaticians who need to compare heterogeneous datasets or validate the impact of different processing pipelines on a single atlas.

## Core Workflows

### Running the Quality Control Pipeline
The primary way to use `checkatlas` is through its Nextflow implementation, which handles the parallel processing of all detected atlases.

```bash
# Basic execution on a folder containing atlas files
nextflow run nf-core-checkatlas --path /path/to/your/atlases/
```

### Key CLI Arguments
- `--path`: The search directory where the tool will crawl for `.h5ad`, `.rds`, and `.h5` files.
- `-r dev`: Use the development branch for the latest metric updates.
- `--metric_cluster`: Specify custom clustering metrics.
- `--metric_annot`: Specify custom annotation metrics.
- `--metric_dimred`: Specify custom dimensionality reduction metrics.

## Expert Tips and Best Practices

### Environment Preparation
- **MultiQC Integration**: To view the integrated HTML report, you must use the specific `checkatlas` branch of MultiQC. Standard MultiQC installations may not parse the `checkatlas` output tables correctly.
- **Seurat Support**: While the tool is Python-based, it uses `rpy2` to interface with R. If you are analyzing Seurat (.rds) files, ensure that `Seurat` is installed in your R environment (`install.packages('Seurat')`).

### Output Management
All results are stored in a folder named `checkatlas_files` created within your search path.
- **Summary Tables**: Found in `checkatlas_files/`, these contain basic QC (nRNA, nFeature, mitochondrial ratio).
- **MultiQC Report**: The file `checkatlas_files/Checkatlas-MultiQC.html` provides the most accessible overview of all atlases compared.

### Metric Selection
`checkatlas` supports a wide array of metrics. For high-quality benchmarking, focus on:
- **Clustering**: Silhouette coefficient and Davies-Bouldin Index for internal consistency.
- **Dimensionality Reduction**: Kruskal stress to evaluate how well low-dimensional embeddings (UMAP/t-SNE) preserve high-dimensional distances.
- **Specificity**: Gini coefficient and Shannon's entropy for cell-type specific gene expression.

## Reference documentation
- [Usage Guide](./references/checkatlas_readthedocs_io_en_tests-0.5.3-9_usage.md)
- [Installation Requirements](./references/checkatlas_readthedocs_io_en_tests-0.5.3-9_installation.md)
- [Available Metrics List](./references/checkatlas_readthedocs_io_en_tests-0.5.3-9_metrics_luca_all_metrics.md)
- [Example Scenarios](./references/checkatlas_readthedocs_io_en_tests-0.5.3-9_examples_examples.md)