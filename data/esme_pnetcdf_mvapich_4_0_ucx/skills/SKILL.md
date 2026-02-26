---
name: esme_pnetcdf_mvapich_4_0_ucx
description: PnetCDF is a high-performance library that enables multiple MPI processes to concurrently access and manage netCDF files in parallel computing environments. Use when user asks to validate netCDF file formats, compare parallel datasets, report file offsets, check library build configurations, or tune parallel I/O performance using alignment hints and environment variables.
homepage: https://parallel-netcdf.github.io/
---


# esme_pnetcdf_mvapich_4_0_ucx

## Overview
PnetCDF (Parallel netCDF) is a high-performance library designed to enable multiple MPI processes to concurrently access a single netCDF file. This specific implementation is built with MVAPICH 4.0 and UCX, making it suitable for large-scale scientific computing where I/O bottlenecks are a concern. Use this skill to manage netCDF metadata, validate file structures, compare parallel datasets, and tune I/O performance for parallel file systems like Lustre or GPFS.

## Utility Programs
The following command-line tools are included for managing and inspecting PnetCDF files:

- **ncvalidator**: Validates a netCDF file against CDF-1, CDF-2, and CDF-5 format specifications.
  `ncvalidator <filename>`
- **ncmpidiff**: Performs a parallel comparison of two netCDF files and reports differences.
  `mpiexec -n <procs> ncmpidiff <file1> <file2>`
- **ncoffsets**: Reports the starting and ending file offsets for all variables in a netCDF file. Useful for debugging alignment issues.
  `ncoffsets <filename>`
- **pnetcdf-config**: Provides information about the compiler flags and libraries used to build PnetCDF.
  `pnetcdf-config --libs`
- **pnetcdf_version**: Reports the version and build date of the PnetCDF library.

## Performance Tuning
To achieve maximum I/O bandwidth, utilize the following tuning mechanisms:

### Environment Variables
- **PNETCDF_SAFE_MODE**: Set to 1 to enable internal data consistency checking (useful for debugging).
- **PNETCDF_VERBOSE_DEBUG_MODE**: Set to 1 to print detailed debugging messages during I/O operations.
- **PNETCDF_HINTS**: Pass MPI-IO hints directly to the library without modifying source code.
  `export PNETCDF_HINTS="nc_var_align_size=1048576;nc_header_align_size=1048576"`

### I/O Hints and Alignment
- **nc_header_align_size**: Reserves extra space in the file header to prevent "data shift penalty" if metadata (attributes/dimensions) is added later.
- **nc_var_align_size**: Aligns the starting offset of fixed-size variables to a specific byte boundary (e.g., 1MB for Lustre). This reduces lock contention on parallel file systems.
- **Collective vs. Independent I/O**: Always prefer collective APIs (`_all` suffix in C/Fortran) for better performance, as they allow the library to optimize the access pattern across all processes.

## File Format Selection
PnetCDF supports three primary formats. Choose based on your data requirements:

- **CDF-1 (Classic)**: The default format. Limited to 2GB for most variables.
- **CDF-2 (64-bit Offset)**: Supports files larger than 2GB. Use the `NC_64BIT_OFFSET` flag during creation.
- **CDF-5 (64-bit Data)**: Supports large dimensions (>2B elements) and new data types (unsigned ints, 64-bit ints). Use the `NC_64BIT_DATA` flag.

## Best Practices
- **Nonblocking APIs**: Use nonblocking routines (`ncmpi_iput_*` / `ncmpi_iget_*`) to aggregate multiple small I/O requests into a single large, efficient MPI-IO operation.
- **Lustre Optimization**: When running on Lustre, set the directory striping count to the maximum allowable for large files using `lfs setstripe`.
- **Buffer Attachment**: When using buffered nonblocking writes (`ncmpi_bput_*`), ensure you attach a sufficiently large buffer using `ncmpi_buffer_attach` before posting requests.

## Reference documentation
- [Parallel netCDF Q&A](./references/parallel-netcdf_github_io_doc_faq.html.md)
- [PnetCDF Quick Tutorial](./references/parallel-netcdf_github_io_wiki_QuickTutorial.html.md)
- [PnetCDF C Interface Guide](./references/parallel-netcdf_github_io_doc_c-reference_pnetcdf-c_index.html.md)
- [CDF-5 file format specification](./references/parallel-netcdf_github_io_doc_c-reference_pnetcdf-c_CDF_002d5-file-format-specification.html.md)