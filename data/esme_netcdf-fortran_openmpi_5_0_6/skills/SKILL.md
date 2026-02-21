---
name: esme_netcdf-fortran_openmpi_5_0_6
description: This skill provides procedural knowledge for utilizing the NetCDF-Fortran library within an OpenMPI 5.0.6 environment.
homepage: http://www.unidata.ucar.edu/software/netcdf/
---

# esme_netcdf-fortran_openmpi_5_0_6

## Overview
This skill provides procedural knowledge for utilizing the NetCDF-Fortran library within an OpenMPI 5.0.6 environment. It focuses on the compilation, linking, and execution of Fortran programs that need to read or write array-oriented scientific data (NetCDF format) across multiple compute nodes. This specific build ensures compatibility between the Fortran bindings and the underlying MPI implementation for parallel I/O operations.

## Compilation and Linking
To correctly compile Fortran code with this library, use the `nf-config` utility to retrieve the necessary compiler flags and library paths. Since this package is built with OpenMPI, you must use the MPI Fortran wrapper.

### Basic Compilation Pattern
```bash
mpifort my_script.f90 -o my_app $(nf-config --fflags --flibs)
```

### Key nf-config Flags
- `nf-config --fflags`: Returns the Fortran compiler flags (include paths).
- `nf-config --flibs`: Returns the library linking flags.
- `nf-config --prefix`: Returns the installation directory.
- `nf-config --has-parallel`: Checks if the build supports parallel I/O (should return 'yes' for this OpenMPI build).

## Best Practices
- **Environment Consistency**: Ensure the conda environment containing `esme_netcdf-fortran_openmpi_5_0_6` is active during both compilation and runtime to avoid shared library mismatches.
- **Parallel I/O**: When using this library for parallel writes, use the `NF90_MPIIO` or `NF90_NETCDF4` flags in your `nf90_create` or `nf90_open` calls to leverage the OpenMPI backend.
- **Module Usage**: Always include `use netcdf` at the beginning of your Fortran modules to access the NetCDF-4 API.
- **Error Handling**: Check the return status of every NetCDF function call (e.g., `status = nf90_open(...)`) and use `nf90_strerror(status)` for debugging.

## Execution
Run your compiled binary using the MPI runner compatible with version 5.0.6:
```bash
mpirun -np <number_of_processes> ./my_app
```

## Reference documentation
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_esme_netcdf-fortran_openmpi_5_0_6_overview.md)
- [NetCDF Software Documentation](./references/www_unidata_ucar_edu_software_netcdf.md)