---
name: esme_omb_mpich_4_2_3
description: The OSU Micro Benchmarks suite measures the performance of MPI and PGAS implementations by evaluating latency, bandwidth, and message rates. Use when user asks to assess network interconnects, run point-to-point or collective benchmarks, and evaluate MPI library efficiency.
homepage: https://mvapich.cse.ohio-state.edu/
---


# esme_omb_mpich_4_2_3

## Overview
The OSU Micro Benchmarks (OMB) suite is a collection of performance measurement tools designed to evaluate the latency, bandwidth, and message rate of MPI and PGAS (OpenSHMEM, UPC, UPC++) implementations. This skill assists in configuring and running these benchmarks to assess network interconnects and MPI library efficiency. It focuses on the version 7.5 release, which is optimized for high-performance computing environments including InfiniBand, Omni-Path, and RoCE.

## Installation and Setup
Install the package using Conda from the Bioconda channel:
```bash
conda install bioconda::esme_omb_mpich_4_2_3
```

## Common Execution Patterns
Benchmarks are typically executed using an MPI launcher such as `mpirun`, `mpiexec`, or `srun`.

### Point-to-Point Benchmarks
Measure the performance between two processes (usually on different nodes).
*   **Latency**: `mpirun -np 2 osu_latency`
*   **Bandwidth**: `mpirun -np 2 osu_bw`
*   **Bidirectional Bandwidth**: `mpirun -np 2 osu_bibw`

### Collective Benchmarks
Measure the performance of operations involving multiple processes.
*   **Allreduce**: `mpirun -np <num_procs> osu_allreduce`
*   **Alltoall**: `mpirun -np <num_procs> osu_alltoall`
*   **Barrier**: `mpirun -np <num_procs> osu_barrier`

### PGAS Benchmarks (OpenSHMEM/UPC)
For OpenSHMEM or UPC-specific tests, use the corresponding launcher and binary:
*   **OpenSHMEM Put Latency**: `oshrun -np 2 osu_oshm_put`
*   **UPC Put Latency**: `upcrun -np 2 osu_upc_put`

## Performance Optimization and Best Practices

### CPU Affinity and Mapping
Ensure processes are bound to specific cores to avoid performance jitter.
*   Use `MV2_CPU_MAPPING` to define core binding (e.g., `export MV2_CPU_MAPPING=0:1`).
*   For intra-socket vs. inter-socket testing, adjust the mapping to target specific CPU topologies.

### Job Startup Tuning
For large-scale benchmarks, optimize the initialization phase:
*   **Homogeneous Clusters**: Set `export MV2_HOMOGENEOUS_CLUSTER=1` if all nodes are identical to skip redundant architecture detection.
*   **On-Demand Connections**: For high process counts, enable on-demand connection management to save memory: `export MV2_ON_DEMAND_THRESHOLD=1`.
*   **SLURM Integration**: When using SLURM, prefer the PMI2 interface for faster startup: `srun --mpi=pmi2 ./osu_latency`.

### Network Transport Selection
If multiple interconnects are available, specify the transport interface to ensure the benchmark is testing the intended hardware:
*   Common interfaces include `OFA-IB-CH3` (InfiniBand), `Omni-Path(PSM2-CH3)`, and `OFA-RoCE-CH3`.

### CUDA/GPU Benchmarking
If using a GPU-enabled version of the benchmarks:
*   Ensure the MPI library supports GPUDirect RDMA.
*   Run benchmarks with GPU buffers: `mpirun -np 2 osu_latency D D` (where 'D' signifies Device/GPU memory).

## Troubleshooting
*   **Low Performance**: Check if `IPoIB` is being used instead of native Verbs/RDMA. TCP/IP interfaces will show significantly higher latency and lower scalability.
*   **Memory Errors**: On very large scales, reduce the internal communication buffer size or increase the `MV2_ON_DEMAND_THRESHOLD`.
*   **Startup Hangs**: Ensure the PMIx or PMI2 protocol matches the installed SLURM/Process Manager configuration.

## Reference documentation
- [OSU Micro Benchmarks Overview](./references/anaconda_org_channels_bioconda_packages_esme_omb_mpich_4_2_3_overview.md)
- [MVAPICH2 Features and OMB Integration](./references/mvapich_cse_ohio-state_edu_features.md)
- [Job Startup Performance Best Practices](./references/mvapich_cse_ohio-state_edu_performance_job-startup.md)