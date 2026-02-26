---
name: esme_netcdf-c_mpich_4_3_1
description: This tool provides the NetCDF-C interface linked with MPICH for managing and sharing array-oriented scientific data with parallel file access. Use when user asks to inspect NetCDF metadata, convert CDL files to binary, apply compression, or configure C applications for high-performance parallel I/O.
homepage: http://www.unidata.ucar.edu/software/netcdf/
---


# esme_netcdf-c_mpich_4_3_1

## Overview

This skill facilitates the use of the NetCDF-C interface, a community standard for sharing and managing array-oriented scientific data. This specific distribution is linked against MPICH 4.3.1, enabling parallel file access and high-performance data operations. Use this skill to navigate the command-line utilities provided by NetCDF-C and to configure C-based applications that require parallel NetCDF capabilities.

## Installation and Environment

To ensure the tool is available in your environment:

```bash
conda install bioconda::esme_netcdf-c_mpich_4_3_1
```

Since this build is MPI-dependent, ensure your environment has the corresponding MPICH runtime active to avoid shared library errors.

## Common CLI Patterns

### Inspecting Metadata and Data
Use `ncdump` to examine the contents of NetCDF files.
- **Header only**: `ncdump -h <filename.nc>` (Essential for checking dimensions and attributes without loading data).
- **Coordinate data**: `ncdump -c <filename.nc>` (Displays header plus coordinate variable values).
- **Full data dump**: `ncdump <filename.nc> > <output.cdl>` (Converts binary NetCDF to human-readable CDL format).

### Generating NetCDF Files
Use `ncgen` to create binary NetCDF files from CDL text files.
- **Create NetCDF-4/HDF5 file**: `ncgen -4 -b -o <output.nc> <input.cdl>`
- **Generate C code**: `ncgen -c <input.cdl>` (Produces C code that, when compiled, creates the specified NetCDF file).

### Copying and Conversion
Use `nccopy` to convert between formats or apply compression.
- **Convert to NetCDF-4**: `nccopy -k netCDF-4 <input.nc> <output.nc>`
- **Apply Deflate compression**: `nccopy -d 5 <input.nc> <output.nc>` (Level 5 is generally the best balance of speed and size).
- **Rechunking**: `nccopy -c <dim1/size1,dim2/size2> <input.nc> <output.nc>` (Optimizes access patterns for specific dimensions).

## Expert Tips for Parallel Usage

### Build Configuration
Because this build is integrated with MPICH, use `nc-config` to retrieve the correct compiler and linker flags for your C applications:
- **Check MPI support**: `nc-config --has-parallel4` or `nc-config --has-pnetcdf`
- **Get C flags**: `nc-config --cflags`
- **Get Linker flags**: `nc-config --libs`

### Parallel I/O Considerations
When writing C code to utilize this specific MPICH-enabled build:
1. **File Creation**: Use `nc_create_par` instead of `nc_create` to enable parallel access.
2. **File Opening**: Use `nc_open_par` for parallel reading.
3. **Collective vs. Independent**: Use `nc_var_par_access` to toggle between `NC_COLLECTIVE` (better for large, contiguous writes) and `NC_INDEPENDENT` (better for sparse or irregular access).

### Performance Tuning
- **Alignment**: When using parallel I/O, align your data chunks with the underlying file system's stripe size to minimize contention.
- **Format Choice**: Prefer NetCDF-4 (HDF5-based) for large datasets requiring parallel I/O, as it provides better support for concurrent access compared to the classic format.

## Reference documentation
- [NetCDF-C - netCDF interface for C Overview](./references/anaconda_org_channels_bioconda_packages_esme_netcdf-c_mpich_4_3_1_overview.md)
- [NetCDF Software Documentation](./references/www_unidata_ucar_edu_software_netcdf.md)