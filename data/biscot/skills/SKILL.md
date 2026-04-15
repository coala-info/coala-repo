---
name: biscot
description: BiSCoT improves hybrid genome assemblies by correcting errors and merging sequences in Bionano optical mapping scaffolds. Use when user asks to refine hybrid assemblies, resolve negative gaps, or merge contigs using enzymatic labeling sites and sequence similarity.
homepage: https://github.com/institut-de-genomique/biscot
metadata:
  docker_image: "quay.io/biocontainers/biscot:2.3.3--pyh7cba7a3_0"
---

# biscot

## Overview

BiSCoT (Bionano SCaffolding Correction Tool) is a specialized utility designed to post-process and improve hybrid assemblies generated through Bionano optical mapping. While standard scaffolders often create "negative gaps" when contig maps overlap or discard contigs that appear nested within others, BiSCoT identifies shared enzymatic labeling sites to merge these sequences accurately. It can also perform sequence-based merging using BLAT for more aggressive contiguity improvements.

## Installation and Dependencies

BiSCoT is available via Bioconda and PyPI. It requires Python 3 and Biopython.

```bash
# Installation via Conda
conda install bioconda::biscot

# Installation via Pip
pip install biscot
```

**Note**: If you intend to use the `--aggressive` mode, the `BLAT` aligner must be installed and available in your system PATH.

## Core Command Line Usage

A standard execution requires the reference CMAP, enzyme-specific CMAP and XMAP files, the key file, and the original contigs FASTA.

```bash
biscot.py --cmap-ref reference.cmap \
  --cmap-1 enzyme1.cmap \
  --cmap-2 enzyme2.cmap \
  --xmap-1 enzyme1.xmap \
  --xmap-2 enzyme2.xmap \
  --key key.txt \
  --contigs contigs.fasta \
  --output biscot_results
```

### Required Arguments
- `--cmap-ref`: Positions of enzymatic labeling sites on the reference genome.
- `--cmap-1` / `--cmap-2`: Labeling sites on the contigs for each enzyme (e.g., DLE1 and BspQI).
- `--xmap-1` / `--xmap-2`: Alignments of contig labels on the anchor for each enzyme.
- `--key`: Mapping file linking contig map IDs to FASTA header names.
- `--contigs`: The FASTA file used for the initial scaffolding.

## Expert Tips and Best Practices

### Improving Accuracy with Combined Maps
For the most reliable results, it is highly recommended to provide the combined enzyme XMAP file.
- Use `--xmap-2enz [FILE]`: Provide the final XMAP containing mappings for both enzymes (usually named `*Export.xmap_sorted.xmap`).
- Use `--only-confirmed-pos`: When this flag is used alongside `--xmap-2enz`, BiSCoT only retains mappings validated by both enzymes, preventing contigs from being placed multiple times in the final assembly.

### Closing Gaps with Sequence Similarity
If label-based merging is insufficient to reach desired contiguity:
- Use `--aggressive`: This enables a second phase where BiSCoT uses BLAT to find sequence similarities between contigs that share label mappings but lack a direct label-based merge point.

### Output Analysis
BiSCoT generates two primary files in the output directory:
1. `scaffolds.fasta`: The improved genomic sequences.
2. `scaffolds.agp`: A standard AGP file describing the modifications, gaps, and merges performed on the input contigs. Use this to audit the scaffolding process.

## Reference documentation
- [BiSCoT GitHub Repository](./references/github_com_institut-de-genomique_biscot.md)
- [BiSCoT Wiki](./references/github_com_institut-de-genomique_biscot_wiki.md)
- [Bioconda BiSCoT Overview](./references/anaconda_org_channels_bioconda_packages_biscot_overview.md)