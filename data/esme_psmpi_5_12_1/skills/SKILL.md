---
name: esme_psmpi_5_12_1
description: The `esme_psmpi_5_12_1` skill provides a specialized environment for climate scientists and HPC engineers.
homepage: https://github.com/j34ni/bioconda-recipes
---

# esme_psmpi_5_12_1

## Overview
The `esme_psmpi_5_12_1` skill provides a specialized environment for climate scientists and HPC engineers. ESME is not a single executable but a curated bundle of interoperable libraries essential for Earth system modeling. This specific version integrates ParaStationMPI (psmpi) with specific versions of data format libraries (netCDF 4.9.3, HDF5 1.14.6) and modeling frameworks (ESMF 8.9.0). Use this skill to ensure consistent environment setup and to troubleshoot library linkages in parallel computing contexts.

## Installation and Environment Setup
To deploy the environment, use the Conda package manager. This ensures all dependencies and MPI-linked binaries are correctly placed in your path.

```bash
conda install bioconda::esme_psmpi_5_12_1
```

### Included Components
This bundle provides the following specific versions:
- **PnetCDF**: 1.14.1 (Parallel NetCDF)
- **HDF5**: 1.14.6
- **netCDF C**: 4.9.3
- **netCDF Fortran**: 4.6.2
- **ParallelIO (PIO)**: 2.6.6
- **ESMF**: 8.9.0
- **OSU Micro Benchmarks**: 7.5.1

## Verification and CLI Usage
After installation, verify that the libraries are correctly linked to ParaStationMPI and are accessible via their respective configuration tools.

### Verifying Data Libraries
Use the config tools to check compiler flags and library paths:
- **netCDF C**: `nc-config --all`
- **netCDF Fortran**: `nf-config --all`
- **HDF5**: `h5cc -showconfig`

### Verifying ESMF
To check the Earth System Modeling Framework status and its parallel capabilities:
```bash
ESMF_PrintReady
```

### Performance Benchmarking
The bundle includes the OSU Micro Benchmarks to test the underlying ParaStationMPI performance. Common patterns include:
- **Latency**: `mpirun osu_latency`
- **Bandwidth**: `mpirun osu_bw`
- **Collective Communication**: `mpirun osu_allreduce`

## Best Practices
- **Compiler Consistency**: When compiling custom climate model code (like WRF, CESM, or MPAS) against this bundle, ensure you use the same compiler wrappers (e.g., `mpicc`, `mpifort`) provided by the ParaStationMPI environment to avoid ABI mismatches.
- **Parallel I/O**: Utilize the ParallelIO (PIO) library included in this bundle to manage I/O bottlenecks. PIO acts as a layer over netCDF and PnetCDF to optimize data throughput on HPC file systems.
- **Library Pathing**: If running binaries outside of the Conda environment, ensure `LD_LIBRARY_PATH` includes the environment's `lib` directory to resolve the specific versions of HDF5 and netCDF provided by ESME.

## Reference documentation
- [esme_psmpi_5_12_1 - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_esme_psmpi_5_12_1_overview.md)