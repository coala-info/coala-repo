---
name: esme_mvapich_4_0_ofi
description: This package provides a curated meta-environment of high-performance I/O libraries and modeling frameworks optimized for MVAPICH 4.0 over the Open Fabrics Interface. Use when user asks to verify netCDF or ESMF configurations, check library versions for climate modeling, or run OSU Micro Benchmarks for MPI performance testing.
homepage: https://github.com/j34ni/bioconda-recipes
---


# esme_mvapich_4_0_ofi

## Overview
The `esme_mvapich_4_0_ofi` package is a curated meta-environment designed for scientific computing and climate modeling. It streamlines the deployment of a complex software stack by bundling specific, compatible versions of high-performance I/O libraries and modeling frameworks. This particular variant is built to leverage the MVAPICH 4.0 MPI implementation over the Open Fabrics Interface (OFI), ensuring optimized communication on modern HPC fabrics. Use this skill to verify the environment, check library configurations, and execute included performance benchmarks.

## Installation and Environment Setup
To deploy the environment using Conda:
```bash
conda install -c bioconda esme_mvapich_4_0_ofi
```
Ensure your environment is activated before attempting to use the bundled libraries or MPI wrappers.

## Included Library Versions
This bundle provides a fixed set of libraries. Use these versions for compatibility checks in your modeling code:
- **PnetCDF**: 1.14.1
- **HDF5**: 1.14.6
- **netCDF C**: 4.9.3
- **netCDF Fortran**: 4.6.2
- **ParallelIO (PIO)**: 2.6.6
- **ESMF**: 8.8.1
- **OSU Micro Benchmarks**: 7.5.1

## Verification and Configuration Patterns

### Verify netCDF Configuration
Use the configuration utilities to check compiler flags and features (like DAP or NetCDF-4 support):
```bash
# Check C library configuration
nc-config --all

# Check Fortran library configuration
nf-config --all
```

### Verify ESMF Installation
To confirm the Earth System Modeling Framework is correctly linked and to see build metadata:
```bash
esmf_info
```

### Check HDF5 Version
```bash
h5dump --version
```

## Running Performance Benchmarks
The bundle includes the OSU Micro Benchmarks (v7.5.1) to test the performance of the MVAPICH/OFI stack.

### Point-to-Point Latency
```bash
mpirun -np 2 osu_latency
```

### Collective Communication (e.g., Allreduce)
```bash
mpirun -np <num_procs> osu_allreduce
```

### Bandwidth Test
```bash
mpirun -np 2 osu_bw
```

## Best Practices
- **MPI Selection**: This bundle is specifically tuned for MVAPICH 4.0 with OFI. Avoid mixing it with other MPI implementations (like OpenMPI or MPICH) in the same environment to prevent symbol conflicts.
- **Library Linking**: When compiling climate models (like WRF, CESM, or E3SM) against this stack, use `nc-config --libs` and `nf-config --flibs` to ensure all transitive dependencies (like HDF5 and PnetCDF) are correctly referenced.
- **Architecture Support**: This package is available for `linux-64` and `linux-aarch64`. Ensure your HPC compute nodes match the architecture of the environment where the package was installed.

## Reference documentation
- [ESME MVAPICH 4.0 OFI Overview](./references/anaconda_org_channels_bioconda_packages_esme_mvapich_4_0_ofi_overview.md)