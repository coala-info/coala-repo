---
name: cath-tools
description: The cath-tools suite provides high-performance C++ implementations for protein structure comparison, classification, and domain architecture resolution. Use when user asks to perform structural alignment via SSAP, resolve overlapping domain hits, superpose 3D coordinates, or cluster structural similarity data.
homepage: https://github.com/UCLOrengoGroup/cath-tools
---


# cath-tools

## Overview

The `cath-tools` suite provides high-performance C++ implementations of protein structure comparison and classification algorithms. Developed by the UCL Orengo Group, these tools are the engine behind the CATH (Class, Architecture, Topology, Homologous superfamily) database. The toolkit is primarily used for pairwise structural alignment via the SSAP algorithm, resolving overlapping domain matches into a definitive domain architecture, and performing hierarchical clustering on structural similarity data.

## Core Tool Usage

### Structural Alignment (cath-ssap)
Use `cath-ssap` to perform a structural alignment between two protein structures. It is the standard tool for determining structural homology in the CATH hierarchy.
- **Basic Pattern**: `cath-ssap <pdb_file_1> <pdb_file_2>`
- **Note**: The tool typically utilizes DSSP (Define Secondary Structure of Proteins) algorithms for secondary structure assignment during the alignment process.

### Domain Hit Resolution (cath-resolve-hits)
When searching a sequence against a library of domain models, you often get overlapping hits. `cath-resolve-hits` identifies the optimal, non-overlapping subset of hits that maximizes the total score.
- **Usage**: `cath-resolve-hits <input_hits_file>`
- **Best Practice**: Use this to convert raw search results into a final "domain architecture" for a protein sequence.

### Structure Superposition (cath-superpose)
Once an alignment is generated, use `cath-superpose` to transform the 3D coordinates of the structures into a common frame of reference.
- **Basic Pattern**: `cath-superpose <pdb_files> --alignment <alignment_file>`
- **Utility**: Essential for visualizing structural differences or creating ensemble models.

### Data Clustering (cath-cluster)
Perform complete-linkage clustering on arbitrary similarity data.
- **Usage**: `cath-cluster <similarity_data_file>`
- **Algorithm**: Uses a reciprocal-nearest-neighbor algorithm for efficient hierarchical clustering.

## Expert Tips and Best Practices

- **Domain Boundaries**: When working with `cath-resolve-hits`, ensure your input file follows the expected hit format (typically query ID, match ID, score, and residue boundaries).
- **Refining Alignments**: For high-precision tasks, use `cath-refine-align` to iteratively improve an existing alignment by optimizing the SSAP score.
- **Scoring**: If you already have an alignment and simply need to evaluate its structural quality, use `cath-score-align` rather than re-running the full SSAP alignment.
- **Installation**: The most reliable way to deploy the toolkit is via Bioconda: `conda install bioconda::cath-tools`.
- **Input Formats**: While the tools primarily handle PDB files, ensure that residue numbering and chain IDs are consistent, as structural alignment is sensitive to backbone completeness.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_UCLOrengoGroup_cath-tools.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_cath-tools_overview.md)