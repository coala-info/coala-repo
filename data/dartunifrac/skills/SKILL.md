---
name: dartunifrac
description: DartUniFrac is a high-performance bioinformatics tool designed to calculate UniFrac distances at a scale that traditional algorithms cannot reach.
homepage: https://github.com/jianshu93/DartUniFrac
---

# dartunifrac

## Overview
DartUniFrac is a high-performance bioinformatics tool designed to calculate UniFrac distances at a scale that traditional algorithms cannot reach. By utilizing Weighted MinHash sketching and optimal balanced parenthesis for tree representation, it can process millions of samples efficiently. It is the preferred choice when standard tools like `striped_unifrac` become too slow for massive microbiome datasets.

## Installation and Setup
The tool is available via Conda and Homebrew. Choose the version based on your hardware:

- **CPU (Linux/macOS):** `conda install -c bioconda dartunifrac`
- **GPU (Linux, NVIDIA):** `conda install -c bioconda dartunifrac-gpu` (Requires NVIDIA driver >= 12.6)
- **macOS (Homebrew):** `brew install jianshu93/DartUniFrac/dartunifrac`

## Common CLI Patterns

### Unweighted UniFrac
Use the default settings for standard presence/absence phylogenetic distance:
```bash
dartunifrac -t phylogeny.tre -b table.biom -m dmh -s 3072 -o unweighted_dist.tsv
```

### Weighted UniFrac
Add the `--weighted` flag to account for the relative abundance of taxa:
```bash
dartunifrac -t phylogeny.tre -b table.biom --weighted -m dmh -s 3072 -o weighted_dist.tsv
```

### GPU Acceleration
If using the CUDA-enabled version, replace the binary name:
```bash
dartunifrac-cuda -t phylogeny.tre -b table.biom --weighted -m dmh -s 3072 -o weighted_dist.tsv
```

## Parameter Optimization and Best Practices

### Choosing the Sketching Method (`-m`)
- **`dmh` (DartMinHash):** Best for sparse data. This is the recommended method for almost all real-world microbiome studies where most taxa are absent in most samples.
- **`ers` (Efficient Rejection Sampling):** Best for dense data. Use this for synthetic communities or datasets where the feature matrix is not sparse.

### Sketch Size (`-s`)
- The default sketch size (e.g., 3072) provides a balance between speed and accuracy.
- Increase the sketch size if you require higher precision for closely related samples, though this will increase memory consumption and runtime.

### Input Requirements
- **Tree File (`-t`):** Must be in Newick format.
- **Table File (`-b`):** Must be in BIOM format.

## Expert Tips
- **Memory Efficiency:** DartUniFrac is significantly more memory-efficient than traditional methods. If you are running out of RAM on a large dataset with other tools, DartUniFrac is the primary alternative.
- **PCoA Integration:** The tool is designed to work alongside `fpcoa` for fast, in-memory Principal Coordinate Analysis using randomized SVD.
- **Driver Compatibility:** If using the GPU version on older Linux systems (NVIDIA drivers before 12.4), download the pre-built binary from the GitHub releases page rather than using the Conda package.

## Reference documentation
- [DartUniFrac GitHub Repository](./references/github_com_jianshu93_DartUniFrac.md)
- [DartUniFrac Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_dartunifrac_overview.md)