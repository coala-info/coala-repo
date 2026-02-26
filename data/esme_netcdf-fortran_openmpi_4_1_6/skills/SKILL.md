---
name: esme_netcdf-fortran_openmpi_4_1_6
description: This tool provides the NetCDF-Fortran library built with OpenMPI 4.1.6 to enable parallel I/O capabilities for Fortran-based scientific applications. Use when user asks to configure the build environment, link against NetCDF-Fortran libraries using nf-config, or compile Fortran code with parallel NetCDF support.
homepage: http://www.unidata.ucar.edu/software/netcdf/
---


# esme_netcdf-fortran_openmpi_4_1_6

## Overview
This skill provides technical guidance for utilizing the NetCDF-Fortran library distributed via Bioconda. It focuses on the specific build linked with OpenMPI 4.1.6, which enables parallel I/O capabilities for Fortran-based scientific software. Use this skill to correctly configure your build environment, link against the necessary libraries, and verify the installation of the NetCDF-Fortran interface.

## Usage and Best Practices

### Environment Configuration
Before compiling or running applications, ensure the package is installed in your active Conda environment:
```bash
conda install bioconda::esme_netcdf-fortran_openmpi_4_1_6
```

### Querying Library Information
The most reliable way to obtain the correct compiler and linker flags is using the `nf-config` utility provided by the package.

- **Check version and features:**
  ```bash
  nf-config --version
  nf-config --has-parallel  # Should return 'yes' for this OpenMPI build
  ```

- **Retrieve compilation flags:**
  ```bash
  nf-config --fflags
  ```

- **Retrieve linking flags:**
  ```bash
  nf-config --flibs
  ```

### Compilation and Linking
When building Fortran applications, use the MPI wrapper for the Fortran compiler (`mpifort`) to ensure proper integration with OpenMPI 4.1.6.

- **Standard Compilation Pattern:**
  ```bash
  mpifort my_model.f90 $(nf-config --fflags) $(nf-config --flibs) -o my_model_exe
  ```

- **Manual Linking (if nf-config is unavailable):**
  If you must link manually, ensure you include the Fortran interface library (`-lnetcdff`) before the C library (`-lnetcdf`).
  ```bash
  mpifort -I$CONDA_PREFIX/include my_model.f90 -L$CONDA_PREFIX/lib -lnetcdff -lnetcdf -o my_model_exe
  ```

### Runtime Considerations
- **Shared Libraries:** Ensure your `LD_LIBRARY_PATH` includes the `$CONDA_PREFIX/lib` directory if you encounter "shared object not found" errors at runtime.
- **Parallel I/O:** Since this package is built with OpenMPI, you can utilize parallel NetCDF features. Ensure your code uses the `NF90_MPIIO` or `NF90_PNETCDF` flags during file creation/opening if performing parallel writes.

### Troubleshooting
- **Module Files:** If the compiler cannot find `netcdf.mod`, verify that the include path returned by `nf-config --fflags` points to the directory containing the `.mod` files (usually `$CONDA_PREFIX/include`).
- **Symbol Mismatch:** Ensure you are using the same Fortran compiler version that was used to build the Bioconda package to avoid ABI incompatibilities with `.mod` files.

## Reference documentation
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_esme_netcdf-fortran_openmpi_4_1_6_overview.md)
- [Unidata NetCDF Software Documentation](./references/www_unidata_ucar_edu_software_netcdf.md)