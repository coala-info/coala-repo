---
name: pybigtools
description: pybigtools is a high-performance library and command-line tool for reading, writing, and manipulating BigWig and BigBed files. Use when user asks to convert between BigWig/BigBed and BED/bedGraph formats, calculate signal statistics over genomic regions, merge multiple BigWig tracks, or access genomic data programmatically using Python.
homepage: https://github.com/jackh726/bigtools/
---


# pybigtools

## Overview

pybigtools is a Python wrapper for the Bigtools Rust library, designed for high-performance I/O of BigWig and BigBed files. It provides a modern, thread-safe, and memory-efficient alternative to older tools. This skill covers both the command-line interface (CLI) for common bioinformatics workflows and the Python API for programmatic data access.

## CLI Usage Patterns

The `bigtools` binary provides several subcommands that are drop-in replacements for UCSC tools but optimized for speed.

### File Information and Extraction
*   **View metadata**: `bigtools bigwiginfo input.bw` or `bigtools bigbedinfo input.bb`
*   **Convert to text**:
    *   BigWig to bedGraph: `bigtools bigwigtobedgraph input.bw output.bedGraph`
    *   BigBed to BED: `bigtools bigbedtobed input.bb output.bed`

### File Creation
*   **BigWig from bedGraph**: `bigtools bedgraphtobigwig input.bedGraph chrom.sizes output.bw`
*   **BigBed from BED**: `bigtools bedtobigbed input.bed chrom.sizes output.bb`
*   **Handling Stdin**: Use `-` as an input argument to pipe data directly (e.g., `cat data.bed | bigtools bedtobigbed - chrom.sizes out.bb`).

### Signal Analysis
*   **Average over regions**: Calculate statistics for BED regions using BigWig signal.
    `bigtools bigwigaverageoverbed input.bw regions.bed output.tab`
*   **Per-base values**: Get exact values for every base in a region.
    `bigtools bigwigvaluesoverbed input.bw regions.bed output.tab`

### Merging Tracks
*   **Merge multiple BigWigs**: Combine several signal files into one.
    `bigtools bigwigmerge in1.bw in2.bw in3.bw output.bw`

## Python API Best Practices

The `pybigtools` library allows for fast programmatic access within Python scripts.

### Reading Data
```python
import pybigtools

# Open a BigWig file
reader = pybigtools.BigWigRead.open("data.bigWig")

# Fetch intervals for a specific chromosome and range
# Returns an iterator of (start, end, value)
intervals = reader.get_interval("chr1", 0, 10000)
for start, end, val in intervals:
    print(f"{start}-{end}: {val}")
```

### Performance Tips
1.  **Memory Efficiency**: The library is designed for minimal memory overhead. Avoid converting large iterators into lists unless necessary.
2.  **Multi-threading**: The underlying Rust library uses async/await for multi-core computation. When running CLI tools, performance scales well with available CPU cores.
3.  **Chrom.sizes**: Always ensure your `chrom.sizes` file matches the assembly used to generate your BED/bedGraph files to avoid coordinate errors.

## Reference documentation
- [github_com_jackh726_bigtools.md](./references/github_com_jackh726_bigtools.md)
- [anaconda_org_channels_bioconda_packages_pybigtools_overview.md](./references/anaconda_org_channels_bioconda_packages_pybigtools_overview.md)