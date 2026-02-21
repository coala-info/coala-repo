---
name: stream
description: STREAM (Single-cell Trajectories Reconstruction, Exploration And Mapping) is an analytical pipeline designed to disentangle complex branching structures in single-cell omics data.
homepage: https://github.com/pinellolab/stream
---

# stream

## Overview
STREAM (Single-cell Trajectories Reconstruction, Exploration And Mapping) is an analytical pipeline designed to disentangle complex branching structures in single-cell omics data. Built on the `anndata` framework, it provides a suite of tools for quality control, dimensionality reduction, and trajectory inference. It is particularly effective for researchers needing to visualize developmental pathways in 2D or 3D and for those performing "mapping" experiments where query cells are compared against a known developmental backbone.

## Installation and Environment Setup
STREAM is best managed via Conda to handle its specific dependencies (notably Python 3.7 for version 1.0+).

**For scRNA-seq analysis:**
```bash
conda create -n env_stream python=3.7 stream=1.0 jupyter
conda activate env_stream
```

**For scATAC-seq analysis:**
```bash
conda create -n env_stream python=3.7 stream=1.0 stream_atac jupyter
conda activate env_stream
```

## Native Python Usage
Since version 1.0, the dedicated command-line interface (CLI) has been deprecated in favor of a Python API, typically used within Jupyter Notebooks.

### Core Workflow Pattern
```python
import stream as st

# 1. Initialize and Preprocess
# STREAM uses anndata objects (adata)
st.add_qc(adata)
st.filter_cells(adata, min_genes=200)
st.filter_genes(adata, min_cells=3)

# 2. Dimension Reduction
st.select_variable_genes(adata)
st.dimension_reduction(adata, method='se') # Spectral Embedding

# 3. Trajectory Inference
st.seed_elastic_principal_graph(adata)
st.learn_graph(adata)

# 4. Visualization
st.plot_dimension_reduction(adata, color_by='label')
st.plot_stream_sc(adata, color_by='label') # Interactive plotly visualization
```

## Docker CLI Patterns
For users who prefer a containerized environment without local installation, use the following Docker patterns to launch a STREAM-ready Jupyter instance.

**Pull the image:**
```bash
docker pull pinellolab/stream:1.0
```

**Run the container with local data mapping:**
```bash
docker run --entrypoint /bin/bash \
  -v /absolute/path/to/your/data:/data \
  -w /data \
  -p 8888:8888 \
  -it pinellolab/stream:1.0
```

**Launch the notebook inside the container:**
```bash
jupyter notebook --ip 0.0.0.0 --port 8888 --no-browser --allow-root
```

## Expert Tips and Best Practices
- **Feature Selection for ATAC-seq:** When working with epigenomic data, STREAM supports multiple feature types including peaks, k-mers, and motifs. Ensure `stream_atac` is installed to access these specialized modules.
- **Interactive Exploration:** Use the `plotly` integration (available in v1.0+) for interactive plots. This is essential for identifying specific cell clusters at complex branching junctions that might be obscured in static 2D plots.
- **Mapping Procedure:** Use the `st.map_new_data` function to project a query dataset onto a pre-calculated trajectory. This is highly efficient for validating trajectories across different experimental batches or conditions.
- **Memory Management:** Since STREAM relies on `anndata`, ensure your environment has sufficient RAM for the size of your sparse matrices, especially when performing the `learn_graph` step on large datasets.

## Reference documentation
- [STREAM GitHub Repository](./references/github_com_pinellolab_STREAM.md)
- [Bioconda STREAM Package Overview](./references/anaconda_org_channels_bioconda_packages_stream_overview.md)