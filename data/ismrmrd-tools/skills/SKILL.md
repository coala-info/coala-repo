---
name: ismrmrd-tools
description: This tool processes MRI raw data using the ISMRMRD standard for reconstruction and coil sensitivity estimation. Use when user asks to generate synthetic phantom datasets, reconstruct k-space data, estimate coil sensitivity maps, or perform parallel imaging reconstructions like GRAPPA.
homepage: https://github.com/ismrmrd/ismrmrd-python-tools
metadata:
  docker_image: "biocontainers/ismrmrd-tools:v1.4.0-1-deb_cv1"
---

# ismrmrd-tools

## Overview
The ismrmrd-tools skill provides a specialized workflow for handling MRI raw data using the Python implementation of the International Standard for Magnetic Resonance Resonance Data (ISMRMRD). This toolbox is essential for researchers and engineers who need to perform offline reconstructions, estimate coil sensitivities using Walsh or Inati methods, or validate reconstruction pipelines with standardized phantom data. Use this skill to navigate the provided demo scripts and core reconstruction utilities.

## Core Workflows and CLI Usage

### Installation
To set up the environment for using these tools, run the standard Python installation command from the root directory:
```bash
python setup.py install
```

### Synthetic Data Generation
For testing reconstruction pipelines without physical scanner data, generate a synthetic Shepp-Logan phantom dataset:
```bash
python generate_cartesian_shepp_logan_dataset.py
```
This produces a Cartesian-sampled ISMRMRD dataset that can be used as input for the reconstruction scripts.

### Image Reconstruction
The toolbox provides scripts for converting raw k-space data into viewable images.

*   **Standard Reconstruction**: Use `recon_ismrmrd_dataset.py` to reconstruct a standard ISMRMRD HDF5 file.
*   **Multi-Repetition Data**: For datasets containing multiple repetitions (e.g., dynamic imaging), use `recon_multi_reps.py`.

### Coil Sensitivity Mapping (CSM)
Estimating coil sensitivity is a prerequisite for many parallel imaging and combination techniques. Use `csm_estimation_demo.py` to explore:
*   **Walsh Method**: A robust eigenvector-based approach for sensitivity estimation.
*   **Inati Iterative Method**: An iterative approach for calculating coil maps and the combined image simultaneously.

### Parallel Imaging
For datasets acquired with acceleration, the `parallel_imaging_demo.py` script demonstrates GRAPPA reconstruction. This is useful for understanding how to apply weights to undersampled k-space data within the ISMRMRD framework.

## Best Practices
*   **Debugging**: Use the utility functions for reading and writing simple array formats to dump intermediate ndarrays for inspection.
*   **Visualization**: The toolbox includes an internal `imshow` utility with window/level support. When using the CLI tools, you can often pass colormap arguments to adjust the output visualization.
*   **Python 3 Compatibility**: Ensure you are using the latest master branch, as recent commits have addressed explicit imports and index division issues specific to Python 3.

## Reference documentation
- [ISMRMRD Python Toolbox Main](./references/github_com_ismrmrd_ismrmrd-python-tools.md)