---
name: libstatgen
description: libstatgen provides a foundational framework for high-performance statistical genetic analysis.
homepage: https://genome.sph.umich.edu/wiki/C++_Library:_libStatGen
---

# libstatgen

## Overview
libstatgen provides a foundational framework for high-performance statistical genetic analysis. It is primarily used as a development library for tools like BamUtil and various association mapping software. This skill assists in navigating the library's core classes for sequence data manipulation and provides guidance on integrating the library into C++ bioinformatics pipelines.

## Development and Compilation
When building tools that utilize libstatgen, follow these patterns:

- **Library Linking**: Ensure the library is compiled first to produce `libstatgen.a`. Link against it using `-lstatgen` and include the library path with `-L`.
- **Header Inclusion**: Include core headers based on the data type:
  - SAM/BAM: `#include "SamFile.h"`
  - VCF: `#include "VcfFile.h"`
  - Parameters: `#include "Parameters.h"` (for standardized CLI argument parsing)
- **Memory Management**: Use the library's built-in string and vector classes (e.g., `String`, `IntVector`) which are optimized for large-scale genomic data and provide helper methods for genomic coordinate handling.

## Common CLI Patterns
While libstatgen is primarily a library, it often powers utilities with the following standard behaviors:

- **Streaming Data**: Most tools built on libstatgen support reading from `stdin` and writing to `stdout` using `-` as a filename, facilitating pipe-based workflows.
- **Region Specification**: Use the `--region chr:start-end` format for targeted analysis of genomic intervals.
- **Validation**: Use the library's built-in validation checks to ensure SAM/BAM files adhere to specifications before processing.

## Expert Tips
- **Performance**: When processing BAM files, utilize the `SamFile::ReadRecord()` method within a loop to minimize memory overhead compared to loading entire files.
- **Thread Safety**: Note that older versions of the library may have limited thread safety in certain I/O operations; wrap file access in mutexes if implementing multi-threaded processing.
- **Coordinate Systems**: Always verify if the specific tool or class is using 0-based (BED-style) or 1-based (SAM-style) coordinates, as libstatgen provides methods to convert between both.

## Reference documentation
- [libstatgen Overview](./references/anaconda_org_channels_bioconda_packages_libstatgen_overview.md)