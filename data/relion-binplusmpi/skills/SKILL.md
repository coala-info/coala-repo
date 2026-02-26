---
name: relion-binplusmpi
description: RELION performs cryo-EM structure determination through MPI-parallelized workflows including 3D auto-refinement, motion correction, and Bayesian polishing. Use when user asks to perform high-resolution reconstruction, estimate CTF parameters, or analyze conformational heterogeneity using version 5.0 features like Blush and ModelAngelo.
homepage: https://github.com/3dem/relion
---


# relion-binplusmpi

## Overview
RELION is a specialized suite for cryo-EM structure determination. This skill provides the procedural knowledge required to execute its core MPI-parallelized workflows, such as 3D auto-refinement, motion correction, and Bayesian polishing. It focuses on the command-line interface (CLI) for version 5.0.x, emphasizing efficient GPU utilization and proper handling of STAR files.

## Core CLI Patterns

### 3D Auto-Refine
The primary tool for high-resolution reconstruction.
```bash
mpirun -np [procs] relion_refine_mpi --i particles.star --ref reference.mrc --first_iter_size 200 --iter 25 --o output_prefix --gpu ""
```
- **Expert Tip**: Use `--relax_sym [symmetry]` in continuation jobs if the initial symmetry was too restrictive.
- **GPU Allocation**: If using multiple GPUs, specify them explicitly (e.g., `--gpu 0:1:2:3`). Note that GPU utilization may vary; ensure your MPI rank count matches your hardware topology.

### Motion Correction and Polishing
For correcting beam-induced motion and performing Bayesian polishing.
- **MotionCorr3**: Integrated in version 5.0. Use the wrapper for local motion model validation.
- **Bayesian Polishing**: Can be continued if interrupted. Ensure the input STAR files from the previous refinement are correctly referenced.

### CTF Estimation
- **CTFFIND Wrapper**: When using the CTFFIND4/5 wrapper, avoid using `use_given_ps` simultaneously with `ctf_win != -1` to prevent configuration conflicts.

## Version 5.0+ Specifics
- **Python Integration**: Version 5.0 requires a configured Python environment for advanced modules:
  - **Blush**: For protein-specific denoising.
  - **ModelAngelo**: For automated model building.
  - **DynaMight**: For analyzing conformational heterogeneity.
- **Class Ranker**: The default model is trained on Python 3.9.12/PyTorch 1.10.0. If retraining, ensure environment parity.
- **Deprecated Flags**: Do not use `--failsafe_threshold` in `ml_optimiser` as it is no longer supported in recent versions.

## Best Practices
- **Box Size**: When Fourier cropping image stacks (e.g., in `FourierCrop_fftwHalfStack`), ensure box sizes are rounded correctly to avoid interpolation artifacts.
- **Subtomogram Averaging**: For 3D subtomograms, verify visibility determination and multiplicity settings, especially if the first tomogram in a set is empty.
- **Memory Management**: For MultiBody refinements, monitor MPI send/receive buffer sizes to prevent mismatches in large-scale datasets.
- **Particle Picking**: Manually picked particles should have a Figure of Merit (FOM) set to 0 (not -999) for compatibility with downstream ranking tools.

## Reference documentation
- [RELION GitHub Overview](./references/github_com_3dem_relion.md)
- [Bioconda RELION Package](./references/anaconda_org_channels_bioconda_packages_relion_overview.md)
- [RELION Issues and Bugfixes](./references/github_com_3dem_relion_issues.md)