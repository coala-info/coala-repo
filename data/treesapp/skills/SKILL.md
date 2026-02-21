---
name: treesapp
description: TreeSAPP (Tree-based Sensitive and Accurate Phylogenetic Profiler) is a bioinformatics toolset designed for high-resolution functional and taxonomic annotation.
homepage: https://github.com/hallamlab/TreeSAPP
---

# treesapp

## Overview

TreeSAPP (Tree-based Sensitive and Accurate Phylogenetic Profiler) is a bioinformatics toolset designed for high-resolution functional and taxonomic annotation. Unlike standard homology-based tools, TreeSAPP utilizes phylogenetic placement to assign sequences to a reference tree, providing more sensitive and accurate classifications. It is particularly effective for identifying specific metabolic markers in complex microbial communities and allows users to build, evaluate, and update their own reference packages for genes of interest.

## Installation and Setup

The recommended way to install TreeSAPP is via Conda to manage its various dependencies (HMMER, RAxML-NG, EPA-ng, etc.):

```bash
conda create -n treesapp_env -c bioconda -c conda-forge treesapp
conda activate treesapp_env
```

## Core Workflows

### Sequence Classification (assign)
The primary command for annotating sequences. It supports both protein and nucleotide inputs.

*   **Basic Protein Classification**:
    ```bash
    treesapp assign -i sequences.faa -m prot -o output_directory
    ```
*   **Targeting Specific Markers**: Use the `-t` flag to limit the search to specific reference packages (e.g., McrA for methanogenesis).
    ```bash
    treesapp assign -i input.fasta -t McrA,DsrAB -o results/
    ```
*   **Optimizing Alignment**: Use `--trim_align` to remove poorly aligned regions, which often improves placement accuracy.
    ```bash
    treesapp assign -i input.faa --trim_align -o results/
    ```

### Reference Package Management
TreeSAPP relies on "reference packages" (RefPkgs). While 33 are built-in, you can create or modify them.

*   **Building a New Package**: Use `treesapp create` if a marker gene is not in the default database.
*   **Testing Purity**: Before using a custom package, run `purity` to ensure the sequences used for the reference are functionally cohesive.
    ```bash
    treesapp purity -i my_refpkg/ -o purity_results/
    ```
*   **Updating Packages**: Keep reference trees current with new NCBI/GTDB data.
    ```bash
    treesapp update -i existing_refpkg/ -o updated_refpkg/
    ```

### Abundance and Clustering
*   **Relative Abundance**: Calculate the abundance of functional genes within a sample.
    ```bash
    treesapp abundance -i assign_output/ -o abundance_table.tsv
    ```
*   **Phylogenetic OTUs**: Cluster sequences based on their placement in the tree rather than simple sequence identity.
    ```bash
    treesapp phylotu -i assign_output/ -o otu_results/
    ```

## Expert Tips and Best Practices

*   **Input Types**: Always specify the molecule type with `-m prot` (amino acids) or `-m nucl` (nucleotides). TreeSAPP is generally more sensitive when working with protein sequences.
*   **Memory Management**: Phylogenetic placement (EPA-ng/RAxML-NG) can be memory-intensive. Ensure your environment has sufficient RAM for large reference trees.
*   **Layering Data**: Use `treesapp layer` to add extra phylogenetic information or metadata to your classifications, which is helpful for distinguishing between closely related orthologous groups.
*   **Visualizing Results**: Use `treesapp colour` to generate tree files (iTOL compatible) that are automatically colored based on taxonomic assignments.

## Reference documentation

- [TreeSAPP GitHub Repository](./references/github_com_hallamlab_TreeSAPP.md)
- [TreeSAPP Wiki and Tutorials](./references/github_com_hallamlab_TreeSAPP_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_treesapp_overview.md)