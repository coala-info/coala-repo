---
name: yame
description: YAME is a toolkit for the efficient storage, compression, and manipulation of DNA methylation data using specialized binary formats. Use when user asks to pack methylation data into CX formats, downsample methylation sites, subset rows, or generate summary statistics for methylation matrices.
homepage: https://github.com/zhou-lab/YAME
metadata:
  docker_image: "quay.io/biocontainers/yame:1.8--ha83d96e_0"
---

# yame

## Overview

YAME (Yet Another Methylation Encoder) is a specialized toolkit designed for the efficient storage and manipulation of DNA methylation data. It introduces the "CX" family of binary formats, which utilize BGZF compression to store methylation values, MU counts, and genomic coordinates in a uniform structure. It is particularly useful for researchers needing to scale methylation analysis to hundreds of thousands of single cells while maintaining high performance and low storage overhead.

## Core CLI Usage

YAME follows a standard command-line interface pattern where the primary binary `yame` is followed by a specific subcommand.

### Installation
Install via Bioconda:
```bash
conda install yame -c bioconda
```

### Primary Subcommands
- **pack**: Convert raw methylation data into compressed CX binary formats.
- **unpack**: Extract data from CX formats back into human-readable or downstream-compatible formats.
- **dsample**: Downsample methylation data (use `-b` for specific downsampling logic).
- **rowsub**: Subset rows from a methylation matrix.
- **rowop**: Perform row-wise operations (e.g., `rowop -o stat` to generate statistics).
- **split**: Split methylation files (use `-s` for specific splitting criteria).
- **summary**: Generate summary statistics for CX files.
- **enrichment**: Perform enrichment testing on methylation sites.

## Expert Tips and Best Practices

- **CX Format Selection**: YAME supports multiple CX format variants (e.g., MU counts, binary states, fractions). Ensure you select the format that matches your data precision requirements to maximize compression.
- **Single-Cell Scaling**: When working with single-cell data, use the binary methylation or categorical state formats to handle the sparsity of the data efficiently.
- **BGZF Integration**: Since YAME uses BGZF frames, the output files are compatible with tools that support blocked GZIP, allowing for random access and indexing.
- **Piping**: YAME is designed to integrate with standard bioinformatics pipelines. You can often pipe output to `bedtools` or other genomic utilities for multi-omic analysis.
- **Memory Management**: For extremely large matrices, prefer `rowsub` and `rowop` to process data in chunks rather than loading entire datasets into memory.



## Subcommands

| Command | Description |
|---------|-------------|
| yame binarize | Convert per-site M/U counts (format 3) into a packed binary-with-universe track (format 6). |
| yame chunk | Chunk a .cx file into smaller pieces. |
| yame chunkchar | Chunk a text file into characters. |
| yame dsample | Downsample methylation data for format 3 or 6.   - For format 3, downsampling masks by setting M=U=0.   - For format 6, downsampling masks by clearing the universe bit. |
| yame hprint | Print data transposed / horizontally. |
| yame index | The index file name default to <in.cx>.idx |
| yame info | Report information about a YAME file. |
| yame mask | Masking tool for CG files |
| yame pairwise | Compute a per-site differential-methylation set between two format-3 (M/U) samples, and output it as a single format-6 track (set + universe). |
| yame rowop | Perform row-wise operations across multiple records (samples) in a CX file.   Depending on the operation, output is either a new CX file or plain text. |
| yame rowsub | Subset (slice) rows from each dataset (record) in a CX stream. Output is always written to stdout. |
| yame split | Split a cx file into multiple files based on sample names. |
| yame subset | Subset a multi-sample .cx by sample names (requires an index), or (with -s) convert a format-2 state track into one binary track per state. |
| yame summary | Summarize a query feature set (or per-state composition) and optionally its overlap/enrichment against one or more masks. |
| yame_pack | Pack tab-delimited text into a compressed cx file. |
| yame_unpack | Print selected records from a .cx file as a tab-delimited table. Each output row is a genomic row index; each output column is a selected sample/record. |

## Reference documentation
- [github_com_zhou-lab_YAME_blob_main_README.md](./references/github_com_zhou-lab_YAME_blob_main_README.md)
- [github_com_zhou-lab_YAME_commits_main.md](./references/github_com_zhou-lab_YAME_commits_main.md)
- [anaconda_org_channels_bioconda_packages_yame_overview.md](./references/anaconda_org_channels_bioconda_packages_yame_overview.md)