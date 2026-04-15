---
name: hippunfold-dev
description: This tool models the topological structure of the human hippocampus by transforming 3D anatomy into a flattened 2D coordinate system for high-precision surface analysis. Use when user asks to unfold hippocampal anatomy, perform subfield-specific morphometry, or map quantitative MRI data across hippocampal layers.
homepage: https://github.com/khanlab/hippunfold
metadata:
  docker_image: "quay.io/biocontainers/hippunfold-dev:2.0.0--pyh7e72e81_0"
---

# hippunfold-dev

## Overview
The `hippunfold-dev` skill provides a specialized workflow for modeling the topological structure of the human hippocampus. It transforms complex 3D hippocampal anatomy into a flattened, 2D "unfolded" coordinate system. This allows for high-precision inter-subject registration, thickness measurements, and the mapping of quantitative MRI data (like qT1 or diffusion metrics) across hippocampal layers. It is particularly useful for researchers requiring subfield-specific analysis that traditional volumetric methods often miss.

## Installation and Setup
Install the development version via Conda to ensure all dependencies for unfolding and surface generation are met:
```bash
conda install -c bioconda hippunfold-dev
```

## Core CLI Patterns
Hippunfold follows the BIDS App standard. The basic execution pattern requires a BIDS input directory, an output directory, and the analysis level.

### Basic Execution
```bash
hippunfold /path/to/bids_dir /path/to/output_dir participant --modality T1w
```

### Advanced Configuration
*   **Modality Selection**: Use `--modality T2w` for high-resolution hippocampal scans. If using a limited Field of View (FOV) T2w scan, ensure it is correctly labeled in your BIDS structure.
*   **Atlas Registration**: By default, version 1.3.0+ uses unfolded space registration to a reference atlas. To use the legacy workflow or specific templates:
    *   Use `--atlas bigbrain` for the BigBrain-based template.
    *   Use `--no-unfolded-reg` to disable unfolded space registration if standard alignment is preferred.
*   **GPU Acceleration**: For deep-learning based segmentation (nnU-Net), always attempt to use a GPU to significantly reduce processing time:
    *   Add the `--use-gpu` flag.
*   **Contrast-Agnostic Processing**: For experimental or non-standard contrasts, use the experimental UNet model trained with `synthseg`.

## Expert Tips and Best Practices
*   **Model Downloads**: Docker and Singularity containers for version 1.3.x+ do not include pre-shipped nnU-Net models. Ensure the execution environment has internet access during the first run to download required models, or pre-cache them in the `nnUNet_raw` directory.
*   **Output Validation**: Always inspect the generated `qc` (Quality Control) images. Look specifically for the "midthickness" surface fit to ensure the unfolding accurately captured the hippocampal ribbon.
*   **Parallel Processing**: When running multiple participants, do not point them to the same output folder simultaneously if they share a subject ID, as this can cause file-locking conflicts during surface generation.
*   **Morphometry**: Use the generated `.surf.gii` and `.shape.gii` files for vertex-wise statistical analysis (e.g., using SurfStat or PALM) rather than relying solely on mean subfield volumes.

## Reference documentation
- [Hippunfold Main README](./references/github_com_khanlab_hippunfold.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_hippunfold-dev_overview.md)
- [GitHub Issues and Troubleshooting](./references/github_com_khanlab_hippunfold_issues.md)