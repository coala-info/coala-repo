---
name: starfish
description: Starfish is a Python library designed to standardize the analysis of image-based transcriptomics by transforming high-dimensional microscopy images into quantified gene expression data. Use when user asks to process raw spatial transcriptomics images, perform image registration, apply filters like WhiteTophat, detect RNA spots, or decode transcripts using a codebook.
homepage: https://github.com/spacetx/starfish
metadata:
  docker_image: "quay.io/biocontainers/starfish:0.4.0--pyhdfd78af_0"
---

# starfish

## Overview
Starfish is a specialized Python library designed to standardize the analysis of image-based transcriptomics. It provides a modular framework to transform raw, high-dimensional microscopy images into quantified "Intensity Tables" and "Codebooks." Use this skill to navigate the complex workflow of localizing and quantifying RNA transcripts across multiple imaging rounds and channels.

## Core Data Structures
Starfish relies on three primary objects to manage the data lifecycle:
- **ImageStack**: A 5D tensor (Round, Channel, Z, Y, X) containing the raw or processed image data.
- **IntensityTable**: A specialized xarray-based table that stores the brightness of detected spots across all rounds and channels.
- **Codebook**: A reference mapping that defines which patterns of intensities across rounds and channels correspond to specific gene targets.

## Common Processing Patterns

### 1. Data Loading and Initialization
For memory-efficient processing, especially with large datasets, prefer the xarray constructor:
```python
from starfish import ImageStack
stack = ImageStack.from_xarray(xarray_obj)
```
For standard experiments, load via the experiment manifest:
```python
from starfish import Experiment
exp = Experiment.from_json("manifest.json")
stack = exp.fov().get_image("primary")
```

### 2. Image Registration
To correct for stage shift between imaging rounds, use the `LearnTransform` and `ApplyTransform` modules:
```python
from starfish.image import Registration
learn_translation = Registration.LearnTransform.Translation(reference_stack=ref_stack, axes="r")
transforms_list = learn_translation.run(stack)
warp = Registration.ApplyTransform.Warp()
registered_stack = warp.run(stack, transforms_list=transforms_list)
```

### 3. Filtering and Pre-processing
Commonly used filters to improve Signal-to-Noise Ratio (SNR):
- **WhiteTophat**: Removes background by performing a morphological opening.
- **DeconvolvePSF**: Reverses the blurring effect of the microscope's Point Spread Function.
- **Clip**: Limits intensity values to a specific range or percentile.

### 4. Spot Detection
Identify RNA transcripts using blob detection or local maxima:
```python
from starfish.spots import SpotFinding
detector = SpotFinding.BlobDetector(
    min_sigma=1,
    max_sigma=10,
    num_sigma=30,
    threshold=0.01
)
spots = detector.run(image_stack=stack)
```

### 5. Decoding
Transform detected spots into gene assignments using a Codebook:
```python
decoded = exp.codebook.decode_per_round_max(spots)
```

## Expert Tips
- **Visualization**: Always install with napari support (`pip install starfish[napari]`) to interactively inspect `ImageStack` objects and validate spot detection parameters.
- **Memory Management**: When working with 3D volumes, ensure `is_volume=True` is set in filters like `DeconvolvePSF` to avoid dimensionality errors.
- **Coordinate Consistency**: Be cautious when using `ApplyTransform.Warp.run()`; it can alter the `TransformsList`. If you need to reuse a transformation, ensure you are working with a copy or re-learning the transform if the stack has been modified.
- **Masking**: Use `BinaryMaskCollection` and `LabelImage` for cell segmentation tasks, which can then be used to assign decoded transcripts to specific cells.

## Reference documentation
- [Starfish GitHub Repository](./references/github_com_spacetx_starfish.md)
- [Starfish 0.4.0 Release Notes](./references/github_com_spacetx_starfish_tags.md)
- [Bioconda Starfish Overview](./references/anaconda_org_channels_bioconda_packages_starfish_overview.md)