---
name: esme_pnetcdf_openmpi_5_0_6
description: This tool provides guidance on using the Parallel NetCDF library within an OpenMPI environment to enable high-performance parallel I/O for scientific data. Use when user asks to perform collective or nonblocking I/O operations, optimize file striping and metadata alignment, or manage large datasets using CDF-5 formats.
homepage: https://parallel-netcdf.github.io/
metadata:
  docker_image: "quay.io/biocontainers/esme_pnetcdf_openmpi_5_0_6:1.14.0--h1080dc9_0"
---

# esme_pnetcdf_openmpi_5_0_6

## Overview
The `esme_pnetcdf_openmpi_5_0_6` skill provides expert guidance on using the Parallel NetCDF (PnetCDF) library within an OpenMPI environment. PnetCDF extends the standard NetCDF interface to support true parallel access, allowing multiple MPI processes to read from and write to a single file simultaneously. This skill focuses on maximizing I/O performance through request aggregation, proper file striping, and metadata alignment, which are critical for large-scale scientific simulations.

## Core Usage and Best Practices

### 1. Selecting the Correct File Format
When creating files with `ncmpi_create`, choose the format that matches your data requirements:
- **CDF-1**: Classic format (default). 32-bit offsets, limited to 2GB variables.
- **CDF-2 (`NC_64BIT_OFFSET`)**: Supports 64-bit offsets for files > 2GB.
- **CDF-5 (`NC_64BIT_DATA`)**: Supports 64-bit integers, unsigned types, and variables with > 2^32 elements.

### 2. Collective vs. Independent Operations
- **Collective APIs**: (e.g., `ncmpi_put_vara_all`) Coordinate all MPI processes to optimize the access pattern for the underlying file system. **Always prefer collective APIs** for better performance on parallel file systems like Lustre or GPFS.
- **Independent APIs**: (e.g., `ncmpi_put_vara`) Allow processes to perform I/O without coordination. Use only when access patterns are highly irregular or coordination overhead is prohibitive.

### 3. Optimizing Performance with Nonblocking APIs
To avoid the overhead of many small I/O requests, use the nonblocking interface to aggregate operations:
1. **Post Requests**: Use `ncmpi_iput_vara_<type>` or `ncmpi_iget_vara_<type>`. These return immediately with a request ID.
2. **Wait/Commit**: Call `ncmpi_wait_all` (collective) or `ncmpi_wait` (independent). PnetCDF combines all pending requests into a single, large I/O operation.

### 4. Tuning via MPI-Info Hints
Pass performance hints during `ncmpi_create` or `ncmpi_open` using an `MPI_Info` object:
- **`nc_header_align_size`**: Reserve extra space for the file header to prevent "data shifting" if you plan to add attributes later.
- **`nc_var_align_size`**: Align the start of fixed-size variables to the file system's striping/block size (e.g., 1MB) to prevent lock contention.

### 5. Utility Programs
- **`ncmpidiff`**: Parallel tool to compare two NetCDF files for differences.
- **`ncoffsets`**: Reports the starting and ending file offsets of variables, useful for debugging alignment issues.
- **`ncvalidator`**: Validates a file against the CDF specifications.
- **`pnetcdf-config`**: Provides compiler and linker flags used during the library build.

## Expert Tips
- **Lustre Striping**: For large datasets, set the directory striping count to the maximum allowed (`lfs setstripe -c -1`) before creating the file.
- **Safe Mode**: If encountering mysterious crashes or data corruption, set the environment variable `PNETCDF_SAFE_MODE=1` to enable internal consistency checking for attributes and arguments across processes.
- **Header Growth**: If you must enter "redefine" mode on an existing file, ensure you have used `nc_header_align_size` previously, or be prepared for a significant performance penalty as the library shifts all data to accommodate a larger header.



## Subcommands

| Command | Description |
|---------|-------------|
| esme_pnetcdf_openmpi_5_0_6_pnetcdf_version | PnetCDF Version Information |
| ncmpidiff | Compare the contents of two netCDF files. |
| ncoffsets | Prints offsets of variables in a netCDF file. |
| ncvalidator | Validate netCDF files |
| pnetcdf-config | is a utility program to display the build and installation information of the PnetCDF library. |

## Reference documentation
- [PnetCDF C Interface Guide](./references/parallel-netcdf_github_io_doc_c-reference_pnetcdf-c_index.html.md)
- [PnetCDF Q&A and Performance Tuning](./references/parallel-netcdf_github_io_doc_faq.html.md)
- [Nonblocking I/O Aggregation](./references/parallel-netcdf_github_io_wiki_CombiningOperations.html.md)
- [CDF-5 File Format Specification](./references/parallel-netcdf_github_io_doc_c-reference_pnetcdf-c_CDF_002d5-file-format-specification.html.md)