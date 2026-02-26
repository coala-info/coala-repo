---
name: smalr
description: SMALR generates 3D animal poses and shapes from 2D photographs by fitting a linear model to keypoints and silhouettes. Use when user asks to reconstruct 3D animal meshes, set up the SMALR environment, or refine animal textures and shapes from images.
homepage: https://github.com/silviazuffi/smalr_online
---


# smalr

## Overview
SMALR (Skinned Multi-Animal Linear model Refinement) is a toolset for generating 3D animal poses and shapes from standard 2D photographs. It bridges the gap between 2D annotations (keypoints and silhouettes) and 3D mesh outputs. This skill provides the necessary procedures for environment setup, model fitting, and texture configuration to ensure successful 3D reconstruction of non-rigid, articulated animal bodies.

## Environment Setup and Patching
SMALR requires Python 3.8 and specific manual modifications to the `opendr` library to function correctly.

1. **Installation Sequence**:
   ```bash
   python3 -m venv venv_smalr_online
   source venv_smalr_online/bin/activate
   pip3 install chumpy opencv-python matplotlib opendr sklearn
   ```

2. **Required OpenDR Patches**:
   You must manually cast specific values to integers in the `opendr` package files within your virtual environment to avoid type errors:
   - `opendr/common.py`: At line 467, change to `(int(verts_by_face.shape[0]/f.shape[1])`.
   - `opendr/renderer.py`: Search for `dImage_wrt_2dVerts` and cast to `int(self.v.r.size/3)`.
   - `opendr/camera.py`: At line 102, cast to `int(self.v.r.size*2/3)`.

3. **External Dependencies**:
   - Install the MPI-IS mesh library.
   - Download Eigen (no compilation needed) and set `EIGEN_DIR` in `src/smalr/sbody/alignment/mesh_distance/setup.py` before running `make`.
   - Place the `smpl_webuser` directory from SMPL into `src/smalr`.

## Core Usage Patterns
The primary entry point for fitting the model to provided data is the demo script.

- **Run Fitting Demo**:
  ```bash
  python run_on_animals.py
  ```

- **Data Loading**:
  When loading model files or data in Python 3, always specify the encoding to handle legacy pickle files:
  ```python
  import pickle
  data = pickle.load(open(file_path, "rb"), encoding='latin1')
  ```

## Configuration and Refinement
Adjust parameters in `smalr_settings.py` to control the output quality:

- **Texture Sharpness**:
  - Set `max_tex_weight = True` for sharp, detailed textures (recommended for datasets like Grevy's zebra).
  - Set `max_tex_weight = False` for smooth, blended textures (recommended for species with less distinct patterns).

- **Annotation**:
  If new images need processing, use the Matlab-based tool in `src/annotate_kp_matlab` to generate the required 2D keypoints and silhouettes before running the fitting code.

## Reference documentation
- [SMALR Main Repository](./references/github_com_silviazuffi_smalr_online.md)
- [Known Issues and Troubleshooting](./references/github_com_silviazuffi_smalr_online_issues.md)