---
name: relion-bin
description: RELION (REgularised LIkelihood OptimisatioN) is a specialized suite for processing cryo-electron microscopy data using a Maximum A Posteriori (MAP) refinement approach.
homepage: https://github.com/3dem/relion
---

# relion-bin

## Overview

RELION (REgularised LIkelihood OptimisatioN) is a specialized suite for processing cryo-electron microscopy data using a Maximum A Posteriori (MAP) refinement approach. It is primarily used to generate high-resolution 3D reconstructions from 2D images of macromolecular complexes. This skill provides guidance on the native command-line interface (CLI) for RELION 5.x, focusing on installation, GPU optimization, and specific job execution patterns for structural biology research.

## Installation and Environment Setup

The preferred method for installing the RELION binary suite is via Bioconda.

```bash
conda install bioconda::relion
```

### Python Dependencies
Starting with version 5.0, RELION relies heavily on Python modules for advanced features. Ensure your environment includes:
- **Pytorch and Numpy**: Required for the Class Ranker and other machine learning components.
- **Specialized Modules**: Separate environments may be needed for Blush, ModelAngelo, and DynaMight.
- **GPU Support**: For Blackwell (RTX 5000+) or newer GPUs, use the specific `environment_blackwell.yml` configuration provided in the source to ensure PyTorch compatibility.

## Command Line Best Practices

### GPU Acceleration and CUDA
RELION is highly optimized for NVIDIA GPUs. 
- **Architecture Flags**: For CUDA 13.0 and higher, the default architecture is typically set to `sm_75`.
- **GPU Indexing**: When running multi-GPU jobs (e.g., 3D auto-refine), specify devices using the colon-separated format: `0:1:2:3`.
- **Memory Management**: If encountering MPI send/receive buffer size mismatches in MultiBody jobs, verify that the MPI implementation matches the version RELION was compiled against.

### Job Continuation and Refinement
- **Symmetry Relaxation**: When continuing a refinement job where you wish to relax symmetry constraints, use the `--relax_sym` flag.
- **Deprecated Flags**: The `--failsafe_threshold` flag in the `ml_optimiser` is no longer used in version 5.x and should be removed from legacy scripts.
- **Helical Symmetry**: For helical samples, ensure you are using the latest patches for `applyHelicalSymmetry` and power spectra averaging to avoid processing bottlenecks.

### Particle Handling
- **Manual Picking**: When manually picking particles, the Figure of Merit (FOM) should be set to `0` rather than `-999` to ensure compatibility with downstream ranking tools.
- **Subtomogram Analysis**: For cryo-electron tomography (cryo-ET), ensure visibility determination is correctly calculated during particle reconstruction to avoid contrast inversion issues.

## Troubleshooting CLI Errors

- **Assertion Errors**: If you encounter `AssertionError: Unknown attribute fp32_precision`, check for version mismatches between the RELION binary and the Python environment variables.
- **Import Issues**: When importing tilt-series STAR files, ensure the `mdoc` directory does not contain duplicate entries, as this can cause import failures.
- **Compilation**: If building from source, ensure `cmake` is configured with `-DCMAKE_CXX_STANDARD=17`, as C++17 is now an explicit requirement.

## Reference documentation
- [relion - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_relion_overview.md)
- [3dem/relion: Image-processing software for cryo-electron microscopy](./references/github_com_3dem_relion.md)
- [Issues · 3dem/relion](./references/github_com_3dem_relion_issues.md)