---
name: esme_netcdf-c_mvapich_4_0_ofi
description: This package provides the C implementation of the Network Common Data Form (NetCDF) optimized for parallel I/O with MVAPICH and OFI fabrics. Use when user asks to inspect NetCDF metadata, convert or compress scientific datasets, generate binary files from CDL text, or configure C projects with MPI-enabled NetCDF linking flags.
homepage: http://www.unidata.ucar.edu/software/netcdf/
---


# esme_netcdf-c_mvapich_4_0_ofi

## Overview

The `esme_netcdf-c_mvapich_4_0_ofi` package provides the C implementation of the Network Common Data Form (NetCDF) specifically compiled for compatibility with MVAPICH and OFI fabrics. This build is essential for researchers and developers working on distributed systems where parallel I/O performance is a priority. It allows for the creation and manipulation of self-describing, machine-independent scientific data formats. Use this skill to navigate the core CLI utilities provided by the library and to configure C-based projects that link against this specific MPI-enabled build.

## Core CLI Usage

The package includes several standard utilities for interacting with NetCDF files from the command line.

### Inspecting Data with ncdump
Use `ncdump` to view the structure and contents of NetCDF files.
- **View header only (metadata):** `ncdump -h filename.nc`
- **View coordinate variables and header:** `ncdump -c filename.nc`
- **Export to CDL (text format):** `ncdump filename.nc > filename.cdl`

### Generating Files with ncgen
Use `ncgen` to create a binary NetCDF file from a CDL text description.
- **Create a NetCDF-4 file:** `ncgen -k nc4 -o output.nc input.cdl`
- **Generate C code to create the file:** `ncgen -lc input.cdl > create_file.c`

### Converting and Compressing with nccopy
Use `nccopy` to change formats or apply compression/chunking.
- **Convert to NetCDF-4 with deflation (compression level 4):** `nccopy -k nc4 -d 4 input.nc output.nc`
- **Re-chunk for better access patterns:** `nccopy -c "var1/10,10,10" input.nc output.nc`

## Development and Linking

Since this is a specialized build for MVAPICH and OFI, correct linking is critical for C applications.

### Using nc-config
The `nc-config` tool provides the necessary flags for compiling and linking.
- **Get C compiler flags:** `nc-config --cflags`
- **Get linker flags:** `nc-config --libs`
- **Check if NetCDF-4/HDF5 is enabled:** `nc-config --has-nc4`
- **Check for parallel I/O support:** `nc-config --has-pnetcdf` or `nc-config --has-parallel4`

## Expert Tips for HPC Environments

1.  **Parallel I/O:** When using this build, ensure your code uses `nc_create_par` or `nc_open_par` to leverage the MVAPICH MPI layer for collective I/O operations.
2.  **Environment Tuning:** Because this build uses OFI, you may need to set the `FI_PROVIDER` environment variable (e.g., `export FI_PROVIDER=psm2` or `verbs`) to match your cluster's interconnect for optimal performance.
3.  **Chunking Strategy:** For large datasets, align your NetCDF chunks with the underlying file system's stripe size (e.g., Lustre) to minimize I/O contention in parallel writes.
4.  **Library Pathing:** Ensure that the Conda environment's `lib` directory is in your `LD_LIBRARY_PATH` to avoid linking against system-default NetCDF libraries that lack MPI/OFI support.

## Reference documentation
- [NetCDF-C - netCDF interface for C](./references/anaconda_org_channels_bioconda_packages_esme_netcdf-c_mvapich_4_0_ofi_overview.md)
- [NetCDF Software Documentation](./references/www_unidata_ucar_edu_software_netcdf.md)