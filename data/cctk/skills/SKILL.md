---
name: cctk
description: CCTK is a Python toolkit for the comparative analysis and evolutionary modeling of CRISPR systems. Use when user asks to identify CRISPR arrays, generate spacer-sharing networks, align homologous arrays for visual comparison, build maximum parsimony trees, or map spacers to targets with PAM validation.
homepage: https://github.com/Alan-Collins/CRISPR_comparison_toolkit
metadata:
  docker_image: "quay.io/biocontainers/cctk:1.0.3--pyhdfd78af_0"
---

# cctk

## Overview

CCTK (CRISPR Comparison ToolKit) is a specialized suite of Python tools for the comparative analysis of CRISPR systems. Unlike general-purpose CRISPR identifiers, CCTK focuses on the relationships between arrays that share spacers. It allows researchers to transition from raw genomic assemblies to sophisticated visualizations and phylogenetic models. Use this skill to identify arrays using BLAST or MinCED, generate spacer-sharing networks, align homologous arrays for visual comparison, and build maximum parsimony trees to explain array evolution.

## Core Workflows and CLI Usage

### 1. Array Identification
Before comparison, arrays must be identified in genome assemblies.
- **MinCED-based**: Use `cctk minced` for standard identification.
- **BLAST-based**: Use `cctk blast` for identification based on known repeat sequences.

### 2. Comparative Analysis
Once arrays are identified, use these tools to analyze their relationships:
- **Spacer Networks**: Run `cctk network` to create a network representation where nodes are arrays and edges represent shared spacers.
- **Visual Alignment**: Use `cctk crisprdiff` to generate figures showing the alignment of homologous arrays, highlighting spacer gains, losses, and conservation.
- **Phylogenetic Inference**: Use `cctk crisprtree` to infer a maximum parsimony tree. This is particularly useful for understanding the chronological order of spacer acquisition.

### 3. Target Identification
- **Spacer Mapping**: Use `cctk spacerblast` to search for spacer targets (protospacers) in a BLAST database. This tool is superior to standard BLAST for this task as it assesses the full length of imperfect matches and specifically checks for the presence of a Protospacer Adjacent Motif (PAM).

### 4. Validation
- **Phylogenetic Constraints**: Use `cctk constrain` to determine if the relationships observed in the CRISPR arrays support or contradict phylogenetic trees built from other data, such as Multi-Locus Sequence Typing (MLST).

## Expert Tips and Best Practices

- **Data Flow**: The standard pipeline follows a linear progression: Identification (`minced`/`blast`) -> Relationship Mapping (`network`/`crisprdiff`) -> Evolutionary Modeling (`crisprtree`).
- **Dependency Management**: Ensure `blast+` and `minced` are available in your system PATH, as CCTK subcommands wrap these external binaries.
- **Visualization**: `crisprdiff` and `crisprtree` rely on Matplotlib. If running on a headless server, ensure a proper backend is configured or use a virtual frame buffer.
- **Parsimony Logic**: When using `crisprtree`, remember that the tool assumes array evolution primarily through spacer acquisition at the leader end and internal deletions; it seeks the simplest path to explain the observed spacer configurations.



## Subcommands

| Command | Description |
|---------|-------------|
| cctk blast | BLASTn settings: |
| cctk constrain | Control run behaviour and plotting elements for tree analysis. |
| cctk crisprdiff | Control run behaviour |
| cctk crisprtree | Builds a CRISPR array phylogenetic tree. |
| cctk minced | Find and process CRISPR arrays using minced. |
| cctk network | Builds a network of CRISPR arrays based on shared spacers. |
| cctk quickrun | Runs the cctk pipeline on a directory of genome fastas. |
| cctk_evolve | Run a simulation of array evolution and plot the resulting tree. |
| cctk_spacerblast | Finds protospacers in a blast database that match a given set of spacers. |

## Reference documentation
- [CRISPR Comparison ToolKit (CCTK) README](./references/github_com_Alan-Collins_CRISPR_comparison_toolkit_blob_main_README.md)
- [CCTK Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_cctk_overview.md)