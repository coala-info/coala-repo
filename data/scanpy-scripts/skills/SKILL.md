---
name: scanpy-scripts
description: Scanpy-scripts provides a command-line interface for executing single-cell RNA sequencing analysis workflows using the Scanpy library. Use when user asks to ingest 10x Genomics data, filter cells, normalize expression levels, perform dimensionality reduction, cluster cell populations, or identify marker genes.
homepage: https://github.com/ebi-gene-expression-group/scanpy-scripts
---


# scanpy-scripts

## Overview

The `scanpy-scripts` tool provides a comprehensive command-line interface (CLI) for the Scanpy Python library. It enables bioinformaticians to execute standard single-cell analysis workflows—from raw data ingestion to trajectory inference—directly from the terminal. This skill helps in configuring and executing modular commands that can be easily integrated into automated shell scripts or workflow managers, ensuring consistent and reproducible data processing.

## Core CLI Usage

The primary entry point is the `scanpy-cli` command. Every subcommand follows a similar pattern, typically requiring an input object (usually in `.h5ad` format) and producing an output object.

### Global Options
- `--njobs INTEGER`: Set the number of CPUs to use (defaults to 1).
- `--verbosity INTEGER`: Adjust the logging level.
- `--debug`: Enable detailed error reporting for troubleshooting.

### Common Workflow Patterns

1. **Data Ingestion**
   Convert 10x Genomics outputs into the Scanpy-native `.h5ad` format.
   ```bash
   scanpy-cli read --input-10x data_dir/ --output-format h5ad output.h5ad
   ```

2. **Quality Control and Filtering**
   Filter cells based on gene counts or other observation variables.
   ```bash
   scanpy-cli filter --input-object input.h5ad --output-object filtered.h5ad --min-genes 200 --max-genes 2500
   ```

3. **Normalization and Scaling**
   Standardize expression levels across cells.
   ```bash
   scanpy-cli norm --input-object filtered.h5ad --output-object normed.h5ad --save-raw
   scanpy-cli scale --input-object normed.h5ad --output-object scaled.h5ad --max-value 10
   ```

4. **Dimensionality Reduction and Embedding**
   Compute PCA, neighborhood graphs, and UMAP/t-SNE embeddings.
   ```bash
   scanpy-cli pca --input-object scaled.h5ad --output-object pca.h5ad
   scanpy-cli neighbor --input-object pca.h5ad --output-object neighbors.h5ad
   scanpy-cli embed --input-object neighbors.h5ad --output-object umap.h5ad --method umap
   ```

5. **Clustering and Marker Genes**
   Identify cell populations and their defining features.
   ```bash
   scanpy-cli cluster --input-object umap.h5ad --output-object clustered.h5ad --method leiden --resolution 0.5
   scanpy-cli diffexp --input-object clustered.h5ad --output-object markers.h5ad --groupby clusters
   ```

## Expert Tips and Best Practices

- **Parallelization**: Always specify `--njobs` for computationally intensive steps like `neighbor`, `embed`, and `integrate` to significantly reduce execution time.
- **Integration Constraints**: If using the `integrate` command (e.g., for MNN), ensure the tool was installed via **Conda/Bioconda**. The `pip` version lacks specific patches required for `mnnpy` to function correctly within this CLI.
- **Metadata Handling**: Use the `read` command to merge additional observation metadata (cell annotations) or variable metadata (gene annotations) during the initial data loading phase.
- **Visualization**: The `plot` command can generate various visualizations (dotplots, violin plots, scatter plots) directly from the CLI. Use `--help` on the plot subcommand to see specific plotting parameters.
- **Workflow Chaining**: Since each command outputs an `.h5ad` file, you can chain operations in a shell script by using the output of the previous step as the `--input-object` for the next.

## Reference documentation
- [Scanpy-scripts GitHub Repository](./references/github_com_ebi-gene-expression-group_scanpy-scripts.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_scanpy-scripts_overview.md)