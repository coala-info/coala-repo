---
name: kitsune
description: KITSUNE selects optimal k-mer lengths for alignment-free genomic analysis by evaluating information content and feature distribution. Use when user asks to find the optimal k-mer size, calculate k-mer entropy or common features, and generate distance matrices for phylogenomic trees.
homepage: https://github.com/natapol/kitsune
---


# kitsune

## Overview

KITSUNE (K-mer-length Iterative Selection for UNbiased Ecophylogenomics) provides a systematic framework for selecting k-mer lengths that capture the most relevant biological information for a given set of sequences. Instead of using arbitrary k-mer sizes, KITSUNE evaluates Cumulative Relative Entropy (CRE), Average number of Common Features (ACF), and Observed Common Features (OCF) to find an empirical optimum. This ensures that subsequent alignment-free analyses, such as distance estimation and tree building, are based on high-quality information content.

## Installation Requirements

KITSUNE requires **Jellyfish** to be installed and available in your PATH for k-mer counting.
- **Python**: >= 3.5
- **Dependencies**: scipy, numpy, tqdm

## Core Commands and Workflows

### 1. Finding the Optimal K-mer Length
The `kopt` command is the primary entry point for the three-step optimization process. It evaluates a range of k-mer lengths to suggest the best choice.

```bash
kitsune kopt --filenames genome1.fna genome2.fna -kf 5 -ke 15 -t 4 -o optimal_k.txt
```

### 2. Calculating Individual Metrics
If you need to inspect specific properties of the k-mer distribution:

*   **CRE (Cumulative Relative Entropy):** Measures the information gain as k-mer length increases.
    ```bash
    kitsune cre --filename genome.fna -kf 4 -ke 20 --fast
    ```
*   **ACF (Average number of Common Features):** Calculates how many k-mers are shared between a reference and other genomes.
    ```bash
    kitsune acf --filenames g1.fna g2.fna g3.fna -k 11 13 15
    ```
*   **OFC (Observed Feature Frequencies):** Computes the frequency of k-mers across the dataset.
    ```bash
    kitsune ofc --filenames genome_dir/*.fasta -k 13
    ```

### 3. Generating Distance Matrices
Once an optimal $k$ is determined, use `dmatrix` to generate a distance matrix for phylogenomic analysis.

```bash
kitsune dmatrix --filenames *.fna -k 13 -m jensenshannon -o distance_matrix.txt
```

**Common Distance Methods (`-m`):**
- `jensenshannon`: Jensen-Shannon distance (standard for frequency vectors).
- `mash`: MASH distance estimation.
- `braycurtis`: Bray-Curtis dissimilarity.
- `euclidean`: Standard Euclidean distance.
- `jaccard`: Jaccard-Needham dissimilarity.

## Expert Tips and Best Practices

*   **Performance Optimization:** Always use the `--fast` flag to enable Jellyfish one-pass calculation, which significantly reduces processing time for large datasets.
*   **Strand Sensitivity:** Use the `--canonical` flag when working with double-stranded DNA to ensure that k-mers and their reverse complements are treated as the same feature.
*   **Parallelization:** Use the `-t` (threads) argument to speed up k-mer counting and matrix calculations, especially when processing many genomes.
*   **K-mer Range:** When using `cre`, start from a low value (e.g., `-kf 4`) and end at a value where the entropy begins to plateau. For most bacterial genomes, an end value (`-ke`) between 15 and 25 is sufficient.
*   **Memory Management:** For very large datasets or high $k$ values, ensure your system has enough RAM, as k-mer frequency vectors can become sparse and large.



## Subcommands

| Command | Description |
|---------|-------------|
| kitsune dmatrix | Create a dmatrix for XGBoost |
| kopt | Kopt is a tool for optimizing K-mer counts. |

## Reference documentation
- [KITSUNE GitHub Repository](./references/github_com_natapol_kitsune.md)
- [KITSUNE README](./references/github_com_natapol_kitsune_blob_master_README.md)