---
name: relion-bin-plusmpi
description: RELION (REgularised LIkelihood OptimisatioN) is a stand-alone computer program for the refinement of 3D reconstructions and 2D class averages in cryo-electron microscopy.
homepage: https://github.com/3dem/relion
---

# relion-bin-plusmpi

## Overview

RELION (REgularised LIkelihood OptimisatioN) is a stand-alone computer program for the refinement of 3D reconstructions and 2D class averages in cryo-electron microscopy. This skill facilitates the use of the `plusmpi` version of the software, which is optimized for distributed computing environments. It is designed to help users navigate the transition to RELION 5.0, manage GPU-accelerated tasks, and execute complex image-processing workflows via the command line.

## Core CLI Patterns

### MPI Execution
Most RELION tasks require MPI for parallelization across multiple CPU cores or nodes.
```bash
mpirun -np [number_of_processes] relion_refine_mpi --i particles.star --o output_dir --ref reference.mrc --gpu ""
```
*Note: The first process acts as the master; use `n+1` processes where `n` is the number of desired workers.*

### GPU Acceleration
RELION 5.0 supports modern NVIDIA architectures (including Blackwell/RTX 5000).
- Use `--gpu ""` to use all available GPUs.
- Use `--gpu "0:1"` to specify specific device IDs.
- For CUDA 13.0+, the default architecture is typically set to `sm_75`.

### Job Continuation
To resume a job that was interrupted or to extend a refinement:
```bash
mpirun -np 5 relion_refine_mpi --continue [job_directory]/run_it015_optimiser.star --relax_sym
```
*Expert Tip: The `--relax_sym` flag is specifically supported in RELION 5.0 for continuation jobs to allow symmetry relaxation.*

## Tool-Specific Best Practices

### Python Environment Requirements
Starting with version 5.0, RELION relies heavily on Python modules for advanced features. Ensure your environment includes:
- **Blush**: For protein-specific regularization.
- **ModelAngelo**: For automated model building.
- **DynaMight**: For analyzing conformational heterogeneity.
- **Class Ranker**: Requires Python 3.9.12, Pytorch 1.10.0, and Numpy 1.20.0.

### Memory and Performance
- **Box Size**: Ensure box sizes are appropriate for Fourier cropping to avoid rounding errors in image stacks.
- **Failsafe Threshold**: Note that `--failsafe_threshold` in `ml_optimiser` is deprecated in recent versions; avoid including it in new scripts.
- **3D Radial Averaging**: Use the latest 5.0.1 binaries to ensure bug fixes for 3D radial averaging and subtomogram particle reconstruction visibility are applied.

### Subtomogram Averaging (STA)
When working with tomography data:
- Ensure the `mdoc` directory does not contain duplicate files, as this can cause import errors for tilt-series STAR files.
- Use the updated `particle_reposition` logic in 5.0.1 to avoid coordinate bugs in subtomo workflows.

## Reference documentation
- [RELION Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_relion_overview.md)
- [RELION GitHub Repository](./references/github_com_3dem_relion.md)
- [RELION Issues and Bugfixes](./references/github_com_3dem_relion_issues.md)