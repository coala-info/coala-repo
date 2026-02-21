---
name: tmhg
description: tMHG-Finder is a bioinformatics tool designed to categorize genomic sequences into homologous groups based on evolutionary relationships.
homepage: https://github.com/yongze-yin/tMHG-Finder/
---

# tmhg

## Overview

tMHG-Finder is a bioinformatics tool designed to categorize genomic sequences into homologous groups based on evolutionary relationships. It utilizes a guide tree—either auto-generated via Mash distances or provided by the user—to determine the order of partitioning. This approach allows the tool to scale effectively for large bacterial datasets and provide intermediate MHGs for subsets of input genomes.

## Installation and Environment

It is highly recommended to use a dedicated Conda environment to manage the various non-python dependencies (BEDtools, BLAST, MAFFT, and Mash).

```bash
conda create --name tmhg bioconda::tmhg
conda activate tmhg
```

## Common CLI Patterns

### Initial MHG Discovery
The `find` command is the primary entry point for partitioning a set of genomes.

```bash
# Basic discovery with default settings
tmhgf find -g path/to/genomes/ -o mhg_results/ -tg temp_workdir/

# High-performance execution with custom thresholds
tmhgf find -g path/to/genomes/ \
    -t 16 \
    -a 100 \
    -o mhg_results/ \
    -tg temp_workdir/
```

### Incremental Analysis
The `add` command allows for adding new genomes to a previous run without recomputing existing internal nodes.

```bash
tmhgf add -g path/to/new_genomes/ \
    -og path/to/old_temp_dir/ \
    -om path/to/old_mhg_output/ \
    -o new_combined_output/ \
    -tg new_temp_dir/
```

## Expert Tips and Best Practices

- **Alignment Thresholds**: The `-a` (alignment length threshold) defaults to 60bp. Setting this significantly lower can lead to an explosion of short MHGs, which increases memory usage and drastically slows down the alignment graph traversal.
- **Guide Tree Control**: By default, the tool estimates a tree using Mash. If you have a high-quality phylogenetic tree already, provide it via `--customized_tree_path` to ensure the partitioning follows your preferred evolutionary model.
- **Tree Rerooting**: Use the `-r True` flag to reroot the guide tree. This minimizes the tree height, which can optimize the MHG output order and processing efficiency.
- **Temporary Data**: The directory specified by `-tg` (or `--temp_dir`) is critical for incremental runs. Always preserve this directory if you plan to add more genomes to the dataset later using the `add` command.
- **Resource Management**: BLASTn operations are the most computationally expensive part of the workflow. Ensure the `-t` (threads) parameter matches your available CPU cores to maximize throughput during the pairwise local alignment phase.

## Reference documentation
- [tMHG-Finder GitHub Repository](./references/github_com_yongze-yin_tMHG-Finder.md)
- [tMHG-Finder Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_tmhg_overview.md)