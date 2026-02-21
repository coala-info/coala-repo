---
name: esme_openmpi_5_0_6
description: The Earth System Modelling Environment (ESME) is a curated bundle of scientific libraries optimized for climate modeling.
homepage: https://github.com/j34ni/bioconda-recipes
---

# esme_openmpi_5_0_6

## Overview
The Earth System Modelling Environment (ESME) is a curated bundle of scientific libraries optimized for climate modeling. Rather than a single standalone application, it provides a consistent environment where complex dependencies like NetCDF, HDF5, and ESMF are pre-compiled to work together seamlessly using OpenMPI. This skill facilitates the installation, verification, and utilization of these libraries for parallel scientific workflows.

## Component Verification
After installation, verify that the specific versions included in the 5.0.6 bundle are correctly mapped in your environment:

- **NetCDF C (4.9.2):** `nc-config --version`
- **NetCDF Fortran (4.6.1):** `nf-config --version`
- **HDF5 (1.14.5):** `h5dump --version`
- **ESMF (8.8.0):** `ESMF_Info`
- **PnetCDF (1.14.0):** `pnetcdf-config --version`

## Compilation Best Practices
When building climate models or custom tools against this bundle, use the provided configuration utilities to ensure all MPI-linked paths are correctly identified.

### C-based Applications
Use `nc-config` to retrieve the necessary flags for linking against the parallel-enabled NetCDF and HDF5 stack:
```bash
mpicc my_model.c $(nc-config --cflags --libs) -o my_model_exe
```

### Fortran-based Climate Models
Most Earth system models (like WRF or CESM) require the Fortran interface. Use `nf-config`:
```bash
mpif90 my_climate_mod.f90 $(nf-config --fflags --flibs) -o my_model_exe
```

## Parallel Execution
Since this bundle is built with OpenMPI 5.0.6, always use the corresponding `mpirun` or `mpiexec` provided within the environment to avoid library mismatches.

### Running Benchmarks
To verify the performance of the MPI interconnect and the ESME stack, run the included OSU Micro Benchmarks:
```bash
mpirun -np 2 osu_latency
mpirun -np 2 osu_bandwidth
```

### Parallel I/O Operations
When using the ParallelIO (PIO) library (v2.6.2) included in this bundle, ensure your execution environment has the `OMPI_MCA` variables set if you are running on a cluster with specific fabric requirements (e.g., InfiniBand).

## Expert Tips
- **Library Conflicts:** If you have other MPI implementations installed, always check `which mpirun` to ensure you are using the OpenMPI 5.0.6 binary associated with the ESME environment.
- **Environment Variables:** For ESMF-heavy workflows, set `ESMF_RUNTIME_COMPLIANCE_CHECK=ON` during initial testing to ensure your model's use of the ESMF 8.8.0 API is compliant with the standard.
- **HDF5 Caching:** When working with large climate datasets, leverage the HDF5 1.14.5 features by setting `HDF5_USE_FILE_LOCKING=FALSE` if your filesystem (like some versions of Lustre) does not support it, to prevent I/O hangs.

## Reference documentation
- [ESME OpenMPI 5.0.6 Overview](./references/anaconda_org_channels_bioconda_packages_esme_openmpi_5_0_6_overview.md)
- [Bioconda Recipes Repository](./references/github_com_j34ni_bioconda-recipes.md)