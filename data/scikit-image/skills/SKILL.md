---
name: scikit-image
description: scikit-image is a Python library that provides a collection of algorithms for scientific image processing. Use when user asks to perform image filtering, thresholding, segmentation (for example nuclei, cells or thin filaments in fluorescence microscopy, with watershed), skeletons and object measurements, feature detection, geometric transformations, or color space conversions.
homepage: https://github.com/scikit-image/scikit-image
metadata:
  docker_image: "quay.io/biocontainers/scikit-image:0.24.0"
---

# scikit-image

## Overview
scikit-image is a robust Python library dedicated to image processing algorithms. It is built on top of NumPy and SciPy, ensuring that images are handled as standard NumPy arrays. This makes it highly interoperable with other scientific Python tools like Matplotlib for visualization and scikit-learn for machine learning. You should use this skill to implement high-quality, peer-reviewed algorithms for tasks ranging from basic image resizing and color space conversion to complex feature extraction and medical image analysis.

## Usage Guidelines and Best Practices

### Installation and Environment
Install the package using standard Python package managers:
- **pip**: `pip install scikit-image`
- **conda**: `conda install -c conda-forge scikit-image`

### Data Type Management
scikit-image functions often expect specific input ranges (e.g., floats between 0 and 1 or integers between 0 and 255). Use the utility functions in `skimage.util` to safely convert images:
- `img_as_float`: Converts to 64-bit floating point (0 to 1).
- `img_as_ubyte`: Converts to 8-bit unsigned integer (0 to 255).
- `img_as_uint`: Converts to 16-bit unsigned integer (0 to 65535).

### Core Module Workflows
- **Feature Detection**: Use `skimage.feature` for edge detection (Canny), blob detection (`blob_dog`, `blob_log`, `blob_doh`), and corner detection.
- **Filtering**: Use `skimage.filters` for denoising, sharpening, and thresholding (e.g., `threshold_otsu`).
- **Morphology**: Use `skimage.morphology` for operations like erosion, dilation, opening, closing, and skeletonization.
- **Transformations**: Use `skimage.transform` for resizing, rotating, and applying homographies or Radon transforms.
- **Segmentation**: Use `skimage.segmentation` for algorithms like SLIC, watershed, or flood fill.

### Expert Tips
- **NumPy Integration**: Since images are arrays, use NumPy slicing for cropping: `image[top:bottom, left:right]`.
- **Color Conversions**: Always check if a function expects grayscale or RGB. Use `skimage.color.rgb2gray` or `skimage.color.label2rgb` to manage channels.
- **Performance**: For large datasets, prefer functions that support the `channel_axis` parameter (introduced in recent versions) to handle multi-channel data efficiently.
- **Experimental Features**: Be aware of the `skimage2` namespace mentioned in development logs, which contains updated signatures for functions like `binary_blobs` and `peak_local_max` as the library transitions to its 2.0 API.

## Recipe: nuclei and thin filaments in fluorescence microscopy
Work in physical units. Read the pixel size from the file (see the tifffile skill), look at the
image, and write every size limit in micrometres, then convert to pixels. A diameter guessed in
pixels without looking is the most common cause of wrong counts.

```python
import numpy as np
from scipy import ndimage as ndi
from skimage import filters, measure, morphology, segmentation

r_px = d_um / 2 / um_per_px                    # expected nucleus radius, from the image
sm = filters.gaussian(nuc.astype(float), sigma=2)
fg = sm > filters.threshold_otsu(sm)           # Otsu suits a bright, large foreground
fg = morphology.remove_small_objects(fg, min_size=int(0.3 * np.pi * r_px ** 2))
dist = ndi.distance_transform_edt(fg)
seeds = measure.label(morphology.h_maxima(ndi.gaussian_filter(dist, 2), h=0.15 * r_px))
nuclei = segmentation.watershed(-dist, seeds, mask=fg)   # or peak_local_max(min_distance≈r_px)
```
- Space watershed seeds by the expected radius (`h_maxima` height or `peak_local_max(min_distance=...)`).
  Seeds closer than a radius split one nucleus into several; seeds too far apart merge touching ones.
- In 3D stacks, decide whether you segment a projection or the volume. Two nuclei that overlap in
  a projection may be separate in depth.

Thin, sparse objects (cilia, filaments, fibres) in a low-count channel need a different threshold:
```python
ch = filters.gaussian(fil.astype(float), sigma=1)
th = morphology.white_tophat(ch, morphology.disk(int(w_um / um_per_px)))  # disk wider than the object
med = np.median(th); mad = 1.4826 * np.median(np.abs(th - med))
mask = filters.apply_hysteresis_threshold(th, med + 4 * mad, med + 8 * mad)
lab = measure.label(mask)
objs = [p for p in measure.regionprops(lab)
        if p.major_axis_length * um_per_px >= min_len_um and p.eccentricity > 0.9]
```
- Otsu on a sparse, noisy channel splits the noise, not the objects: on a synthetic Poisson
  channel with four filaments it marked 36% of pixels as foreground, against 0.3% for the robust
  hysteresis threshold above. Always print the foreground fraction; it should match how much of
  the image the objects cover.
- Ridge filters (`sato`, `meijering`, `frangi`) also respond to noise; threshold their output with
  the same robust rule, not Otsu.

Endpoints of an elongated object: skeletonize it, then take the longest path through the skeleton.
Run a breadth-first search from any skeleton pixel to the farthest one (the first end). Run it again
from there; the farthest pixel is the second end, and the distance is the path length. Skeleton
pixels with one neighbour can include spurs, so do not take those as the ends. Decide which end is
which from another channel, for example the end next to a marker spot.

Review: draw the result on the image and look at it before you trust any count.
```python
import matplotlib; matplotlib.use("Agg"); import matplotlib.pyplot as plt
fig, ax = plt.subplots(figsize=(8, 8)); ax.imshow(img, cmap="gray")
ax.contour(segmentation.find_boundaries(nuclei), [0.5], colors="y", linewidths=0.5)
ax.contour(mask, [0.5], colors="m", linewidths=0.5); ax.set_axis_off()
fig.savefig("overlay.png", dpi=150, bbox_inches="tight")
```
Check that the numbers are plausible: objects per cell, sizes in micrometres, and percentages
between 0 and 100.

## Reference documentation
- [scikit-image Main Repository](./references/github_com_scikit-image_scikit-image.md)
- [scikit-image Wiki](./references/github_com_scikit-image_scikit-image_wiki.md)
- [API 2.0 Transition Notes](./references/github_com_scikit-image_scikit-image_commits_main.md)