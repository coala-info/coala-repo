---
name: tqdist
description: "tqdist computes triplet distances for rooted trees and quartet distances for unrooted trees to compare phylogenetic topologies. Use when user asks to calculate triplet distances, compute quartet distances, or perform all-pairs distance comparisons between phylogenetic trees."
homepage: http://users-cs.au.dk/cstorm/software/tqdist/
---


# tqdist

## Overview
tqdist is a specialized toolset for computing the triplet distance (for rooted trees) and the quartet distance (for unrooted trees). It is particularly efficient for large-scale phylogenetic analyses where traditional Robinson-Foulds distances might not provide enough resolution or where computational efficiency is required for many-taxa trees.

## Command Line Usage

The tool provides two primary executables: `triplet_dist` and `quartet_dist`.

### Triplet Distance (Rooted Trees)
Use `triplet_dist` to compare rooted trees. The distance is defined as the number of subsets of three taxa that have different topologies in the two trees.

```bash
triplet_dist <tree_file_1> <tree_file_2>
```

### Quartet Distance (Unrooted Trees)
Use `quartet_dist` to compare unrooted trees. The distance is defined as the number of subsets of four taxa that have different topologies in the two trees.

```bash
quartet_dist <tree_file_1> <tree_file_2>
```

## Best Practices
- **Input Format**: Ensure trees are in Newick format.
- **Taxa Matching**: Both input files must contain trees with the exact same set of leaf labels (taxa).
- **All-Pairs Comparison**: To compare multiple trees within a single file or across two files, ensure the input files contain one Newick string per line.
- **Normalization**: The raw triplet/quartet distance is often scaled by the total number of possible triplets $\binom{n}{3}$ or quartets $\binom{n}{4}$ to get a value between 0 and 1.



## Subcommands

| Command | Description |
|---------|-------------|
| all_pairs_quartet_dist | Calculates the pairwise quartet distance between all trees in a Newick file and outputs a lower triangular matrix. |
| all_pairs_triplet_dist | Calculates the pairwise triplet distance between all pairs of trees in a file. The output is a lower triangular matrix. |
| pairs_quartet_dist | Calculates the quartet distance between pairs of trees in two files. The files must contain the same number of trees in Newick format, and corresponding trees must have the same set of leaf labels. |
| pairs_triplet_dist | Calculates the triplet distance between pairs of trees in two files. The files must contain the same number of trees in Newick format, and trees on the same line must have the same set of leaf labels. |
| quartet_dist | Calculates the quartet distance between two trees in Newick format. The quartet distance is printed to stdout. |
| triplet_dist | Calculate the triplet distance between two trees in Newick format. The triplet distance between the two trees will be printed to stdout. |

## Reference documentation
- [tqdist Overview](./references/anaconda_org_channels_bioconda_packages_tqdist_overview.md)