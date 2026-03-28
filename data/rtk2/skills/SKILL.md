---
name: rtk2
description: rtk2 is a high-performance C++ tool designed for efficient matrix manipulation, rarefaction, and metagenomic data processing. Use when user asks to normalize sampling depth through rarefaction, convert gene clustering outputs into abundance matrices, or split large matrices into sub-matrices based on reference indices.
homepage: https://github.com/hildebra/rtk2/
---


# rtk2

## Overview

rtk2 is a high-performance C++ binary designed for efficient matrix manipulation, specifically tailored for metagenomic data processing within the MATAFILER framework. It provides specialized routines for normalizing data through rarefaction, performing "ultrafast" Fisher's Exact Tests, and converting gene clustering outputs into structured abundance matrices. It is particularly useful for researchers handling large-scale genomic tables where standard scripting languages may encounter memory or performance bottlenecks.

## Core Workflows

### Rarefaction
Use rtk2 to normalize sampling depth across multiple samples in an abundance matrix. This is critical for comparative metagenomics to ensure that differences in species or gene richness are not artifacts of sequencing depth.

### Gene Clustering to Matrix (ClStr2Mat)
rtk2 can transform clustering results (such as those from cd-hit) into a sample-by-gene abundance matrix.
- Requires a mapping file to link sequences to their original samples.
- Supports supplementary coverage calculations and gzip-compressed outputs to save disk space.

### Matrix Extraction and Splitting
The tool can split a master matrix into multiple sub-matrices based on a reference index file. This is useful for:
- Extracting specific rows (genes/taxa) belonging to functional bins.
- Organizing data by categories (e.g., splitting a global matrix into individual species-level matrices).

## CLI Usage Patterns

While specific flags are defined in the source headers, the following patterns represent the standard execution logic:

### Basic Matrix Operations
```bash
# General help and version info
./rtk2 -h

# Extract rows into multiple sub-matrices
# -i: Input matrix
# -o: Output directory
# -r: Reference/Index file for row-to-bin mapping
./rtk2 -i input_matrix.mat -o output_dir/ -r mapping_index.txt
```

### Gene Clustering Conversion
When converting clustering results to matrices, ensure your sample names follow the expected separator convention (default is `__`).
```bash
# Convert clustering output to matrix with mapping
# -m: Map file linking genes to samples
./rtk2 -i clustering.clstr -m sample_map.txt -o abundance_output
```

### Performance Tips
- **Gzip Support**: Use the `-z` flag (if enabled in your build) to stream output directly to `.gz` files, significantly reducing I/O overhead for large matrices.
- **Separator Control**: Use the `-s` flag to specify custom delimiters (e.g., commas for CSV or tabs for TSV) if your input data does not use standard whitespace.
- **Header Handling**: If your input matrix contains a header row, ensure the tool is aware of it to prevent the header from being treated as data.



## Subcommands

| Command | Description |
|---------|-------------|
| rtk | Reports the column sums of all columns in form of a sorted and an unsorted file. |
| rtk | rarefaction tool kit (rtk) |

## Reference documentation

- [Main README](./references/github_com_hildebra_rtk2_blob_main_README.md)
- [Matrix IO Operations](./references/github_com_hildebra_rtk2_blob_main_IO.cpp.md)
- [Gene Clustering Logic](./references/github_com_hildebra_rtk2_blob_main_ClStr2Mat.cpp.md)
- [Fisher's Exact Test Implementation](./references/github_com_hildebra_rtk2_blob_main_Fisher.cpp.md)