---
name: fununifrac
description: FunUniFrac performs functional UniFrac analysis on metagenomic data by applying phylogenetic distance metrics to the KEGG Orthology hierarchy. Use when user asks to assign branch lengths to KEGG trees, compute pairwise functional UniFrac distances between metagenomes, or perform differential abundance analysis on functional profiles.
homepage: https://github.com/KoslickiLab/FunUniFrac
---

# fununifrac

## Overview

FunUniFrac is a specialized tool for performing functional UniFrac analysis on metagenomic data. While traditional UniFrac measures the distance between samples based on phylogenetic trees, FunUniFrac applies this logic to functional profiles using the KEGG Orthology (KO) hierarchy. This allows for a comparison of metagenomes that accounts for the relatedness of different functions.

Use this skill to:
1.  **Assign branch lengths** to KEGG hierarchy trees using pairwise amino acid identity (AAI) as a proxy for distance.
2.  **Compute pairwise functional UniFrac distances** between metagenomic samples.
3.  **Perform differential abundance analysis** to identify specific functional nodes that drive the differences between samples.

## Core Workflows

### 1. Preprocessing: Computing Edge Lengths
Since the KEGG hierarchy does not naturally include branch lengths, you must first estimate them using `compute_edges.py`. This script solves a regularized, randomized non-negative least squares (NNLS) problem to assign lengths to the KO tree.

```bash
python ./fununifrac/compute_edges.py \
    -e edge_ko00001.txt \
    -d KOs_sketched_scaled_10_compare_5 \
    -o ./output_dir \
    -b ko00001 \
    -n 50 -f 10 -r 100 --distance
```

**Key Arguments:**
*   `-e`: The KEGG hierarchy edge list (e.g., `ko00001`).
*   `-d`: Pairwise distances between leaf nodes (KOs).
*   `-b`: The BRITE ID used as the root.
*   `--distance`: Flag to indicate input is a distance matrix.

### 2. Computing Functional UniFrac
The core analysis is performed using `compute_fununifrac.py`. It requires functional profiles (typically `sourmash gather` CSV files) and the edge list with lengths generated in the previous step.

```bash
python ./fununifrac/compute_fununifrac.py \
    -e ./edge_ko00001_lengths.txt \
    -fd ./profiles_directory \
    -o ./results \
    --diffab \
    -a median_abund \
    --L2
```

**Key Arguments:**
*   `-e`: The edge list file containing calculated branch lengths.
*   `-fd`: Directory containing functional profiles (default pattern: `*_gather.csv`).
*   `-a`: Abundance column to use (e.g., `median_abund` or `f_unique_to_query`).
*   `--diffab`: Enables differential abundance calculation to see which nodes contribute to the distance.
*   `--L2`: Uses the L2 norm for the distance calculation.

## Best Practices and Tips

*   **Input Format**: Ensure your functional profiles are in the `sourmash gather` CSV format. FunUniFrac is optimized to work with these outputs.
*   **Tree Selection**: The `ko00001` BRITE hierarchy is the standard reference for general functional profiling.
*   **Regularization**: When computing edges, the tool uses a regularization parameter (`lambda`) to handle rank-deficient matrices. If the resulting tree has many zero-length branches, consider adjusting the randomization parameters (`-n`, `-f`, `-r`).
*   **Output Interpretation**:
    *   `.npy` files: Contain the pairwise distance matrix and its basis (sample names).
    *   `.diffab.npz`: Contains the differential abundance vectors, useful for identifying functional drivers of sample separation.



## Subcommands

| Command | Description |
|---------|-------------|
| compute_edges.py | This will take the matrix made by graph_to_path_matrix.py and the all pairwise distance matrix and solve the least squares problem of inferring the edge lengths of the graph. |
| compute_fununifrac.py | This script will take a directory of sourmash gather results and a weighted edge list representing the KEGG hierarchy and compute all pairwise functional unifrac distances. |

## Reference documentation
- [GitHub - KoslickiLab/FunUniFrac](./references/github_com_KoslickiLab_FunUniFrac.md)
- [FunUniFrac Wiki - Reproducibles](./references/github_com_KoslickiLab_FunUniFrac_wiki_Reproducibles.md)