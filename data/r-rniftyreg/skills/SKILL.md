---
name: r-rniftyreg
description: This tool provides an R interface to the NiftyReg library for performing 2D and 3D image registration, transformation manipulation, and NIfTI image processing. Use when user asks to perform linear or nonlinear image registration, apply transformations to images or coordinates, compose multiple transforms, or resample medical images.
homepage: https://cloud.r-project.org/web/packages/RNiftyReg/index.html
---


# r-rniftyreg

name: r-rniftyreg
description: Expert guidance for the RNiftyReg R package, used for 2D and 3D image registration (linear and nonlinear), transformation manipulation, and NIfTI image I/O. Use this skill when performing medical image alignment, applying affine or control-point transformations, or resampling images onto new grids.

# r-rniftyreg

## Overview
`RNiftyReg` is an R-native interface to the NiftyReg image registration library. It provides high-performance tools for aligning images (registration) and applying those alignments to other data (transformation). It supports 2D and 3D images, including NIfTI-1 formats and standard R arrays/matrices.

## Installation
```r
install.packages("RNiftyReg")
# For NIfTI I/O support
install.packages("RNifti")
```

## Core Workflow: Image Registration
Registration finds the best transformation to align a `source` image to a `target` image.

### 1. Linear (Affine) Registration
Used for global alignment (translation, rotation, scaling, shearing).
```r
library(RNiftyReg)
source <- readNifti("source.nii.gz")
target <- readNifti("target.nii.gz")

# Perform default affine registration
result <- niftyreg(source, target, scope="affine")

# View the registered image
plot(result$image)
```

### 2. Nonlinear Registration
Used for local deformations. It is best practice to initialize with an affine result.
```r
# Initialize nonlinear with the forward affine transform
result_nl <- niftyreg(source, target, scope="nonlinear", init=forward(result))
```

## Working with Transformations

### Extracting Transforms
Registration is symmetric; you can extract the mapping in either direction.
- `forward(result)`: Source to Target.
- `reverse(result)`: Target to Source.

### Applying Transforms
Apply a calculated transformation to images or specific point coordinates.
```r
# Apply to an image
new_image <- applyTransform(forward(result), source)

# Apply to pixel coordinates (e.g., x=10, y=20, z=5)
coords <- c(10, 20, 5)
new_coords <- applyTransform(forward(result), coords)
```

### Manual Transformation Construction
Use `buildAffine` to create transforms without registration.
```r
# Create a rotation of 45 degrees (pi/4)
affine <- buildAffine(angles=c(0, 0, pi/4), source=source)
rotated <- applyTransform(affine, source)
```

### Composition and Decomposition
- `composeTransforms(xfm1, xfm2)`: Combine two transformations into one to avoid multiple resampling steps (prevents data loss).
- `decomposeAffine(xfm)`: Break an affine matrix into its constituent parts (translation, rotation, scale, skew).
- `halfTransform(xfm)`: Calculate the "mid-way" transformation.

## Convenience Functions
For quick, simple manipulations:
- `translate(image, translation)`
- `rotate(image, angles)`
- `rescale(image, scales)`
- `skew(image, skews)`

**Tip:** When chaining multiple operations, use `buildAffine` and `composeTransforms` instead of piping individual convenience functions to maintain image quality and avoid edge truncation.

## Reference documentation
- [RNiftyReg README](./references/README.md)