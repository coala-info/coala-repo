---
name: bigtools
description: bigtools is a high-performance suite of utilities for processing, converting, and analyzing BigWig and BigBed genomic file formats. Use when user asks to view metadata, convert bedGraph or BED files to BigWig or BigBed, calculate signal averages over genomic regions, or merge multiple signal tracks.
homepage: https://github.com/jackh726/bigtools/
metadata:
  docker_image: "quay.io/biocontainers/bigtools:0.5.6--hc1c3326_1"
---

# bigtools

## Overview

bigtools is a high-performance, Rust-based suite of utilities designed to handle BigWig and BigBed files, which are standard formats for genomic signal tracks and features. It serves as a modern, multi-threaded alternative to the traditional UCSC genome browser tools. Use this skill to perform efficient data conversions, calculate statistics over genomic regions, and merge multiple signal tracks with minimal memory overhead.

## CLI Usage and Subcommands

The `bigtools` binary provides access to several subcommands. You can call them as `bigtools <subcommand>` or, if installed via certain package managers, as standalone binaries (e.g., `bigwiginfo`).

### File Information and Extraction
*   **View metadata**: Use `bigwiginfo` or `bigbedinfo` to see header information, chromosome lists, and summary statistics.
    ```bash
    bigtools bigwiginfo input.bigWig
    ```
*   **Convert to text**: Use `bigwigtobedgraph` or `bigbedtobed` to extract raw data into human-readable formats.
    ```bash
    bigtools bigwigtobedgraph input.bigWig output.bedGraph
    ```

### Creating BigWig and BigBed Files
*   **From bedGraph**: `bedgraphtobigwig` requires a bedGraph file and a chromosome sizes file.
    ```bash
    bigtools bedgraphtobigwig input.bedGraph chrom.sizes output.bw
    ```
*   **From BED**: `bedtobigbed` converts feature files.
    ```bash
    bigtools bedtobigbed input.bed chrom.sizes output.bb
    ```

### Analysis and Merging
*   **Calculate Averages**: `bigwigaverageoverbed` computes signal statistics (mean, min, max) from a BigWig over regions defined in a BED file.
    ```bash
    bigtools bigwigaverageoverbed input.bw regions.bed output.tab
    ```
*   **Merge Tracks**: `bigwigmerge` combines multiple BigWig files into a single output.
    ```bash
    bigtools bigwigmerge in1.bw in2.bw in3.bw merged.bw
    ```

## Expert Tips and Best Practices

*   **Performance**: bigtools uses async/await and multi-core processing. For large-scale merges or conversions, ensure your environment allows for multi-threaded execution to take full advantage of the Rust backend.
*   **Standard Input**: Many subcommands support `/dev/stdin` or `-` for input, allowing you to pipe data from other bioinformatics tools (like `sort` or `awk`) directly into bigtools without intermediate files.
*   **UCSC Compatibility**: The CLI flags are designed to be drop-in replacements for the original UCSC binaries. If you have existing scripts using `bedGraphToBigWig`, you can often swap the binary name with minimal changes.
*   **Memory Efficiency**: Unlike some older tools that load entire datasets into memory, bigtools is optimized for low memory footprints, making it suitable for processing very large chromosomes or high-density signal tracks on standard workstations.

## Reference documentation
- [Bigtools GitHub README](./references/github_com_jackh726_bigtools.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_bigtools_overview.md)