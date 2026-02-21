---
name: esme_pnetcdf_openmpi_4_1_6
description: PnetCDF (Parallel netCDF) is a library that enables MPI-based applications to concurrently access netCDF files.
homepage: https://parallel-netcdf.github.io/
---

# esme_pnetcdf_openmpi_4_1_6

## Overview
PnetCDF (Parallel netCDF) is a library that enables MPI-based applications to concurrently access netCDF files. It provides a high-level interface for multi-dimensional arrays while maintaining compatibility with the classic netCDF file formats. This skill focuses on utilizing the PnetCDF command-line utilities and applying performance tuning strategies such as request aggregation, nonblocking I/O, and file alignment to maximize throughput on high-performance computing (HPC) clusters.

## Utility Programs
PnetCDF includes several command-line tools for managing and inspecting parallel netCDF files:

- **ncvalidator**: Validates a netCDF file against CDF-1, CDF-2, and CDF-5 format specifications.
  - Usage: `ncvalidator <filename>`
- **ncmpidiff**: Performs a parallel comparison of two netCDF files and reports differences in metadata or data.
  - Usage: `mpiexec -n <procs> ncmpidiff <file1> <file2>`
- **ncoffsets**: Reports the starting and ending file offsets of variables within a netCDF file. This is critical for verifying file alignment and debugging "data shift" penalties.
  - Usage: `ncoffsets <filename>`
- **pnetcdf-config**: Provides information about the PnetCDF installation, including compiler flags and library dependencies.
  - Usage: `pnetcdf-config --libs` or `pnetcdf-config --all`
- **pnetcdf_version**: Reports the version and build information of the PnetCDF library.

## Performance Tuning and Best Practices

### 1. Use Collective APIs
Always prefer collective APIs (functions ending in `_all`) over independent APIs. Collective I/O allows the underlying MPI-IO layer to coordinate requests across processes, enabling optimizations like collective buffering and merged I/O requests.

### 2. Nonblocking I/O Aggregation
For applications accessing many small variables or non-contiguous data, use the nonblocking interface (`ncmpi_iput_*` / `ncmpi_iget_*`).
- **Aggregation**: Post multiple requests and then call `ncmpi_wait_all`. This allows PnetCDF to "stitch" small requests into a single, large, efficient MPI-IO operation.
- **Buffered Writes**: Use `ncmpi_bput_*` if you need to modify the user buffer immediately after the call. This requires attaching a buffer first via `ncmpi_buffer_attach`.

### 3. File Layout Alignment
Unaligned file access can cause significant performance degradation due to file locking contention.
- **Header Alignment**: Use the `nc_header_align_size` hint to reserve extra space in the file header. This prevents a "data shift penalty" (moving the entire data section) if attributes or variables are added later.
- **Variable Alignment**: Use the `nc_var_align_size` hint to align the start of fixed-size variables with the file system's striping size (e.g., 1MB for Lustre).

### 4. Environment Variables
Control library behavior at runtime without recompilation:
- `PNETCDF_HINTS`: Set I/O hints globally (e.g., `export PNETCDF_HINTS="nc_var_align_size=1048576"`).
- `PNETCDF_SAFE_MODE`: Enable data consistency checking (1 to enable, 0 to disable).
- `PNETCDF_VERBOSE_DEBUG_MODE`: Enable detailed debugging output for I/O operations.

### 5. File Format Selection
- **CDF-1**: Classic format (32-bit offsets). Use for maximum compatibility with old tools.
- **CDF-2**: 64-bit offset format. Use for files larger than 2GB.
- **CDF-5**: 64-bit data format. Use for datasets with more than 2^32 elements per variable or when using 64-bit integer types (`NC_INT64`, `NC_UINT64`).

## Reference documentation
- [PnetCDF C Interface Guide](./references/parallel-netcdf_github_io_doc_c-reference_pnetcdf_c_index.html.md)
- [PnetCDF FAQ](./references/parallel-netcdf_github_io_doc_faq.html.md)
- [PnetCDF Quick Tutorial](./references/parallel-netcdf_github_io_wiki_QuickTutorial.html.md)
- [File Format Specifications (CDF-5)](./references/parallel-netcdf_github_io_doc_c-reference_pnetcdf_c_CDF_002d5-file-format-specification.html.md)