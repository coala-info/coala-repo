---
name: bioconductor-ebimage
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/EBImage.html
---

# bioconductor-ebimage

name: bioconductor-ebimage
description: Image processing and analysis in R. Use for reading, writing, and displaying images; performing spatial transformations, filtering, and morphological operations; and executing advanced image segmentation workflows (e.g., cell/nuclei identification) using watershed and Voronoi algorithms.

# bioconductor-ebimage

## Overview
EBImage provides general-purpose functionality for image processing and analysis within the R environment. It is particularly optimized for microscopy-based cellular assays, offering tools for segmentation and the extraction of quantitative cellular descriptors. It uses a specialized `Image` class that extends R's native `array` class, allowing for seamless integration with R's statistical and machine learning tools.

## Core Workflows

### 1. Image I/O and Visualization
Read images from files or URLs and display them using either a browser-based interactive viewer or R's internal raster plotting.

```r
library(EBImage)

# Read image (supports jpeg, png, tiff)
img = readImage("path/to/image.png")

# Display image
display(img, method = "raster") # Use "browser" for interactive JS viewer

# Write image
writeImage(img, "output.jpg", quality = 85)
```

### 2. Data Representation and Color Management
The `Image` class stores pixel intensities in the `.Data` slot. The `colorMode` determines how dimensions are interpreted.

- **Grayscale**: 3rd and higher dimensions are separate frames.
- **Color**: 3rd dimension holds color channels (usually RGB).

```r
# Inspect structure
print(img, short = TRUE)
dim(img)

# Change rendering mode without changing data
colorMode(img) = Grayscale 

# Convert color spaces or extract channels
gray_img = channel(img, "luminance")
rgb_img = toRGB(gray_img)
```

### 3. Image Manipulation and Transformations
Perform arithmetic operations directly on image objects or apply spatial transformations.

```r
# Arithmetic (brightness, contrast, gamma)
img_bright = img + 0.2
img_contrast = img * 1.5
img_gamma = img ^ 0.7

# Spatial transformations
img_rot = rotate(img, 45, bg.col = "white")
img_rsz = resize(img, w = 256) # Aspect ratio preserved if only one dim provided
img_flip = flip(img)
img_flop = flop(img)
```

### 4. Filtering and Smoothing
Use linear convolution filters or non-linear median filters to reduce noise or detect edges.

```r
# Gaussian smoothing
w = makeBrush(size = 31, shape = 'gaussian', sigma = 5)
img_smooth = filter2(img, w)

# Shortcut for Gaussian blur
img_blur = gblur(img, sigma = 5)

# Median filtering (noise reduction)
img_med = medianFilter(img, size = 2)
```

### 5. Segmentation Workflow
Identify individual objects (e.g., cells) through thresholding and labeling.

```r
# 1. Thresholding
# Global (Otsu's method)
th = otsu(img)
binary_mask = img > th

# Adaptive (local)
binary_mask = thresh(img, w = 15, h = 15, offset = 0.05)

# 2. Morphological operations to clean mask
mask_cleaned = opening(binary_mask, makeBrush(5, shape = 'disc'))
mask_filled = fillHull(mask_cleaned)

# 3. Labeling connected components
labels = bwlabel(mask_filled)

# 4. Watershed (to separate touching objects)
# Use distance map as heightmap for watershed
nmask = watershed(distmap(binary_mask), tolerance = 2)
```

### 6. Object Analysis and Visualization
Highlight segmented objects or remove specific IDs.

```r
# Highlight objects on original image
visual_result = paintObjects(nmask, toRGB(img), col = "red")

# Color code objects randomly
display(colorLabels(nmask))

# Remove specific objects (e.g., IDs 2 and 5)
cleaned_labels = rmObjects(nmask, c(2, 5))
```

## Tips for AI Agents
- **Frame Handling**: When working with multi-frame images (TIFF stacks), use `getFrames(img)` to iterate over frames with `lapply`.
- **Memory**: `EBImage` objects can be large. Use `print(img, short = TRUE)` to avoid flooding the console with pixel values.
- **Coordinate System**: In `EBImage`, the first dimension is the x-axis (columns) and the second is the y-axis (rows). This is consistent with image standards but may feel inverted compared to standard R matrix indexing `[row, col]`.
- **Normalization**: Use `normalize()` to scale pixel intensities to the `[0, 1]` range required for many functions and display.

## Reference documentation
- [Introduction to EBImage](./references/EBImage-introduction.Rmd)
- [Introduction to EBImage](./references/EBImage-introduction.md)