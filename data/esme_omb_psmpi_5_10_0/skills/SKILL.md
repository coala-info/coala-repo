---
name: esme_omb_psmpi_5_10_0
description: This tool measures point-to-point, collective, and one-sided communication performance using the OSU Micro Benchmarks suite in MVAPICH2 environments. Use when user asks to measure network latency, evaluate aggregate bandwidth, benchmark MPI collective operations, or tune process affinity for cluster interconnects.
homepage: https://mvapich.cse.ohio-state.edu/
metadata:
  docker_image: "quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0"
---

# esme_omb_psmpi_5_10_0

## Overview
The esme_omb_psmpi_5_10_0 skill provides procedural knowledge for the OSU Micro Benchmarks (OMB) suite within MVAPICH2-based environments. It enables precise measurement of point-to-point, collective, and one-sided (RMA) communication patterns. This skill is essential for validating cluster interconnect performance and ensuring that the MPI stack is correctly tuned for the underlying hardware, specifically Intel TrueScale and Omni-Path architectures.

## Execution Patterns

### Basic Benchmarking
Most OMB binaries require exactly two processes for point-to-point tests and multiple processes for collectives.

```bash
# Measure point-to-point latency between two nodes
mpirun -np 2 osu_latency

# Measure aggregate bandwidth
mpirun -np 2 osu_bw

# Measure collective Allreduce performance across 16 processes
mpirun -np 16 osu_allreduce
```

### CPU Affinity and Binding
Accurate benchmarking requires strict process-to-core mapping to avoid noise from context switching or suboptimal NUMA placement.

- **Intra-socket testing**: Bind processes to adjacent cores.
- **Inter-socket testing**: Bind processes to cores on different CPUs within the same node.
- **Inter-node testing**: Ensure processes are on different physical hosts.

Use the `MV2_CPU_MAPPING` environment variable for MVAPICH2:
```bash
# Bind to core 1 on both nodes for a point-to-point test
MV2_CPU_MAPPING=1 mpirun -np 2 osu_latency
```

## Performance Tuning for Benchmarking

To ensure benchmarks reflect the hardware's peak capability rather than software overhead, apply the following MVAPICH2 optimizations:

### Cluster Configuration
- **Homogeneous Clusters**: If all nodes are identical, set `MV2_HOMOGENEOUS_CLUSTER=1` to skip redundant architecture detection.
- **On-Demand Connections**: For large-scale benchmarks, use `MV2_ON_DEMAND_THRESHOLD=1` to manage connection memory footprint.

### Job Startup Optimization
If measuring `MPI_Init` or startup scaling:
- Use `MV2_MT_DEGREE` to adjust the hierarchical tree degree for `mpirun_rsh`.
- For SLURM environments, ensure the use of `pmi2` or `pmix` for faster process exchange: `srun --mpi=pmi2 ./osu_latency`.

### Interconnect Specifics (PSM/PSM2)
This package is built for PSM (TrueScale) and PSM2 (Omni-Path). 
- Ensure the transport is correctly identified in the output (usually visible in the MVAPICH2 version header at runtime).
- For Omni-Path, the `PSM2-CH3` channel is the preferred high-performance path.

## Best Practices
- **Warm-up Runs**: OMB typically performs iterations to average results, but ensure the network is "warm" by running a small sample before recording final metrics.
- **Message Size Sweeps**: Do not rely on a single message size. Use the default OMB sweep (typically 1B to 1MB) to identify the "crossover" point where protocols switch from eager to rendezvous.
- **CUDA/GPU Support**: If the environment has GPUs, use the `osu_latency -d cuda` or `osu_bw -d opencl` flags if the binary was compiled with GPU-Direct support.

## Reference documentation
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_esme_omb_psmpi_5_10_0_overview.md)
- [MVAPICH2 Job Startup Performance Tuning](./references/mvapich_cse_ohio-state_edu_performance_job-startup.md)
- [MVAPICH2 Point-to-Point Performance Notes](./references/mvapich_cse_ohio-state_edu_performance_pt_to_pt.md)
- [MVAPICH2 Transport Interface Features](./references/mvapich_cse_ohio-state_edu_features.md)