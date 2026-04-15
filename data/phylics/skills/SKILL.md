---
name: phylics
description: PhyliCS is a Python toolkit for analyzing single-cell copy number alterations to identify sub-clonal structures and measure intra-tumor heterogeneity. Use when user asks to load binned CNV data, calculate genomic metrics, perform dimensionality reduction with UMAP, or visualize cell clusters and copy number distributions.
homepage: https://github.com/bioinformatics-polito/PhyliCS
metadata:
  docker_image: "quay.io/biocontainers/phylics:1.0.7--pyhdfd78af_0"
---

# phylics

## Overview

PhyliCS is a specialized Python toolkit designed for the analysis of single-cell Copy Number Alterations (scCNA). It facilitates the processing of multi-sample datasets to identify sub-clonal structures and measure intra-tumor heterogeneity. This skill provides the procedural knowledge required to transform raw binned CNV data into visualized clusters and annotated genomic features, helping researchers distinguish between different cell populations based on their genomic profiles.

## Installation and Environment

PhyliCS requires Python 3.7 or 3.8. It is recommended to use a dedicated Conda environment to avoid dependency conflicts with newer Python versions.

```bash
# Setup environment
conda create --name phylics python=3.7
conda activate phylics

# Install via Bioconda (preferred)
conda install -c bioconda phylics

# Or install via PyPI
pip install phylics
```

## Data Preparation

PhyliCS expects a specific tab-delimited matrix format for input. Ensure your data follows these constraints:
- **Columns 1-3**: Must be `CHR`, `START`, and `END` (genomic bins).
- **Subsequent Columns**: Each column represents a single cell, containing integer or float copy-number values.
- **Consistency**: All cells must be binned using the same genomic coordinates (identical number of rows and bin boundaries).

## Core Workflow Patterns

### 1. Loading and Initializing Data
Initialize a `Sample` object from your binned file.

```python
import phylics
import pandas as pd

# Load the dataset
sample = phylics.Sample.from_file("path/to/cnv_matrix.txt", sample_name="my_sample")

# Access underlying data if needed
df = sample.get_cnv_dataframe()
matrix = sample.get_cnv_matrix()
```

### 2. Feature Engineering and Annotation
Enhance the dataset by calculating metrics or adding external metadata (like ploidy or quality scores).

```python
# Calculate Median Absolute Deviation (MAD) for each cell
sample.mad()

# Identify highly variable genomic regions (bins)
sample.variable_features()

# Add custom annotations (e.g., from a separate results file)
# annotations should be a pandas Series indexed by cell ID
sample.add_annotation(custom_series, "annotation_name")

# View current annotations
print(sample.get_annotations("obs"))  # 'obs' for cells, 'feat' for bins
```

### 3. Dimensionality Reduction and Clustering
To mitigate the "curse of dimensionality" in sparse single-cell data, use UMAP on highly variable features.

```python
# Run UMAP
sample.umap(use_highly_variable=True)

# Visualize the embedding
sample.plot_umap(outpath="umap_results.png")
```

### 4. Statistical Visualization
Analyze the distribution of specific annotations (like mean copy number) to identify potential clusters or outliers.

```python
# Plot distribution (e.g., to see ploidy groups)
sample.plot_annotation_dist("mean_cn", outpath="ploidy_dist.png", kind="kde")
```

## Expert Tips

- **Memory Management**: For very large single-cell datasets, ensure you have sufficient RAM as PhyliCS loads the CNV matrix into memory via pandas/numpy.
- **Feature Selection**: Always run `variable_features()` before `umap()`. Using all bins often introduces noise from stable genomic regions, which can obscure biological sub-clusters.
- **Troubleshooting**: If you encounter installation errors related to `hdbscan` or `umap-learn`, ensure your `gcc` is up to date and you are strictly using Python < 3.9.

## Reference documentation
- [PhyliCS GitHub Repository](./references/github_com_bioinformatics-polito_PhyliCS.md)
- [PhyliCS Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_phylics_overview.md)