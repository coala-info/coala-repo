---
name: libbigwig
description: libbigwig is a C library for high-performance reading and writing of bigWig and bigBed genomic track files. Use when user asks to read or write bigWig files, calculate summary statistics across genomic bins, or access remote genomic data via URLs.
homepage: https://github.com/dpryan79/libBigWig
metadata:
  docker_image: "quay.io/biocontainers/libbigwig:0.4.8--h44aa6d8_0"
---

# libbigwig

## Overview
libbigwig is a specialized C library designed for high-performance handling of bigWig and bigBed genomic tracks. It serves as a modern alternative to the original UCSC source code, offering a more "library-friendly" architecture that avoids hard exits on errors—making it ideal for integration into larger software suites or language bindings (like Python). It features native support for remote data access through libcurl and provides a streamlined API for both reading and writing bigWig data.

## Installation and Linking
To use libbigwig in your development environment, install it via bioconda:

```bash
conda install bioconda::libbigwig
```

When compiling your application, link against the library and its dependencies (typically `-lBigWig` and `-lcurl`).

## Core Reading Workflow
The library follows a strict initialization and cleanup lifecycle.

1.  **Initialize**: Call `bwInit(size_t bufferSize)` to allocate the internal buffer (e.g., `1 << 17` for 128KiB).
2.  **Open**: Use `bwOpen(char *path, void *callbacks, char *mode)` for local files or URLs.
3.  **Query**:
    *   `bwGetValues`: Retrieve values for a specific range (0-based, half-open).
    *   `bwGetOverlappingIntervals`: Retrieve full interval structures.
    *   `bwStats`: Calculate summary statistics (mean, std, max, etc.) across bins.
4.  **Memory Management**: Always free interval results using `bwDestroyOverlappingIntervals`.
5.  **Close and Cleanup**: Use `bwClose(fp)` and `bwCleanup()`.

## Writing bigWig Files
Note: libbigwig supports writing bigWig files but does **not** support creating bigBed files.

1.  **Header Creation**: Use `bwCreateHdr(fp, zoomLevels)` to define the file structure.
2.  **Chromosome List**: Define your contigs using `bwCreateChromList(names, lengths, count)`.
3.  **Adding Data**:
    *   `bwAddIntervals`: Add bedGraph-like entries (chrom, start, end, value).
    *   `bwAddIntervalSpans`: Add entries with a fixed span.
    *   `bwAddIntervalSpanSteps`: Add fixed-step entries.
4.  **Appending**: Use `bwAppend...` functions to add data to the current block. Note that you cannot append a different chromosome to the same block.
5.  **Finalizing**: Closing the file (`bwClose`) triggers the creation of zoom levels.

## Expert Tips
*   **Remote Access**: To access files over HTTPS or S3, ensure the path passed to `bwOpen` is a valid URL. The library handles the network I/O transparently via curl.
*   **Error Handling**: Check if the `bigWigFile_t` pointer is `NULL` after `bwOpen`. Unlike other tools, libbigwig will return `NULL` rather than crashing your program.
*   **Type Detection**: Use `bwIsBigWig(filename, callbacks)` and `bbIsBigBed(filename, callbacks)` to programmatically determine file types based on magic numbers.
*   **Memory Efficiency**: For large-scale processing, reuse the buffer initialized in `bwInit` and ensure all `bwOverlappingIntervals_t` objects are destroyed immediately after use to prevent leaks.

## Reference documentation
- [libbigwig - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_libbigwig_overview.md)
- [GitHub - dpryan79/libBigWig: A C library for handling bigWig files](./references/github_com_dpryan79_libBigWig.md)