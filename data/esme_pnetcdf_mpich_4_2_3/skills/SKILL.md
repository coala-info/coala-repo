---
name: esme_pnetcdf_mpich_4_2_3
description: PnetCDF provides a library and command-line utilities for high-performance, concurrent access to netCDF files using MPI. Use when user asks to validate netCDF file specifications, compare parallel datasets, check variable file offsets, or tune parallel I/O performance using environment variables and alignment hints.
homepage: https://parallel-netcdf.github.io/
---


# esme_pnetcdf_mpich_4_2_3

## Overview
PnetCDF (Parallel netCDF) is a specialized library designed to enable multiple MPI processes to read and write netCDF files concurrently. It maintains compatibility with the classic netCDF file formats while providing advanced features like nonblocking I/O and collective data aggregation. This skill focuses on the command-line utilities and runtime configuration required to manage and optimize parallel datasets.

## Utility Programs
PnetCDF includes several command-line tools for file management and debugging:

- **ncvalidator**: Validates a netCDF file against CDF-1, CDF-2, and CDF-5 specifications.
  - Usage: `ncvalidator <filename>`
- **ncmpidiff**: Performs a parallel comparison of two netCDF files and reports differences.
  - Usage: `mpiexec -n <procs> ncmpidiff <file1> <file2>`
- **ncoffsets**: Reports the starting and ending file offsets of variables within a netCDF file. Useful for debugging alignment issues.
  - Usage: `ncoffsets <filename>`
- **pnetcdf-config**: Provides compiler and linker flags used to build the library.
  - Usage: `pnetcdf-config --libs` or `pnetcdf-config --cflags`
- **pnetcdf_version**: Reports the library version and build information.

## Performance Tuning via Environment Variables
You can tune PnetCDF behavior at runtime without recompiling the application:

- **PNETCDF_HINTS**: Pass I/O hints directly to the library.
  - Example: `export PNETCDF_HINTS="nc_var_align_size=1048576;nc_header_align_size=1048576"`
- **PNETCDF_SAFE_MODE**: Enables data consistency checking (1 to enable, 0 to disable).
- **PNETCDF_VERBOSE_DEBUG_MODE**: Enables verbose debugging messages for I/O operations.

## Expert Tips and Best Practices

### 1. File Format Selection
- **CDF-1**: Classic format (32-bit offsets). Use only for small, legacy datasets.
- **CDF-2**: 64-bit offset format. Use for files > 2GB but where individual variables are < 4GB.
- **CDF-5**: 64-bit data format. Supports large dimensions (> 2^32 elements) and 8-byte integers. Use for modern, large-scale simulations.

### 2. Avoiding the "Data Shift Penalty"
When adding metadata (attributes/variables) to an existing file, the header may grow. If it exceeds the reserved space, PnetCDF must shift the entire data section.
- **Solution**: Use the `nc_header_align_size` hint to reserve extra space in the header during file creation.

### 3. Alignment for Parallel File Systems (Lustre/GPFS)
Aligning variable starts with file system block boundaries (striping size) prevents expensive lock contention.
- **Lustre**: Use `lfs setstripe -c <count> -s <size> <directory>` on the output directory.
- **PnetCDF Hint**: Set `nc_var_align_size` to match the file system striping size (e.g., 1MB).

### 4. Collective vs. Independent I/O
- **Collective APIs** (`_all` suffix): Always prefer these. They allow the library to coordinate between processes and optimize the physical disk access pattern.
- **Independent APIs**: Use only for small, non-overlapping metadata updates or when processes are performing completely different tasks.

### 5. Nonblocking I/O Aggregation
If an application writes many small variables, use the nonblocking interface (`ncmpi_iput_*`).
- **Workflow**: Post multiple requests using `iput`, then call `ncmpi_wait_all`. This allows PnetCDF to "stitch" small requests into a single large, efficient MPI-IO operation.

## Reference documentation
- [PnetCDF Quick Tutorial](./references/parallel-netcdf_github_io_wiki_QuickTutorial.html.md)
- [PnetCDF FAQ](./references/parallel-netcdf_github_io_doc_faq.html.md)
- [PnetCDF File Limits](./references/parallel-netcdf_github_io_wiki_FileLimits.html.md)
- [CDF-5 File Format Specification](./references/parallel-netcdf_github_io_doc_c-reference_pnetcdf-c_CDF_002d5-file-format-specification.html.md)