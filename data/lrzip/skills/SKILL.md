---
name: lrzip
description: lrzip is a compression utility optimized for identifying redundancies across very large files using long-range redundancy reduction. Use when user asks to compress large files, decompress .lrz archives, archive directories with lrztar, or optimize compression for high RAM availability.
homepage: https://github.com/ckolivas/lrzip
---


# lrzip

## Overview
lrzip (Long Range ZIP) is a compression utility specifically optimized for large files. Unlike standard compressors that look for patterns within small windows, lrzip uses an extended rzip stage to identify redundancies across hundreds of megabytes. It is most effective on files larger than 100MB and scales its performance based on available system RAM. It supports multiple compression backends including LZMA, ZPAQ, LZO, GZIP, and BZIP2, allowing users to prioritize either extreme space savings or high-speed processing.

## Common CLI Patterns

### Basic Compression and Decompression
*   **Default (LZMA):** `lrzip filename` (Creates `filename.lrz`)
*   **Decompress:** `lrunzip filename.lrz`
*   **Gzip-compatible semantics:** `lrz filename` (Compresses and deletes the original file)
*   **Test integrity:** `lrzip -t filename.lrz`

### Working with Directories
Since lrzip operates on single files, use the provided wrappers for directory structures:
*   **Archive directory:** `lrztar directory_name`
*   **Extract directory:** `lrzuntar directory_name.tar.lrz`

### Selecting Compression Backends
*   **Extreme Compression (ZPAQ):** `lrzip -z filename` (Very slow, but highest ratio)
*   **High Speed (LZO):** `lrzip -l filename` (Extremely fast, often faster than a disk copy)
*   **Standard Compatibility (BZIP2):** `lrzip -b filename`
*   **Fast/Balanced (GZIP):** `lrzip -g filename`

### Performance Optimization
*   **Maximize RAM usage:** `lrzip -U filename` (Tells lrzip to use the largest possible memory window for better compression)
*   **Control CPU Cores:** `lrzip -p 4 filename` (Restricts usage to 4 processors)
*   **Set Compression Level:** `lrzip -L 9 filename` (Levels 1-9, default is 7)

## Expert Tips
*   **Memory Requirements:** lrzip performs best when it can fit the entire file (or large chunks of it) into RAM. If you have less than 256MB of RAM, performance may degrade significantly.
*   **The Sliding Window:** For files larger than available RAM, lrzip uses a "sliding mmap" feature. While this allows it to compress multi-gigabyte files on modest hardware, providing more RAM will always improve the compression ratio.
*   **Piping:** You can pipe data into lrzip, but it is less efficient for the long-range redundancy algorithm than working with a seekable file on disk.
    *   Example: `cat large_data | lrzip > data.lrz`
*   **Rzip-only mode:** Using `lrzip -n filename` performs only the long-range redundancy reduction without a secondary compressor. This is useful if you plan to process the file later with a different tool or if you want a very fast "pre-compression" pass.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_ckolivas_lrzip.md)
- [Bioconda Package Summary](./references/anaconda_org_channels_bioconda_packages_lrzip_overview.md)