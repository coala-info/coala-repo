---
name: clustalw
description: ClustalW is a progressive multiple sequence alignment tool optimized for high-performance computing using GPU acceleration. Use when user asks to perform multiple sequence alignments, align genomic or proteomic sequences, or accelerate alignment tasks using CUDA.
homepage: https://github.com/coldfunction/CUDA-clustalW
---


# clustalw

## Overview
ClustalW is a progressive multiple sequence alignment tool that aligns sets of sequences by repeatedly aligning pairs and previously generated alignments. This specific version, CUDA-clustalW, is optimized for high-performance computing environments. It uses intra-task parallelization to offload computationally intensive stages to the GPU, achieving up to 33x speedup compared to standard CPU versions. It is best suited for large-scale genomic or proteomic projects where alignment time is a bottleneck.

## Installation and Setup
Before running alignments, the tool must be compiled for the specific environment:

- **Compile**: Run `./make.sh` in the root directory.
- **Clean**: Run `./make.sh clean` to remove previous build artifacts.
- **Requirements**: Requires a Linux x86 64-bit environment with NVIDIA CUDA support and a compatible GPU.

## Command Line Usage
The CUDA-clustalW implementation uses wrapper scripts to handle the execution logic for both CPU and GPU modes.

### GPU Execution (Recommended for large datasets)
Use the GPU script to take advantage of parallel processing.
```bash
./run_gpu.sh [number_of_sequences] [sequence_length]
```
*Example*: To align 1000 sequences of length 1523:
```bash
./run_gpu.sh 1000 1523
```

### CPU Execution (Fallback)
Use the CPU script for smaller datasets or when GPU resources are unavailable.
```bash
./run_cpu.sh [number_of_sequences] [sequence_length]
```
*Example*: To align 100 sequences of length 498:
```bash
./run_cpu.sh 100 498
```

## Data Management
- **Input Format**: Sequences must be in FASTA format.
- **Test Data**: Sample datasets are located in the `./test_data` directory.
- **Scaling**: The tool is benchmarked for datasets ranging from 100 to 1000 sequences with lengths between 97 and 1523 residues/bases.

## Expert Tips
- **Performance Gains**: The most significant speedups (approx. 22x) occur during the distance matrix calculation step. If your workflow involves many pairwise comparisons, always prefer the GPU mode.
- **Multi-GPU Support**: This version supports multiple GPUs. Ensure your CUDA environment variables (e.g., `CUDA_VISIBLE_DEVICES`) are configured if you wish to isolate or distribute the workload across specific hardware.
- **Memory Constraints**: While the GPU accelerates the process, the sequence length and count are still bound by GPU VRAM. For extremely long sequences, monitor memory usage to avoid out-of-memory (OOM) errors.

## Reference documentation
- [CUDA-clustalW README](./references/github_com_coldfunction_CUDA-clustalW.md)