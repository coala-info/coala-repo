---
name: ghost-tree
description: ghost-tree is a bioinformatics tool designed to solve the problem of missing phylogenetic information in high-resolution genetic markers like the fungal Internal Transcribed Spacer (ITS) region.
homepage: https://github.com/JTFouquier/ghost-tree
---

# ghost-tree

## Overview
ghost-tree is a bioinformatics tool designed to solve the problem of missing phylogenetic information in high-resolution genetic markers like the fungal Internal Transcribed Spacer (ITS) region. It functions by "grafting" finer taxonomic data onto a stable, broad-scale "foundation" tree. This allows researchers to perform phylogenetically-informed diversity analyses (like UniFrac) on groups where a single-gene tree would otherwise be unreliable or impossible to construct across all phyla.

## Installation and Dependencies
The tool is primarily distributed via Bioconda. It relies on three external binaries that must be present in your system PATH:

- **Installation**: `conda install -c bioconda ghost-tree`
- **Required Dependencies**:
  - MUSCLE (v3.8.31) for sequence alignment.
  - FastTree (v2.1.7+) for tree construction.
  - SUMACLUST (v1.0.01) for regrouping extension OTUs (highly recommended).

## Common CLI Patterns

### 1. Basic Usage
The primary interface is accessed via the `ghost-tree` command. Use the help flag to see available subcommands:
```bash
ghost-tree --help
```

### 2. Building a Hybrid Tree
While specific subcommands vary by version, the general workflow requires:
- A foundation tree (Newick format).
- Extension sequences (FASTA format).
- Taxonomy files mapping sequences to the foundation tree.

### 3. Preparing Data for Diversity Analysis
A critical step in using ghost-trees is ensuring your OTU table (.biom) matches the tips present in the generated tree. If the table contains OTUs not in the tree, downstream diversity scripts will fail.

**Step A: Extract valid OTUs from the tree**
Use the helper script to identify which accessions made it into the final tree:
```bash
python get_otus_from_ghost_tree.py ghost-tree.nwk
```
*Note: This requires the `skbio` (scikit-bio) library.*

**Step B: Filter the BIOM table**
Use the QIIME-style filtering pattern to keep only the OTUs identified in Step A:
```bash
filter_otus_from_otu_table.py -i original_table.biom -o filtered_table.biom -e ghost_tree_tips.txt --negate_ids_to_exclude
```

## Expert Tips and Best Practices
- **Database Matching**: Ensure the ghost-tree you build (or download) matches the specific version of the UNITE database used for your OTU picking. Incompatibility between database versions is a common source of empty filtered tables.
- **Foundation Selection**: For fungal ITS studies, a SILVA-based 18S tree is the standard foundation.
- **Clustering**: Always use the SUMACLUST option if available in your workflow version. Regrouping extension OTUs significantly improves the biological relevance of the grafted branches.
- **Pre-built Trees**: For standard ITS analyses, check the official ghost-tree repository for pre-built `.nwk` files to save significant computation time.
- **QIIME 2 Transition**: While ghost-tree originated in the QIIME 1 ecosystem, current best practice is to use the `q2-ghost-tree` plugin for modern QIIME 2 workflows.

## Reference documentation
- [ghost-tree GitHub Repository](./references/github_com_JTFouquier_ghost-tree.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_ghost-tree_overview.md)