---
name: esme_netcdf-c_psmpi_5_12_1
description: This tool provides the NetCDF-C interface optimized for parallel I/O operations using PSMPI in high-performance computing environments. Use when user asks to compile C applications with parallel NetCDF support, inspect NetCDF metadata using ncdump, or generate binary NetCDF files from CDL text using ncgen.
homepage: http://www.unidata.ucar.edu/software/netcdf/
metadata:
  docker_image: "quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0"
---

# esme_netcdf-c_psmpi_5_12_1

## Overview

This skill assists in the development and execution of applications using the NetCDF-C interface within high-performance computing (HPC) environments utilizing PSMPI. NetCDF (Network Common Data Form) is a standard for array-oriented scientific data that is self-describing and portable. This specific build is optimized for parallel I/O operations, allowing multiple processes to read and write to the same dataset efficiently.

## Installation and Environment

To ensure the correct environment is active, install the package via conda:

```bash
conda install bioconda::esme_netcdf-c_psmpi_5_12_1
```

Verify the installation and version:
```bash
nc-config --version
```

## Compiling C Applications

When building applications against this library, use `nc-config` to retrieve the necessary compiler and linker flags. This ensures that the PSMPI dependencies are correctly linked.

### Basic Compilation
```bash
# Get compilation flags
cc $(nc-config --cflags) -c my_app.c

# Get linker flags
cc my_app.o $(nc-config --libs) -o my_app
```

### Parallel NetCDF Support
Since this build is for `psmpi`, ensure your code uses the `nc_create_par` or `nc_open_par` functions for parallel access. You must include `mpi.h` before `netcdf.h`.

## Common CLI Patterns

### Inspecting Data (ncdump)
Use `ncdump` to view the header or data content of a NetCDF file.

- **View Header Only (Metadata):**
  ```bash
  ncdump -h data_file.nc
  ```
- **View Specific Variable:**
  ```bash
  ncdump -v temperature data_file.nc
  ```
- **Generate C Code Template:**
  Generate a C program that recreates the structure of an existing NetCDF file:
  ```bash
  ncdump -c data_file.nc > recreate_file.c
  ```

### Generating Files (ncgen)
Use `ncgen` to create a binary NetCDF file from a CDL (Network Common Data form Language) text description.

- **Create NetCDF-4 File:**
  ```bash
  ncgen -o output.nc -k netCDF-4 input.cdl
  ```

## Expert Tips

1. **Chunking for Performance:** When working with large datasets in parallel, use `nc_def_var_chunking` to align data chunks with the underlying file system's striping for better I/O throughput.
2. **Parallel Access Modes:** Remember that `nc_var_par_access` can switch between `NC_COLLECTIVE` (all processes participate) and `NC_INDEPENDENT` (processes act individually) modes. Collective I/O is generally faster for large, contiguous writes.
3. **Check Format Compatibility:** Use `ncdump -k` to identify the file format (e.g., classic, 64-bit offset, or netCDF-4/HDF5) to ensure your application logic supports the specific features of that format.

## Reference documentation
- [NetCDF-C Overview](./references/anaconda_org_channels_bioconda_packages_esme_netcdf-c_psmpi_5_12_1_overview.md)
- [NetCDF Software Documentation](./references/www_unidata_ucar_edu_software_netcdf.md)