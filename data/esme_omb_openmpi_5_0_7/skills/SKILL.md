---
name: esme_omb_openmpi_5_0_7
description: This tool executes OSU Micro Benchmarks to evaluate the performance of MPI implementations and network interconnects. Use when user asks to measure MPI latency, bandwidth, or collective communication performance using OpenMPI 5.0.7.
homepage: https://mvapich.cse.ohio-state.edu/
---


# esme_omb_openmpi_5_0_7

## Overview
The `esme_omb_openmpi_5_0_7` skill provides procedural knowledge for using the OSU Micro Benchmarks (OMB) to evaluate the performance of MPI implementations and underlying network interconnects (e.g., InfiniBand, RoCE, Omni-Path). It focuses on the practical execution of benchmark binaries to obtain deterministic measurements of message-passing overhead, throughput, and scalability.

## Installation and Setup
The package is available via Bioconda. Ensure your environment is configured to use the `bioconda` and `conda-forge` channels.

```bash
conda install bioconda::esme_omb_openmpi_5_0_7
```

## Common Execution Patterns
OMB benchmarks are typically executed using `mpirun` or `mpiexec`. Since this version is built with OpenMPI 5.0.7, use standard OpenMPI CLI flags.

### Point-to-Point Benchmarks
Used to measure the performance of communication between two processes.
*   **Latency**: `mpirun -np 2 osu_latency`
*   **Bandwidth**: `mpirun -np 2 osu_bw`
*   **Bidirectional Bandwidth**: `mpirun -np 2 osu_bibw`

### Collective Benchmarks
Used to measure the scalability of operations involving multiple processes.
*   **Allreduce**: `mpirun -np <num_procs> osu_allreduce`
*   **Barrier**: `mpirun -np <num_procs> osu_barrier`
*   **Broadcast**: `mpirun -np <num_procs> osu_bcast`

### One-Sided (RMA) Benchmarks
Used for Remote Memory Access performance evaluation.
*   **Put Latency**: `mpirun -np 2 osu_put_latency`
*   **Get Latency**: `mpirun -np 2 osu_get_latency`

## Expert Tips and Best Practices

### Process Affinity and Binding
For accurate results, always bind processes to specific CPU cores to avoid OS jitter and migration overhead.
*   **Example**: `mpirun -np 2 --bind-to core --map-by node osu_latency`
*   Use `--map-by ppr:1:node` to ensure processes are on different physical nodes when testing inter-node interconnect performance.

### Message Size Tuning
By default, OMB iterates through a range of message sizes (typically 1B to 1MB+). You can restrict this for specific tests:
*   **Set message range**: Use `-m <min_size>:<max_size>` (e.g., `osu_latency -m 1:1024`).
*   **Set iterations**: Use `-i <iterations>` to increase sample size for more stable averages.

### Environment Variables for OpenMPI 5.0.7
When running on specific fabrics, you may need to select the appropriate Byte Transport Layer (BTL) or Modular Component Architecture (MCA) parameters:
*   **InfiniBand (UCX)**: `mpirun --mca pml ucx ...`
*   **TCP/IP**: `mpirun --mca btl self,tcp ...`

### Interpreting Results
*   **Latency**: Reported in microseconds (us). Lower is better.
*   **Bandwidth**: Reported in Megabytes per second (MB/s). Higher is better.
*   **Note on Units**: OMB typically uses "Million Bytes per second" for bandwidth calculations.

## Reference documentation
- [OSU Micro Benchmarks Overview](./references/anaconda_org_channels_bioconda_packages_esme_omb_openmpi_5_0_7_overview.md)
- [MVAPICH/OMB Features and Benchmarks](./references/mvapich_cse_ohio-state_edu_index.md)
- [Job Startup Performance Best Practices](./references/mvapich_cse_ohio-state_edu_performance_job-startup.md)