---
name: hdf5
description: HDF5 provides a suite of command-line utilities and compiler wrappers for managing, inspecting, and optimizing large, complex datasets stored in the .h5 format. Use when user asks to list file hierarchies, dump dataset contents, compare files, apply compression filters, or compile HDF5 applications using library wrappers.
homepage: https://github.com/HDFGroup/hdf5
---


# hdf5

## Overview
HDF5 is a specialized data model and file format designed for high-performance storage and management of large, complex datasets. This skill provides procedural knowledge for using the native HDF5 command-line toolsuite to interact with .h5 files and optimize library behavior. It covers essential utilities for data inspection, comparison, and compilation, as well as expert-level tuning for metadata performance and compression.

## Core Command-Line Utilities

### Inspection and Extraction
*   **h5ls**: Use to quickly view the hierarchy of an HDF5 file.
    *   `h5ls -r file.h5`: Recursively list all groups and datasets.
    *   `h5ls -v file.h5/dataset_name`: View detailed metadata, including data type, chunking, and fill values.
*   **h5dump**: Use to examine the contents of a file or export data to text/XML.
    *   `h5dump -H file.h5`: Display only the header (metadata) without the raw data.
    *   `h5dump -d /group/dataset file.h5`: Dump a specific dataset.
    *   `h5dump -b LE -o output.bin file.h5`: Export data to a binary file in Little Endian format.
*   **h5stat**: Use to generate a statistical report on the file's storage efficiency, including object headers, free space, and metadata overhead.

### Comparison and Modification
*   **h5diff**: Use to compare two HDF5 files and identify differences in datasets.
    *   `h5diff file1.h5 file2.h5`: Compare all objects.
    *   `h5diff -v file1.h5 file2.h5 /dataset1 /dataset1`: Compare specific datasets with verbose output.
*   **h5repack**: Use to apply or remove filters (like compression) and change the layout of an existing file.
    *   `h5repack -f GZIP=6 input.h5 output.h5`: Apply GZIP compression level 6 to all datasets.
    *   `h5repack -l CHUNK=20x20 input.h5 output.h5`: Change the chunking layout.

## Development and Compilation
The HDF5 library provides wrappers to simplify the inclusion of necessary headers and libraries during compilation.

*   **h5cc**: C compiler wrapper.
*   **h5c++**: C++ compiler wrapper.
*   **h5fc**: Fortran compiler wrapper.

**Common Pattern:**
To see the underlying command being executed (including include paths and library links), use the `-show` flag:
`h5cc -show -c my_program.c`

*Note: In recent versions, `h5cc -show` behavior has been standardized to ensure it does not repeat the `-show` argument in the output, making it easier to use in shell scripts.*

## Expert Performance Tuning

### Metadata Cache Management
For applications with high metadata overhead (e.g., thousands of small datasets or external links), performance can be improved by adjusting the Metadata Cache (MDC).
*   **Cache Limits**: The library typically defaults to a 2 MiB cache. For large working sets, consider increasing this to 32 MiB or 64 MiB.
*   **Aggressive Adaptation**: If performance lags during file opening or closing, the cache may need to be more aggressive about adapting to larger working sets.

### Compression and Filters
*   **zlib/GZIP**: By default, HDF5 is often built with zlib support. If a file requires GZIP and the library was built without it, operations will fail.
*   **Filter Requirements**: Filters are generally required only when writing data. If a dataset was written with a specific filter (e.g., SZIP), the reading library must have that filter available to decode the data.

### Parallel HDF5 (PHDF5)
When running on HPC systems using MPI:
*   Ensure the library is configured with `--enable-parallel`.
*   Use `MPIO` as the Virtual File Driver (VFD).
*   Collective I/O operations are generally more efficient than independent I/O for large-scale data writes.



## Subcommands

| Command | Description |
|---------|-------------|
| h5c++ | Compile line for HDF5 C++ programs |
| h5cc | Compile line for HDF5 |
| h5diff | Compares HDF5 files and objects within them. |
| h5dump | Print a usage message and exit |
| h5ls | List the contents of an HDF5 file |
| h5repack | Repacks HDF5 files |

## Reference documentation
- [Official HDF5 Library Repository](./references/github_com_HDFGroup_hdf5.md)
- [HDF5 Wiki 2024 Notes](./references/github_com_HDFGroup_hdf5_wiki_2024.md)
- [HDF5 Tags and Release Notes](./references/github_com_HDFGroup_hdf5_tags.md)