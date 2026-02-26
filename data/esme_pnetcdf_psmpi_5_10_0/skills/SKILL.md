---
name: esme_pnetcdf_psmpi_5_10_0
description: PnetCDF is a high-performance parallel I/O library designed for MPI-based applications to access and manage multi-dimensional netCDF datasets. Use when user asks to perform parallel I/O on netCDF files, validate file formats, compare large datasets using ncmpidiff, or optimize data alignment and collective buffering on parallel file systems.
homepage: https://parallel-netcdf.github.io/
---


# esme_pnetcdf_psmpi_5_10_0

## Overview
PnetCDF (Parallel netCDF) is a high-performance I/O library designed for MPI-based applications to access netCDF files in a truly parallel fashion. Unlike standard netCDF-4 which often relies on HDF5 for parallelism, PnetCDF provides a specialized interface for classic netCDF formats (CDF-1, CDF-2, and CDF-5). This skill enables the efficient management of multi-dimensional arrays across multiple processes, focusing on collective I/O optimizations, nonblocking request aggregation, and file alignment strategies for parallel file systems like Lustre or GPFS.

## Utility Programs
The following command-line tools are included for managing and validating PnetCDF files:

- **ncvalidator**: Validates a netCDF file against CDF-1, CDF-2, and CDF-5 format specifications.
  `ncvalidator <filename>`
- **ncmpidiff**: Performs a parallel comparison of two netCDF files and reports differences. This is more efficient than serial `diff` for large datasets.
  `mpiexec -n <procs> ncmpidiff <file1> <file2>`
- **ncoffsets**: Reports the starting and ending file offsets of variables. Useful for debugging alignment and "data shift" issues.
  `ncoffsets <filename>`
- **pnetcdf_version**: Displays the library version and build configuration.
- **pnetcdf-config**: Provides compiler and linker flags for building applications against the library.
  `pnetcdf-config --libs`

## Performance Tuning and Best Practices

### 1. Collective vs. Independent I/O
- **Collective I/O (Recommended)**: Use APIs with the `_all` suffix (e.g., `ncmpi_put_vara_all`). This allows the library to coordinate requests across all MPI processes, enabling optimizations like collective buffering and merged disk access.
- **Independent I/O**: Use only when processes access completely disjoint parts of a file at different times, but be aware this often leads to poor performance on parallel file systems due to lock contention.

### 2. Nonblocking I/O Aggregation
For applications writing many small variables, use the nonblocking interface to aggregate requests into a single large I/O operation:
1. Post multiple requests using `ncmpi_iput_vara_<type>`.
2. Commit them all at once using `ncmpi_wait_all`.
3. This reduces the number of expensive MPI-IO calls and improves throughput.

### 3. File Alignment (MPI Hints)
To avoid "data shift" penalties and improve performance on striped file systems (like Lustre), use MPI Info hints during file creation:
- **nc_header_align_size**: Pre-allocates extra space in the file header to allow for future metadata growth (adding attributes/variables) without shifting the entire data section.
- **nc_var_align_size**: Aligns the starting offset of fixed-size variables to the file system's striping block size (e.g., 1MB).

### 4. Environment Variables
- `PNETCDF_SAFE_MODE`: Set to `1` to enable strict data consistency checking across processes.
- `PNETCDF_HINTS`: Can be used to pass I/O hints (like `nc_var_align_size=1048576`) without modifying application code.
- `PNETCDF_VERBOSE_DEBUG_MODE`: Enables detailed debugging output for I/O operations.

## File Format Selection
- **CDF-1**: Classic format. Limited to 2GB variables.
- **CDF-2 (64-bit Offset)**: Use `NC_64BIT_OFFSET` flag. Supports files > 2GB, but individual fixed-size variables are still limited to 4GB.
- **CDF-5 (64-bit Data)**: Use `NC_64BIT_DATA` flag. Supports 64-bit integers, unsigned types, and variables with > 4 billion elements.

## Reference documentation
- [Parallel netCDF Q&A](./references/parallel-netcdf_github_io_doc_faq.html.md)
- [PnetCDF Quick Tutorial](./references/parallel-netcdf_github_io_wiki_QuickTutorial.html.md)
- [CDF-5 File Format Specification](./references/parallel-netcdf_github_io_doc_c-reference_pnetcdf-c_CDF_002d5-file-format-specification.html.md)
- [PnetCDF I/O Aggregation](./references/parallel-netcdf_github_io_wiki_CombiningOperations.html.md)