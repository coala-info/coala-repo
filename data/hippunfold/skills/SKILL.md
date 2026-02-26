---
name: hippunfold
description: Hippunfold automates the modeling of the human hippocampus by unfolding its topological structure into a 2D surface representation. Use when user asks to model hippocampal folding, perform surface-based morphometry, or map quantitative metrics across hippocampal layers.
homepage: https://github.com/khanlab/hippunfold
---


# hippunfold

## Overview

Hippunfold is a specialized BIDS App that automates the modeling of the human hippocampus's topological folding structure. Unlike traditional volumetric segmentation, this tool computationally "unfolds" the hippocampus into a 2D surface representation. This approach provides superior inter-subject alignment, enables topologically-constrained registration to histology-based atlases, and allows for high-resolution morphometry and quantitative mapping (e.g., mapping qT1 or diffusion metrics) across hippocampal layers.

## Installation and Setup

The tool is available via Conda or Docker/Singularity.

```bash
# Conda installation
conda install bioconda::hippunfold
```

Note: In version 1.3.x and above, Docker containers are lightweight and do not include pre-shipped nnU-net models; these are downloaded automatically during the first execution.

## Common CLI Patterns

As a BIDS App, Hippunfold follows the standard BIDS execution structure:

```bash
hippunfold <bids_directory> <output_directory> <analysis_level> [options]
```

### Basic Participant Level Run
To process a single subject using T2w images (often preferred for hippocampal detail):
```bash
hippunfold /path/to/bids /path/to/output participant --participant_label 01 --modality T2w
```

### Using GPU Acceleration
For significantly faster segmentation using deep learning models:
```bash
hippunfold /path/to/bids /path/to/output participant --use-gpu
```

### Atlas and Registration Control
Version 1.3+ introduces unfolded space registration to a harmonized histology atlas.
*   **Default**: Uses the multihist7 atlas with unfolded space registration.
*   **Legacy Workflow**: To use the BigBrain atlas or disable unfolded registration:
    ```bash
    hippunfold /path/to/bids /path/to/output participant --atlas bigbrain --no-unfolded-reg
    ```

## Expert Tips and Best Practices

*   **Modality Selection**: While T1w is supported, T2w (especially high-resolution limited FOV) typically yields better subfield segmentations. If using limited FOV T2w, ensure the BIDS metadata correctly reflects the orientation.
*   **Quantitative Mapping**: Use Hippunfold to map external data (like fMRI or DWI) to the midthickness surface. This allows for laminar profile extraction perpendicular to the hippocampal surface.
*   **Contrast-Agnostic Processing**: For experimental or non-standard contrasts, consider the experimental UNet model (available in newer versions) which utilizes synthseg-based training for better generalization.
*   **Output Inspection**: Always check the generated Quality Control (QC) images in the output directory to verify the topological fit and subfield boundaries, especially in cases of significant atrophy or anatomical variants.
*   **Resource Management**: When running on a cluster (SGE/Slurm), ensure you provide sufficient memory for the nnU-net inference step, which is the most resource-intensive part of the workflow.

## Reference documentation
- [Hippunfold GitHub Repository](./references/github_com_khanlab_hippunfold.md)
- [Hippunfold Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_hippunfold_overview.md)