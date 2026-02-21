---
name: elastix
description: elastix is a modular toolbox designed for the automated registration of (medical) images.
homepage: https://github.com/SuperElastix/elastix
---

# elastix

## Overview

elastix is a modular toolbox designed for the automated registration of (medical) images. It provides a framework to find the optimal spatial transformation that maps a moving image to a fixed image. The tool is built on the Insight Segmentation and Registration Toolkit (ITK) and is highly configurable through parameter files, allowing users to define specific metrics, samplers, interpolators, and optimizers. It consists of two primary command-line executables: `elastix` (for computing transformations) and `transformix` (for applying transformations to images or point sets).

## Core CLI Usage

The primary workflow involves calling `elastix` with a fixed image, a moving image, and one or more parameter files.

### Running Registration
To perform a basic registration:
```bash
elastix -f fixed_image.nii -m moving_image.nii -out output_directory -p parameters.txt
```

### Multi-Stage Registration
For complex tasks (e.g., Rigid followed by Non-rigid), pass multiple parameter files in sequence:
```bash
elastix -f fixed.nii -m moving.nii -out ./output -p rigid.txt -p bspline.txt
```

### Applying Transformations with transformix
Once a registration is complete, use the generated `TransformParameters.txt` to warp images:
```bash
transformix -in moving_image.nii -out output_directory -tp TransformParameters.0.txt
```

To compute a deformation field (vector field):
```bash
transformix -def all -out output_directory -tp TransformParameters.0.txt
```

## Parameter File Best Practices

The behavior of elastix is governed by the `-p` file. Key settings to consider:

- **Registration Components**: Ensure you define `Registration`, `FixedImagePyramid`, `MovingImagePyramid`, `Interpolator`, `Metric`, `Optimizer`, `ResampleInterpolator`, `Resampler`, and `Transform`.
- **Image Sampling**: For large datasets, use `(ImageSampler "RandomCoordinate")` to speed up the metric calculation.
- **Multi-Resolution**: Use a multi-resolution approach (e.g., `(NumberOfResolutions 3)`) to avoid local minima and improve robustness.
- **Final Result**: Set `(WriteResultImage "true")` if you want the warped moving image saved immediately, or "false" if you only need the transformation parameters.

## Expert Tips

- **Initial Alignment**: If images are far apart, use `(AutomaticTransformInitialization "true")` in the parameter file to align centers of gravity or geometric centers before optimization.
- **Masking**: Use `-fMask` or `-mMask` to restrict the registration metric calculation to specific anatomical regions, which is critical for avoiding influence from image artifacts or non-relevant structures.
- **Checking Convergence**: Review the `iterationInfo.txt` file in the output directory to monitor the metric value and ensure the optimizer has converged.
- **Transformix for Points**: You can transform a set of landmarks/points using the `-def` flag with a point file:
  ```bash
  transformix -def points.txt -out ./output -tp TransformParameters.0.txt
  ```

## Reference documentation

- [Official elastix repository](./references/github_com_SuperElastix_elastix.md)
- [elastix Wiki and Documentation](./references/github_com_SuperElastix_elastix_wiki.md)