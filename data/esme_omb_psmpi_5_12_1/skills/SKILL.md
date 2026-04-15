---
name: esme_omb_psmpi_5_12_1
description: This tool provides procedural knowledge for executing and tuning the OSU Micro Benchmarks to measure MPI communication performance and identify network bottlenecks. Use when user asks to measure latency and bandwidth, run collective or one-sided benchmarks, optimize job startup, or apply CPU affinity and interconnect tuning parameters.
homepage: https://mvapich.cse.ohio-state.edu/
metadata:
  docker_image: "quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0"
---

# esme_omb_psmpi_5_12_1

## Overview
The `esme_omb_psmpi_5_12_1` skill provides procedural knowledge for utilizing the OSU Micro Benchmarks (OMB) version 7.5.1. This suite is the standard for performance characterization in high-performance computing. It allows for the precise measurement of communication overheads, helping to identify bottlenecks in network fabrics or MPI configurations. Use this skill to guide the execution of benchmarks that validate cluster performance and to apply tuning parameters that optimize job startup and message passing efficiency.

## Execution Patterns

The OMB suite consists of several categories of benchmarks. Most are executed using standard MPI launchers like `mpirun` or `mpiexec`.

### Point-to-Point Benchmarks
Used to measure the performance between two processes (typically on different nodes).
- **Latency**: `mpirun -np 2 osu_latency`
- **Bandwidth**: `mpirun -np 2 osu_bw`
- **Bidirectional Bandwidth**: `mpirun -np 2 osu_bibw`

### Collective Benchmarks
Used to measure the performance of operations involving a group of processes.
- **Allreduce**: `mpirun -np <N> osu_allreduce`
- **Barrier**: `mpirun -np <N> osu_barrier`
- **Alltoall**: `mpirun -np <N> osu_alltoall`

### One-Sided (RMA) Benchmarks
Used for Remote Memory Access performance testing.
- **Put Latency**: `mpirun -np 2 osu_put_latency`
- **Get Latency**: `mpirun -np 2 osu_get_latency`

## Performance Tuning & Best Practices

### CPU Affinity and Binding
To obtain consistent results, processes must be bound to specific CPU cores to prevent migration.
- Use `MV2_CPU_MAPPING` to define core placement.
- Example: `export MV2_CPU_MAPPING=0:1` (binds processes to cores 0 and 1).

### Job Startup Optimization
For large-scale benchmarks (thousands of processes), use the following environment variables to reduce `MPI_Init` time:
- `MV2_HOMOGENEOUS_CLUSTER=1`: Set this if all nodes in the cluster are identical.
- `MV2_ON_DEMAND_THRESHOLD=1`: Enables on-demand connection management for all job sizes, significantly reducing memory footprint and startup time.
- `MV2_ON_DEMAND_UD_INFO_EXCHANGE=1`: Enables efficient address handle creation in hybrid modes.

### Interconnect Specifics
- **Omni-Path (PSM2)**: Ensure the PSM2-CH3 channel is active for Intel Omni-Path adapters to achieve sub-microsecond latency.
- **InfiniBand (Verbs)**: Use the `OFA-IB-CH3` interface for the most feature-complete support on Mellanox hardware.
- **Azure/Cloud**: When running on Azure HBv2 or similar, ensure nodes are under the same leaf switch for optimal point-to-point performance.

### Benchmarking Tips
- **Warm-up**: OMB benchmarks typically include iterations for warm-up; however, for very short runs, manually increasing the iteration count with `-i` can improve statistical significance.
- **Message Sizes**: By default, OMB tests a range of message sizes. Use the `-m` and `-M` flags to restrict the min/max message sizes if you are only interested in specific ranges (e.g., small control messages vs. large data transfers).

## Reference documentation
- [OSU Micro Benchmarks Overview](./references/anaconda_org_channels_bioconda_packages_esme_omb_psmpi_5_12_1_overview.md)
- [MVAPICH2 Job Startup Performance](./references/mvapich_cse_ohio-state_edu_performance_job-startup.md)
- [MVAPICH2 Features and Transport Interfaces](./references/mvapich_cse_ohio-state_edu_features.md)
- [Point-to-Point Performance Reference](./references/mvapich_cse_ohio-state_edu_performance_pt_to_pt.md)