---
name: relion-bin-plusgui
description: RELION is a comprehensive software suite for processing cryo-electron microscopy image data through tasks like motion correction, CTF estimation, and 3D refinement. Use when user asks to perform particle picking, refine 3D reconstructions, configure GPU-accelerated jobs, or manage cryo-EM workflows via the command-line interface.
homepage: https://github.com/3dem/relion
---


# relion-bin-plusgui

## Overview
RELION (REgularised LIkelihood OptimisatioN) is a comprehensive suite for cryo-EM image processing. It provides tools for motion correction, CTF estimation, particle picking, and high-resolution 3D refinement. This skill focuses on the native command-line interface (CLI) usage of RELION, emphasizing configuration for modern GPU architectures, job continuation strategies, and version-specific optimizations for RELION 5.0.1.

## Installation and Environment
RELION 5.0+ requires a specific Python environment for advanced modules such as Blush, ModelAngelo, and DynaMight.

- **Conda Installation**:
  `conda install bioconda::relion`
- **Python Requirements**: Ensure Python 3.9+ is available. The class ranker specifically targets Pytorch 1.10.0 and Numpy 1.20.0.
- **GPU Support**: For NVIDIA RTX 5000 (Blackwell) or newer, ensure the `environment_blackwell.yml` configuration is used or that the environment is patched for CUDA 13.x compatibility.

## Common CLI Patterns and Flags
RELION commands typically follow a pattern of `relion_<task>`.

- **Symmetry Relaxation**:
  When continuing a job where you wish to relax symmetry constraints, use the following flag:
  `--relax_sym`
  *Note: This is specifically supported in continuation jobs in version 5.0+.*

- **GPU Architecture Targeting**:
  For systems running CUDA 13.0 or higher, explicitly set the architecture to avoid compatibility issues:
  `--arch=sm_75`

- **Deprecated Flags**:
  Do not use `--failsafe_threshold` in `ml_optimiser` as it is no longer supported in recent versions.

- **CTFFIND Wrapper**:
  When using the CTFFIND wrapper, avoid using `use_given_ps` simultaneously with `ctf_win != -1` to prevent configuration conflicts.

## Expert Tips for RELION 5.0
- **Blackwell GPU Optimization**: If using the latest NVIDIA Blackwell GPUs, ensure you are on version 5.0.1 or higher to resolve environment-specific crashes.
- **Particle Repositioning**: Be aware that `particle_reposition` bugs were addressed in recent patches; ensure your binaries are updated if performing subtomogram analysis.
- **Memory Management**: For MultiBody refinements, monitor MPI send/receive buffer sizes, as mismatches can occur in complex reconstructions.
- **Manual Picking**: In the GUI or CLI output, manually picked particles now have a Figure of Merit (FOM) set to 0 rather than -999 to maintain consistency with downstream filtering.

## Reference documentation
- [RELION GitHub Repository](./references/github_com_3dem_relion.md)
- [Bioconda RELION Overview](./references/anaconda_org_channels_bioconda_packages_relion_overview.md)
- [RELION Issues and Bug Reports](./references/github_com_3dem_relion_issues.md)
- [RELION Commit History (v5.0.1)](./references/github_com_3dem_relion_commits_master.md)