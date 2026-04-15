---
name: esme_netcdf-fortran_mvapich_4_0_ofi
description: This tool provides a NetCDF-Fortran interface built with MVAPICH and OFI support for handling array-oriented scientific data in parallel computing environments. Use when user asks to read or write NetCDF files in Fortran, compile MPI-based Fortran applications with NetCDF, or perform parallel I/O using high-speed interconnects.
homepage: http://www.unidata.ucar.edu/software/netcdf/
metadata:
  docker_image: "quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0"
---

# esme_netcdf-fortran_mvapich_4_0_ofi

## Overview
This skill provides guidance for utilizing the NetCDF-Fortran interface within an MVAPICH-enabled environment. It focuses on the `esme_netcdf-fortran_mvapich_4_0_ofi` package, which allows Fortran programs to read and write machine-independent, array-oriented scientific data. Because this version is built with MVAPICH and OFI support, it is specifically intended for parallel computing tasks where high-speed interconnects and MPI-based data distribution are required.

## Installation and Environment Setup
To deploy this specific build in a Conda-based environment, use the following command:

```bash
conda install bioconda::esme_netcdf-fortran_mvapich_4_0_ofi
```

After installation, ensure your environment variables are correctly set to point to the Conda prefix, as the Fortran modules (.mod files) and libraries (.a, .so) will be located there.

## Compilation and Linking
When building Fortran applications against this library, use the `nf-config` utility provided by the package to ensure all dependencies (including the underlying NetCDF-C libraries and MPI wrappers) are correctly referenced.

### Retrieving Flags
- **For compilation flags (include paths):**
  ```bash
  nf-config --fflags
  ```
- **For linking flags (library paths and names):**
  ```bash
  nf-config --flibs
  ```

### Standard Compilation Pattern
Since this is an MVAPICH build, you should use the MPI Fortran wrapper (typically `mpifort`) for compilation to ensure the MPI headers and libraries are correctly included:

```bash
mpifort my_script.f90 -o my_app $(nf-config --fflags) $(nf-config --flibs)
```

## Best Practices
- **Parallel I/O:** When using this build, leverage the parallel features of NetCDF-4. Ensure your code calls `nf90_create` or `nf90_open` with the `NF90_MPIIO` or `NF90_MPIPOSIX` comm modes to take advantage of the MVAPICH backend.
- **Consistency:** Always ensure that the MPI implementation used to compile your application matches the MVAPICH version provided in this package to avoid binary compatibility issues.
- **Verification:** Use `nf-config --version` to verify you are using version 4.6.2 or the specific version required by your project.
- **OFI Configuration:** Since this build uses OFI (OpenFabrics Interfaces), you may need to set the `FI_PROVIDER` environment variable at runtime to match your hardware (e.g., `export FI_PROVIDER=psm2` or `verbs`) for optimal performance.

## Reference documentation
- [NetCDF-Fortran - netCDF interface for Fortran](./references/anaconda_org_channels_bioconda_packages_esme_netcdf-fortran_mvapich_4_0_ofi_overview.md)
- [NetCDF Software Overview](./references/www_unidata_ucar_edu_software_netcdf.md)