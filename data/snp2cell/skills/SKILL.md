---
name: snp2cell
description: snp2cell is a specialized bioinformatics tool designed to bridge the gap between genetic association studies (GWAS) and functional single-cell biology.
homepage: https://github.com/Teichlab/snp2cell
---

# snp2cell

## Overview

snp2cell is a specialized bioinformatics tool designed to bridge the gap between genetic association studies (GWAS) and functional single-cell biology. It identifies gene regulatory programs linked to specific traits on a per-cell-type basis. The tool functions by mapping GWAS scores onto a gene regulatory network and using network propagation to overlap these with single-cell data. It is particularly effective for researchers looking to move from "variant-to-gene" to "variant-to-network" in specific cellular contexts.

## Installation and Environment

The package requires Python >= 3.5 and < 3.12.

```bash
# Recommended installation via Conda/Mamba
mamba create -n snp2cell "python<3.12"
mamba activate snp2cell
conda install bioconda::snp2cell

# Alternative installation from source
git clone https://github.com/Teichlab/snp2cell.git
cd snp2cell
pip install .
```

## Command Line Interface (CLI)

While the Python API offers the most flexibility, the CLI provides quick access to core functionality.

```bash
# View all available commands and options
snp2cell --help

# Enable shell autocompletion (e.g., for bash)
snp2cell --install-completion bash
source ~/.bashrc
```

## Python API Workflow

The primary way to use snp2cell is through its Python module, which integrates with the `scanpy` and `networkx` ecosystems.

### 1. Initialization and Data Loading
Initialize the `SNP2CELL` class and load your GWAS/fGWAS scores.

```python
import snp2cell

# Initialize the main class
s2c = snp2cell.SNP2CELL(
    gex_data=adata,        # Scanpy AnnData object
    network=grn_graph,     # NetworkX graph object
    de_groups=de_results   # Differential expression groups
)

# Load fGWAS scores
s2c.load_fgwas_scores(
    scores_path="path/to/scores.txt",
    rbf_table_path="path/to/rbf.table", # Optional
    use_log_scale=True
)
```

### 2. Network Propagation and Analysis
The tool uses network propagation to integrate scores across the regulatory network.

*   **Parallelization**: Use the `loop_parallel` parameter in methods to speed up computations across multiple CPUs.
*   **Significance**: Significance is evaluated through random permutations of scores.
*   **Transformations**: The tool supports `asinh` and `log modulus` transformations for handling score distributions.

### 3. Visualization
snp2cell provides several specialized plotting methods to inspect trait-associated regulation.

```python
# Generate a summary plot of trait-cell type associations
s2c.plot_group_summary()

# Create a heatmap of integrated scores across cell types
s2c.plot_group_heatmap(robust=True) # Uses robust z-score by default

# Visualize the regulatory network for a specific trait/cell type
s2c.plot_network(group="CellType_A", trait="Height")
```

## Expert Tips and Best Practices

*   **Plotting Defaults**: The tool defaults to `robust zscore` for plotting. This is generally preferred to minimize the impact of outliers in network scores.
*   **Memory Management**: Ensure your system has enough RAM to hold the single-cell AnnData and the NetworkX graph simultaneously. For large datasets, subset the AnnData to highly variable genes or specific clusters of interest before initialization.
*   **Debugging**: If propagation results seem unexpected, enable the `debug` flag in `loop_parallel` or set the logging level to `DEBUG` to trace the score integration process.
*   **Output**: The final output is a `networkx` graph object. You can export this to standard formats (like GraphML) for further inspection in tools like Cytoscape.

## Reference documentation

- [snp2cell Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_snp2cell_overview.md)
- [snp2cell GitHub Repository](./references/github_com_Teichlab_snp2cell.md)