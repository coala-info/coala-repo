---
name: chromosight
description: Chromosight identifies spatial patterns such as loops and boundaries in chromosome contact maps using computer vision and template matching. Use when user asks to detect chromatin patterns, quantify matching scores for specific coordinates, or generate custom kernels for genomic features.
homepage: https://github.com/koszullab/chromosight
---


# chromosight

## Overview

Chromosight is a computer vision-based tool designed for the high-throughput identification of spatial patterns in chromosome contact maps. It leverages template matching to find specific structures like loops and boundaries, allowing for both the discovery of new features and the quantification of known ones across different datasets. Use this skill to guide the execution of pattern detection workflows, optimize parameters for low-coverage data, or generate custom kernels for specialized genomic features.

## Core Subcommands

- `detect`: The primary command used to find patterns (loops, borders, etc.) in a contact map.
- `quantify`: Computes pattern matching scores for a provided list of 2D coordinates on a Hi-C matrix.
- `list-kernels`: Displays information about available pattern presets.
- `generate-config`: Creates a new pattern template (kernel) that can be used with the `--custom-kernel` option in `detect`.
- `test`: Downloads a small dataset and runs a sample detection to verify the installation.

## Common CLI Patterns

### Basic Loop Detection
To detect chromatin loops within a specific genomic distance range (e.g., 20kb to 200kb) using multiple threads:
```bash
chromosight detect --threads 8 --min-dist 20000 --max-dist 200000 input_data.cool output_prefix
```

### Quantifying Existing Coordinates
To score a set of known coordinates against a contact map:
```bash
chromosight quantify coordinates.bed input_data.cool output_prefix
```

## Expert Tips and Parameter Tuning

### Sensitivity and Specificity
- **`--pearson`**: This is the detection threshold. Lowering this value increases sensitivity (more patterns detected) but may increase false positives. Note that extremely low values can sometimes reduce the count due to the algorithm merging neighboring patterns.
- **`--min-separation`**: Use this to control the minimum distance between two detected patterns to avoid redundant calls.

### Handling Low Coverage
- **`--perc-zero`**: If working with low-coverage Hi-C data, increase the proportion of allowed zero pixels in a window to improve detection success.
- **`--perc-undetected`**: Adjust this if many regions are being skipped due to missing data.

### Performance Optimization
- **`--max-dist`**: Genomic distance significantly impacts memory and runtime. Always set a realistic maximum distance relevant to the biological feature (e.g., 2Mb for loops) to keep the tool efficient.
- **`--threads`**: Chromosight is parallelized; always specify threads to match your hardware capabilities.

### Custom Patterns
If the built-in kernels (loops, borders, centromeres, hairpins) are insufficient, use `generate-config` to create a custom kernel based on a specific region of your contact map.



## Subcommands

| Command | Description |
|---------|-------------|
| chromosight | Explore and detect patterns (loops, borders, centromeres, etc.) in Hi-C contact maps with pattern matching. |
| chromosight | Explore and detect patterns (loops, borders, centromeres, etc.) in Hi-C contact maps with pattern matching. |
| chromosight | Explore and detect patterns (loops, borders, centromeres, etc.) in Hi-C contact maps with pattern matching. |
| chromosight detect | Explore and detect patterns (loops, borders, centromeres, etc.) in Hi-C contact maps with pattern matching. |
| quantify | Given a list of pairs of positions and a contact map, computes the correlation coefficients between those positions and the kernel of the selected pattern. |

## Reference documentation
- [Chromosight Main Repository](./references/github_com_koszullab_chromosight_blob_master_README.md)
- [Chromosight Overview](./references/github_com_koszullab_chromosight.md)