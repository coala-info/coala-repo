---
name: pigz
description: `pigz` (Parallel Implementation of GZip) is a high-performance, multi-threaded replacement for the standard `gzip` utility.
homepage: https://github.com/madler/pigz
---

# pigz

## Overview
`pigz` (Parallel Implementation of GZip) is a high-performance, multi-threaded replacement for the standard `gzip` utility. It achieves superior speed by splitting input data into blocks and processing them simultaneously across all available processors and cores. The resulting output is fully compatible with the gzip format, meaning files compressed with `pigz` can be decompressed by standard `gzip` and vice versa.

## Common CLI Patterns

### Basic Compression and Decompression
*   **Compress a file**: `pigz filename` (replaces original with `filename.gz`)
*   **Decompress a file**: `pigz -d filename.gz` or use the alias `unpigz filename.gz`
*   **Keep the original file**: `pigz -k filename`
*   **Compress a directory (via tar)**: `tar cf - directory/ | pigz > directory.tar.gz`

### Performance Tuning
*   **Specify number of processors**: `pigz -p 8 filename` (default uses all available cores)
*   **Adjust compression level**: `-0` (no compression) to `-9` (best compression). Default is `-6`.
*   **Use Zopfli for maximum compression**: `pigz --zopfli filename` (much slower but produces smaller files; compatible with gzip).

### Specialized Strategies
*   **Huffman only**: `pigz --huffman filename` (faster, less compression)
*   **RLE (Run-Length Encoding)**: `pigz --rle filename` (optimized for data with long runs of repeated values)
*   **Synchronous output**: `pigz -Y filename` (forces a flush to disk for every block)

### Information and Verification
*   **List compressed file contents**: `pigz -l filename.gz`
*   **Test integrity**: `pigz -t filename.gz`

## Expert Tips
*   **Pipe Efficiency**: When using `pigz` in a pipeline, it uses a separate thread for reading, a separate thread for writing, and a separate thread for calculating the check value, in addition to the compression threads. This makes it highly efficient even on single-core machines compared to standard `gzip`.
*   **Block Size**: You can adjust the block size using `-b <size_in_kb>` (default is 128). Larger block sizes can slightly improve compression ratios on very large files but increase memory usage.
*   **Independent Blocks**: By default, `pigz` writes independent blocks. While this allows for parallel compression, it adds a tiny bit of overhead. If you are using version 1.2.6 of zlib or later, this overhead is minimized.
*   **Zip Format**: `pigz` can produce `.zip` files using the `-K` or `--zip` flag, though it is primarily used for `.gz`.

## Reference documentation
- [README](./references/github_com_madler_pigz.md)
- [Commit History (Options and Features)](./references/github_com_madler_pigz_commits_master.md)