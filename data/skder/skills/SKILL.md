---
name: skder
description: skder (and its companion CiDDER) provides an efficient way to select representative microbial genomes from large input sets.
homepage: https://github.com/raufs/skDER
---

# skder

## Overview

skder (and its companion CiDDER) provides an efficient way to select representative microbial genomes from large input sets. Unlike traditional tools that use a two-step "divide-and-conquer" approach with sketches, skder leverages the speed of `skani` to perform accurate Average Nucleotide Identity (ANI) and Aligned Fraction (AF) estimates in a single round. It selects representatives by balancing assembly quality (favoring higher N50) and "connectedness" (favoring genomes that are similar to many others).

## Installation and Setup

The recommended way to install skder is via Conda/Mamba using the bioconda channel.

```bash
# Create environment and install
conda create -n skder_env -c conda-forge -c bioconda skder
conda activate skder_env

# For Apple Silicon (M1/M2/M3) users
CONDA_SUBDIR=osx-64 conda create -n skder_env -c conda-forge -c bioconda skder
```

To enable Mobile Genetic Element (MGE) pruning (removing MGEs before dereplication), install additional dependencies:
```bash
conda install -c conda-forge -c bioconda genomad=1.8.0 phispy "keras>=2.7,<3.0" "tensorflow>=2.7,<2.16"
```

## Common CLI Patterns

### Standard Dereplication
Use the greedy algorithm for most datasets under 5,000 genomes.
```bash
skder -i /path/to/genomes/ -o output_dir/ -d greedy -c 8
```

### Large-Scale Dereplication (>10,000 genomes)
For massive datasets (e.g., 20k+ Staphylococcus genomes), use the `low_mem_greedy` mode to minimize RAM usage. This mode prioritizes N50 and uses an iterative search approach.
```bash
skder -t TaxonName -d low_mem_greedy -c 20 -o output_dir/ -auto
```

### MGE-Aware Dereplication
If your analysis is sensitive to MGEs (which can inflate ANI/AF), use geNomad or PhiSpy to filter them out during the assessment.
```bash
skder -i /path/to/genomes/ -o output_dir/ --mge_filter genomad --genomad_db /path/to/genomad_db/
```

## Expert Tips and Best Practices

*   **Version Check**: Ensure you are using version 1.0.7 or greater to avoid critical bugs present in earlier releases.
*   **Memory Management**: Standard dereplication is memory-efficient for <5,000 genomes. Beyond this, memory requirements scale significantly unless using the `low_mem_greedy` flag.
*   **Representative Quality**: Note that `low_mem_greedy` is faster but may select slightly lower-quality representatives compared to the standard greedy approach because it does not fully account for "centrality" in the connectivity graph.
*   **Disk Space**: When dereplicating thousands of genomes, ensure you have sufficient disk space, as the tool may generate intermediate files and copies of representative genomes.
*   **ANI Cutoffs**: By default, skder uses a 90% ANI cutoff (via skani). You can adjust this based on your specific taxonomic resolution needs.

## Reference documentation
- [skDER GitHub Repository](./references/github_com_raufs_skDER.md)
- [skDER Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_skder_overview.md)
- [skDER Wiki](./references/github_com_raufs_skDER_wiki.md)