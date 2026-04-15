---
name: esme_pnetcdf_openmpi_5_0_7
description: PnetCDF provides a library and utility programs for MPI-based parallel programs to read and write netCDF files in CDF-1, CDF-2, and CDF-5 formats. Use when user asks to validate netCDF files, compare two netCDF files in parallel, report variable file offsets, or optimize parallel I/O performance using hints and environment variables.
homepage: https://parallel-netcdf.github.io/
metadata:
  docker_image: "quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0"
---

# esme_pnetcdf_openmpi_5_0_7

## Overview
PnetCDF (Parallel netCDF) is a specialized library designed for MPI-based parallel programs to read and write netCDF files. It supports the classic CDF-1 format, the 64-bit offset CDF-2 format, and the 64-bit data CDF-5 format (which allows for 8-byte integers and variables exceeding 4GiB). This skill provides guidance on using the bundled utility programs, managing file formats, and applying performance tuning via I/O hints and environment variables.

## Utility Programs
The following CLI tools are included for managing and inspecting PnetCDF files:

- **ncvalidator**: Validates a netCDF file against the CDF-1, 2, and 5 format specifications.
  - Usage: `ncvalidator <filename>`
- **ncmpidiff**: A parallel tool to compare two netCDF files and report differences.
  - Usage: `mpiexec -n <procs> ncmpidiff <file1> <file2>`
- **ncoffsets**: Reports the starting and ending file offsets of variables within a netCDF file. This is critical for verifying if variable alignment hints are being respected.
  - Usage: `ncoffsets <filename>`
- **pnetcdf_version**: Reports the version and build information of the PnetCDF library.
- **pnetcdf-config**: Provides compiler flags and library dependencies used during the build. Useful for linking new applications.

## Performance Tuning and Best Practices

### I/O Hints
PnetCDF uses MPI-Info objects to pass "hints" that optimize I/O. These can be set in code or via the `PNETCDF_HINTS` environment variable.

- **nc_header_align_size**: Sets the alignment for the file header. Use this to reserve extra space (e.g., 1MB) to prevent the "data shift penalty" if you plan to add more metadata/attributes later.
- **nc_var_align_size**: Aligns the starting offset of fixed-size variables to a specific block size (e.g., 1048576 for 1MB). This reduces unaligned file system accesses on Lustre or GPFS.
- **Example (Environment Variable)**: `export PNETCDF_HINTS="nc_var_align_size=1048576;nc_header_align_size=1048576"`

### File System Optimization (Lustre)
When running on Lustre, always set the striping count to the maximum allowable for large files to increase bandwidth:
- `lfs setstripe -c -1 -s 1M <directory_or_file>`

### API Selection
- **Collective vs. Independent**: Prefer collective APIs (e.g., `ncmpi_put_vara_all`) over independent ones. Collective calls allow the underlying MPI-IO layer to optimize requests across all processes.
- **Nonblocking APIs**: Use nonblocking APIs (e.g., `ncmpi_iput_vara`) to aggregate multiple small requests into a single large I/O operation. This is significantly faster than making many small serial calls.
- **Buffered Writes**: If you need to reuse your data buffer immediately after a write call, use the buffered interface (`ncmpi_bput_vara`), but ensure you have attached a buffer using `ncmpi_buffer_attach`.

## Runtime Environment Variables
- **PNETCDF_SAFE_MODE**: Set to `1` to enable internal data consistency checking (useful for debugging).
- **PNETCDF_VERBOSE_DEBUG_MODE**: Set to `1` to print detailed debugging messages regarding I/O operations.
- **PNETCDF_HINTS**: Used to pass I/O hints to the library without recompiling the application.

## File Format Selection
- **CDF-1**: Classic format. Limited to 2GiB variables.
- **CDF-2**: 64-bit offset. Allows files > 2GiB, but individual variables are still mostly limited to 4GiB.
- **CDF-5**: 64-bit data. Supports `NC_UINT`, `NC_INT64`, etc., and allows variables to exceed 4GiB. Use the `NC_64BIT_DATA` flag during file creation.

## Reference documentation
- [Parallel netCDF Q&A](./references/parallel-netcdf_github_io_doc_faq.html.md)
- [PnetCDF Quick Tutorial](./references/parallel-netcdf_github_io_wiki_QuickTutorial.html.md)
- [CDF-5 file format specification](./references/parallel-netcdf_github_io_doc_c-reference_pnetcdf-c_CDF_002d5-file-format-specification.html.md)
- [PnetCDF I/O Aggregation Through Nonblocking APIs](./references/parallel-netcdf_github_io_wiki_CombiningOperations.html.md)