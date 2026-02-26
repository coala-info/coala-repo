---
name: libdeflate
description: libdeflate is a high-performance library and toolset for fast, whole-buffer compression and decompression using DEFLATE, zlib, and gzip formats. Use when user asks to compress or decompress files quickly, benchmark compression performance, or calculate Adler-32 and CRC-32 checksums.
homepage: https://github.com/ebiggers/libdeflate
---


# libdeflate

## Overview
libdeflate is a heavily optimized library designed for fast, whole-buffer compression and decompression. It supports raw DEFLATE, zlib, and gzip formats. While it lacks a streaming API, it excels in performance for discrete data chunks, often significantly outperforming the standard zlib library. It also provides high-compression modes that can exceed the compression ratios of zlib's maximum settings.

## Installation
The library and its associated command-line tools can be installed via Bioconda:
```bash
conda install bioconda::libdeflate
```
Alternatively, it can be built from source using CMake:
```bash
cmake -B build && cmake --build build
```

## Command Line Usage

### libdeflate-gzip
This tool serves as a high-performance, albeit limited, replacement for standard gzip. It is best used for files that can fit entirely into memory.

*   **Compress a file:**
    ```bash
    libdeflate-gzip filename
    ```
*   **Decompress a file (using the gunzip alias):**
    ```bash
    libdeflate-gunzip filename.gz
    ```
*   **Set compression level (1-12):**
    ```bash
    libdeflate-gzip -12 filename
    ```

### Benchmarking and Validation
libdeflate includes utility programs to test performance and data integrity.

*   **Benchmark compression speed:**
    Use the `benchmark` tool to compare libdeflate against zlib or measure round-trip speed.
    ```bash
    benchmark [options] [file...]
    ```
*   **Compute checksums:**
    Use the `checksum` tool for fast Adler-32 or CRC-32 calculation.
    ```bash
    checksum [options] [file...]
    ```

## Expert Tips and Best Practices

*   **Chunk-Based Processing:** libdeflate is designed for "whole-buffer" operations. If your application processes data in chunks (e.g., 1 MB blocks), libdeflate is an excellent choice. It is not suitable for processing massive files as a single continuous stream due to memory constraints and the lack of a streaming API.
*   **Compression Levels:** libdeflate supports levels 1 through 12. Levels 10-12 are "high compression" modes that often provide better ratios than zlib's level 9 while maintaining competitive speeds.
*   **Architecture Optimization:** The library uses runtime CPU feature detection. You do not need to manually specify flags like `-mavx2`; the library will automatically select the fastest implementation for your hardware (x86 or ARM).
*   **Compiler Choice:** For maximum performance, compile with recent versions of GCC or Clang. While `-O3` is supported, the developer recommends `-O2` as it often yields better results for this specific codebase.
*   **Memory Management:** When decompressing, you should ideally know the uncompressed size beforehand (stored as metadata) to allocate the output buffer accurately. If unknown, libdeflate's routines can still provide the actual number of output bytes after processing.

## Reference documentation
- [libdeflate GitHub Overview](./references/github_com_ebiggers_libdeflate.md)
- [Bioconda libdeflate Package](./references/anaconda_org_channels_bioconda_packages_libdeflate_overview.md)