---
name: treesapp
description: TreeSAPP provides a framework for the functional and taxonomic annotation of protein and nucleotide sequences using phylogenetic placement. Use when user asks to classify sequences, manage reference packages, generate tree visualizations, or calculate relative abundance and diversity.
homepage: https://github.com/hallamlab/TreeSAPP
---


# treesapp

## Overview

TreeSAPP (Tree-based Sensitive and Accurate Phylogenetic Profiler) provides a robust framework for the functional and taxonomic annotation of proteins using phylogenetic placement rather than simple homology. It allows researchers to accurately identify and classify sequences within genomes and metagenomes by placing them into pre-constructed or custom-built reference trees. This approach is particularly effective for resolving closely related orthologs and providing high-resolution taxonomic context for metabolic marker genes.

## Core Workflows

### Sequence Classification

Use `treesapp assign` to classify protein or nucleotide sequences.

*   **Basic protein classification**:
    `treesapp assign -i sequences.faa -o output_dir -m prot`
*   **Target specific markers**:
    `treesapp assign -i sequences.faa -o output_dir -t McrA,DsrAB`
*   **Improve accuracy**:
    Use the `--trim_align` flag to remove poorly aligned regions before placement.
    `treesapp assign -i sequences.faa -o output_dir --trim_align`

### Reference Package Management

Reference packages (.pkl files) are the core of TreeSAPP.

*   **List available markers**:
    `treesapp` (running the base command lists sub-commands and available reference packages).
*   **View package metadata**:
    `treesapp package view feature_annotations -r path/to/refpkg.pkl`
*   **Edit package attributes**:
    Use `treesapp package edit` to add phenotypic data or custom lineages to a package.

### Visualization and Annotation

*   **Generate iTOL files**:
    Create color-strip and style files for tree visualization.
    `treesapp colour -r path/to/refpkg.pkl --rank_level family --palette viridis`
*   **Layer annotations**:
    Add phenotypic data (e.g., metabolic pathways) to classification tables.
    `treesapp layer -c classification_table.tsv -r path/to/refpkg.pkl -a Pathway`

### Abundance and Diversity

*   **Calculate relative abundance**:
    `treesapp abundance -i classification_table.tsv -o abundance_out`
*   **Cluster into OTUs**:
    Use `treesapp phylotu` to cluster sequences based on phylogenetic distance.

## Expert Tips

*   **Mode Selection**: Always specify `-m prot` for protein sequences or `-m nucl` for nucleotides to ensure the correct alignment model is used.
*   **Custom Packages**: If a gene is not in the default 33 packages, use `treesapp create` to build a new one. Always run `treesapp purity` on new packages to ensure they don't capture homologous but functionally distinct sequences.
*   **Memory Management**: Phylogenetic placement can be memory-intensive. For large metagenomes, consider subsetting your input sequences to those identified as hits by a preliminary HMM search.
*   **iTOL Integration**: When coloring multiple trees, provide all reference packages in a single `treesapp colour` command to ensure consistent color mapping across different markers.



## Subcommands

| Command | Description |
|---------|-------------|
| phylotu | A tool for sorting query sequences placed on a phylogeny into phylogenetically-inferred clusters. |
| treesapp abundance | Calculate query sequence abundances from read coverage. |
| treesapp evaluate | Evaluate classification performance using clade-exclusion analysis. |
| treesapp layer | This script adds extra feature annotations, such as Subgroup and Metabolic Pathway, to an existing classification table made by treesapp assign. A new column is bound to the table for each feature. |
| treesapp package | Facilitate operations on reference packages |
| treesapp_assign | Classify sequences through evolutionary placement. |
| treesapp_colour | Generates colour style and strip files for visualizing a reference package's phylogeny in iTOL based on taxonomic or phenotypic data. |
| treesapp_create | Create a reference package for TreeSAPP. |
| treesapp_purity | Validate the functional purity of a reference package. |
| treesapp_train | Model evolutionary distances across taxonomic ranks. |
| treesapp_update | Update a reference package with assigned sequences. |

## Reference documentation

- [TreeSAPP Overview](./references/github_com_hallamlab_TreeSAPP.md)
- [Classifying sequences with treesapp assign](./references/github_com_hallamlab_TreeSAPP_wiki_Classifying-sequences-with-treesapp-assign.md)
- [Automatically colouring trees](./references/github_com_hallamlab_TreeSAPP_wiki_Automatically-colouring-trees.md)
- [Reference package operations](./references/github_com_hallamlab_TreeSAPP_wiki_Reference-package-operations.md)