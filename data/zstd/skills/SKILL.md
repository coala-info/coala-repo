---
name: zstd
description: Zstandard (zstd) is a fast, lossless compression algorithm designed for high compression ratios and real-time speeds. Use when user asks to compress files, decompress files, adjust compression levels, train a dictionary, compress or decompress small files with a dictionary, use multiple CPU cores for compression, or benchmark compression.
homepage: https://github.com/facebook/zstd
---


# zstd

## Overview
Zstandard (zstd) is a fast, lossless compression algorithm designed to provide high compression ratios while maintaining real-time speeds. It is particularly effective as a modern alternative to zlib, offering better compression and significantly faster decompression. One of its standout features is "Dictionary Compression," which allows the tool to learn from a set of samples to efficiently compress small files (like JSON records or small logs) that otherwise lack enough internal repetition for traditional algorithms to handle well.

## Common CLI Patterns

### Basic Compression and Decompression
*   **Compress a file**: `zstd filename` (creates `filename.zst`)
*   **Decompress a file**: `zstd -d filename.zst` or `unzstd filename.zst`
*   **Compress to a specific location**: `zstd filename -o /path/to/output.zst`
*   **Decompress and keep the source file**: `zstd -dc filename.zst > original_filename` (using stdout)

### Adjusting Compression Levels
Zstd offers a wide range of trade-offs between speed and ratio:
*   **Fastest compression**: `zstd --fast=1 filename` (higher numbers like `--fast=4` are even faster but provide lower ratios)
*   **Default level**: Level 3 is the default.
*   **High compression**: `zstd -19 filename` (levels above 19 require the `--ultra` flag)
*   **Ultra compression**: `zstd --ultra -22 filename` (uses significant memory)

### Dictionary Training (For Small Data)
If you have thousands of small, similar files (e.g., 1KB JSON files), use a dictionary to improve the compression ratio:
1.  **Train the dictionary**: `zstd --train /path/to/samples/* -o my_dictionary`
2.  **Compress with the dictionary**: `zstd -D my_dictionary small_file`
3.  **Decompress with the dictionary**: `zstd -d -D my_dictionary small_file.zst`

### Advanced Operations
*   **Multi-threaded compression**: `zstd -T0 filename` (uses all detected CPU cores)
*   **Benchmark mode**: `zstd -b1 -e5 filename` (benchmarks levels 1 through 5 on the specified file to test local performance)
*   **Verbose output**: `zstd -v filename` (provides more details during the process)
*   **Integrate with pipes**: `cat data | zstd > data.zst`

## Expert Tips
*   **Decompression Speed**: Unlike many algorithms, zstd's decompression speed remains relatively constant regardless of the compression level used. You can compress at level 19 without worrying about slow decompression later.
*   **Negative Levels**: The `--fast` flag actually maps to negative compression levels. These are specifically designed for scenarios where throughput is more critical than the final file size.
*   **Small Data Strategy**: Dictionary compression is most effective for files under a few KB. For larger files, the algorithm naturally builds its own "dictionary" from the file's history, making the external dictionary less impactful.
*   **Legacy Support**: The zstd CLI can often decode other formats like `.gz`, `.xz`, and `.lz4` if it was compiled with the necessary support libraries.

## Reference documentation
- [Zstandard README](./references/github_com_facebook_zstd.md)
- [Zstandard Wiki](./references/github_com_facebook_zstd_wiki.md)