---
name: esme_netcdf-c_psmpi_5_10_0
description: This tool provides a C interface for the NetCDF data format optimized for parallel I/O using PSMPI in high-performance computing environments. Use when user asks to inspect NetCDF file structures, generate C code templates from datasets, create binary files from CDL descriptions, or implement parallel data access for scientific modeling.
homepage: http://www.unidata.ucar.edu/software/netcdf/
metadata:
  docker_image: "quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0"
---

# esme_netcdf-c_psmpi_5_10_0

## Overview
This skill provides guidance for utilizing the NetCDF-C interface within high-performance computing (HPC) environments. NetCDF (Network Common Data Form) is a machine-independent data format for sharing scientific data. This specific build is optimized for use with the PSMPI implementation, enabling parallel access to datasets which is critical for large-scale climate, oceanic, and atmospheric modeling.

## Installation and Environment Setup
To use this specific build via Conda:
```bash
conda install bioconda::esme_netcdf-c_psmpi_5_10_0
```
Ensure your environment variables (like `LD_LIBRARY_PATH` and `PATH`) are correctly pointed to the conda environment prefix to ensure the PSMPI-linked libraries are prioritized over system defaults.

## Common CLI Patterns

### Inspecting NetCDF Files
Use `ncdump` to view the structure and contents of NetCDF files:
- **Header only**: `ncdump -h filename.nc` (View dimensions, variables, and attributes without data).
- **Coordinate data**: `ncdump -c filename.nc` (View header plus coordinate variable values).
- **Full dump**: `ncdump filename.nc` (Warning: can be extremely large for scientific datasets).

### Generating C Code Templates
If you have an existing `.cdl` (network Common Data form Language) file or an existing `.nc` file, you can generate the C code required to recreate that file structure:
```bash
ncdump -v var1,var2 filename.nc > template.cdl
ncgen -c template.cdl > recreate_file.c
```

### Creating Files from CDL
To create a binary NetCDF file from a text-based CDL description:
```bash
ncgen -o output.nc input.cdl
```

## Best Practices for NetCDF-C with PSMPI
- **Parallel I/O**: When using this PSMPI-linked version, always use `nc_create_par` or `nc_open_par` in your C code to leverage parallel file access.
- **Data Locality**: Define dimensions and variables such that the fastest-varying dimension (the last dimension in C) matches your memory access patterns to maximize I/O throughput.
- **Self-Description**: Always populate global attributes (e.g., `title`, `history`, `conventions`) and variable attributes (e.g., `units`, `_FillValue`) to ensure the data remains portable and understandable by other researchers.
- **Chunking**: For large datasets, use `nc_def_var_chunking` to optimize access patterns, especially when reading subsets of data across a network or from parallel file systems.

## Reference documentation
- [NetCDF-C Overview](./references/anaconda_org_channels_bioconda_packages_esme_netcdf-c_psmpi_5_10_0_overview.md)
- [Unidata NetCDF Software Documentation](./references/www_unidata_ucar_edu_software_netcdf.md)