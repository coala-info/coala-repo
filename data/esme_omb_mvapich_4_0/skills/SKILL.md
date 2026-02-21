---
name: esme_omb_mvapich_4_0
description: The `esme_omb_mvapich_4_0` skill provides guidance on using the OSU Micro Benchmarks (OMB) to assess high-performance computing (HPC) interconnects and MPI implementations.
homepage: https://mvapich.cse.ohio-state.edu/
---

# esme_omb_mvapich_4_0

## Overview
The `esme_omb_mvapich_4_0` skill provides guidance on using the OSU Micro Benchmarks (OMB) to assess high-performance computing (HPC) interconnects and MPI implementations. This suite is the industry standard for measuring critical performance metrics such as latency, bandwidth, and message rates. Use this skill when you need to validate cluster performance, compare different network transports (e.g., InfiniBand, RoCE, Omni-Path), or tune MVAPICH runtime parameters for optimal throughput and synchronization.

## Benchmarking Best Practices
To obtain accurate and reproducible results, follow these execution patterns:

### 1. Point-to-Point Benchmarks
Used to measure the basic overhead of the network.
- **Latency (`osu_latency`)**: Measures the min, max, and average time to send a message between two nodes.
- **Bandwidth (`osu_bw`)**: Measures the maximum throughput achievable for various message sizes.
- **Bibandwidth (`osu_bibw`)**: Measures full-duplex throughput (simultaneous send/receive).

### 2. Collective Benchmarks
Used to evaluate the efficiency of multi-node synchronization and data movement.
- **Blocking Collectives**: `osu_allreduce`, `osu_barrier`, `osu_bcast`, `osu_gather`.
- **Non-blocking Collectives**: `osu_iallgather`, `osu_ibcast`. These are useful for measuring the overlap of communication and computation.

### 3. One-Sided (RMA) Benchmarks
Used for PGAS and MPI-3 RMA evaluation.
- **Put/Get Latency**: `osu_put_latency`, `osu_get_latency`.
- **Accumulate**: `osu_acc_latency`.

## Common Execution Patterns
OMB benchmarks are typically executed using an MPI launcher (`mpirun`, `mpiexec`, or `srun`).

### Basic Execution
```bash
# Run latency test between two processes
mpirun -np 2 osu_latency

# Run bandwidth test with specific message size limits
mpirun -np 2 osu_bw -m 1:1048576
```

### Using the Unified Launcher
Recent versions (v7.5+) include a unified launcher for batch testing.
```bash
# Example of running a suite of tests
osu_launcher --test pt2pt
osu_launcher --test collective
```

## Performance Tuning for MVAPICH
When running OMB, use these environment variables to optimize the underlying MVAPICH transport:

- **`MV2_HOMOGENEOUS_CLUSTER=1`**: Set this if all nodes in the cluster are identical to skip unnecessary architecture detection.
- **`MV2_USE_CUDA=1`**: Use this when running benchmarks on GPU-enabled nodes (e.g., `osu_latency` with D-D or H-D transfers).
- **`MV2_ON_DEMAND_THRESHOLD=1`**: Forces on-demand connection management, which is critical for reducing memory footprint during large-scale collective benchmarks.
- **`MV2_CPU_MAPPING`**: Crucial for intra-node benchmarks.
  - `MV2_CPU_MAPPING=0:1` (Intra-socket)
  - `MV2_CPU_MAPPING=0:12` (Inter-socket, depending on core count)

## Troubleshooting and Accuracy
- **Process Binding**: Always use CPU affinity (e.g., `--bind-to core` in mpirun) to prevent process migration from skewing latency results.
- **Warm-up**: OMB performs warm-up iterations by default, but for very high-speed interconnects, you may need to increase iterations using the `-i` flag.
- **HugePages**: Ensure HugePages are enabled on the system and MVAPICH is configured to use them to reduce TLB misses during large message bandwidth tests.

## Reference documentation
- [OSU Micro Benchmarks Overview](./references/anaconda_org_channels_bioconda_packages_esme_omb_mvapich_4_0_overview.md)
- [MVAPICH Features and Transport Interfaces](./references/mvapich_cse_ohio-state_edu_features.md)
- [Job Startup and Runtime Optimization](./references/mvapich_cse_ohio-state_edu_performance_job-startup.md)
- [Collective Performance Benchmarking](./references/mvapich_cse_ohio-state_edu_performance_collectives.md)