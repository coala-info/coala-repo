---
name: esme_netcdf-fortran_mvapich_4_0_ucx
description: This skill facilitates the use of NetCDF-Fortran, a library providing Fortran language bindings for the Network Common Data Form (NetCDF).
homepage: http://www.unidata.ucar.edu/software/netcdf/
---

# esme_netcdf-fortran_mvapich_4_0_ucx

## Overview
This skill facilitates the use of NetCDF-Fortran, a library providing Fortran language bindings for the Network Common Data Form (NetCDF). This specific build is optimized for `mvapich` using the `ucx` communication layer, making it suitable for parallel scientific computing on Linux AArch64 architectures. It allows researchers to create, access, and share self-describing, portable, and scalable scientific datasets.

## Installation
To install this specific build from the Bioconda channel:
```bash
conda install bioconda::esme_netcdf-fortran_mvapich_4_0_ucx
```

## Compilation and Linking
When compiling Fortran applications with this library, you must ensure the compiler can find the module files (`.mod`) and the linker can find the shared libraries.

### Environment Variables
After installation, ensure your environment paths are set (usually handled by conda activate, but verify if manual compilation is required):
- `CPATH` or `FFLAGS`: Should include the path to the NetCDF Fortran include directory (e.g., `$CONDA_PREFIX/include`).
- `LIBRARY_PATH` or `LDFLAGS`: Should include the path to the NetCDF Fortran library directory (e.g., `$CONDA_PREFIX/lib`).

### Basic Compilation Pattern
Use `nf-config` to automatically retrieve the necessary flags for your specific installation:

```bash
# Get compilation flags
nf-config --fflags

# Get linking flags
nf-config --flibs
```

Example manual compilation command:
```bash
mpif90 my_model.f90 -o my_model $(nf-config --fflags --flibs)
```

## Best Practices
- **Parallel I/O**: Since this build uses MVAPICH, ensure you are using the parallel NetCDF features (if supported by the underlying NetCDF-C library) by calling `nf90_open` or `nf90_create` with the `NF90_MPIIO` or `NF90_NETCDF4` flags.
- **Module Usage**: Always include `use netcdf` at the beginning of your Fortran subroutines or modules to access the NetCDF-4 interface.
- **Error Handling**: Check the return status of every NetCDF function call. Use `nf90_strerror(status)` to print human-readable error messages.
- **Data Portability**: Leverage NetCDF's self-describing nature by defining clear attributes for units, long names, and coordinates to ensure data remains usable across different platforms.

## Reference documentation
- [NetCDF-Fortran Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_esme_netcdf-fortran_mvapich_4_0_ucx_overview.md)
- [Unidata NetCDF Software Documentation](./references/www_unidata_ucar_edu_software_netcdf.md)