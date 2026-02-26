---
name: super_distance
description: This tool reconstructs species trees from multiple gene trees using distance-based summary statistics. Use when user asks to reconstruct a species tree from gene trees, handle paralogs in multi-labeled trees, or aggregate information from trees with non-overlapping leaf sets.
homepage: https://github.com/quadram-institute-bioscience/super_distance
---


# super_distance

## Overview

`super_distance` implements distance-based summary statistics methods to reconstruct a species tree from multiple gene trees. It is specifically designed to handle "mul-trees" (trees where a single species label appears multiple times due to paralogy) and can aggregate information from trees with non-overlapping leaf sets. It produces a set of candidate supertrees by applying various combinations of branch rescaling, clustering algorithms, and matrix merging options.

## Usage Instructions

### Basic Command Structure
The tool requires a list of gene trees in Newick format. While optional, providing a species list is strongly recommended for accurate mapping.

```bash
super_distance -s species_names.txt gene_tree1.tre gene_tree2.tre [gene_trees...]
```

### Handling Large Datasets
By default, the tool generates 36 different supertree estimates using various algorithm combinations. For datasets with many species or for a quick assessment, use the "fast" mode to limit output to the two most robust estimates (UPGMA estimates of nodal distances and normalized branch lengths).

```bash
super_distance -F -s species_names.txt *.tre -o output_supertree.tre
```

### Key Parameters
- `-s, --species <file>`: Path to a plain text file containing the master list of species names (one per line).
- `-o, --output <file>`: Specify the output filename for the resulting supertrees (defaults to stdout).
- `-e, --epsilon <float>`: Set the minimum branch length for internodal distances; values smaller than this are treated as multifurcations.
- `-F, --fast`: Reduce output to the two primary species tree estimates.

### Input Requirements
- **Gene Trees**: Must be in Newick format.
- **Branch Lengths**: While the tool can function without them, providing trees with branch lengths is preferred as it allows for more accurate distance estimation between leaves.
- **Paralogs**: No pre-processing of paralogs is required; the tool natively handles multi-labeled trees.

## Best Practices
- **Species Mapping**: Always provide a species list (`-s`) when working with genomic data to ensure that leaves are correctly mapped to the intended species, especially when gene trees contain different subsets of the total taxa.
- **Output Redundancy**: If your input trees lack paralogs or branch lengths, many of the 36 default output trees may be identical. In these cases, use `--fast` to save computation time.
- **Shell Expansion**: When processing hundreds of gene trees, use shell wildcards (e.g., `gene_trees/*.tre`) to pass all files as arguments.

## Reference documentation
- [super_distance - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_super_distance_overview.md)
- [GitHub - quadram-institute-bioscience/super_distance](./references/github_com_quadram-institute-bioscience_super_distance.md)