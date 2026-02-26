---
name: esme_pnetcdf_openmpi_5_0_6
description: PnetCDF is a library that enables MPI-based applications to perform high-performance concurrent I/O operations on shared netCDF files. Use when user asks to validate netCDF files, compare two datasets in parallel, report variable file offsets, or optimize parallel I/O performance through collective and nonblocking operations.
homepage: https://parallel-netcdf.github.io/
---


# esme_pnetcdf_openmpi_5_0_6

## Overview

PnetCDF (Parallel netCDF) is a library designed for MPI-based applications to perform concurrent I/O operations on shared netCDF files. Unlike standard serial netCDF, PnetCDF allows multiple processes to write to or read from a single file simultaneously, significantly improving throughput for large-scale simulations. This skill provides guidance on using the PnetCDF utility suite and runtime environment to manage datasets and optimize performance through I/O hints and nonblocking operations.

## Utility Programs

The following command-line tools are essential for managing PnetCDF files:

- **ncvalidator**: Validates a netCDF file against the CDF-1, CDF-2, and CDF-5 format specifications.
  - Usage: `ncvalidator <filename>`
- **ncmpidiff**: A parallel tool to compare two netCDF files and report differences. It is more efficient than serial `diff` for large datasets.
  - Usage: `mpiexec -n <procs> ncmpidiff <file1.nc> <file2.nc>`
- **ncoffsets**: Reports the starting and ending file offsets of variables within a netCDF file. Useful for debugging alignment issues.
  - Usage: `ncoffsets <filename>`
- **pnetcdf-config**: Provides the compiler and linker flags used to build the PnetCDF library.
  - Usage: `pnetcdf-config --libs` or `pnetcdf-config --cflags`
- **pnetcdf_version**: Reports the version and build features of the PnetCDF library.

## Performance Tuning and Best Practices

### Choosing the Right Format
- **CDF-1 (Classic)**: Default format; limited to 2GB variables.
- **CDF-2 (64-bit Offset)**: Use `NC_64BIT_OFFSET` flag. Allows files > 2GB, but individual fixed-size variables are still limited to 4GB.
- **CDF-5 (64-bit Data)**: Use `NC_64BIT_DATA` flag. Supports variables > 4GB, 64-bit integers, and unsigned data types.

### I/O Hints and Alignment
To avoid the "data shift penalty" (where the entire data section must be moved because the header grew), use I/O hints:
- **nc_header_align_size**: Pre-allocates space for the file header. Set this to a large value (e.g., 1MB) if you expect to add more attributes or variables later.
- **nc_var_align_size**: Aligns the start of variables to file system block boundaries (e.g., Lustre OST striping size).
- **Environment Variable**: Hints can be passed at runtime using `PNETCDF_HINTS`.
  - Example: `export PNETCDF_HINTS="nc_var_align_size=1048576;nc_header_align_size=1048576"`

### Collective vs. Independent I/O
- **Collective I/O**: Use APIs with the `_all` suffix (e.g., `ncmpi_put_vara_all`). This allows the library to coordinate between processes and optimize the access pattern for the underlying file system.
- **Independent I/O**: Use when processes access data in a completely unsynchronized manner. Generally slower for large-scale parallel writes.

### Nonblocking APIs
For applications writing many small variables, use nonblocking APIs to aggregate requests:
1. Post requests using `ncmpi_iput_vara_<type>`.
2. Commit all requests simultaneously using `ncmpi_wait_all`.
3. This reduces the number of MPI-IO calls and improves network/storage efficiency.

## Runtime Environment Variables

- **PNETCDF_SAFE_MODE**: Set to `1` to enable internal data consistency checking (useful for debugging).
- **PNETCDF_VERBOSE_DEBUG_MODE**: Set to `1` to print detailed debugging messages regarding I/O operations.

## Reference documentation

- [Parallel netCDF Q&A](./references/parallel-netcdf_github_io_doc_faq.html.md)
- [PnetCDF Quick Tutorial](./references/parallel-netcdf_github_io_wiki_QuickTutorial.html.md)
- [PnetCDF C Interface Guide](./references/parallel-netcdf_github_io_doc_c-reference_pnetcdf-c_index.html.md)
- [CDF-5 File Format Specification](./references/parallel-netcdf_github_io_doc_c-reference_pnetcdf-c_CDF_002d5-file-format-specification.html.md)