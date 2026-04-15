---
name: scikit-image
description: scikit-image is a Python library that provides a collection of algorithms for scientific image processing. Use when user asks to perform image filtering, segmentation, feature detection, geometric transformations, or color space conversions.
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

## Reference documentation
- [scikit-image Main Repository](./references/github_com_scikit-image_scikit-image.md)
- [scikit-image Wiki](./references/github_com_scikit-image_scikit-image_wiki.md)
- [API 2.0 Transition Notes](./references/github_com_scikit-image_scikit-image_commits_main.md)