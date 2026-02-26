---
name: bwtk
description: "bwtk is a specialized toolkit for efficiently creating, merging, and manipulating bigWig files in genomics. Use when user asks to convert bedGraph files to bigWig, merge multiple tracks, extract base-resolution scores, or optimize file size through binning and mathematical transformations."
homepage: https://github.com/bjmt/bwtk
---


# bwtk

## Overview
bwtk is a specialized toolkit designed for the efficient handling of bigWig files, which are indexed binary formats used in genomics for fast data retrieval. It improves upon traditional UCSC tools by supporting gzipped bedGraph inputs and providing advanced binning capabilities. Use this tool when you need to perform multi-track aggregations, extract base-resolution scores for specific genomic intervals, or optimize large datasets for storage and visualization without losing significant signal resolution.

## Core Command Patterns

### File Conversion and Creation
*   **Convert bedGraph to bigWig**: Supports compressed inputs directly.
    `bwtk bg2bw -i input.bedGraph.gz -g chrom.sizes -o output.bw`
*   **Merge multiple bigWigs**: Combine tracks using mathematical operations.
    `bwtk merge -i file1.bw file2.bw file3.bw -o merged.bw [operation]`
    *Operations include: `sum`, `mean`, `min`, `max`.*

### Data Transformation and Optimization
*   **Adjust and Subset**: Modify a single bigWig file.
    `bwtk adjust -i input.bw -o adjusted.bw [options]`
    *   **Subsetting**: Use `-r` to specify a single region (e.g., `chr1:100-200`).
    *   **Math**: Apply transformations like `-l` (log10), `-a [val]` (addition), or `-m [val]` (multiplication).
*   **Binning for Compression**: Drastically reduce file size by rounding values.
    `bwtk adjust -i input.bw -s 0.5 -o binned.bw`
    *A bin step (`-s`) of 0.5 or 1.0 can often reduce file size by 20x-30x while maintaining visual peak shapes.*

### Data Extraction and Statistics
*   **Chromosome Statistics**: Get summary info (mean, min, max, coverage) per chromosome.
    `bwtk score -i input.bw -o-`
*   **Base-Resolution Extraction**: Get scores for specific BED ranges.
    `bwtk values -i input.bw -b regions.bed -o scores.txt`
*   **List Chromosomes**: Retrieve names and sizes from a bigWig header.
    `bwtk chroms -i input.bw`

## Expert Tips and Best Practices

### Memory Management
Creating new bigWig files (via `bg2bw`, `adjust`, or `merge`) involves an indexing step that can be memory-intensive. For large genomes or high-resolution files, ensure the environment has several gigabytes of RAM available. Other subcommands like `score` or `values` are lightweight and require minimal memory.

### Optimization Workflow
To balance file size and data fidelity for genome browsers (like IGV):
1.  Run `bwtk score` to understand the value distribution (min/max/mean).
2.  Apply `bwtk adjust -s [step]` to bin the data. 
    *   Use `-s 0.1` for high-fidelity research data.
    *   Use `-s 0.5` or `-s 1.0` for general visualization and storage efficiency.

### Remote Files
If the underlying `libBigWig` was compiled with curl support, `bwtk` can operate on remote URLs. If you encounter errors with remote paths, you may need to download the file locally or ensure the tool was dynamically linked with a curl-enabled version of the library.

## Reference documentation
- [bwtk GitHub Repository](./references/github_com_bjmt_bwtk.md)