---
name: orientationpy
description: OrientationPy provides a Python-based framework for gradient-based orientation analysis, serving as the successor to the OrientationJ Fiji plugin.
homepage: https://pypi.org/project/orientationpy
---

# orientationpy

## Overview
OrientationPy provides a Python-based framework for gradient-based orientation analysis, serving as the successor to the OrientationJ Fiji plugin. It calculates the structure tensor for every pixel or voxel in an image, allowing for the extraction of local orientation (angles), coherency (how strongly oriented a region is), and energy (local contrast). This tool is essential for quantifying the alignment of features in multidimensional image data.

## Core Functionality
The library operates by computing the partial derivatives of the image, forming the structure tensor, and performing eigenvalue decomposition.

### Key Metrics
- **Orientation**: The local direction of the gradient (or the direction of least variation).
- **Coherency/Anisotropy**: A measure of how dominant the local orientation is (0 for isotropic/random, 1 for perfectly oriented).
- **Energy**: The local strength of the signal (sum of squared gradients).

## Usage Patterns

### Basic Python Integration
```python
import orientationpy
import numpy as np

# Compute structure tensor and orientation properties
# image: 2D or 3D numpy array
# sigma: local smoothing scale for the structure tensor
results = orientationpy.compute_orientation(image, sigma=2.0)

# Accessing components
orientation = results['theta']  # 2D angle or 3D orientation
coherency = results['coherency']
energy = results['energy']
```

### 3D Volume Analysis
When working with 3D data, the tool computes two angles (theta and phi) to describe the orientation in spherical coordinates.
- Ensure `sigma` is tuned to the scale of the features (e.g., fiber diameter).
- Use the `compute_local_stress` or specific tensor components if physical modeling is required.

## Best Practices
- **Preprocessing**: Apply a Gaussian blur or median filter if the image is noisy, as gradient calculations are sensitive to high-frequency noise.
- **Scale Selection**: The `sigma` parameter (integration scale) should be large enough to average over local noise but small enough to capture the curvature of the structures of interest.
- **Boundary Effects**: Be aware that orientation estimates near the edges of the image may be less reliable due to padding requirements for gradient filters.

## Reference documentation
- [OrientationPy PyPI Overview](./references/pypi_org_project_orientationpy.md)
- [Bioconda Package Summary](./references/anaconda_org_channels_bioconda_packages_orientationpy_overview.md)