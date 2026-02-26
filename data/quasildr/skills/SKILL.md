---
name: quasildr
description: quasildr is a toolkit for single-cell data analysis that provides scalable nonlinear dimensionality reduction and density ridge estimation for trajectory inference. Use when user asks to create interpretable low-dimensional representations, identify density ridges, or perform trajectory inference on high-dimensional biological data.
homepage: https://github.com/jzthree/quasildr
---


# quasildr

## Overview
quasildr is a specialized toolkit for single-cell data analysis that balances the interpretability of linear methods with the representational power of nonlinear methods. It is primarily used for two tasks:
1. **GraphDR**: A scalable, nonlinear representation method that preserves the orientation of the input space (e.g., PCA or gene space), allowing for direct comparison across datasets.
2. **StructDR**: A method for identifying 0, 1, or 2-dimensional density ridges, which is essential for clustering, trajectory inference, and surface estimation with associated confidence sets.

## Installation
Install via bioconda or pip:
```bash
conda install -c bioconda quasildr
# OR
pip install quasildr
```

## Command-Line Usage

### GraphDR (Visualization and Representation)
Use `run_graphdr.py` to process high-dimensional data. It includes built-in preprocessing options.

**Standard Pattern:**
```bash
python run_graphdr.py input_data.gz --pca --log --transpose --scale --max_dim 50 --reg 500 --no_rotation --plot
```

**Key Arguments:**
- `--reg`: Regularization parameter. Controls global shrinkage toward neighbors. Higher values increase nonlinear "clumping."
- `--no_rotation`: Prevents rotation of the output. Essential if you want the output dimensions to remain interpretable relative to the input (e.g., keeping PC1 as the primary axis).
- `--refine_iter`: Number of refinement iterations (default is often 4). Increase for smoother embeddings on complex topologies.
- `--anno_file` / `--anno_column`: Used to color the resulting plot by metadata (e.g., ClusterName).

### StructDR (Trajectory Extraction)
Use `run_structdr.py` to identify trajectories from GraphDR or PCA coordinates.

**Standard Pattern:**
```bash
python run_structdr.py --input graphdr_output.gz --bw 0.1 --automatic_bw 0 --output trajectory_results.gz
```

**Key Arguments:**
- `--bw`: Bandwidth for kernel density estimation. This is the most critical parameter for ridge estimation.
- `--automatic_bw`: Set to 1 to let the tool estimate bandwidth, though manual tuning is often required for biological accuracy.

## Expert Tips and Best Practices

### Interpretable Embeddings
To maintain the meaning of your principal components while gaining nonlinear separation, always use `no_rotation=True`. This allows you to say "Dimension 1 of the GraphDR embedding is still primarily driven by the genes in PC1."

### Handling Large Datasets
GraphDR is highly efficient. It can process over a million cells in minutes on standard CPUs. If memory is an issue, ensure you are providing a PCA-transformed input (using the `--pca` flag) rather than a raw gene-cell matrix.

### Custom Graphs
For complex experimental designs (e.g., multiple batches or time-series), you can construct a custom adjacency graph and provide it to GraphDR. This allows the embedding to be "aware" of batch effects or temporal constraints.

### Trajectory Uncertainty
Unlike many trajectory tools, StructDR (via the `Scms` class in Python) can estimate confidence sets. If a trajectory appears "shaky" or thin in certain regions, it may indicate low cell density or high noise in that developmental transition.

## Reference documentation
- [quasildr GitHub Repository](./references/github_com_jzhoulab_quasildr.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_quasildr_overview.md)