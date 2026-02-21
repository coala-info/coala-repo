---
name: esme_omb_openmpi_5_0_6
description: The `esme_omb_openmpi_5_0_6` skill provides procedural knowledge for utilizing the OSU Micro Benchmarks (OMB) to profile MPI communication performance.
homepage: https://mvapich.cse.ohio-state.edu/
---

# esme_omb_openmpi_5_0_6

## Overview

The `esme_omb_openmpi_5_0_6` skill provides procedural knowledge for utilizing the OSU Micro Benchmarks (OMB) to profile MPI communication performance. OMB is a specialized suite of tools designed to provide low-level performance data for MPI implementations. This skill focuses on the practical application of these benchmarks to validate network configurations, identify communication bottlenecks, and establish performance baselines for high-performance computing (HPC) clusters.

## Execution Patterns

The OSU Micro Benchmarks are typically installed as a set of individual binaries categorized by communication type (Point-to-Point, Collective, One-Sided).

### Point-to-Point Benchmarks
Use these to measure the raw performance between two MPI processes.

*   **Latency (`osu_latency`)**: Measures the time taken to send a message from a sender to a receiver and back.
    ```bash
    mpirun -np 2 osu_latency
    ```
*   **Bandwidth (`osu_bw`)**: Measures the unidirectional throughput between two processes.
    ```bash
    mpirun -np 2 osu_bw
    ```
*   **Bidirectional Bandwidth (`osu_bibw`)**: Measures the aggregate throughput when both processes send messages simultaneously.
    ```bash
    mpirun -np 2 osu_bibw
    ```

### Collective Benchmarks
Use these to evaluate the efficiency of communication involving multiple processes. These benchmarks require specifying the number of processes (`-np`) and often benefit from testing at various scales.

*   **Allreduce (`osu_allreduce`)**: Measures the time for a global reduction operation.
    ```bash
    mpirun -np 16 osu_allreduce
    ```
*   **Barrier (`osu_barrier`)**: Measures the synchronization overhead across all processes.
    ```bash
    mpirun -np 64 osu_barrier
    ```
*   **Alltoall (`osu_alltoall`)**: Measures the performance of all-to-all personalized communication.
    ```bash
    mpirun -np 32 osu_alltoall
    ```

## Best Practices and Expert Tips

### Process Placement and Affinity
For accurate benchmarking, ensure processes are pinned to specific CPU cores to avoid context switching and migration overhead.
*   Use OpenMPI's `--bind-to` and `--map-by` flags to control placement.
*   **Intra-node testing**: Run processes on the same socket or different sockets on the same node to measure shared memory performance.
*   **Inter-node testing**: Ensure processes are placed on different physical nodes to measure network interconnect performance.

### Message Size Tuning
By default, OMB iterates through a range of message sizes (typically 1 byte to 4 MB). 
*   To test a specific message size range, use the `-m` (minimum) and `-x` (maximum) flags if supported by the specific OMB version.
*   Use the `-i` flag to increase the number of iterations for more stable results in noisy environments.

### Environment Variables for OpenMPI 5.0.6
When running OMB, performance can be significantly impacted by the underlying Byte Transport Layer (BTL) or Modular Component Architecture (MCA) settings.
*   Force a specific interconnect (e.g., InfiniBand): `mpirun --mca pml ucx -np 2 osu_latency`
*   Enable CUDA/GPU support (if the OMB build supports it): `mpirun --mca opal_cuda_support 1 ...`

### Interpreting Results
*   **Latency**: Look for consistent results at small message sizes (1-64 bytes). High variance indicates network jitter or OS interference.
*   **Bandwidth**: Observe the "knee" in the curve where bandwidth saturates. This indicates the message size at which the interconnect reaches peak efficiency.

## Reference documentation
- [OSU Micro Benchmarks Overview](./references/anaconda_org_channels_bioconda_packages_esme_omb_openmpi_5_0_6_overview.md)
- [MVAPICH Performance and OMB Integration](./references/mvapich_cse_ohio-state_edu_index.md)