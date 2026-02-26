---
name: esme_pnetcdf_mvapich_4_0
description: PnetCDF is a high-performance library that enables MPI applications to read and write netCDF files in parallel. Use when user asks to validate netCDF files, compare datasets in parallel, aggregate I/O requests with nonblocking APIs, or optimize file alignment and performance for large-scale scientific simulations.
homepage: https://parallel-netcdf.github.io/
---


# esme_pnetcdf_mvapich_4_0

## Overview

PnetCDF (Parallel netCDF) is a high-performance library designed for MPI applications to read and write netCDF files in parallel. It is particularly effective for large-scale scientific simulations where multiple processes need to access a shared file simultaneously. This skill focuses on the practical application of PnetCDF's utility programs and the implementation of performance-tuning strategies such as request aggregation, file alignment, and the use of nonblocking interfaces to overcome the limitations of serial I/O.

## Utility Programs

PnetCDF includes several command-line tools for file validation, comparison, and inspection:

- **ncvalidator**: Validates a netCDF file against CDF-1, CDF-2, and CDF-5 format specifications.
  - Usage: `ncvalidator <filename>`
- **ncmpidiff**: Performs a parallel comparison of two netCDF files and reports differences. This is more efficient than serial `diff` for large datasets.
  - Usage: `mpiexec -n <procs> ncmpidiff <file1> <file2>`
- **ncoffsets**: Reports the starting and ending file offsets for all variables in a netCDF file. Useful for debugging alignment issues.
  - Usage: `ncoffsets <filename>`
- **pnetcdf-config**: Provides information about the PnetCDF installation, such as compiler flags and library paths needed for linking.
  - Usage: `pnetcdf-config --libs` or `pnetcdf-config --all`
- **pnetcdf_version**: Reports the version and build configuration of the PnetCDF library.

## Performance Best Practices

### 1. Use Collective APIs
Whenever possible, use collective APIs (functions ending in `_all`). Collective I/O allows the underlying MPI-IO layer to coordinate requests across all processes, enabling optimizations like "collective buffering" (two-phase I/O) which can significantly outperform independent I/O.

### 2. Aggregate Requests with Nonblocking APIs
If your application makes many small I/O requests, use the nonblocking interface to aggregate them into larger, more efficient operations.
- **Pattern**: Post multiple requests using `ncmpi_iput_var*` or `ncmpi_iget_var*`, then commit them all at once using `ncmpi_wait_all`.
- **Benefit**: This allows PnetCDF to "stitch" non-contiguous requests into a single large MPI-IO call.

### 3. File Alignment and Striping
To avoid "data shift penalties" and unaligned file system access:
- **Header Alignment**: Use the `nc_header_align_size` hint to reserve extra space in the file header if you expect to add more attributes or variables later.
- **Variable Alignment**: Use the `nc_var_align_size` hint to align the start of fixed-size variables with the file system's block size (e.g., 1MB for Lustre).
- **Lustre Tuning**: For Lustre file systems, set the striping count to the maximum allowable if I/O volume is high: `lfs setstripe -c -1 <directory>`.

### 4. Buffered Writes
If you need to reuse your I/O buffers immediately after a write call, use the buffered nonblocking interface (`ncmpi_bput_var*`).
- **Requirement**: You must first attach a buffer using `ncmpi_buffer_attach` to provide the memory PnetCDF needs for internal copies.

## Runtime Configuration

PnetCDF behavior can be tuned using environment variables without recompiling the application:

- **PNETCDF_HINTS**: Pass I/O hints directly to the library.
  - Example: `export PNETCDF_HINTS="nc_var_align_size=1048576;nc_header_align_size=1048576"`
- **PNETCDF_SAFE_MODE**: Set to `1` to enable internal consistency checking for data and metadata across processes.
- **PNETCDF_VERBOSE_DEBUG_MODE**: Set to `1` to enable detailed debugging output.

## Reference documentation

- [PnetCDF C Interface Guide](./references/parallel-netcdf_github_io_doc_c-reference_pnetcdf-c_index.html.md)
- [Parallel netCDF Q&A](./references/parallel-netcdf_github_io_doc_faq.html.md)
- [PnetCDF Quick Tutorial](./references/parallel-netcdf_github_io_wiki_QuickTutorial.html.md)
- [PnetCDF File Limits](./references/parallel-netcdf_github_io_wiki_FileLimits.html.md)