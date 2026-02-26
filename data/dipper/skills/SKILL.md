---
name: dipper
description: DIPPER is a high-throughput phylogenetic tool designed for large-scale tree reconstruction using distance-based methods and GPU acceleration. Use when user asks to construct de-novo phylogenies, perform phylogenetic placement, or build trees from large sequence datasets using divide-and-conquer strategies.
homepage: https://github.com/TurakhiaLab/DIPPER
---


# dipper

## Overview
DIPPER (DIstance-based Phylogenetic PlacER) is designed for high-throughput phylogenetics with a minimal memory footprint. It implements a suite of innovations including a divide-and-conquer strategy, a specialized placement algorithm, and an on-the-fly distance calculator. While it defaults to standard Neighbor-Joining (NJ) for smaller datasets, its true strength lies in its ability to scale to millions of sequences using GPU-accelerated placement and divide-and-conquer techniques.

## Installation and Setup
DIPPER is available via Bioconda and Docker. For local environments, ensure you choose the correct executable based on your hardware:
- **GPU Version**: `dipper` (Supports NVIDIA/CUDA and AMD/HIP)
- **CPU Version**: `dipper_cpu`

To install via Conda:
```bash
conda install bioconda::dipper
# Or for CPU-only
conda install bioconda::dipper_cpu
```

## Common CLI Patterns

### De-novo Phylogeny Construction
DIPPER automatically selects the best algorithm based on the number of taxa, but you can force specific modes using the `-m` flag.

**From Unaligned Sequences (FASTA)**
```bash
dipper -i r -o t -I input.fa -O tree.nwk
```

**From Aligned Sequences (FASTA) using Jukes-Cantor (JC) Model**
```bash
dipper -i m -o t -d 2 -I aligned.fa -O tree.nwk
```

**From Distance Matrix (PHYLIP)**
```bash
dipper -i d -o t -I matrix.phy -O tree.nwk
```

### Advanced Reconstruction Modes
Use the `-m` flag to override the default heuristic selection:
- **Placement Technique (`-m 1`)**: Recommended for datasets between 30,000 and 1,000,000 taxa.
- **Divide-and-Conquer (`-m 3`)**: Recommended for datasets exceeding 1,000,000 taxa.

Example forcing Divide-and-Conquer:
```bash
dipper -i r -o t -m 3 -I large_dataset.fa -O tree.nwk
```

### Working with MSA Subsets
If you only want to compute distances based on a specific range of columns in a Multiple Sequence Alignment (MSA), use the `-r` flag:
```bash
# Compute distances using columns 100 to 500
dipper -i m -o t -r 100,500 -I aligned.fa -O tree.nwk
```

## Expert Tips and Best Practices
- **Algorithm Selection**: DIPPER's default thresholds are <30k (NJ), 30k-1M (Placement), and >1M (Divide-and-Conquer). If your dataset is near a threshold and accuracy is more critical than speed, consider forcing the lower-tier algorithm.
- **Branch Lengths**: DIPPER is designed to minimize branch length underestimation for non-additive distance matrices. If you encounter issues with branch length accuracy, ensure you are using the latest version (v0.1.3+) which includes a "strict mode" to eliminate underestimation.
- **Hardware Optimization**: Always prefer the GPU version (`dipper`) for datasets over 100,000 sequences to take advantage of the parallel distance calculator.
- **Memory Management**: DIPPER is built for a minimal memory footprint; however, when running on GPUs, ensure your VRAM can accommodate the distance calculations for your specific taxa count.

## Reference documentation
- [DIPPER GitHub Repository](./references/github_com_TurakhiaLab_DIPPER.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_dipper_overview.md)