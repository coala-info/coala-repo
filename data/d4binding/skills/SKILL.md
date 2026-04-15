---
name: d4binding
description: d4binding provides a high-performance interface for converting, querying, and performing statistical analysis on quantitative genomics data in the D4 format. Use when user asks to convert alignment files to D4, extract genomic data, or calculate coverage statistics across specific intervals.
homepage: https://github.com/38/d4-format
metadata:
  docker_image: "quay.io/biocontainers/d4binding:0.3.11--ha986137_4"
---

# d4binding

## Overview
The D4 format is designed for efficient storage and rapid analysis of quantitative genomics datasets, such as RNA-seq, ChIP-seq, and WGS depth profiles. It provides significant speed improvements (up to 440x) over traditional formats for random access and data aggregation. This skill covers the native `d4tools` command-line interface for converting alignment files to D4, extracting data, and performing statistical summaries on genomic intervals.

## Installation
The tool is available via Bioconda:
```bash
conda install bioconda::d4binding
```

## Common CLI Patterns

### Creating D4 Files
The `create` command converts various formats (BAM, CRAM, BigWig, BedGraph) into D4.

*   **From BAM/CRAM (Recommended for WGS):**
    Use `-A` for automatic dictionary detection and `-z` for deflate compression.
    ```bash
    d4tools create -Azr reference.fa.fai input.bam output.d4
    ```
*   **From BigWig:**
    ```bash
    d4tools create -z input.bw output.d4
    ```
*   **Sparse Mode:**
    Use `-S` for datasets with large regions of zero or constant depth to minimize file size.
    ```bash
    d4tools create -S input.bam output.d4
    ```

### Viewing and Exporting Data
The `view` command extracts data or converts D4 back to BedGraph format.

*   **Convert to BedGraph:**
    ```bash
    d4tools view input.d4 > output.bedgraph
    ```
*   **Query Specific Regions:**
    Format: `chr:start-end`
    ```bash
    d4tools view input.d4 chr1:1000000-1200000 X:5000-6000
    ```
*   **Check Genome Layout:**
    ```bash
    d4tools view -g input.d4
    ```

### Statistical Analysis
The `stat` command performs rapid calculations on arbitrary intervals.

*   **Calculate Mean Coverage (Default):**
    ```bash
    d4tools stat input.d4
    ```
*   **Calculate Median or Percentiles:**
    ```bash
    d4tools stat -s median input.d4
    d4tools stat -s percentile=95 input.d4
    ```
*   **Calculate Statistics for Specific Regions (BED file):**
    ```bash
    d4tools stat -r regions.bed input.d4
    ```

## Expert Tips
*   **Threading:** Use the `-t` flag with `create` and `stat` to specify the number of threads for parallel processing, which significantly improves performance on large WGS files.
*   **Dictionary Optimization:** If you know the range of your data values, use `-R <start-end>` during creation to manually set the encoding range instead of using `-A` (auto-sampling), which can be slightly faster.
*   **CRAM Requirements:** When converting from CRAM, always provide the reference fasta index (`.fai`) using the `-r` flag.
*   **Multi-track Support:** D4 supports multiple tracks in a single file. While `d4tools` handles basic operations, the Python API (`pyd4`) is often more flexible for complex multi-track manipulation.

## Reference documentation
- [The D4 Quantitative Data Format](./references/github_com_38_d4-format.md)
- [d4binding - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_d4binding_overview.md)