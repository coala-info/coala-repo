---
name: fastme
description: FastME reconstructs phylogenetic trees from distance matrices or sequences using Balanced Minimum Evolution principles. Use when user asks to infer phylogenetic trees, perform topological searches with NNI or SPR, or conduct bootstrap analysis for branch support.
homepage: http://www.atgc-montpellier.fr/fastme/binaries.php
metadata:
  docker_image: "quay.io/biocontainers/fastme:2.1.6.3--h7b50bb2_1"
---

# fastme

## Overview
FastME is a specialized tool for reconstructing phylogenetic trees from distance matrices. It improves upon traditional Neighbor-Joining methods by utilizing Balanced Minimum Evolution principles. This skill enables efficient tree inference through sophisticated topological search algorithms like Nearest Neighbor Interchange (NNI) and Subtree Pruning and Regrafting (SPR). It is particularly effective for large datasets where speed and accuracy in distance-based methods are required.

## Command Line Usage

### Basic Tree Inference
To run FastME with default settings (usually BME with NNI):
```bash
fastme -i input_file -o output_tree_file
```

### Common CLI Options
- `-i <filename>`: Input data file (Distance matrix or sequence file).
- `-o <filename>`: Output tree file.
- `-m <method>`: Choose the inference method.
    - `B`: Balanced Minimum Evolution (default).
    - `O`: Ordinary Least Squares.
- `-t <type>`: Specify the type of topological search.
    - `n`: Nearest Neighbor Interchange (NNI).
    - `s`: Subtree Pruning and Regrafting (SPR).
- `-d <model>`: Distance estimation model (if input is sequences).
    - DNA: `p` (p-distance), `j` (Jukes-Cantor), `k` (K2P), `f` (F84).
    - Protein: `p` (p-distance), `j` (Jukes-Cantor), `k` (Kimura).

### Bootstrapping
To perform a bootstrap analysis to assess branch support:
```bash
fastme -i input_file -o output_tree_file -b 100
```
Replace `100` with the desired number of replicates.

### Parallel Execution
For large datasets, use the parallel processing capability:
```bash
fastme -i input_file -o output_tree_file -T <number_of_threads>
```

## Best Practices
- **Input Format**: Ensure your input is in PHYLIP format, as FastME follows PHYLIP-like interface conventions.
- **Algorithm Selection**: Use SPR (`-t s`) for a more thorough search of the tree space than NNI, though it may take longer on very large trees.
- **Distance Matrices**: If you already have a distance matrix, providing it directly is faster than letting FastME calculate distances from raw sequences.
- **Model Selection**: When using raw sequences, ensure the distance model (`-d`) matches your biological data type (DNA vs. Protein).

## Reference documentation
- [FastME Overview and Binaries](./references/www_atgc-montpellier_fr_fastme_binaries.php.md)
- [Bioconda FastME Package Details](./references/anaconda_org_channels_bioconda_packages_fastme_overview.md)