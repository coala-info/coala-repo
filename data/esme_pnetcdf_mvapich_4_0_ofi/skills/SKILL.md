---
name: esme_pnetcdf_mvapich_4_0_ofi
description: PnetCDF (Parallel netCDF) is a high-performance I/O library designed to allow MPI-based applications to access netCDF files in parallel.
homepage: https://parallel-netcdf.github.io/
---

# esme_pnetcdf_mvapich_4_0_ofi

## Overview

PnetCDF (Parallel netCDF) is a high-performance I/O library designed to allow MPI-based applications to access netCDF files in parallel. It provides a specialized interface that enables multiple processes to read from or write to a single shared file simultaneously, bypassing the bottlenecks of serial I/O. This specific implementation is built to work with the MVAPICH MPI stack over the OpenFabrics Interface (OFI), making it ideal for high-performance computing (HPC) environments. It supports classic netCDF formats as well as extended formats like CDF-5, which allows for variables with more than 4 billion elements.

## Utility Programs

The package includes several command-line utilities for managing and inspecting parallel netCDF files:

*   **ncvalidator**: Validates a netCDF file against the CDF-1, CDF-2, or CDF-5 specifications. Use this to ensure file integrity after parallel writes.
*   **ncmpidiff**: A parallel tool to compare two netCDF files and report differences. It is more efficient than serial `diff` for large datasets.
*   **cdfdiff**: A serial version of `ncmpidiff` for smaller files or quick checks.
*   **ncoffsets**: Reports the starting and ending file offsets of variables within a netCDF file. Useful for debugging file layout and alignment.
*   **pnetcdf_version**: Reports the library version and build configuration.
*   **pnetcdf-config**: Provides compiler and linker flags used during the library build, essential for compiling custom C or Fortran applications against this specific PnetCDF build.

## Performance Optimization Best Practices

To achieve maximum I/O throughput, follow these expert guidelines:

### 1. Use Collective APIs
Always prefer collective I/O functions (those ending in `_all`, such as `ncmpi_put_vara_all`) over independent APIs. Collective calls allow the underlying MPI-IO layer to coordinate requests across processes, enabling optimizations like "collective buffering" and "data sieving."

### 2. Leverage Nonblocking APIs for Aggregation
If your application performs many small I/O requests, use the nonblocking interface (`ncmpi_iput_...` and `ncmpi_iget_...`). 
*   **Workflow**: Post multiple requests using `iput` or `iget`, then call `ncmpi_wait_all`.
*   **Benefit**: PnetCDF will aggregate these small requests into a single, large, contiguous MPI-IO operation, significantly reducing metadata overhead and improving bandwidth.

### 3. File Alignment and Striping
On parallel file systems like Lustre or GPFS, align your data with the file system's striping unit:
*   **nc_header_align_size**: Set this hint via `MPI_Info` to reserve extra space in the file header. This prevents a "data shift penalty" if you add attributes later.
*   **nc_var_align_size**: Set this to match your file system's stripe size (e.g., 1MB or 4MB) to ensure variables start on block boundaries, reducing lock contention.

### 4. Select the Correct File Format
*   **CDF-1**: Use for maximum compatibility with legacy serial netCDF tools.
*   **CDF-2 (64-bit Offset)**: Use for files larger than 2GB.
*   **CDF-5 (64-bit Data)**: Use when you need to define dimensions or variables with more than $2^{32}$ elements or require 8-byte integer support.

## Common Environment Variables

*   **PNETCDF_SAFE_MODE**: Set to `1` to enable internal data consistency checking (useful for debugging).
*   **PNETCDF_VERBOSE_DEBUG_MODE**: Set to `1` to print detailed debugging messages regarding I/O operations.
*   **PNETCDF_HINTS**: Use this to pass MPI-IO hints directly to the library without modifying application code (e.g., `export PNETCDF_HINTS="nc_var_align_size=1048576"`).

## Reference documentation

- [PnetCDF C Interface Guide](./references/parallel-netcdf_github_io_doc_c-reference_pnetcdf-c_index.html.md)
- [PnetCDF Quick Tutorial](./references/parallel-netcdf_github_io_wiki_QuickTutorial.html.md)
- [PnetCDF FAQ](./references/parallel-netcdf_github_io_doc_faq.html.md)
- [CDF-5 File Format Specification](./references/parallel-netcdf_github_io_doc_c-reference_pnetcdf-c_CDF_002d5-file-format-specification.html.md)
- [Nonblocking I/O Aggregation](./references/parallel-netcdf_github_io_wiki_CombiningOperations.html.md)