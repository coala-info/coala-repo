---
name: sapling
description: Sapling is a Python-based computational tool designed to navigate the complex space of tumor evolution.
homepage: https://github.com/elkebir-group/Sapling
---

# sapling

## Overview

Sapling is a Python-based computational tool designed to navigate the complex space of tumor evolution. Rather than focusing solely on a single optimal tree, Sapling identifies a small set of "backbone trees" that capture the most likely evolutionary structures from bulk sequencing data. It utilizes various solvers to estimate frequency matrices and can scale from summarizing core mutations to enumerating full phylogenies using beam search.

## Input Data Requirements

Sapling requires a tab-separated values (TSV) file. Ensure your input contains the following mandatory columns:

- `sample_index`: Integer ID for each sample (0 to m-1).
- `mutation_index`: Integer ID for each mutation (0 to n-1).
- `var`: Number of variant reads supporting the mutation.
- `depth`: Total read depth at the locus.
- `cluster_index` (Optional): ID for mutation clusters. If omitted, the tool treats each mutation as its own cluster.

## Common CLI Patterns

### 1. Inferring Backbone Trees
To identify a set of trees that summarize the evolutionary space, use the `--tau` and `--rho` parameters.
```bash
sapling --tau 5 --rho 0.9 -f input.tsv -o backbone_trees.tsv
```
- `--tau 5`: Limits the output to a maximum of 5 backbone trees.
- `--rho 0.9`: Sets the minimum allowed deviation from the maximum likelihood (likelihood cutoff).

### 2. Inferring Full Phylogenies
To generate complete trees containing all mutations, disable the backbone constraints and set a beam width.
```bash
sapling --tau -1 --ell -1 --beam_width 100 -f input.tsv -o full_trees.tsv
```
- `--beam_width 100`: Controls the search breadth; higher values explore more of the tree space but increase runtime.

### 3. Expanding Existing Backbones
If you have already identified backbone trees and want to grow them into full phylogenies:
```bash
sapling --init_trees backbone_trees.tsv --tau -1 --ell -1 --rho 0.9 -f input.tsv -o expanded_trees.tsv
```

## Expert Tips and Best Practices

- **Solver Selection**: Use `-L fastppm` (default) for the best performance. If `fastppm` is unavailable in your environment, fallback to `cvxopt`.
- **Handling Polyclonality**: If you suspect a polyclonal origin for the tumor, use the `-m` or `--poly_clonal_root` flag to allow for a polyclonal root node.
- **Alternative Roots**: Use `--alt_roots` if the primary root node is uncertain; this forces the algorithm to explore different starting points for the phylogeny.
- **Clustering**: If you have pre-computed mutation clusters, use `--use_clusters`. Sapling will calculate the median read depth and average frequency for these clusters to improve inference stability.
- **Parameter Tuning**: 
    - If the tool returns too many trees, decrease `--tau` or increase `--rho`.
    - If the tool fails to find valid trees, try lowering `--rho` (e.g., to 0.8) or increasing `--beam_width`.

## Reference documentation
- [Sapling GitHub Repository](./references/github_com_elkebir-group_Sapling.md)
- [Sapling Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_sapling_overview.md)