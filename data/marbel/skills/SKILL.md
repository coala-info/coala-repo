---
name: marbel
description: Marbel generates synthetic metatranscriptomic datasets by modeling functional redundancies and realistic read count matrices from a library of bacterial transcriptomes. Use when user asks to simulate metatranscriptomic data, evaluate assembly pipelines, or test differential expression detection with varying taxonomic and functional diversity.
homepage: https://github.com/jlab/marbel
---


# marbel

## Overview

Marbel (MetAtranscriptomic Reference Builder Evaluation Library) is a specialized simulation tool that generates synthetic metatranscriptomic datasets based on a library of over 600 bacterial transcriptomes. Unlike simple read simulators, Marbel models functional redundancies by using orthogroups as the basis for gene selection and employs DESeq2-based modeling to create realistic read count matrices. It is particularly valuable for testing how assemblers handle overlapping genomic regions and for evaluating the sensitivity of metatranscriptomic pipelines to varying levels of taxonomic and functional diversity.

## Installation

The recommended way to install marbel is via Conda:

```bash
conda install bioconda::marbel
```

## Core CLI Patterns

### Basic Simulation
Run a simulation with default parameters (20 species, 1000 orthogroups, 10 vs 10 samples):
```bash
marbel
```

### Customizing Community Composition
Specify the number of species, functional groups, and sample sizes for two experimental groups:
```bash
marbel --n-species 15 --n-orthogroups 2000 --n-samples 5 5 --outdir my_simulation
```

### Controlling Sequence Identity and Phylogeny
To simulate more closely related or highly conserved functional groups, use identity and distance filters:
```bash
marbel --min-identity 0.95 --max-phylo-distance genus
```

### Modeling Differential Expression
Adjust the ratio of up-regulated and down-regulated genes to test DE detection pipelines:
```bash
marbel --dge-ratio 0.1 0.1
```

### Sequencing Parameters
Match the simulation to specific hardware using error models and library sizes:
```bash
marbel --error-model NovaSeq --library-size 1000000 --read-length 150
```
*Note: `--read-length` is only available when using `basic` or `perfect` error models.*

## Expert Tips and Best Practices

- **Performance:** Large simulations can be computationally intensive and may take days to complete. Always utilize the `--threads` parameter (default is 10) and consider running on a cluster for high-coverage datasets.
- **Reproducibility:** Always specify a `--seed [INTEGER]` when generating datasets for publications or benchmarking to ensure the random sampling of species and orthogroups is reproducible.
- **Assembler Benchmarking:** Marbel calculates "maximum blocks" and "overlap blocks." Use the `--min-overlap` parameter (default 16) to define the threshold for genomic regions that assemblers might merge, which is critical for evaluating assembly continuity.
- **Sparsity Control:** Use `--min-sparsity` to simulate the "zero-inflation" often seen in real-world metatranscriptomic data, which helps in testing the robustness of normalization methods.
- **Orthology Levels:** The `--group-orthology-level` parameter (very_low to very_high) significantly impacts runtime. Use "high" or "very_high" only when necessary and with maximum available threads.

## Reference documentation

- [Marbel GitHub Repository](./references/github_com_jlab_marbel.md)
- [Marbel Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_marbel_overview.md)