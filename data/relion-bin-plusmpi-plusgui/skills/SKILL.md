---
name: relion-bin-plusmpi-plusgui
description: RELION is a software package for high-resolution reconstruction of macromolecules from cryo-electron microscopy images using Bayesian optimization and MPI parallelization. Use when user asks to launch the RELION GUI, perform 2D or 3D classification, refine macromolecular structures, or execute motion correction and CTF estimation.
homepage: https://github.com/3dem/relion
---


# relion-bin-plusmpi-plusgui

## Overview
RELION (REgularised LIkelihood OptimisatioN) is a specialized software package for the structural biology domain, specifically designed for the high-resolution reconstruction of macromolecules from cryo-electron microscopy images. It employs a Bayesian approach to account for noise and structural heterogeneity. This skill provides guidance on using the RELION binary suite, which supports high-performance computing (HPC) through MPI (Message Passing Interface) and GPU acceleration (CUDA).

## Installation and Environment
RELION 5.0+ requires a specific Python environment for advanced modules like ModelAngelo or Blush.

- **Conda Installation**: `conda install bioconda::relion`
- **GPU Support**: Ensure CUDA drivers are compatible. RELION 5.0+ defaults to `--arch=sm_75` for newer CUDA versions.
- **Python Dependencies**: Newer versions rely on PyTorch and NumPy. Use the provided `environment.yml` from the source if manual environment setup is required.

## Core CLI Patterns

### Launching the GUI
To start the project management interface:
```bash
relion &
```

### MPI Parallelization
Most compute-intensive RELION programs have an `_mpi` suffix. Use `mpirun` or `srun` to execute them across multiple CPU cores or nodes.
```bash
mpirun -np [number_of_procs] relion_refine_mpi [options]
```

### Common Command Modules
- **Preprocessing**: `relion_preprocess` (extracting particles, normalization).
- **Motion Correction**: `relion_motion_correction` (correcting beam-induced motion).
- **CTF Estimation**: `relion_ctffind_wrapper` (estimating Contrast Transfer Function).
- **Refinement**: `relion_refine` or `relion_refine_mpi` (2D/3D classification and high-resolution refinement).
- **Post-processing**: `relion_postprocess` (masking and B-factor sharpening).

## Expert Tips and Best Practices

### STAR Files
RELION uses `.star` files (Self-defining Text Archiving and Retrieval) for all metadata. Always ensure the input `--i` points to a valid STAR file.

### GPU Allocation
Specify GPUs using the `--gpu` flag followed by the device IDs (e.g., `0:1:2:3`).
- For MPI jobs, RELION typically maps one MPI rank to one GPU.
- Ensure the number of MPI ranks matches the number of available GPUs for optimal performance in refinement steps.

### Memory Management
- **Pre-reading images**: Use `--pre_read_images` to load particles into RAM if the system has sufficient memory, significantly speeding up iterations.
- **Scratch Space**: Use `--scratch_dir /path/to/ssd` to copy large particle stacks to local fast storage (SSD) during processing.

### Continuation Jobs
To resume a job that was interrupted or to extend a refinement:
```bash
mpirun -np [procs] relion_refine_mpi --continue [alias_of_previous_job].star [additional_options]
```

### Symmetry Relaxation
For particles with broken symmetry, use the `--relax_sym` flag in continuation jobs to allow for asymmetric refinements of symmetric starting models.

## Reference documentation
- [RELION Overview](./references/anaconda_org_channels_bioconda_packages_relion_overview.md)
- [RELION GitHub Repository](./references/github_com_3dem_relion.md)
- [RELION Issues and Bug Reports](./references/github_com_3dem_relion_issues.md)