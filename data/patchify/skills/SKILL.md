---
name: patchify
description: patchify tiles large images or 3D volumes into smaller patches and merges them back into their original dimensions. Use when user asks to split images into patches, reconstruct images from tiles, or handle large medical and satellite imagery for model processing.
homepage: https://github.com/dovahcrow/patchify.py
metadata:
  docker_image: "quay.io/biocontainers/patchify:0.2.3--pyhdfd78af_0"
---

# patchify

## Overview
patchify is a specialized Python library used to tile images into smaller "patches" and merge them back together. It is essential for workflows where images are too large to be processed in a single pass—common in medical imaging, satellite imagery, and computer vision—or when a model requires fixed-size inputs. It supports both 2D arrays and 3D volumes (including multi-channel images) and allows for fine-grained control over the "step" size to create overlapping regions.

## Installation
Install the library via pip or conda:
```bash
pip install patchify
# OR
conda install bioconda::patchify
```

## Core Usage Patterns

### Splitting an Image (2D)
To split a 2D image into patches, provide the image array, the desired patch shape, and the step size.
```python
import numpy as np
from patchify import patchify

image = np.random.rand(512, 512)
# Create 64x64 patches with a step of 64 (no overlap)
patches = patchify(image, (64, 64), step=64) 
# patches.shape will be (8, 8, 64, 64)
```

### Splitting a Volume or Multi-channel Image (3D)
For 3D data, the patch shape must match the number of dimensions (3).
```python
image = np.random.rand(512, 512, 3)
# Create 128x128 patches across all 3 channels
patches = patchify(image, (128, 128, 3), step=128)
# patches.shape will be (4, 4, 1, 128, 128, 3)
```

### Reconstructing the Image
Use `unpatchify` to merge patches back into the original dimensions.
```python
from patchify import unpatchify

reconstructed_image = unpatchify(patches, image.shape)
```

## Expert Tips and Best Practices

### The Reconstruction Constraint
For `unpatchify` to work correctly, the patches must be created with a consistent step size that aligns with the image dimensions. The library requires that:
**(image_dimension - patch_dimension) % step_size == 0**
If this condition is not met, the reconstructed image may be distorted or the function may fail. Always calculate your step size or pad your image to satisfy this modulus operation.

### Managing Overlap
*   **Non-overlapping:** Set `step` equal to the patch size (e.g., patch `(64, 64)` with `step=64`).
*   **Overlapping:** Set `step` smaller than the patch size (e.g., patch `(64, 64)` with `step=32` for 50% overlap).
*   **Note:** `unpatchify` currently handles overlapping patches by overwriting pixels. If you require averaging or "blending" of overlapping regions, you must implement a custom weighted-average merge after retrieving the patches.

### Memory Efficiency
`patchify` uses NumPy's `as_strided` internally, which creates a **view** of the original array rather than a copy whenever possible. This is memory efficient, but be aware that modifying a patch may modify the original image array if they share memory.

## Reference documentation
- [patchify.py GitHub Repository](./references/github_com_dovahcrow_patchify.py.md)
- [patchify Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_patchify_overview.md)