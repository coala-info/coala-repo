---
name: esme_pnetcdf_psmpi_5_12_1
description: This skill provides guidance on using PnetCDF (Parallel NetCDF), a library designed for efficient, concurrent access to NetCDF files.
homepage: https://parallel-netcdf.github.io/
---

# esme_pnetcdf_psmpi_5_12_1

## Overview
This skill provides guidance on using PnetCDF (Parallel NetCDF), a library designed for efficient, concurrent access to NetCDF files. It is particularly useful for scientific applications running on clusters where multiple MPI processes must read from or write to a single shared file. The library supports classic (CDF-1), 64-bit offset (CDF-2), and 64-bit data (CDF-5) formats, allowing for datasets that exceed 2GB and support for 64-bit integer types.

## Core Workflows

### Programming Model
PnetCDF uses a bi-modal interface. You must transition between these modes to manage metadata and data:
1.  **Define Mode**: Describe dimensions, variables, and attributes.
2.  **Data Mode**: Perform actual read/write operations.
3.  **Transition**: Use `ncmpi_enddef` to move from Define to Data mode, and `ncmpi_redef` to return to Define mode.

### File Creation and Formats
When creating files, choose the format that matches your data requirements:
*   **CDF-1 (Default)**: Classic NetCDF format.
*   **CDF-2 (`NC_64BIT_OFFSET`)**: Supports files > 2GB.
*   **CDF-5 (`NC_64BIT_DATA`)**: Supports large dimensions (> 2^32 elements) and 64-bit data types (e.g., `NC_INT64`, `NC_UINT64`).

### Performance Optimization
*   **Collective vs. Independent I/O**: Always prefer collective APIs (ending in `_all`) for shared file access. This allows the underlying MPI-IO to optimize disk access patterns.
*   **Nonblocking APIs**: Use `ncmpi_iput_*` and `ncmpi_iget_*` to aggregate multiple small requests into a single large, efficient I/O operation. Follow these with `ncmpi_wait_all`.
*   **Alignment**: Align the start of variables to file system block boundaries (e.g., Lustre striping size) using the `nc_var_align_size` hint in the `MPI_Info` object during file creation.

## Common Utility Commands
The package includes several CLI tools for managing and inspecting PnetCDF files:

*   **ncvalidator**: Validates a file against CDF specifications.
    ```bash
    ncvalidator <filename.nc>
    ```
*   **ncmpidiff**: Performs a parallel comparison of two NetCDF files.
    ```bash
    mpirun -n <procs> ncmpidiff <file1.nc> <file2.nc>
    ```
*   **ncoffsets**: Reports the starting and ending file offsets for variables, useful for debugging alignment.
    ```bash
    ncoffsets <filename.nc>
    ```
*   **pnetcdf-config**: Provides compiler and linker flags used during the library build.
    ```bash
    pnetcdf-config --libs
    ```

## Expert Tips
*   **Data Shift Penalty**: Avoid adding new dimensions or variables to existing files if possible. If the header grows beyond its reserved space, the library must shift the entire data section, which is extremely slow. Use the `nc_header_align_size` hint to reserve extra header space upfront.
*   **Buffered Writes**: If you need to reuse your data buffer immediately after a write call, use the buffered nonblocking API (`ncmpi_bput_*`). You must first attach a buffer using `ncmpi_buffer_attach`.
*   **Lustre Tuning**: On Lustre systems, set the striping count to the maximum allowable for large files to increase aggregate bandwidth. Use `lfs setstripe` on the output directory.

## Reference documentation
- [PnetCDF C Interface Guide](./references/parallel-netcdf_github_io_doc_c-reference_pnetcdf-c_index.html.md)
- [PnetCDF Quick Tutorial](./references/parallel-netcdf_github_io_wiki_QuickTutorial.html.md)
- [PnetCDF FAQ](./references/parallel-netcdf_github_io_doc_faq.html.md)
- [CDF-5 File Format Specification](./references/parallel-netcdf_github_io_doc_c-reference_pnetcdf-c_CDF_002d5-file-format-specification.html.md)