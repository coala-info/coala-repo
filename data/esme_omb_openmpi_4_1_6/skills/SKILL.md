---
name: esme_omb_openmpi_4_1_6
description: The `esme_omb_openmpi_4_1_6` skill provides a standardized way to execute the OSU Micro Benchmarks (OMB) to evaluate the communication performance of an MPI implementation.
homepage: https://mvapich.cse.ohio-state.edu/
---

# esme_omb_openmpi_4_1_6

## Overview

The `esme_omb_openmpi_4_1_6` skill provides a standardized way to execute the OSU Micro Benchmarks (OMB) to evaluate the communication performance of an MPI implementation. OMB is the industry standard for measuring the "speed of light" of a cluster's network. This skill focuses on the three primary categories of benchmarks: point-to-point (measuring basic latency and throughput between two nodes), collectives (measuring the efficiency of group communications like Allreduce or Barrier), and RMA (measuring Remote Memory Access performance).

## Execution Patterns

The benchmarks are typically installed as individual binaries. Since this package is built for OpenMPI 4.1.6, always use `mpirun` or `mpiexec` to launch the tests.

### Point-to-Point Benchmarks
Used to test the performance between two specific MPI processes (usually on different nodes).

*   **Latency**: `mpirun -np 2 osu_latency`
*   **Bandwidth**: `mpirun -np 2 osu_bw`
*   **Bidirectional Bandwidth**: `mpirun -np 2 osu_bibw`

### Collective Benchmarks
Used to test how well the MPI library handles communication involving multiple processes.

*   **Allreduce**: `mpirun -np <N> osu_allreduce`
*   **Barrier**: `mpirun -np <N> osu_barrier`
*   **Broadcast**: `mpirun -np <N> osu_bcast`

### One-Sided (RMA) Benchmarks
Used to test Remote Direct Memory Access (RDMA) capabilities.

*   **Put Latency**: `mpirun -np 2 osu_put_latency`
*   **Get Latency**: `mpirun -np 2 osu_get_latency`

## Expert Tips and Best Practices

### Process Binding
For accurate results, always bind MPI processes to specific CPU cores to avoid OS jitter and context switching.
*   Example: `mpirun -np 2 --bind-to core osu_latency`

### Message Size Selection
By default, OMB cycles through a range of message sizes (typically 1B to 1MB). To test a specific message size or range, use the `-m` flag.
*   Example (Test only 1KB): `mpirun -np 2 osu_latency -m 1024:1024`

### Iterations for Accuracy
If the network is noisy, increase the number of iterations to get a more stable average using the `-i` flag.
*   Example: `mpirun -np 2 osu_latency -i 10000`

### Multi-Rail and Interconnect Tuning
When running on systems with multiple network interfaces (multi-rail), ensure OpenMPI is configured to use the correct byte transport layer (BTL) or MTU settings to match the hardware capabilities described in the system documentation.

### Interpreting Results
*   **Latency**: Reported in microseconds (us). Lower is better.
*   **Bandwidth**: Reported in Megabytes per second (MB/s). Higher is better.
*   **Collectives**: Pay attention to how latency scales as the number of processes (`-np`) increases.

## Reference documentation

- [OSU Micro Benchmarks Overview](./references/anaconda_org_channels_bioconda_packages_esme_omb_openmpi_4_1_6_overview.md)
- [MVAPICH Performance and Benchmarks Guide](./references/mvapich_cse_ohio-state_edu_index.md)
- [Job Startup and Runtime Optimization](./references/mvapich_cse_ohio-state_edu_performance_job-startup.md)