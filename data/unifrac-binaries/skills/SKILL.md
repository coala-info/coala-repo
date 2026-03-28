---
name: unifrac-binaries
description: unifrac-binaries is a high-performance suite of tools for calculating phylogenetic diversity metrics and UniFrac distance matrices in microbiome research. Use when user asks to calculate UniFrac distances, compute Faith's Phylogenetic Diversity, or optimize performance using GPU acceleration and multi-threading.
homepage: https://github.com/biocore/unifrac-binaries
---

# unifrac-binaries

## Overview

unifrac-binaries is a specialized suite of tools for calculating phylogenetic diversity metrics, which are essential in microbiome research to compare microbial communities. The core of the package is the Strided State UniFrac algorithm, which is engineered for high performance, offering faster execution and lower memory overhead than previous implementations. 

Use this skill to:
- Calculate various UniFrac distances (Unweighted, Weighted, Generalized, etc.).
- Compute Faith's Phylogenetic Diversity (Faith's PD) using the optimized Stacked Faith method.
- Configure execution environments for multi-core CPUs or GPU acceleration.
- Troubleshoot performance and hardware compatibility issues.

## Core Executables

The package provides two primary standalone binaries:

1.  **`ssu`**: The main tool for calculating UniFrac distance matrices. It supports multiple variants including Unweighted, Weighted (both single and double precision), Generalized, Variance Adjusted, and meta UniFrac.
2.  **`faithpd`**: A dedicated tool for calculating Faith's Phylogenetic Diversity, utilizing the "Stacked Faith" method for improved efficiency over reference implementations.

## Performance Optimization

The tools are designed to leverage modern hardware automatically, but behavior can be tuned using environment variables.

### CPU and Multi-threading
The binaries use OpenMP for parallelization. By default, they attempt to use all available cores.
- **Limit CPU usage**: Set `export OMP_NUM_THREADS=n` to restrict the tool to a specific number of threads.
- **Compatibility Mode**: If running on older hardware or encountering instruction set errors (e.g., AVX/AVX2 issues), force the basic binary variant:
  `export UNIFRAC_MAX_CPU=basic`
- **Verify CPU Path**: To see which optimized binary variant is being executed at runtime:
  `export UNIFRAC_CPU_INFO=Y`

### GPU Acceleration
On Linux systems, the tools will automatically attempt to offload computations to an NVIDIA or AMD GPU if detected.
- **Disable GPU**: To force CPU-only execution:
  `export UNIFRAC_USE_GPU=N`
- **Disable GPU for post-processing**: To disable acceleration specifically for secondary tools like PERMANOVA:
  `export UNIFRAC_SKBIO_USE_GPU=N`
- **Select Device**: In multi-GPU environments, specify the target device index:
  `export ACC_DEVICE_NUM=0` (or the desired GPU ID)
- **Verify GPU Usage**: To confirm if the GPU code path is active:
  `export UNIFRAC_GPU_INFO=Y`

### Benchmarking and Debugging
- **Timing Data**: To separate data I/O time from actual computation time for performance analysis:
  `export UNIFRAC_TIMING_INFO=Y`

## Installation Patterns

The recommended installation method is via Bioconda to ensure all dependencies (like HDF5) are correctly linked:

```bash
conda create --name unifrac -c conda-forge -c bioconda unifrac-binaries
conda activate unifrac
```

For native compilation, the `Makefile` supports various targets including `api` (for the C shared library) and `main` (for the executables).



## Subcommands

| Command | Description |
|---------|-------------|
| faithpd | Calculates Faith's Phylogenetic Diversity for each sample in a BIOM table using a provided phylogeny. |
| ssu | Computes UniFrac distances between samples based on a phylogeny and a BIOM table. |

## Reference documentation
- [UniFrac Binaries README](./references/github_com_biocore_unifrac-binaries_blob_main_README.md)
- [Build and Installation Guide](./references/github_com_biocore_unifrac-binaries_blob_main_Makefile.md)