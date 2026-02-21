---
name: esme_netcdf-fortran_mpich_4_3_1
description: This skill provides guidance for utilizing the NetCDF-Fortran interface as packaged in the `esme_netcdf-fortran_mpich_4_3_1` distribution.
homepage: http://www.unidata.ucar.edu/software/netcdf/
---

# esme_netcdf-fortran_mpich_4_3_1

## Overview
This skill provides guidance for utilizing the NetCDF-Fortran interface as packaged in the `esme_netcdf-fortran_mpich_4_3_1` distribution. It focuses on the integration of NetCDF libraries into Fortran source code, the retrieval of necessary compiler and linker flags, and the execution of parallel-aware data operations. This specific build ensures that the Fortran bindings are binary-compatible with the MPICH 4.3.1 implementation, which is critical for avoiding segmentation faults or linking errors in parallel clusters.

## Installation and Environment Setup
To ensure the library and its dependencies (NetCDF-C, MPICH, HDF5) are correctly placed in your path:

```bash
conda install -c bioconda esme_netcdf-fortran_mpich_4_3_1
```

Verify the installation and check the version:
```bash
nf-config --version
```

## Compilation and Linking
Because this package is built with MPICH, you must use the MPI-wrapped Fortran compiler (typically `mpif90` or `mpifort`) to ensure proper alignment of MPI types and library paths.

### Using nf-config
The `nf-config` utility is the primary tool for retrieving the correct flags for your build system.

*   **Get Include Flags:** `nf-config --fflags` (Provides `-I` paths for `netcdf.mod`)
*   **Get Linking Flags:** `nf-config --flibs` (Provides `-L` and `-lnetcdff`)

### Manual Compilation Pattern
```bash
# Compile
mpif90 -c $(nf-config --fflags) my_script.f90

# Link
mpif90 my_script.o -o my_app $(nf-config --flibs)
```

## Fortran Code Integration
To use the library within your source code, always use the `netcdf` module.

```fortran
program netcdf_example
    use netcdf
    implicit none
    integer :: ncid, varid, status

    ! Open an existing netCDF file
    status = nf90_open("data.nc", NF90_NOWRITE, ncid)
    if (status /= nf90_noerr) print *, nf90_strerror(status)

    ! ... perform operations ...

    status = nf90_close(ncid)
end program netcdf_example
```

## Expert Tips for MPICH 4.3.1 Compatibility
1.  **Parallel I/O:** When opening files for parallel access, ensure you use the `NF90_MPIIO` or `NF90_MPIPOSIX` flags in `nf90_create` or `nf90_open`. This requires the underlying NetCDF-C library to have been built with HDF5 parallel support.
2.  **Shared Libraries:** If you encounter "library not found" errors at runtime, ensure your `LD_LIBRARY_PATH` includes the `lib` directory of your conda environment.
3.  **Mixed-Language Linking:** If linking a C/C++ application that calls Fortran NetCDF functions, you must link both `netcdff` (Fortran) and `netcdf` (C) libraries, usually in that order: `-lnetcdff -lnetcdf`.
4.  **Large File Support:** For datasets exceeding 2GB, use the `NF90_64BIT_OFFSET` or `NF90_NETCDF4` creation modes.

## Reference documentation
- [NetCDF-Fortran - netCDF interface for Fortran Overview](./references/anaconda_org_channels_bioconda_packages_esme_netcdf-fortran_mpich_4_3_1_overview.md)
- [NetCDF (Network Common Data Form) Software Documentation](./references/www_unidata_ucar_edu_software_netcdf.md)