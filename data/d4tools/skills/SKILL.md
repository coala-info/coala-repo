---
name: d4tools
description: d4tools manages high-performance genomic signal data by converting, querying, and calculating statistics on files in the D4 format. Use when user asks to convert BAM, CRAM, BigWig, or BedGraph files to D4, query specific genomic regions, or calculate coverage statistics like mean and median.
homepage: https://github.com/38/d4-format
metadata:
  docker_image: "quay.io/biocontainers/d4tools:0.3.11--ha986137_3"
---

# d4tools

## Overview
The Dense Depth Data Dump (D4) format is a high-performance alternative to BigWig for storing and analyzing quantitative genomic signals like read depth. This skill enables the efficient conversion of common formats (BAM, CRAM, BigWig, BedGraph) into D4, as well as rapid querying and statistical summarization of these files. D4 is optimized for random access and multi-track data, making it ideal for large-scale genomic workflows where speed and disk space are critical.

## Core CLI Commands

### Creating D4 Files
The `create` subcommand converts existing genomic data into the D4 format.

*   **From BAM/CRAM (Recommended Pattern):**
    Use `-A` for automatic dictionary profiling and `-z` for deflate compression.
    `d4tools create -Azr <reference.fa.fai> <input.bam/cram> <output.d4>`
*   **From BigWig:**
    `d4tools create -z <input.bw> <output.d4>`
*   **From BedGraph:**
    Input must have the `.bedgraph` extension. Requires a genome description file.
    `d4tools create -z -g <genome_file> <input.bedgraph> <output.d4>`

### Viewing and Exporting Data
The `view` subcommand is used for data inspection and format conversion.

*   **Convert D4 to BedGraph:**
    `d4tools view <input.d4>`
*   **Query Specific Regions:**
    Format: `chr:start-end`
    `d4tools view <input.d4> chr1:1000000-2000000`
*   **Inspect Genome Layout:**
    `d4tools view -g <input.d4>`

### Calculating Statistics
The `stat` subcommand performs rapid aggregation over genomic intervals.

*   **Default Mean Coverage:**
    `d4tools stat <input.d4>`
*   **Specific Statistic Types:**
    Supported methods: `mean`, `median`, `hist`, `perc_cov`, `percentile=X%`.
    `d4tools stat -s median <input.d4>`
*   **Statistics for Specific Regions (BED file):**
    `d4tools stat -r <regions.bed> -s mean <input.d4>`

## Expert Tips and Best Practices

*   **Optimization with Sparse Mode:** Use the `-S` flag (Sparse mode) for datasets with many zero-coverage regions. This is equivalent to `-zR0-1`, which enables secondary table compression while disabling the primary table.
*   **Performance Tuning:** Always specify the number of threads with `-t <threads>` for large-scale creation or statistical tasks to leverage multi-core processing.
*   **Dictionary Selection:** If you know the range of your data values, you can manually set the dictionary range using `-R <a-b>` to avoid the overhead of the auto-profiling step.
*   **CRAM Requirements:** When converting from CRAM, you must provide the reference genome index (`.fai`) using the `-r` option.

## Reference documentation
- [GitHub - 38/d4-format](./references/github_com_38_d4-format.md)
- [d4tools - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_d4tools_overview.md)