---
name: astral-tree
description: astral-tree reconstructs species trees from a set of gene trees by maximizing quartet tree consistency under the multi-species coalescent model. Use when user asks to infer a species tree from gene trees, handle incomplete lineage sorting, or calculate local posterior probabilities for phylogenomic branches.
homepage: https://github.com/smirarab/ASTRAL
metadata:
  docker_image: "quay.io/biocontainers/astral-tree:5.7.8--hdfd78af_1"
---

# astral-tree

## Overview

ASTRAL (Accurate Species TRee ALgorithm) is a leading phylogenomic tool for species tree reconstruction. It operates by identifying the species tree that maximizes the number of shared induced quartet trees across a provided set of gene trees. Unlike concatenation methods, ASTRAL is statistically consistent under the multi-species coalescent model, making it highly effective at resolving evolutionary relationships even in the presence of significant incomplete lineage sorting. The current implementation (ASTRAL-III) provides efficient polynomial-time performance suitable for datasets with hundreds of taxa and thousands of genes.

## CLI Usage and Best Practices

### Basic Execution
The standard bioconda installation typically provides a wrapper. The primary input is a file containing one or more gene trees in Newick format.

```bash
astral -i gene_trees.nwk -o species_tree.tre
```

### Handling Multi-Individual Datasets
When you have multiple individuals per species, provide a mapping file (one line per species: `species_name: individual1,individual2`) to ensure correct quartet calculations.

```bash
astral -i gene_trees.nwk -a mapping_file.txt -o species_tree.tre
```

### Branch Support and Polytomy Testing
ASTRAL computes local posterior probabilities by default, which is a reliable measure of branch support.
- **Polytomy Test**: To test the null hypothesis that a branch is a polytomy rather than a bifurcating node, use the `-t 10` option.
- **Quartet Support**: Use `-t 1` to output quartet support (the fraction of gene tree quartets satisfied by the species tree) for each branch.

### Advanced Options
- **-R**: Use for name mapping if your gene trees use different naming conventions than your desired output.
- **--outgroup**: Specify an outgroup to root the resulting species tree (note: ASTRAL internally estimates an unrooted tree).
- **-t 32**: Useful for specific multi-individual quartet scoring adjustments in newer versions.

## Expert Tips for High-Quality Trees

### Input Gene Tree Quality
The accuracy of ASTRAL is highly dependent on the quality of the input gene trees.
- **Inference Method**: Research suggests that gene trees inferred with RAxML often yield better ASTRAL results than those from faster but less exhaustive tools like FastTree.
- **Fragmentary Data**: Remove highly fragmentary sequences (those with an uncharacteristically high number of gaps) before inferring gene trees, as they can introduce noise into the quartet frequencies.

### Missing Data
ASTRAL is robust to missing data. You do not need to filter out genes simply because they do not contain all taxa. In fact, keeping more genes with some missing taxa is often preferable to using a small "core" set of genes with full taxon occupancy.

### Branch Lengths
ASTRAL reports branch lengths in coalescent units. These lengths are derived from the ratio of observed quartet frequencies. Very long branches indicate high concordance (low ILS), while very short branches (near zero) suggest high discordance or potential polytomies.

## Reference documentation
- [astral-tree Overview](./references/anaconda_org_channels_bioconda_packages_astral-tree_overview.md)
- [ASTRAL GitHub Repository](./references/github_com_smirarab_ASTRAL.md)