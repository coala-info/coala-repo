---
name: gb_taxonomy_tools
description: The gb_taxonomy_tools suite transforms GenBank IDs into structured NCBI taxonomic hierarchies and visualizations. Use when user asks to map GenBank IDs to taxonomy IDs, expand TaxIDs into full lineages, generate Newick trees, or render taxonomic trees as PostScript images.
homepage: https://github.com/spond/gb_taxonomy_tools
---


# gb_taxonomy_tools

## Overview

The `gb_taxonomy_tools` suite provides a specialized workflow for bioinformaticians to transform raw GenBank IDs (GIDs) into structured, hierarchical taxonomic data. It bridges the gap between sequence identifiers and the NCBI classification system, allowing for the generation of machine-readable Newick trees and publication-ready PostScript visualizations. This skill is particularly useful for summarizing the taxonomic composition of large sequence datasets.

## Core Workflow and CLI Usage

The tools are designed to be used sequentially, often involving large NCBI reference files.

### 1. Map GIDs to Taxonomy IDs (gid-taxid)
Converts a list of GenBank IDs and counts into GID-TaxID-Count triplets.
- **Requirement**: Access to the NCBI mapping file `gi_taxid_nucl.dmp`.
- **Command**: `gid-taxid <input_gid_file> <path_to_gi_taxid_nucl.dmp>`
- **Input Format**: Space-separated lines (e.g., `160338813 160`).

### 2. Expand Taxonomy (taxonomy-reader)
Converts TaxID triplets into a fully expanded 22-level NCBI taxonomy.
- **Requirement**: `names.dmp` and `nodes.dmp` from the NCBI `taxdump`.
- **Command**: `cat <input.taxid> | taxonomy-reader <names.dmp> <nodes.dmp> > <output.taxonomy>`
- **Note**: This tool typically reads from standard input.

### 3. Generate Trees and Summaries (taxonomy2tree)
Transforms expanded taxonomy files into Newick format and text summaries.
- **Command**: `taxonomy2tree <input.taxonomy> <mode> <output.tree> <output_summary.txt> <count_mode>`
- **Parameters**:
    - `mode`: Usually `0`.
    - `count_mode`: `0` to ignore counts, `1` to include them.

### 4. Visualize Trees (tree2ps)
Renders a Newick tree as a PostScript image.
- **Command**: `tree2ps <tree_file> <output.ps> <max_depth> <font_size> <max_leaves> <color_mode>`
- **Parameters**:
    - `max_depth`: Maximum steps from root (use `0` for all).
    - `max_leaves`: Display limit for tree density.
    - `color_mode`: `0` counts leaves; `1` counts duplicate TaxIDs for coloring.

## Expert Tips and Best Practices

- **Data Preparation**: Ensure your input GID files are clean and match the format expected by `gid-taxid`. The mapping files (`gi_taxid_nucl.dmp`) are extremely large; ensure sufficient disk space and memory are available before execution.
- **Piping Strategy**: For efficient processing, pipe the output of `gid-taxid` directly into `taxonomy-reader` to avoid creating large intermediate files.
- **Visualization Tuning**: When using `tree2ps`, start with a `max_depth` of `5` or `8` to avoid overcrowded PostScript files if your dataset is taxonomically diverse.
- **Reference Updates**: NCBI taxonomy is updated frequently. Always use the latest `taxdump.tar.gz` and mapping files to ensure accurate classification.

## Reference documentation
- [GenBank taxonomy processing tools](./references/github_com_spond_gb_taxonomy_tools.md)
- [gb_taxonomy_tools - bioconda](./references/anaconda_org_channels_bioconda_packages_gb_taxonomy_tools_overview.md)