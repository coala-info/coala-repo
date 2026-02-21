---
name: unifrac-binaries
description: The `unifrac-binaries` package provides a high-performance C++ implementation of phylogenetic diversity metrics.
homepage: https://github.com/biocore/unifrac-binaries
---

# unifrac-binaries

## Overview

The `unifrac-binaries` package provides a high-performance C++ implementation of phylogenetic diversity metrics. It is centered around the Strided State UniFrac algorithm, which is designed to be faster and more memory-efficient than the original Fast UniFrac implementation. This tool is essential for microbiome researchers working with large-scale datasets who need to calculate distances between samples based on evolutionary history. It supports both CPU (via OpenMP) and GPU acceleration (NVIDIA/AMD) to handle massive feature tables and complex phylogenetic trees.

## Core Executables

The package provides two primary command-line utilities:
- `ssu`: Used for calculating various UniFrac distance metrics.
- `faithpd`: Used for calculating Faith's Phylogenetic Diversity.

## Common CLI Patterns

### Calculating UniFrac Distances
The basic syntax for `ssu` requires an input BIOM file, a Newick tree file, and an output path.

```bash
ssu -i input.biom -t tree.nwk -o output.dm -m [METHOD]
```

**Supported Methods (`-m`):**
- `unweighted`: Standard Unweighted UniFrac.
- `weighted_normalized`: Weighted UniFrac (normalized).
- `weighted_unnormalized`: Weighted UniFrac (unnormalized).
- `generalized`: Generalized UniFrac (requires `-a` for alpha parameter).
- `va`: Variance Adjusted UniFrac.

### Calculating Faith's PD
To calculate alpha diversity using Faith's PD:

```bash
faithpd -i input.biom -t tree.nwk -o faith_pd.txt
```

## Performance and Environment Tuning

### Multi-core Execution
The binaries use OpenMP for parallelization. By default, they use all available cores. To restrict usage (e.g., on a shared cluster):

```bash
export OMP_NUM_THREADS=4
```

### GPU Acceleration
On Linux systems, the tool automatically attempts to use a GPU if detected.
- **Disable GPU:** `export UNIFRAC_USE_GPU=N`
- **Select specific GPU:** `export ACC_DEVICE_NUM=0` (where 0 is the device index).
- **Verify GPU usage:** `export UNIFRAC_GPU_INFO=Y` (prints status to stdout at runtime).

### Hardware Compatibility
If running on older hardware that does not support modern vector instructions (AVX/AVX2), force a compatible binary:

```bash
export UNIFRAC_MAX_CPU=basic
```

### Debugging and Timing
To distinguish between data I/O time and actual computation time:

```bash
export UNIFRAC_TIMING_INFO=Y
```

## Expert Tips

- **Memory Efficiency:** Strided State UniFrac is significantly more efficient than Fast UniFrac. If you are hitting memory limits with other tools, `ssu` is the recommended alternative.
- **Precision:** The tool supports both double and single precision (fp32). If absolute precision is less critical than speed/memory, fp32 can be utilized in specific builds.
- **Input Validation:** Ensure your BIOM file and Newick tree have matching IDs. Discrepancies between the feature table and the tree tips are a common source of empty results or errors.
- **Normalization:** For Weighted UniFrac, `weighted_normalized` is generally preferred for most microbiome beta-diversity analyses to account for varying sequence depths.

## Reference documentation
- [UniFrac Binaries Main Documentation](./references/github_com_biocore_unifrac-binaries.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_unifrac-binaries_overview.md)