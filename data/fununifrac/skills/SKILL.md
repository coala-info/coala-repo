---
name: fununifrac
description: FunUniFrac adapts the phylogenetic UniFrac metric for use with functional metagenomic profiles.
homepage: https://github.com/KoslickiLab/FunUniFrac
---

# fununifrac

## Overview
FunUniFrac adapts the phylogenetic UniFrac metric for use with functional metagenomic profiles. Instead of a traditional phylogenetic tree, it utilizes a KEGG Orthology (KO) hierarchy. Since functional hierarchies often lack branch lengths, the tool provides a workflow to infer these lengths using protein sequence similarity (AAI) as a proxy for distance. This allows for a more nuanced comparison of metagenomes based on what the microbial community is doing (function) rather than just who is there (taxonomy).

## Installation and Setup
The tool is available via Bioconda. It is recommended to use a dedicated environment.

```bash
conda install bioconda::fununifrac
# Or via the repository environment file
conda env update -f environment.yml
conda activate fununifrac
```

## Core Workflows

### 1. Inferring Functional Edge Lengths
Before computing UniFrac, you must assign lengths to the functional tree edges. This is done by solving a regularized, randomized non-negative least squares problem based on pairwise AAI distances.

```bash
python ./fununifrac/compute_edges.py \
    -e edge_ko00001.txt \
    -d KOs_sketched_distances \
    -o ./output_dir \
    -b ko00001 \
    -n 50 -f 10 -r 100 --distance
```
*   `-e`: The KEGG hierarchy edge list.
*   `-d`: Pairwise distances (typically generated via sketching tools like sourmash).
*   `-b`: The root BRITE ID (e.g., ko00001).

### 2. Computing Functional UniFrac
This is the primary analysis step. It compares functional profiles (in `sourmash gather` CSV format) against the weighted functional tree.

```bash
python ./fununifrac/compute_fununifrac.py \
    -e edge_ko00001_lengths.txt \
    -fd ./profiles_directory \
    -o ./results \
    --diffab \
    -a median_abund \
    --L2
```
*   `-fd`: Directory containing `*_gather.csv` files.
*   `--diffab`: Optional flag to compute differential abundance vectors.
*   `-a`: Abundance column to use (e.g., `median_abund` or `f_unique_to_query`).

## Expert Tips and Best Practices
*   **Input Format**: Ensure your functional profiles are generated using `sourmash gather`. The tool defaults to looking for files ending in `_gather.csv`.
*   **Memory Management**: The `create_edge_matrix.py` script (called by `compute_edges.py`) generates a massive sparse matrix (often >200M rows). Ensure your environment has sufficient RAM for preprocessing large KO sets.
*   **Regularization**: If the edge length inference fails to converge or produces unrealistic values, adjust the randomization parameters (`-n`, `-f`, `-r`) in `compute_edges.py`.
*   **Output Interpretation**: The tool produces `.npy` (NumPy) files for the distance matrix and its basis. Use `numpy.load()` in Python to inspect these results for downstream statistical analysis or PCoA plotting.

## Reference documentation
- [Functional UniFrac GitHub Repository](./references/github_com_KoslickiLab_FunUniFrac.md)
- [Bioconda fununifrac Overview](./references/anaconda_org_channels_bioconda_packages_fununifrac_overview.md)