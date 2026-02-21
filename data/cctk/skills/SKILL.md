---
name: cctk
description: The CRISPR Comparison ToolKit (CCTK) is a specialized suite of Python tools designed to analyze the differences and similarities between CRISPR arrays that share spacers.
homepage: https://github.com/Alan-Collins/CRISPR_comparison_toolkit
---

# cctk

## Overview

The CRISPR Comparison ToolKit (CCTK) is a specialized suite of Python tools designed to analyze the differences and similarities between CRISPR arrays that share spacers. Unlike general CRISPR detectors, CCTK focuses on the comparative evolution of arrays, allowing you to track spacer acquisition/loss events, build network representations of shared spacers, and assess whether array relationships align with broader phylogenetic data.

## Core Workflows

### 1. Array Identification
Before comparison, identify arrays in your genome assemblies using either a MinCED-based or BLAST-based approach.

*   **MinCED Method**: Best for standard array detection.
    ```bash
    cctk minced --input assemblies/ --output arrays_minced/
    ```
*   **BLAST Method**: Useful for finding degenerate or highly specific repeats.
    ```bash
    cctk blast --input assemblies/ --output arrays_blast/
    ```

### 2. Comparative Analysis
Once arrays are identified, use these tools to analyze their relationships:

*   **Network Representation**: Generate a network of arrays based on shared spacers.
    ```bash
    cctk network --input arrays_minced/ --output network_results/
    ```
*   **Visual Alignment**: Create a visual comparison of homologous arrays to see insertions, deletions, or rearrangements.
    ```bash
    cctk crisprdiff --input arrays_minced/ --output diff_plots/
    ```
*   **Phylogenetic Inference**: Build a maximum parsimony tree based on spacer content.
    ```bash
    cctk crisprtree --input arrays_minced/ --output tree_results/
    ```

### 3. Target Identification (Spacer BLAST)
Identify potential protospacers while accounting for biological constraints like the Protospacer Adjacent Motif (PAM).
```bash
cctk spacerblast --query spacers.fasta --db target_genomes.db --pam NGG
```

## Expert Tips and Best Practices

*   **Quick Assessments**: Use the `--quickrun` flag during initial exploratory analysis to generate rapid outputs before committing to high-resolution plotting or deep bootstrapping.
*   **Filtering Noise**: If working with fragmented assemblies, adjust `--min-repeat-spacing` and `--min-array-length` to prevent false positives from short, repetitive sequences that are not true CRISPR arrays.
*   **Seed Region Matching**: For `spacerblast`, use the `--seed-region` option to specify a portion of the spacer (usually the PAM-proximal end) where no mismatches are allowed, reflecting the biological "seed" requirement for Cas interference.
*   **Branch Support**: When generating trees with `crisprtree`, use `--branch-support` to include support values in the resulting Newick file, which is critical for assessing the reliability of the inferred evolutionary path.
*   **Cluster Management**: For datasets with a very large number of arrays, check the `Array_clusters.txt` output to understand how CCTK has grouped homologous systems before running intensive visualization tasks.

## Reference documentation
- [CRISPR Comparison ToolKit Overview](./references/github_com_Alan-Collins_CRISPR_comparison_toolkit.md)
- [CCTK Bioconda Package](./references/anaconda_org_channels_bioconda_packages_cctk_overview.md)