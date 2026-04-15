---
name: unifrac
description: UniFrac calculates phylogenetic diversity metrics to compare microbial communities by accounting for evolutionary relationships between taxa. Use when user asks to calculate beta-diversity distance matrices, compute Faith's Phylogenetic Diversity, or perform high-performance phylogenetic analysis on BIOM tables and trees.
homepage: https://github.com/biocore/unifrac
metadata:
  docker_image: "quay.io/biocontainers/unifrac:1.5.1--py39hff726c5_0"
---

# unifrac

## Overview

UniFrac is the industry-standard tool for calculating phylogenetic diversity metrics, essential for comparing microbial communities. This skill leverages the "Strided State" implementation, which provides significant speed and memory improvements over traditional methods. It is primarily used to generate distance matrices (beta-diversity) that account for the evolutionary relationships between taxa, as well as Faith's Phylogenetic Diversity (alpha-diversity).

## Installation and Setup

UniFrac is available via multiple package managers. For high-performance execution, ensure your environment supports OpenMP (CPU) or OpenACC (GPU).

```bash
# Via Bioconda (Recommended)
conda create --name unifrac -c conda-forge -c bioconda unifrac

# Via Pip
pip install unifrac iow
```

## Command Line Interface (ssu)

The primary CLI tool is `ssu`. It requires a BIOM table (V2.1.0) and a rooted Newick tree.

### Basic Beta-Diversity Calculation
To calculate a standard distance matrix:
```bash
ssu -i table.biom -t tree.nwk -m [metric] -o output.dm
```

**Supported Metrics (`-m`):**
- `unweighted`: Presence/absence phylogenetic diversity.
- `weighted_normalized`: Abundance-weighted diversity (normalized).
- `weighted_unnormalized`: Raw abundance-weighted diversity.
- `generalized`: Adjusts the weight of abundant vs. rare lineages (requires `-a` parameter).
- `va`: Variance Adjusted UniFrac.

### Performance Optimization
UniFrac automatically attempts to use all available CPU cores via OpenMP and available GPUs on Linux.

- **Restrict CPU Cores:** `export OMP_NUM_THREADS=4`
- **Disable GPU:** `export UNIFRAC_USE_GPU=N`
- **Select Specific GPU:** `export ACC_DEVICE_NUM=0`
- **Verify Execution Path:** `export UNIFRAC_GPU_INFO=Y` (Prints whether CPU or GPU is being used).

## Python API Usage

The `unifrac` Python module allows for direct integration into data science workflows. Note that the API typically expects file paths rather than in-memory objects for the largest datasets to maintain performance.

```python
import unifrac

# Calculate Unweighted UniFrac
dm = unifrac.unweighted(
    table_path="path/to/table.biom",
    tree_path="path/to/tree.nwk"
)

# Calculate Faith's PD (Alpha Diversity)
pd_series = unifrac.faith_pd(
    table_path="path/to/table.biom",
    tree_path="path/to/tree.nwk"
)
```

## Expert Tips and Best Practices

1. **Precision Selection:** For extremely large datasets where memory is a bottleneck, use the `_fp32` variants of functions (e.g., `unweighted_fp32`) to reduce memory footprint at the cost of some numerical precision.
2. **Rooted Trees:** Ensure your Newick tree is rooted. UniFrac calculations are phylogenetically dependent and will fail or produce incorrect results with unrooted trees.
3. **BIOM Format:** The standalone tool requires BIOM V2.1.0 (HDF5). If you have a classic JSON BIOM table, convert it using the `biom convert` tool before running `ssu`.
4. **QIIME 2 Integration:** If using UniFrac within QIIME 2, use `qiime diversity beta-phylogenetic` for UniFrac and `qiime diversity alpha-phylogenetic-alt` for the high-performance Faith's PD implementation.



## Subcommands

| Command | Description |
|---------|-------------|
| faithpd | Calculates Faith's Phylogenetic Diversity (PD) for each sample in a BIOM table using a provided phylogeny. |
| ssu | Compute UniFrac distances between samples based on phylogenetic relationships. |

## Reference documentation
- [UniFrac GitHub Repository](./references/github_com_biocore_unifrac_blob_master_README.md)
- [UniFrac Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_unifrac_overview.md)