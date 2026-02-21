---
name: esme_netcdf-c_openmpi_4_1_6
description: This skill assists in the development and execution of applications using the NetCDF-C interface within a parallel computing context.
homepage: http://www.unidata.ucar.edu/software/netcdf/
---

# esme_netcdf-c_openmpi_4_1_6

## Overview
This skill assists in the development and execution of applications using the NetCDF-C interface within a parallel computing context. It focuses on leveraging the `esme_netcdf-c_openmpi_4_1_6` package from Bioconda to handle array-oriented scientific data. Use this skill to navigate the complexities of parallel NetCDF (PnetCDF) integration, ensure proper linking with OpenMPI, and utilize standard NetCDF utilities for data inspection and generation.

## Compilation and Linking
To compile C applications against this specific build, you must ensure both the NetCDF headers and the MPI wrappers are correctly referenced.

- **Using nc-config**: The `nc-config` utility is the most reliable way to retrieve compiler flags.
  - Get CFLAGS: `nc-config --cflags`
  - Get Linker flags: `nc-config --libs`
  - Check for MPI support: `nc-config --has-parallel` (Should return 'yes')

- **Manual Compilation**:
  ```bash
  mpicc -o my_app my_app.c $(nc-config --cflags) $(nc-config --libs)
  ```

## Parallel I/O Best Practices
Since this version is linked with OpenMPI 4.1.6, follow these patterns for efficient parallel data access:

- **File Creation**: Use `nc_create_par` instead of `nc_create` to enable parallel access.
- **Access Modes**:
  - **Independent**: Each process performs I/O independently (default).
  - **Collective**: All processes participate in the I/O operation simultaneously. Use `nc_var_par_access(ncid, varid, NC_COLLECTIVE)` for significantly better performance on large datasets.
- **MPI Communicator**: Always pass `MPI_COMM_WORLD` (or your specific communicator) and `MPI_INFO_NULL` to the parallel open/create functions.

## Common Utility Patterns
- **Inspecting Metadata**: Use `ncdump -h <filename.nc>` to view the header information without dumping the data arrays.
- **Generating Code from CDL**: Use `ncgen -c -o output.nc input.cdl` to generate a C template or a binary NetCDF file from a Common Data Language (CDL) description.
- **Checking Chunking**: For large datasets, use `ncdump -s` to see the storage properties, including chunking and compression, which are critical for parallel performance.

## Environment Configuration
Ensure your runtime environment is correctly set up to find the OpenMPI and NetCDF shared libraries:
```bash
export LD_LIBRARY_PATH=$CONDA_PREFIX/lib:$LD_LIBRARY_PATH
```

## Reference documentation
- [NetCDF-C Overview](./references/anaconda_org_channels_bioconda_packages_esme_netcdf-c_openmpi_4_1_6_overview.md)
- [Unidata NetCDF Software Documentation](./references/www_unidata_ucar_edu_software_netcdf.md)