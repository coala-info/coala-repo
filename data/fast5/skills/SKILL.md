---
name: fast5
description: The `fast5` toolset provides a lightweight interface for interacting with Oxford Nanopore Fast5 files.
homepage: https://github.com/mateidavid/fast5
---

# fast5

## Overview
The `fast5` toolset provides a lightweight interface for interacting with Oxford Nanopore Fast5 files. It consists of a C++11 header-only library for high-performance read-write access and a Python wrapper that includes command-line utilities for file inspection and optimization. It is particularly useful for researchers needing to explore HDF5-based sequencing data or reduce storage footprints through packing.

## Installation
The most efficient way to install the toolset and its dependencies (like HDF5) is via Bioconda:

```bash
conda install -c bioconda fast5
```

## Command Line Utilities

### f5ls: Inspecting Fast5 Files
Use `f5ls` to summarize the internal structure of a Fast5 file, which is built on the HDF5 format. This is essential for verifying basecall groups or metadata attributes.

*   **Basic usage**: `f5ls [options] <file.fast5>`
*   **Common Pattern**: Use this to check if a file contains specific basecall events or tracking ID information before running downstream analysis.

### f5pack: Managing Storage
`f5pack` is used to pack and unpack Fast5 files. This is often used to convert between different versions of the Fast5 format or to optimize how reads are stored.

*   **Packing**: Consolidate multiple single-read files into a multi-read file to improve I/O performance on many filesystems.
*   **Unpacking**: Extract reads from a multi-read container back into individual files.

## C++ Library Integration
The core of `fast5` is a header-only C++ library. To use it in a project:

1.  **Include the header**: `#include <fast5.hpp>`
2.  **Compiler Setup**: Ensure your compiler supports C++11.
3.  **Dependencies**: You must have the HDF5 C library installed and available in your include/library paths.
4.  **Compilation Example**:
    ```bash
    g++ -std=c++11 -I/path/to/fast5/include my_program.cpp -lhdf5 -o my_program
    ```

## Best Practices
*   **HDF5 Environment**: When building the Python wrapper from source, always set `HDF5_INCLUDE_DIR` and `HDF5_LIB_DIR` to point to your specific HDF5 installation to avoid version mismatches.
*   **Read-Only Python**: Note that the Python wrapper is currently limited to read-only access. For write operations (such as adding custom metadata or basecalls), use the C++ library directly.
*   **Performance**: For large-scale processing, the C++ library is significantly faster than the Python wrapper as it avoids the overhead of the Cython layer.

## Reference documentation
- [Fast5 GitHub Repository](./references/github_com_mateidavid_fast5.md)
- [Bioconda Fast5 Overview](./references/anaconda_org_channels_bioconda_packages_fast5_overview.md)