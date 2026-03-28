---
name: pycistopic
description: pycisTopic is a Python framework for analyzing single-cell chromatin accessibility data using Latent Dirichlet Allocation to identify cis-regulatory topics. Use when user asks to process scATAC-seq fragments, perform topic modeling, identify co-accessible genomic regions, or cluster cells based on regulatory landscapes.
homepage: https://github.com/aertslab/pycistopic
---

# pycistopic

## Overview
pycisTopic is a specialized Python framework designed for the analysis of single-cell chromatin accessibility data. It employs Latent Dirichlet Allocation (LDA) to identify "cis-regulatory topics"—co-accessible regions of the genome that characterize specific cell states. Use this skill to guide the processing of scATAC-seq fragments into count matrices, the execution of topic modeling, and the downstream interpretation of regulatory landscapes.

## Installation and Setup
The recommended way to use pycisTopic is through the SCENIC+ ecosystem to ensure all dependencies for multi-omic inference are met.

```bash
# Create a dedicated environment
conda create --name scenicplus python=3.11 -y
conda activate scenicplus

# Install via the SCENIC+ repository
git clone https://github.com/aertslab/scenicplus.git
cd scenicplus
pip install .
```

To verify the installation and check the version within a Python session:
```python
import pycisTopic
print(pycisTopic.__version__)
```

## Core Workflow Patterns
While pycisTopic is primarily a Python library rather than a CLI-heavy tool, the following patterns are essential for its operation:

### 1. Object Initialization
The workflow typically begins by creating a `CistopicObject`. This requires a count matrix (cells x peaks) or fragment files.
- **Input**: BED files, fragment files, or sparse matrices.
- **Best Practice**: Ensure your peak set is "consensus" peaks (merged from all clusters) to allow for proper topic modeling across the entire dataset.

### 2. Topic Modeling (LDA)
This is the computationally intensive core of the tool.
- **Models**: It supports various LDA implementations (e.g., Mallet, Gensim).
- **Selection**: Run models with a range of topic numbers (e.g., 10, 20, 30, 40, 50) and use the provided plotting functions to evaluate the "elbow" or stabilization of log-likelihood to select the optimal number of topics.

### 3. Downstream Analysis
Once topics are defined, the tool enables:
- **Cell Clustering**: Based on topic contributions per cell.
- **Region Scoring**: Identifying which genomic regions contribute most to specific topics.
- **Differentially Accessible Regions (DARs)**: Finding regions specific to cell clusters.

## Expert Tips
- **Memory Management**: For large datasets, use the `collapsed` LDA implementation or ensure you are utilizing a high-memory environment, as the cell-by-peak matrix can be extremely sparse but large.
- **Blacklist Filtering**: Always filter your peaks against genomic blacklists (e.g., ENCODE blacklist) before running `pycisTopic` to avoid topics being driven by repetitive elements or sequencing artifacts.
- **Integration**: pycisTopic is designed to feed directly into `pycistarget` for motif enrichment and `SCENIC+` for gene regulatory network (GRN) inference.



## Subcommands

| Command | Description |
|---------|-------------|
| pycistopic qc | QC for scATAC-seq data. |
| pycistopic topic_modeling | Topic modeling for pycisTopic |
| pycistopic tss | TSS: List of TSS subcommands. |

## Reference documentation
- [pycisTopic GitHub Repository](./references/github_com_aertslab_pycisTopic.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_pycistopic_overview.md)