---
name: esme_pnetcdf_mpich_4_3_1
description: PnetCDF (Parallel netCDF) is a specialized library designed for MPI-based applications to perform high-concurrency I/O on netCDF datasets.
homepage: https://parallel-netcdf.github.io/
---

# esme_pnetcdf_mpich_4_3_1

## Overview
PnetCDF (Parallel netCDF) is a specialized library designed for MPI-based applications to perform high-concurrency I/O on netCDF datasets. It supports the classic CDF-1 format, the 64-bit offset CDF-2 format, and the 64-bit data CDF-5 format (which allows for unsigned types and dimensions exceeding 2^32 elements). This skill provides guidance on using the bundled utility programs to manage, validate, and tune parallel netCDF files, as well as configuring the runtime environment for optimal performance on parallel file systems like Lustre or GPFS.

## Utility Programs
The package includes several command-line tools for file management and debugging:

- **ncvalidator**: Use this to check if a netCDF file conforms to the CDF-1, CDF-2, or CDF-5 specifications.
  - `ncvalidator <filename>`
- **ncmpidiff**: A parallel tool to compare two netCDF files and report differences in metadata or data.
  - `mpiexec -n <procs> ncmpidiff <file1.nc> <file2.nc>`
- **ncoffsets**: Reports the starting and ending file offsets of variables within a netCDF file. This is critical for verifying if variable alignment hints are being respected.
  - `ncoffsets <filename>`
- **pnetcdf-config**: Provides information about the library's configuration, including compiler flags and dependencies.
  - `pnetcdf-config --libs`
- **pnetcdf_version**: Reports the version and build date of the PnetCDF library.

## Performance Tuning and Hints
PnetCDF uses "hints" passed via MPI_Info objects or environment variables to optimize I/O patterns.

### Key I/O Hints
- **nc_header_align_size**: Sets the alignment for the file header. Use this to reserve extra space (e.g., 1MB) to avoid the "data shift penalty" if you plan to add more attributes or variables later.
- **nc_var_align_size**: Aligns the starting offset of fixed-size variables to a specific block size (e.g., the striping size of the file system).
  - *Expert Tip*: For Lustre or GPFS, setting this to the striping size (often 1MB) can significantly reduce file locking contention.

### Runtime Environment Variables
You can apply tuning without recompiling by using environment variables:
- **PNETCDF_HINTS**: Pass multiple hints using a semicolon-separated string.
  - `export PNETCDF_HINTS="nc_var_align_size=1048576;nc_header_align_size=1048576"`
- **PNETCDF_SAFE_MODE**: Set to `1` to enable strict data consistency checking across processes.
- **PNETCDF_VERBOSE_DEBUG_MODE**: Set to `1` to print detailed debugging messages during I/O operations.

## Best Practices
- **Prefer Collective APIs**: Always use collective calls (e.g., `ncmpi_put_vara_all`) over independent calls when multiple processes are accessing the same file. This allows the underlying MPI-IO layer to optimize requests via collective buffering.
- **Use Nonblocking APIs for Small Requests**: If your application writes many small variables, use the nonblocking interface (`ncmpi_iput_...`) and a single `ncmpi_wait_all` to aggregate these into a single large, efficient I/O operation.
- **CDF-5 for Large Data**: Use the `NC_64BIT_DATA` flag (CDF-5) when creating files that require variables with more than 4 billion elements or when using unsigned 64-bit integers.
- **Lustre Striping**: When working on Lustre, use `lfs setstripe` on the output directory to set a high stripe count before running the PnetCDF application to maximize bandwidth.

## Reference documentation
- [The PnetCDF C Interface Guide](./references/parallel-netcdf_github_io_doc_c-reference_pnetcdf-c_index.html.md)
- [Parallel netCDF Q&A](./references/parallel-netcdf_github_io_doc_faq.html.md)
- [PnetCDF Quick Tutorial](./references/parallel-netcdf_github_io_wiki_QuickTutorial.html.md)
- [PnetCDF File Limits](./references/parallel-netcdf_github_io_wiki_FileLimits.html.md)