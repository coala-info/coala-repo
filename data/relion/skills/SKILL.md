---
name: relion
description: RELION (REgularised LIkelihood OptimisatioN) is a specialized suite for cryo-EM image processing.
homepage: https://github.com/3dem/relion
---

# relion

## Overview
RELION (REgularised LIkelihood OptimisatioN) is a specialized suite for cryo-EM image processing. It is primarily used for high-resolution structure determination by refining 3D reconstructions or 2D class averages from large sets of electron micrographs. This skill assists in navigating the software's transition to version 5.0+, managing GPU-accelerated workflows, and troubleshooting common installation or execution issues.

## Installation and Environment
RELION 5.0+ requires a specific Python environment for its modern AI-driven modules.

- **Conda Installation**: The most reliable way to install the core package is via bioconda.
  ```bash
  conda install bioconda::relion
  ```
- **Python Dependencies**: Modules like Blush, ModelAngelo, and DynaMight require a dedicated environment. Use the provided `environment.yml` or `environment_blackwell.yml` (for RTX 5000/Blackwell GPUs) found in the source root to ensure compatibility with PyTorch and CUDA.
- **GPU Support**: Ensure `nvcc` is available. For CUDA 13+, RELION uses `--arch=sm_75` by default. If using newer hardware, you may need to specify the architecture during compilation if building from source.

## Common CLI Patterns
While RELION is famous for its GUI, many high-performance computing (HPC) tasks are executed via the command line.

- **Refinement**: Use `relion_refine` for 3D auto-refinement.
- **Symmetry Relaxation**: In version 5.0+, you can use the `--relax_sym` flag when continuing a job to explore lower symmetry than the initial run.
- **Particle Polishing**: When using MotionCor3, ensure your Polish jobs are correctly configured to handle the specific motion model outputs.
- **Class Ranking**: The default ranker is trained on Python 3.9.12. If the ranker fails, verify that your `PYTHONPATH` points to the correct RELION-specific site-packages.

## Expert Tips
- **Memory Management**: For MultiBody refinements, monitor MPI send/receive buffer sizes, as mismatches can occur in complex reconstructions.
- **GPU Utilization**: If you notice inconsistent utilization across multiple GPUs (e.g., 4 GPUs), check the MPI rank distribution. RELION typically assigns one MPI rank per GPU for the actual calculations.
- **Contrast Inversion**: If particles appear with inverted contrast after reconstruction, verify the `reconstruct` parameters; recent bug fixes in version 5.0.1 addressed specific contrast inversion issues in subtomogram particle reconstruction.
- **Overwriting Protection**: Be cautious when using `CPlot2D`; ensure overwrite protection is active to avoid losing previous plotting data during iterative analysis.

## Reference documentation
- [RELION GitHub Repository](./references/github_com_3dem_relion.md)
- [Bioconda RELION Overview](./references/anaconda_org_channels_bioconda_packages_relion_overview.md)
- [RELION Issues and Troubleshooting](./references/github_com_3dem_relion_issues.md)