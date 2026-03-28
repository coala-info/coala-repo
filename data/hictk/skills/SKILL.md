---
name: hictk
description: "hictk is a high-performance toolkit for processing and converting between .hic and .cool Hi-C data formats. Use when user asks to convert between Hi-C file formats, extract interaction matrices, normalize contact maps using balancing algorithms, or create multi-resolution files."
homepage: https://github.com/paulsengroup/hictk
---


# hictk

## Overview
`hictk` is a high-performance C++ toolkit and CLI designed to provide a unified interface for the most common Hi-C data formats. It solves the interoperability challenge in 3D genomics by allowing users to treat `.cool` and `.hic` files almost interchangeably. This skill provides the necessary command patterns for efficient data transformation, normalization, and extraction using the `hictk` binary.

## Common CLI Patterns

### File Conversion
The most frequent use case for `hictk` is converting between the Cooler and Juicer ecosystems.

- **Convert .hic to .cool**:
  ```bash
  hictk convert input.hic output.cool --resolution 2500000
  ```
- **Convert .cool to .hic**:
  ```bash
  hictk convert input.cool output.hic
  ```

### Data Extraction (Dumping)
Extract interaction counts in various formats (triplet, BG2, or dense matrices).

- **Dump to Triplet format**:
  ```bash
  hictk dump input.hic --resolution 50000 --range chr1:0-1,000,000
  ```
- **Dump a specific chromosome pair (Inter-chromosomal)**:
  ```bash
  hictk dump input.mcool --resolution 1000000 --range1 chr1 --range2 chr2
  ```
- **Output as a dense matrix**:
  ```bash
  hictk dump input.cool --format dense
  ```

### Matrix Balancing (Normalization)
`hictk` implements fast balancing algorithms (like ICE) to normalize contact maps.

- **Balance a .cool file**:
  ```bash
  hictk balance input.cool --mode ICE
  ```
- **Balance with specific constraints**:
  ```bash
  hictk balance input.cool --max-iters 500 --tolerance 1e-5
  ```

### Multi-resolution Management
- **Zoomify (Create .mcool from .cool)**:
  ```bash
  hictk zoomify input.cool output.mcool --resolutions 1000,5000,10000
  ```
- **Load/Create from pairs**:
  ```bash
  hictk load --bins genome.bins input.pairs.gz output.cool
  ```

### Metadata and Validation
- **Inspect file metadata**:
  ```bash
  hictk metadata input.hic
  ```
- **Validate file integrity**:
  ```bash
  hictk validate input.mcool
  ```

## Expert Tips
- **Resolution Selection**: When working with `.hic` or `.mcool` files, always specify the `--resolution` flag, as these files contain data at multiple scales.
- **Memory Efficiency**: For large-scale conversions, use the `--tmpdir` flag to specify a high-speed SSD directory for temporary files.
- **Query Syntax**: The `--range` argument supports standard genomic coordinates (`chr:start-end`) or just chromosome names (`chr1`).
- **Parallelization**: Many `hictk` commands support multi-threading via the `--threads` flag to significantly speed up balancing and conversion.



## Subcommands

| Command | Description |
|---------|-------------|
| hictk | Blazing fast tools to work with .hic and .cool files. |
| hictk | Blazing fast tools to work with .hic and .cool files. |
| hictk convert | Convert Hi-C files between different formats. |
| hictk dump | Read interactions and other kinds of data from .hic and Cooler files and write them to stdout. |
| hictk fix-mcool | Fix corrupted .mcool files. |
| hictk load | Build .cool and .hic files from interactions in various text formats. |
| hictk merge | Merge multiple Cooler or .hic files into a single file. |
| hictk metadata | Print file metadata to stdout. |
| hictk validate | Validate .hic and Cooler files. |
| hictk zoomify | Convert single-resolution Cooler and .hic files to multi-resolution by coarsening. |

## Reference documentation
- [hictk CLI Reference](./references/hictk_readthedocs_io_en_stable_cli_reference.html.md)
- [Quickstart CLI Guide](./references/hictk_readthedocs_io_en_stable_quickstart_cli.html.md)
- [Format Conversion Guide](./references/hictk_readthedocs_io_en_stable_format_conversion.html.md)
- [Balancing Matrices](./references/hictk_readthedocs_io_en_stable_balancing_matrices.html.md)