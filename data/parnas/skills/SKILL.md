---
name: parnas
description: PARNAS (Phylogenetic maximum representation sampling) is a specialized tool designed to solve the problem of taxon selection in large phylogenies.
homepage: https://github.com/flu-crew/parnas
---

# parnas

## Overview
PARNAS (Phylogenetic maximum representation sampling) is a specialized tool designed to solve the problem of taxon selection in large phylogenies. Instead of random sampling, PARNAS uses objective algorithms to identify the smallest set of taxa that captures the maximum evolutionary diversity or covers the tree within a user-defined sequence divergence threshold (radius). It is particularly effective for virology and epidemiology workflows where identifying representative strains—such as vaccine candidates—is critical.

## Common CLI Patterns

### Selecting a Fixed Number of Representatives
To find the $n$ most representative strains and visualize their clusters:
```bash
parnas -t input_tree.rooted.tre -n 5 --color "representatives_n5.tre"
```
*The `--color` flag produces a tree file compatible with FigTree, where each representative and its associated cluster are assigned distinct colors.*

### Optimal Downsampling (Radius-based)
To reduce a massive tree to the smallest possible subset where every original taxon is within a specific distance (e.g., 1% divergence) of a representative:
```bash
parnas -t large_tree.tre --cover --radius 0.01 --subtree "downsampled.tre"
```

### Determining Optimal Sample Size
To analyze how much diversity is covered as you increase the number of representatives:
```bash
parnas -t input_tree.tre -n 20 --diversity "diversity_scores.csv"
```
*This generates a CSV containing optimal diversity scores for $n$ values from 2 to 20, allowing you to find the "elbow" in the curve.*

### Incorporating Prior Representatives
To select new representatives while accounting for existing ones (e.g., current vaccine strains):
```bash
parnas -t tree.tre -n 3 --prior "Vaccine_.*" --color "new_plus_old.tre"
```
*The `--prior` flag accepts a regular expression to match the names of existing taxa in the tree.*

## Expert Tips and Best Practices

- **Radius Interpretation**: On a Maximum Likelihood (ML) phylogeny, the `--radius` value serves as a proxy for sequence divergence. For example, a radius of `0.005` typically corresponds to 0.5% sequence divergence.
- **Rooting is Required**: PARNAS requires a rooted tree to function correctly. Ensure your tree is rooted (e.g., using an outgroup or midpoint rooting) before running the analysis.
- **Weighting Taxa**: If certain taxa are more important (e.g., higher abundance or better sequence quality), PARNAS supports arbitrary weighting to bias the selection toward those nodes.
- **Clustering Output**: Use the `--clusters` option to output the specific membership of each cluster, which is useful for downstream partitioning tasks.
- **Large Trees**: For very large trees (e.g., >10,000 taxa), PARNAS utilizes `numba` for just-in-time compilation to maintain performance. Ensure `numpy` and `numba` are correctly installed in your environment.

## Reference documentation
- [PARNAS GitHub Repository](./references/github_com_flu-crew_parnas.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_parnas_overview.md)