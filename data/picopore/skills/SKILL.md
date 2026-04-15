---
name: picopore
description: Picopore compresses Oxford Nanopore FAST5 files using HDF5 compression and selective data removal to reduce storage requirements. Use when user asks to shrink FAST5 files, apply lossless or raw compression to nanopore data, or revert compressed files to their original state.
homepage: https://github.com/scottgigante/picopore
metadata:
  docker_image: "quay.io/biocontainers/picopore:1.2.0--pyh8b68c5b_1"
---

# picopore

## Overview
Picopore is a specialized utility for shrinking Oxford Nanopore FAST5 files by leveraging HDF5 compression and selective data removal. It offers three distinct tiers of compression: Lossless (standard HDF5 gzip), Deep Lossless (structural indexing), and Raw (removal of intermediate "squiggle-space" event data). While newer ONT files often include native compression, Picopore remains highly effective for legacy datasets and for users who only require raw signals and FASTQ data without the overhead of intermediate basecalling datasets.

## Command Line Usage

### Primary Compression Modes
The tool requires a specific mode to be selected for any operation:

*   **Lossless**: Uses HDF5's built-in gzip. Best for general storage reduction while maintaining compatibility with all tools.
    ```bash
    picopore --mode lossless /path/to/fast5/
    ```
*   **Deep Lossless**: More aggressive structural changes. Files must be reverted before they can be read by most third-party tools.
    ```bash
    picopore --mode deep-lossless /path/to/fast5/
    ```
*   **Raw**: Removes event detection and basecall intermediate data. This provides the most significant space savings.
    ```bash
    picopore --mode raw --fastq --no-summary /path/to/fast5/
    ```

### Real-time and Utility Commands
*   **Real-time Compression**: Monitor a directory during a sequencing run to compress files as they are generated.
    ```bash
    picopore-realtime --mode raw --threads 4 /data/sequencing_run/
    ```
*   **Reverting Files**: Restore files to their original state (applicable to lossless and deep-lossless modes).
    ```bash
    picopore --mode deep-lossless --revert /path/to/compressed_files/
    ```
*   **Testing Integrity**: Verify that compression did not corrupt or alter the data (lossless modes only).
    ```bash
    picopore-test --mode lossless /path/to/files/
    ```

## Expert Tips and Best Practices

### Mode Selection Strategy
*   **Post-2017 Data**: Oxford Nanopore implemented native HDF5 compression in May 2017. If your files were basecalled recently, `lossless` mode will likely yield zero additional space savings. Use `raw` mode instead if you do not need "squiggle" data.
*   **Tool Compatibility**: If you plan to use `nanopolish`, `nanoraw`, or `nanonettrain`, avoid `raw` mode unless you are prepared to re-basecall the files later to regenerate the event detection data.
*   **Manual Group Removal**: For advanced users, use the `--manual` flag with regular expressions to target specific HDF5 groups for removal in raw mode.
    ```bash
    picopore --mode raw --manual "1D.*Events" /path/to/files/
    ```

### Performance Optimization
*   **Multi-threading**: Use the `-t` or `--threads` flag to speed up processing on large datasets.
*   **Prefixing**: When testing workflows, use `--prefix` to create compressed copies rather than overwriting original data in-place.
*   **Silent Operation**: When running in automated pipelines, use `--print-every -1` to silence progress dots.



## Subcommands

| Command | Description |
|---------|-------------|
| picopore | A tool for reducing the size of an Oxford Nanopore Technologies dataset without losing any data |
| picopore-realtime | A tool for monitoring a directory for new Oxford Nanopore Technologies reads and compressing them in real time without losing data. |
| picopore-test | A tool for reducing the size of an Oxford Nanopore Technologies dataset without losing any data. picopore-test compresses to temporary files and checks that all datasets and attributes are equal (lossless modes only). |

## Reference documentation
- [Picopore README and Usage Guide](./references/github_com_scottgigante_picopore_blob_master_README.rst.md)