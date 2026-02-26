---
name: attotree
description: attotree rapidly constructs phylogenetic trees from genomic sequences using sketching to estimate genetic distances. Use when user asks to generate a phylogenetic tree from FASTA files, perform rapid genomic surveillance, or estimate genetic distances between large sets of genomes.
homepage: https://github.com/karel-brinda/attotree
---


# attotree

## Overview

`attotree` is a bioinformatics tool designed for the high-speed construction of phylogenetic trees directly from genomic sequences. It utilizes "sketching" (via Mash) to estimate genetic distances, significantly reducing computation time compared to traditional alignment-based methods. It is particularly effective for initial genomic surveillance, outbreak investigation, and large-scale comparative genomics where rapid results are prioritized.

## Installation

Install via Bioconda for the most reliable dependency management:

```bash
conda install -c bioconda attotree
```

## Common Workflows

### Basic Tree Generation
Generate a phylogenetic tree from a directory of FASTA files:

```bash
attotree *.fa > tree.nwk
```

### Using a List of Files
If you have a large number of genomes, use a file-of-filenames (fof) to avoid shell argument limits:

```bash
attotree -L list_of_genomes.txt -o output_tree.nwk
```

### Adjusting Tree Construction
By default, `attotree` uses Neighbor-Joining (NJ). You can switch to UPGMA if required by your analysis:

```bash
attotree -m upgma *.fasta -o upgma_tree.nwk
```

## Optimization and Parameters

- **Performance**: Use the `-t` flag to specify threads. It defaults to 10 or the number of available cores.
- **Sketching Sensitivity**:
    - `-k INT`: K-mer size (default: 21). Increase for more specificity in closely related strains.
    - `-s INT`: Sketch size (default: 10000). Increase for higher resolution at the cost of speed and memory.
- **Temporary Files**: Use `-d DIR` to specify a custom temporary directory, especially useful when working with large datasets on systems with limited `/tmp` space.
- **Debugging**: If a run fails, use `-D` to prevent the tool from deleting temporary files, allowing for inspection of the intermediate Mash sketches.

## Expert Tips

- **Mashtree Compatibility**: `attotree` is designed to be a drop-in, faster replacement for Mashtree. With default settings, the resulting tree topology should be identical.
- **Input Formats**: The tool natively supports FASTA and gzipped FASTA files.
- **Output**: The output is a standard Newick file, which can be visualized using tools like iTOL, FigTree, or the `ete3` Python library.

## Reference documentation

- [GitHub Repository and Documentation](./references/github_com_karel-brinda_attotree.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_attotree_overview.md)