---
name: showit
description: The showit library provides a streamlined interface for visualizing NumPy arrays as images or tiled grids without axes or interpolation artifacts. Use when user asks to display images, visualize image tiles, or inspect image data with specific colormaps and scaling.
homepage: https://github.com/freeman-lab/showit
---


# showit

## Overview
The `showit` library provides a streamlined interface for image visualization in Python, acting as a "sensible" wrapper around Matplotlib. It is designed for researchers and developers who need to inspect image data (NumPy arrays) quickly without the visual clutter of coordinate axes or interpolation artifacts. Use this skill to generate code for displaying single images or multi-image grids (tiles) with precise control over colormaps and scaling.

## Installation
Install the package via pip or conda:
```bash
pip install showit
# OR
conda install bioconda::showit
```

## Core Functions

### Displaying a Single Image
Use `image()` to render a 2D or 3D array. By default, it removes axes and uses "nearest" interpolation to ensure pixel integrity.

```python
from showit import image
import numpy as np

# Create a random 25x25 RGB image
im = np.random.rand(25, 25, 3)
image(im, size=5, interp='nearest')
```

**Key Options:**
- `cmap`: Set the colormap (default is 'gray').
- `bar`: Boolean to toggle a color bar (default `False`).
- `clim`: A tuple `(min, max)` to set colormap limits.
- `nans`: Boolean to automatically replace NaNs with 0 (default `True`).
- `ax`: Pass an existing Matplotlib axis to plot into.

### Displaying Image Tiles
Use `tile()` to display a collection of images (a 3D or 4D array) in a grid format.

```python
from showit import tile
import numpy as np

# Create a stack of 9 grayscale images
ims = np.random.rand(9, 25, 25)
tile(ims, grid=(3, 3), titles=[f"Img {i}" for i in range(9)])
```

**Key Options:**
- `grid`: Tuple defining `(rows, cols)`. Defaults to the largest square grid possible.
- `axis`: The index of the array to iterate over (default `0`).
- `titles`: A list of strings to label each individual tile.
- `size`: Total figure size (default `7`).

## Best Practices
- **Data Inspection**: Always use `interp='nearest'` (the default behavior) when inspecting raw data to avoid Matplotlib's default smoothing/interpolation which can hide artifacts.
- **Scaling**: Use the `clim` parameter when comparing multiple images to ensure they share the same intensity scale.
- **Memory**: For very large stacks of images, specify a smaller `size` or a specific `grid` to prevent excessive memory usage during rendering.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_freeman-lab_showit.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_showit_overview.md)