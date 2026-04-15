---
name: gb_taxonomy_tools
description: This tool maps biological sequence identifiers to the NCBI taxonomic hierarchy and generates structured classifications, summaries, and tree visualizations. Use when user asks to map GenBank IDs to TaxIDs, expand TaxIDs into full taxonomic rankings, generate Newick tree files, or visualize taxonomy in PostScript format.
homepage: https://github.com/spond/gb_taxonomy_tools
metadata:
  docker_image: "quay.io/biocontainers/gb_taxonomy_tools:1.0.1--h503566f_7"
---

# gb_taxonomy_tools

## Overview
The `gb_taxonomy_tools` suite provides a high-performance pipeline for mapping biological sequence identifiers to the NCBI taxonomic hierarchy. It is designed to handle large-scale datasets, transforming raw GenBank IDs into structured 22-level taxonomic classifications, summaries, and visual tree representations.

## Installation and Setup
To build the tools from source, use CMake:
```bash
cmake ./
make install
```
By default, binaries are installed to `/usr/local/bin`.

## Core Workflow and CLI Usage

### 1. Convert GID to TaxID
Use `gid-taxid` to map GenBank IDs to their corresponding NCBI Taxonomy IDs. This tool requires the NCBI mapping file (e.g., `gi_taxid_nucl.dmp`).

**Command:**
`gid-taxid <input_gid_file> <mapping_file>`

**Example:**
`gid-taxid tests/data/test.gid path/to/gi_taxid_nucl.dmp > output.taxid`

### 2. Expand TaxIDs to Full Rankings
Use `taxonomy-reader` to transform TaxID triplets into a 22-level expanded taxonomy. This requires `names.dmp` and `nodes.dmp` from the NCBI taxdump.

**Command (Piped):**
`cat output.taxid | taxonomy-reader <names.dmp> <nodes.dmp> > output.taxonomy`

### 3. Generate Trees and Summaries
Use `taxonomy2tree` to convert the expanded taxonomy into a Newick tree file and a tabular summary.

**Command:**
`taxonomy2tree <input.taxonomy> <mode> <output.tree> <output_summary.txt> <root_id>`

*   **mode**: Usually set to `0`.
*   **root_id**: The TaxID to use as the root (e.g., `0` for the absolute root).

### 4. Visualize Taxonomy
Use `tree2ps` to render the Newick tree into a PostScript image.

**Command:**
`tree2ps <tree_file> <output.ps> <max_depth> <font_size> <max_leaves> <color_mode>`

**Parameters:**
*   **max_depth**: Maximum steps from root (use `0` for all levels).
*   **font_size**: Size in points.
*   **max_leaves**: Display limit for tree width.
*   **color_mode**: Set to `1` to color by duplicate TaxID counts; `0` to count unique leaves only.

## Expert Tips and Best Practices
*   **Data Requirements**: Ensure you have downloaded the latest `taxdump.tar.gz` and `gi_taxid_nucl.dmp.gz` from the NCBI FTP server (`ftp://ftp.ncbi.nih.gov/pub/taxonomy/`), as these tools rely on local access to these large mapping files.
*   **Stream Processing**: `taxonomy-reader` is designed to read from `stdin`. Always pipe the output of `gid-taxid` or `cat` your taxid files directly into it to avoid creating unnecessary intermediate files.
*   **Tree Pruning**: When using `tree2ps` on large datasets, start with a `max_depth` of `5` or `8` to avoid creating unreadable, overly dense PostScript files.
*   **Memory Efficiency**: The tools use buffered reads to accelerate I/O. When processing millions of IDs, ensure the host system has sufficient RAM to handle the loaded taxonomy nodes.



## Subcommands

| Command | Description |
|---------|-------------|
| gid-taxid | Maps GenBank IDs to TaxIDs using a provided mapping file. |
| taxonomy-reader | Reads GenBank taxonomic information from provided map and hierarchy files. |
| taxonomy2tree | Converts a taxonomy dump file into a tree structure and a summary. |
| tree2ps | Converts a Newick tree file to a PostScript file. |

## Reference documentation
- [GenBank taxonomy processing tools](./references/github_com_spond_gb_taxonomy_tools.md)