---
name: aevol
description: Aevol is a digital genetics platform for simulating the evolution of populations of digital organisms.
homepage: https://github.com/otouat/micro-aevol2-hypervitesse
---

# aevol

## Overview
The `aevol` skill provides a specialized workflow for interacting with `micro-aevol2-hypervitesse`, a streamlined C++ fork of the Aevol simulator. Unlike the full Aevol suite, this version is specifically engineered for High-Performance Computing (HPC) tasks, such as testing parallelization, vectorization, and GPU acceleration. Use this skill to navigate the build process, execute simulations, and resume experiments from specific generations.

## Compilation and Setup
The tool supports both standard CPU execution and CUDA-accelerated GPU execution.

### Prerequisites
- Unix-based system (Linux/macOS).
- `zlib` and its headers (`zlib1g-dev` on Debian/Ubuntu).
- `cuda-toolkit` (required only for GPU support).

### Building the Binaries
1. Create a build directory: `mkdir build && cd build`
2. Configure with CMake:
   - **CPU only**: `cmake ..`
   - **GPU support**: `cmake .. -DUSE_CUDA=on`
3. Compile: `make`

This produces `micro_aevol_cpu` or `micro_aevol_gpu` depending on your configuration.

## Running Simulations
Simulations must be run within a dedicated directory to manage backup, checkpointing, and statistics files.

### Basic Execution
```bash
# Create and enter a simulation workspace
mkdir my_simulation && cd my_simulation

# Run the CPU version
/path/to/micro_aevol_cpu

# Run the GPU version (if compiled)
/path/to/micro_aevol_gpu
```

### Command Line Options
- `-H` or `--help`: Display all available parameters and configuration options.
- `-r <generation>`: Resume a simulation from a specific backup/checkpoint file (e.g., `-r 1000` to restart from generation 1000).

## Expert Tips and Best Practices
- **HPC Benchmarking**: This tool is intended for performance testing, not biological research. Use it to measure the impact of compiler flags, thread counts, or GPU kernel optimizations.
- **Performance Tracing**: Utilize `Timetracer.h` (available in the source) to add custom instrumentation for bottleneck analysis.
- **Checkpoint Management**: Always run simulations in a clean directory. The tool generates significant metadata for each generation; ensure your filesystem has sufficient IOPS for high-speed simulations.
- **Randomness**: The implementation uses `Random123` for deterministic random number generation, which is critical for reproducing HPC performance results across different hardware.

## Reference documentation
- [Main README and Build Instructions](./references/github_com_otouat_micro-aevol2-hypervitesse.md)
- [Development History and Feature Implementation](./references/github_com_otouat_micro-aevol2-hypervitesse_commits_master.md)