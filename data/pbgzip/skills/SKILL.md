---
name: pbgzip
description: pbgzip is a parallel block compression utility that creates gzip-compatible files using multiple CPU cores for increased speed. Use when user asks to compress files using parallel processing, create BGZF files for random access indexing, or decompress block-compressed data.
homepage: https://github.com/nh13/pbgzip
metadata:
  docker_image: "quay.io/biocontainers/pbgzip:2016.08.04--hb1d24b7_6"
---

# pbgzip

## Overview

pbgzip is a specialized utility that implements parallel block compression. By dividing data into independent blocks and processing them across multiple CPU cores, it achieves significantly higher compression speeds than single-threaded gzip. Because it uses the Block GZIP (BGZF) format, the resulting files remain compatible with standard gzip tools while enabling downstream applications (like samtools or tabix) to perform random retrieval of data without decompressing the entire file.

## Common CLI Patterns

### Basic Compression and Decompression
The tool generally follows gzip-like conventions for its primary operations:

*   **Compress a file**: `pbgzip [filename]`
*   **Decompress a file**: `pbgzip -d [filename.gz]`
*   **Write to stdout**: `pbgzip -c [filename] > [filename.gz]`
*   **Decompress to stdout**: `pbgzip -dc [filename.gz] | [next_command]`

### Parallel Processing
The primary advantage of pbgzip is its multi-threaded execution. While it often auto-detects available cores, you can typically specify the thread count to manage system resources:
*   **Specify threads**: `pbgzip -n [threads] [filename]` (Note: Check local version help as flag conventions can vary between pbgzip and standard bgzip).

### Genomics Workflows
pbgzip is a drop-in replacement for `bgzip` in bioinformatics pipelines:
*   **Prepare for indexing**: Use pbgzip to compress VCF or SAM files before running `tabix` or `samtools index`.
*   **BAM Optimization**: If the binary was compiled with `igzip` support, it provides a significant speedup for BAM/SAM formats with minimal loss in compression ratio.

## Expert Tips and Best Practices

### High-Entropy Data Limitation
A critical limitation of pbgzip is that it may fail when attempting to compress data with extremely high entropy (e.g., encrypted files or raw `/dev/urandom` streams). This occurs because the tool must fit a chunk of compressed data into a fixed maximum block size. If the data is too random to be compressed effectively, the block overflow causes the process to exit with an error. In these rare cases, use standard `bgzip` or `gzip`.

### Performance Tuning
*   **IGZIP and IPP**: For maximum performance on Intel systems, ensure the version of pbgzip in use was compiled with `--enable-igzip` and `--enable-ipp`. This can boost compression performance by an additional 20-30%.
*   **Pipe Efficiency**: When using pbgzip in a pipe (e.g., `sort -k1,1 | pbgzip -c`), ensure the upstream process is not the bottleneck, as pbgzip will likely process data faster than most single-threaded text manipulators can provide it.

### Troubleshooting "rpl_malloc"
If you are compiling pbgzip from source and encounter an `undefined reference to 'rpl_malloc'`, this is a known configuration issue. Resolve it by running:
`ac_cv_func_malloc_0_nonnull=yes ./configure [options]`

## Reference documentation
- [pbgzip - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_pbgzip_overview.md)
- [GitHub - nh13/pbgzip: Parallel Block GZIP](./references/github_com_nh13_pbgzip.md)