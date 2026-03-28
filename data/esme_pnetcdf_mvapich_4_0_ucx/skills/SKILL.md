---
name: esme_pnetcdf_mvapich_4_0_ucx
description: PnetCDF provides high-performance parallel access to NetCDF files using MPI-based communication for large-scale scientific datasets. Use when user asks to compare NetCDF files in parallel, validate file specifications, report variable offsets, or optimize parallel I/O performance through nonblocking APIs and alignment hints.
homepage: https://parallel-netcdf.github.io/
---

# esme_pnetcdf_mvapich_4_0_ucx

## Overview
PnetCDF (Parallel NetCDF) is a specialized library designed for MPI-based parallel access to Unidata's NetCDF files. This specific implementation leverages MVAPICH and UCX to provide high-bandwidth communication for large-scale scientific datasets. It supports the classic CDF-1 and CDF-2 formats, as well as the CDF-5 format, which allows for 64-bit integers and variables exceeding 2 billion elements. This skill focuses on utilizing the library's utility programs and performance-tuning mechanisms to ensure efficient data throughput on parallel file systems.

## Utility Programs
The following command-line tools are essential for managing PnetCDF files:

- **ncmpidiff**: Compares two NetCDF files in parallel and reports differences.
  `mpiexec -n <procs> ncmpidiff file1.nc file2.nc`
- **ncvalidator**: Validates a NetCDF file against the CDF-1, CDF-2, and CDF-5 specifications.
  `ncvalidator <filename>`
- **ncoffsets**: Reports the starting and ending file offsets of NetCDF variables, useful for debugging alignment issues.
  `ncoffsets <filename>`
- **pnetcdf-config**: Provides information about the compiler flags and libraries used to build PnetCDF.
  `pnetcdf-config --libs`
- **pnetcdf_version**: Reports the version and build date of the PnetCDF library.

## Performance Tuning and Best Practices

### I/O Aggregation with Nonblocking APIs
For applications accessing many small variables, use nonblocking APIs (prefixed with `ncmpi_i`) to aggregate requests.
- **Post requests**: Use `ncmpi_iput_vara_<type>` or `ncmpi_iget_vara_<type>`.
- **Commit**: Use `ncmpi_wait_all` (collective) or `ncmpi_wait` (independent) to execute the aggregated I/O.

### Alignment and Hints
To avoid "data shift penalties" (where the entire data section is moved because the header grew), use I/O hints via the `PNETCDF_HINTS` environment variable:
- **Header Alignment**: Set `nc_header_align_size` to match your file system's striping size (e.g., 1MB).
- **Variable Alignment**: Set `nc_var_align_size` to align the start of fixed-size variables to block boundaries.
- **Example**: `export PNETCDF_HINTS="nc_header_align_size=1048576;nc_var_align_size=1048576"`

### File System Optimization (Lustre)
When running on Lustre, match the PnetCDF access pattern to the file striping:
- Use `lfs setstripe -c <count> -s <size> <directory>` to set high striping counts for large files.
- Prefer **Collective APIs** (`_all` suffix) over independent APIs, as they allow the library to coordinate requests to match the underlying storage targets.

### Safe Mode and Debugging
- **PNETCDF_SAFE_MODE**: Set to `1` to enable internal consistency checking for attributes and arguments across all MPI processes.
- **PNETCDF_VERBOSE_DEBUG_MODE**: Set to `1` (if the library was built with `--enable-debug`) to trace the origin of error codes.



## Subcommands

| Command | Description |
|---------|-------------|
| esme_pnetcdf_mvapich_4_0_ucx_pnetcdf_version | PnetCDF Version and Release Information |
| ncoffsets | Output variable offsets, sizes, and gaps in a netCDF file. |
| ncvalidator | Validate netCDF files |
| pnetcdf-config | pnetcdf-config is a utility program to display the build and installation information of the PnetCDF library. |

## Reference documentation
- [PnetCDF FAQ and Performance Tuning](./references/parallel-netcdf_github_io_doc_faq.html.md)
- [Nonblocking I/O and Aggregation](./references/parallel-netcdf_github_io_wiki_CombiningOperations.html.md)
- [CDF-5 File Format Specification](./references/parallel-netcdf_github_io_doc_c-reference_pnetcdf-c_CDF_002d5-file-format-specification.html.md)
- [PnetCDF C Interface Guide](./references/parallel-netcdf_github_io_doc_c-reference_pnetcdf-c_index.html.md)