---
name: kitsune
description: Kitsune (K-mer-length Iterative Selection for UNbiased Ecophylogenomics) is a specialized toolkit designed to solve the "k-mer selection problem" in alignment-free genomics.
homepage: https://github.com/natapol/kitsune
---

# kitsune

## Overview
Kitsune (K-mer-length Iterative Selection for UNbiased Ecophylogenomics) is a specialized toolkit designed to solve the "k-mer selection problem" in alignment-free genomics. Instead of choosing a k-mer length arbitrarily, Kitsune provides a systematic framework to calculate Cumulative Relative Entropy (CRE), Average number of Common Features (ACF), and Observed Common Features (OCF) to identify the most informative k-mer size for a specific dataset. It also supports the generation of distance matrices using over 20 different metrics, including MASH and Jensen-Shannon distances, which are essential for building phylogenetic trees or identifying species.

## Core Workflow

### 1. Determining Optimal K-mer Length
The primary use case is finding the "sweet spot" for k-mer length where information content is maximized without excessive noise.

*   **Calculate CRE (Cumulative Relative Entropy):** Identifies the k-mer length where the distribution of k-mers stabilizes.
    `kitsune cre --filename genome.fna -kf 4 -ke 15 -o cre_results.txt`
*   **Calculate ACF (Average Common Features):** Measures how many k-mers are shared between genomes.
    `kitsune acf --filenames genome1.fna genome2.fna -k 5 7 9 11 -o acf_results.txt`
*   **Calculate OFC (Observed Feature Frequencies):**
    `kitsune ofc --filenames genome_folder/*.fna -k 11 -o ofc_results.txt`
*   **Automated Optimization:** Use the `kopt` command to get a recommended k-mer choice within a range based on the three metrics.
    `kitsune kopt --filenames genomes/*.fna -kf 4 -ke 20`

### 2. Generating Distance Matrices
Once the optimal k-mer length is determined, generate a distance matrix for downstream analysis.

`kitsune dmatrix --filenames genomes/*.fna -k 11 -d mash -o distance_matrix.txt`

**Commonly Used Distance Metrics:**
- `mash`, `jsmash` (MASH-based)
- `jaccard`, `jaccarddistp`
- `euclidean`, `euclidean_of_frequency`
- `braycurtis`, `canberra`, `cosine`

## Expert Tips & Best Practices

*   **Performance:** Always use the `--fast` flag to enable Jellyfish one-pass calculation. This significantly reduces processing time, especially for large eukaryotic genomes.
*   **Strand Sensitivity:** Use the `--canonical` flag when working with double-stranded DNA. This ensures k-mers and their reverse complements are counted together as a single feature.
*   **Parallelization:** Utilize the `-t` (threads) parameter to speed up k-mer counting and matrix calculations on multi-core systems.
*   **Input Handling:** For commands accepting multiple files (`dmatrix`, `acf`, `ofc`), you can use shell wildcards (e.g., `data/*.fna`) to process entire directories at once.
*   **Distance Transformation:** Use the `--transformed` flag with `dmatrix` to apply distance transformations proposed by Fan et al., which can improve the biological relevance of the resulting phylogenetic relationships.
*   **External Dependency:** Ensure `Jellyfish` is installed and available in the system PATH, as Kitsune relies on it for the underlying k-mer counting operations.

## Reference documentation
- [Kitsune GitHub Repository](./references/github_com_natapol_kitsune.md)
- [Bioconda Kitsune Package](./references/anaconda_org_channels_bioconda_packages_kitsune_overview.md)