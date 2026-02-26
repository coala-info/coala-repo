---
name: dartunifrac-gpu
description: DartUniFrac-GPU provides ultra-fast unweighted and weighted UniFrac distance estimation for large-scale microbiome datasets using GPU acceleration. Use when user asks to calculate UniFrac distances, estimate diversity metrics for millions of samples, or perform rapid Principle Coordinate Analysis.
homepage: https://github.com/jianshu93/DartUniFrac
---


# dartunifrac-gpu

## Overview

DartUniFrac-GPU is a specialized tool for ultra-fast UniFrac distance estimation. While traditional methods like striped UniFrac scale poorly with sample size, DartUniFrac utilizes optimal balanced parenthesis and Weighted MinHash sketching to handle millions of samples. This skill provides the necessary command-line patterns to execute these calculations on NVIDIA GPU hardware, allowing for rapid Principle Coordinate Analysis (PCoA) and diversity metrics in large-scale microbiome studies.

## Installation

The GPU-enabled version is available via Bioconda for Linux systems with NVIDIA drivers (version 12.6 or later recommended).

```bash
conda install -c bioconda -c conda-forge dartunifrac-gpu
```

## Common CLI Patterns

The GPU-accelerated binary is typically named `dartunifrac-cuda`.

### Unweighted UniFrac
To calculate unweighted UniFrac distances using the DartMinHash method:
```bash
dartunifrac-cuda -t phylogeny.tre -b table.biom -m dmh -s 3072 -o unweighted_output.tsv
```

### Weighted UniFrac
To calculate weighted UniFrac, add the `--weighted` flag:
```bash
dartunifrac-cuda -t phylogeny.tre -b table.biom --weighted -m dmh -s 3072 -o weighted_output.tsv
```

## Parameter Optimization and Best Practices

### Method Selection (`-m`)
*   **dmh (DartMinHash)**: The default and preferred method for sparse, real-world microbiome data. It is faster and more accurate for typical sparse feature tables.
*   **ers (Efficient Rejection Sampling)**: Use this method for dense datasets, such as synthetic communities or low-diversity samples where most taxa are present across samples.

### Sketch Size (`-s`)
*   The `-s` parameter determines the number of hashes used for the approximation.
*   **Standard**: `3072` provides a good balance between speed and accuracy.
*   **High Precision**: Increase this value (e.g., `4096` or higher) if you require more precise distance estimates, though this will increase memory usage and computation time.

### Input Requirements
*   **Tree File (`-t`)**: Must be in Newick format.
*   **Feature Table (`-b`)**: Must be in BIOM format.

## Troubleshooting GPU Issues

*   **Driver Version**: The Bioconda package is generally compiled against CUDA 13.0+. Ensure your NVIDIA driver is up to date (`nvcc --version`).
*   **Legacy Hardware**: If using older drivers (pre-12.4), you may need to download the pre-built binary directly from the GitHub releases page rather than using the Conda package.
*   **Memory**: While sketching is memory-efficient, extremely large trees or very high sketch sizes may still hit VRAM limits on smaller GPUs.

## Reference documentation
- [DartUniFrac-GPU Overview](./references/anaconda_org_channels_bioconda_packages_dartunifrac-gpu_overview.md)
- [DartUniFrac GitHub Documentation](./references/github_com_jianshu93_DartUniFrac.md)