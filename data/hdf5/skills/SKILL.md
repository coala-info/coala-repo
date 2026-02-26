---
name: hdf5
description: HDF5 is a high-performance data management framework used to store, organize, and manipulate massive amounts of data in a hierarchical structure. Use when user asks to explore file metadata, extract specific datasets, compare data between files, optimize storage through compression, or compile HDF5 applications.
homepage: https://github.com/HDFGroup/hdf5
---


# hdf5

## Overview
HDF5 is a high-performance data management framework used to store and organize massive amounts of data in a hierarchical structure, similar to a filesystem within a single file. This skill enables efficient interaction with HDF5 files using the standard suite of command-line tools. Use this skill to explore metadata, extract specific datasets, verify data integrity between files, and optimize storage through repacking and compression.

## Common CLI Patterns

### Inspecting File Structure and Metadata
Use `h5ls` for quick navigation and `h5dump` for detailed inspection.

*   **List top-level groups:**
    `h5ls file.h5`
*   **Recursive listing of all objects:**
    `h5ls -r file.h5`
*   **View file metadata (header only) without data values:**
    `h5dump -H file.h5`
*   **Examine a specific dataset or group:**
    `h5dump -d /path/to/dataset file.h5`
    `h5dump -g /path/to/group file.h5`

### Comparing and Verifying Data
Use `h5diff` to identify discrepancies between two HDF5 files.

*   **Basic comparison of two files:**
    `h5diff file1.h5 file2.h5`
*   **Compare specific datasets with a relative error tolerance:**
    `h5diff -d /dataset1 file1.h5 file2.h5 -r 1e-7`
*   **Report only the differences (quiet mode):**
    `h5diff -q file1.h5 file2.h5`

### Data Manipulation and Optimization
Use `h5repack` to change layout, chunking, or compression filters on an existing file.

*   **Apply GZIP compression (level 6) to all datasets:**
    `h5repack -f GZIP=6 input.h5 output.h5`
*   **Convert a dataset to a chunked layout:**
    `h5repack -l /dataset:CHUNK=20x20 input.h5 output.h5`
*   **Remove all filters (uncompress):**
    `h5repack -f NONE input.h5 output.h5`

### Compiling HDF5 Applications
Use the provided compiler wrappers to ensure correct linking of HDF5 libraries and headers.

*   **Compile a C application:**
    `h5cc -o my_app my_app.c`
*   **Compile a C++ application:**
    `h5c++ -o my_cpp_app my_app.cpp`
*   **Show the underlying compile command and flags:**
    `h5cc -show`

## Expert Tips
*   **Partial Data Extraction:** When dealing with massive datasets, use `h5dump -s` (start) and `-c` (count) to subset the data output and avoid flooding the terminal.
*   **External Links:** HDF5 files can link to datasets in other files. Use `h5ls -v` to identify if an object is a hard link, soft link, or external link.
*   **Parallel HDF5:** If working on HPC systems, ensure you are using the parallel-enabled wrappers (often requiring `mpicc` integration) and check `libhdf5.settings` to verify if "Parallel HDF5" is set to `yes`.
*   **Performance Tuning:** For large writes, always use chunked layouts. Use `h5repack` to tune chunk sizes if read/write performance is suboptimal; chunks should generally be between 10KB and 1MB.

## Reference documentation
- [Official HDF5 Library Repository](./references/github_com_HDFGroup_hdf5.md)
- [HDF5 Tags and Releases](./references/github_com_HDFGroup_hdf5_tags.md)
- [HDF5 Discussions and Tool Usage](./references/github_com_HDFGroup_hdf5_discussions.md)