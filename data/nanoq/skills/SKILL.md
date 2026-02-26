---
name: nanoq
description: Nanoq is a high-performance utility for filtering, trimming, and generating summary statistics for nanopore sequencing reads. Use when user asks to filter reads by length or quality, generate sequencing run reports, trim read ends, or output read statistics in JSON format.
homepage: https://github.com/esteinig/nanoq
---


# nanoq

## Overview

Nanoq is a high-performance Rust-based utility designed for the "minimal but speedy" processing of nanopore reads. It excels at pre-processing steps where speed is critical, such as filtering out short or low-quality reads before assembly or mapping, and providing immediate feedback on sequencing run performance. It supports compressed inputs and outputs natively and can be easily integrated into command-line pipes.

## Core CLI Patterns

### Basic Filtering
Filter reads by minimum length and average quality score.
```bash
nanoq -i input.fq.gz -l 1000 -q 10 -o filtered.fq.gz
```

### Summary Reporting
Generate a summary report to stdout without saving the filtered reads.
```bash
nanoq -i input.fq.gz -s
```

### Read Trimming
Remove a fixed number of bases from the start or end of every read.
```bash
nanoq -i input.fq -S 100 -E 50 > trimmed.fq
```

### Advanced Statistics
Generate a detailed, verbose report (similar to NanoStat) including top read lengths.
```bash
nanoq -i input.fq -vvv -t 10
```

## Expert Tips and Best Practices

- **Fast Mode**: Use the `-f` or `--fast` flag if you only need length-based statistics or filtering. This skips the computationally expensive quality score calculations, significantly increasing throughput.
- **JSON for Automation**: Use the `-j` flag to output summary statistics in JSON format, which is ideal for multi-sample tracking or automated pipeline triggers.
- **Streaming Data**: Nanoq is designed for pipes. You can check active sequencing runs by piping `find` and `xargs cat` into `nanoq -s`.
- **Compression Control**: While nanoq infers compression from file extensions (gz, bz2, xz), you can manually force output types using `-O` (u: uncompressed, g: gzip, b: bzip2, l: lzma) and set the compression level with `-c` (1-9).
- **Header Support**: When generating minimal reports for batch processing, use `-H` to include a machine-readable header for the columns.
- **Distribution Analysis**: Use `-L` and `-Q` to output raw read lengths and qualities to separate files. These are useful for quick plotting of distributions in R or Python.

## Reference documentation

- [Nanoq GitHub Repository](./references/github_com_esteinig_nanoq.md)
- [Nanoq Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_nanoq_overview.md)