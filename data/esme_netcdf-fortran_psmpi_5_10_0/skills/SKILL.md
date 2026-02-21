---
name: esme_netcdf-fortran_psmpi_5_10_0
description: This skill provides procedural knowledge for utilizing the NetCDF-Fortran interface specifically built for the PSMPI 5.10.0 stack.
homepage: http://www.unidata.ucar.edu/software/netcdf/
---

# esme_netcdf-fortran_psmpi_5_10_0

## Overview
This skill provides procedural knowledge for utilizing the NetCDF-Fortran interface specifically built for the PSMPI 5.10.0 stack. It is essential for researchers and developers working on Earth system models or atmospheric science simulations that need to read and write portable, self-describing, array-oriented data. The skill focuses on the configuration and compilation workflows required to link Fortran applications against this specific library build.

## Installation and Environment Setup
To ensure the library and its dependencies (including the specific PSMPI version) are available in your environment, use the Conda package manager:

```bash
conda install bioconda::esme_netcdf-fortran_psmpi_5_10_0
```

## Configuration with nf-config
The `nf-config` utility is the primary tool for retrieving compiler and linker flags. Because this build is tied to a specific MPI implementation, always verify the configuration before compiling.

- **Check version and prefix:**
  `nf-config --version --prefix`
- **Retrieve all configuration settings:**
  `nf-config --all`
- **Get Fortran compiler flags (Include paths):**
  `nf-config --fflags`
- **Get Linker flags:**
  `nf-config --flibs`

## Compilation Best Practices
When compiling Fortran source code (e.g., `model.f90`) to use NetCDF, use the flags provided by the tool to ensure compatibility with the PSMPI headers and NetCDF modules.

### Standard Compilation Pattern
```bash
# Compile and link in one step
mpifort $(nf-config --fflags) model.f90 $(nf-config --flibs) -o model_exe
```

### Separate Compilation and Linking
If your project has a complex build structure:
1. **Compile to object file:**
   `mpifort $(nf-config --fflags) -c model.f90`
2. **Link object files:**
   `mpifort model.o $(nf-config --flibs) -o model_exe`

## Expert Tips for PSMPI Environments
- **MPI Consistency:** Ensure that the `mpifort` wrapper in your PATH matches the PSMPI 5.10.0 version used to build this library. Mismatched MPI implementations will lead to "Undefined Reference" errors or segmentation faults during parallel I/O operations.
- **Module Files:** NetCDF-Fortran uses `.mod` files. If the compiler cannot find `use netcdf`, verify that `nf-config --fflags` points to the correct directory containing `netcdf.mod`.
- **Parallel I/O:** Since this is a PSMPI-enabled build, you can utilize parallel features. Ensure you are calling `nf90_open` or `nf90_create` with the `NF90_MPIIO` or `NF90_NETCDF4` flags to leverage parallel throughput.
- **Shared vs. Static:** By default, `nf-config --flibs` will prefer shared libraries. If you are deploying to a cluster where the Conda environment is not present on compute nodes, you may need to set `LD_LIBRARY_PATH` to include the environment's `lib` directory.

## Reference documentation
- [NetCDF-Fortran Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_esme_netcdf-fortran_psmpi_5_10_0_overview.md)
- [Unidata NetCDF Software Documentation](./references/www_unidata_ucar_edu_software_netcdf.md)