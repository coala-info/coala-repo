---
name: esme_pnetcdf_openmpi_4_1_6
description: PnetCDF provides high-performance parallel access to NetCDF files using MPI-IO for concurrent reading and writing. Use when user asks to compare NetCDF files, validate file formats, inspect variable offsets, check library configurations, or optimize parallel I/O performance.
homepage: https://parallel-netcdf.github.io/
---


# esme_pnetcdf_openmpi_4_1_6

## Overview

PnetCDF (Parallel NetCDF) is a high-performance library designed for concurrent access to NetCDF files in classic formats (CDF-1, CDF-2, and CDF-5). By leveraging MPI-IO, it allows multiple processes to read and write to a single file efficiently. This skill provides guidance on using the bundled utility programs for file validation, comparison, and metadata inspection, as well as expert tips for tuning I/O performance on parallel file systems.

## Utility Programs

The following CLI tools are essential for managing PnetCDF files and verifying library configurations:

- **ncmpidiff**: Compares two NetCDF files in parallel and reports differences in header metadata or variable data.
  - Usage: `mpiexec -n <procs> ncmpidiff file1.nc file2.nc`
- **ncvalidator**: Validates a classic NetCDF file against CDF-1, CDF-2, and CDF-5 format specifications.
  - Usage: `ncvalidator <filename>`
- **ncoffsets**: Reports the starting and ending file offsets of NetCDF variables, which is useful for debugging alignment and layout issues.
  - Usage: `ncoffsets <filename>`
- **pnetcdf-config**: Reports the configuration and compilation options used to build the PnetCDF library.
  - Usage: `pnetcdf-config --all`
- **pnetcdf_version**: Reports the version information of the PnetCDF library.
- **cdfdiff**: A serial version of `ncmpidiff` for comparing files without requiring an MPI environment.

## Performance Tuning and Best Practices

To achieve maximum I/O throughput, especially on parallel file systems like Lustre or GPFS, follow these expert guidelines:

### 1. Use Collective APIs
Always prefer collective APIs (e.g., `ncmpi_put_vara_all`) over independent APIs. Collective I/O allows the library and the underlying MPI-IO implementation to coordinate requests, merge small accesses, and optimize the pattern for the file system's striping.

### 2. File Alignment
Aligning the start of variables to file system block boundaries (striping size) can eliminate "unaligned" access penalties.
- **Hint**: Use `nc_var_align_size` to set the alignment (e.g., 1MB or 4MB depending on the OST striping).
- **Header Alignment**: Use `nc_header_align_size` to reserve extra space in the file header. This prevents a "data shift penalty" if you later add attributes or variables that cause the header to grow beyond its initial allocation.

### 3. Nonblocking APIs for Small Requests
If your application performs many small I/O requests, use nonblocking APIs (e.g., `ncmpi_iput_vara`).
- Post multiple requests using `iput`/`iget`.
- Commit them all at once using `ncmpi_wait_all`.
- This allows PnetCDF to aggregate multiple small requests into a single large, contiguous I/O operation.

### 4. Lustre Striping
On Lustre file systems, set the striping count to the maximum allowable for large files to distribute I/O across multiple Object Storage Targets (OSTs).
- Command: `lfs setstripe -c -1 -s 1M <directory>`

## Runtime Environment Variables

You can tune PnetCDF behavior without recompiling by setting these environment variables:

- **PNETCDF_HINTS**: Pass I/O hints directly to the library.
  - Example: `export PNETCDF_HINTS="nc_header_align_size=1048576;nc_var_align_size=1048576"`
- **PNETCDF_SAFE_MODE**: Set to `1` to enable internal consistency checking for attributes and arguments across all processes (useful for debugging).
- **PNETCDF_VERBOSE_DEBUG_MODE**: Set to `1` to print the source code location where error codes originate (requires library built with `--enable-debug`).



## Subcommands

| Command | Description |
|---------|-------------|
| esme_pnetcdf_openmpi_4_1_6_pnetcdf_version | PnetCDF Version Information |
| ncoffsets | Prints offsets of variables in a netCDF file. |
| ncvalidator | Validate a netCDF file. |
| pnetcdf-config | A utility program to display the build and installation information of the PnetCDF library. |

## Reference documentation

- [PnetCDF C Interface Guide](./references/parallel-netcdf_github_io_doc_c-reference_pnetcdf-c_index.html.md)
- [PnetCDF Q&A and Performance Tuning](./references/parallel-netcdf_github_io_doc_faq.html.md)
- [PnetCDF I/O Aggregation (Nonblocking APIs)](./references/parallel-netcdf_github_io_wiki_CombiningOperations.html.md)
- [CDF-5 File Format Specification](./references/parallel-netcdf_github_io_doc_c-reference_pnetcdf-c_CDF_002d5-file-format-specification.html.md)