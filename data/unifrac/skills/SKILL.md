---
name: unifrac
description: UniFrac is a specialized tool designed to compare microbiome samples based on their evolutionary history.
homepage: https://github.com/biocore/unifrac
---

# unifrac

## Overview

UniFrac is a specialized tool designed to compare microbiome samples based on their evolutionary history. By calculating the amount of overlapping branch length between samples on a phylogenetic tree, it provides a distance metric that reflects biological similarity. This implementation uses the Strided State UniFrac algorithm, which is significantly faster and more memory-efficient than traditional methods. It supports both a standalone command-line interface (`ssu` and `faithpd`) and a Python API, and it serves as the underlying engine for phylogenetic diversity commands in QIIME 2.

## Installation and Setup

The tool is most easily managed via Conda or Pip:

```bash
# Via Bioconda
conda install -c conda-forge -c bioconda unifrac

# Via Pip
pip install unifrac
```

## Command Line Interface (CLI)

The primary executable for UniFrac distances is `ssu`, and for Faith's PD, it is `faithpd`.

### Calculating UniFrac Distances
To calculate beta diversity distances, you must provide a BIOM-format table (V2.1.0) and a Newick-formatted phylogenetic tree.

```bash
ssu -i table.biom -t tree.nwk -m unweighted -o output.dm
```

**Common Metrics (`-m`):**
- `unweighted`: Presence/absence of taxa.
- `weighted_normalized`: Abundance-weighted, normalized by total branch length.
- `weighted_unnormalized`: Abundance-weighted without normalization.
- `generalized`: A flexible metric (Chen et al. 2012) that accounts for both abundant and rare lineages.

### Calculating Faith's Phylogenetic Diversity
To calculate alpha diversity (within-sample diversity):

```bash
faithpd -i table.biom -t tree.nwk -o faith_pd.txt
```

## Performance Optimization

UniFrac is highly optimized for modern hardware. Use environment variables to control resource allocation.

### Multi-core CPU Support
By default, UniFrac uses all available cores via OpenMP. To restrict usage (e.g., on a shared cluster):
```bash
export OMP_NUM_THREADS=4
```

### GPU Acceleration (Linux Only)
If a compatible GPU is detected on a Linux system, UniFrac will attempt to offload calculations to it automatically.
- **Force CPU-only:** `export UNIFRAC_USE_GPU=N`
- **Debug GPU usage:** `export UNIFRAC_GPU_INFO=Y`
- **Select specific GPU:** `export ACC_DEVICE_NUM=1` (where 1 is the device index)

## Python API Usage

The `unifrac` package allows for direct integration into Python workflows. The functions typically expect file paths to the BIOM table and Newick tree.

```python
import unifrac

# Calculate unweighted UniFrac
dm = unifrac.unweighted("path/to/table.biom", "path/to/tree.nwk")

# Calculate Faith's PD
pd_series = unifrac.faith_pd("path/to/table.biom", "path/to/tree.nwk")
```

## Expert Tips

- **Input Formats:** Ensure your BIOM table is version 2.1.0 (HDF5). If you have a TSV or older BIOM file, convert it using the `biom-format` package before running `ssu`.
- **Tree Rooting:** UniFrac requires a rooted phylogenetic tree. If your tree is unrooted, use a tool like `qiime phylogeny midpoint-root` or an equivalent Newick parser to root it.
- **Memory Management:** For extremely large datasets, the Strided State algorithm is preferred over "Fast UniFrac" implementations found in older software, as it avoids the creation of massive intermediate matrices.
- **Precision:** The tool supports both double and single precision (fp32). If memory is a bottleneck and extreme precision isn't required, look for `_fp32` variants in the Python API.

## Reference documentation
- [UniFrac GitHub Repository](./references/github_com_biocore_unifrac.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_unifrac_overview.md)