---
name: vpt-cellpose2
description: The `vpt-cellpose2` skill provides a specialized interface for applying Cellpose 2.0 deep-learning models to MERSCOPE transcriptomics datasets.
homepage: https://github.com/Vizgen/vpt-plugin-cellpose2
---

# vpt-cellpose2

## Overview
The `vpt-cellpose2` skill provides a specialized interface for applying Cellpose 2.0 deep-learning models to MERSCOPE transcriptomics datasets. It functions as a plugin for the Vizgen Post-processing Tool (VPT), allowing for scalable and reproducible cell boundary detection. The tool separates the execution logic into two parts: command-line arguments for environment-specific paths and a JSON configuration file for the immutable segmentation algorithm steps.

## Installation
The plugin can be added to an existing VPT environment using standard Python package managers:

```bash
# Using pip
pip install vpt-plugin-cellpose2

# Using poetry
poetry add vpt-plugin-cellpose2
```

## Core Workflow
Running a segmentation task requires invoking the VPT CLI with the Cellpose plugin specified in an algorithm JSON file.

### 1. Command Line Execution
The standard pattern for running segmentation with the plugin involves pointing VPT to the input data and the algorithm definition:

```bash
vpt run-segmentation \
    --segmentation-algorithm <path_to_algorithm.json> \
    --input-path <directory_containing_images> \
    --output-path <output_directory> \
    --tile-size 2048
```

### 2. Algorithm JSON Structure
The JSON file defines how Cellpose should process the data. It must reference the plugin module and the specific algorithm class.

**Key Components:**
- `module`: Must be set to `vpt_plugin_cellpose2`.
- `algorithm`: Typically `CellposeSegmentation`.
- `parameters`: Contains the model selection and hyper-parameters.

**Example JSON Configuration:**
```json
{
    "module": "vpt_plugin_cellpose2",
    "algorithm": "CellposeSegmentation",
    "parameters": {
        "model": "cyto2",
        "diameter": 30,
        "channels": [1, 2],
        "flow_threshold": 0.4,
        "cellprob_threshold": 0.0,
        "gpu": true
    }
}
```

## Expert Tips and Best Practices

### Model Selection
- **Model Zoo**: Use `cyto` or `cyto2` for general cellular segmentation. Use `nuclei` if segmenting based on DAPI/nuclear stains alone.
- **Custom Models**: Provide the full path to a custom-trained Cellpose model file in the `model` parameter for tissue-specific optimization.

### Parameter Tuning
- **Diameter**: This is the most critical parameter. If set to `0`, Cellpose will attempt to auto-estimate the diameter, but providing a fixed value based on your tissue type (typically 15-100 pixels) improves consistency across tiles.
- **Channels**: Define which image channels to use. For MERSCOPE, channel 1 is typically the primary stain (e.g., PolyDT or Cell Boundary) and channel 2 is the nuclear stain (DAPI).
- **Flow and Cell Probability**: 
    - Increase `flow_threshold` if the masks are too small or disappearing.
    - Decrease `cellprob_threshold` if you want to include more uncertain cell detections.

### Performance
- **GPU Acceleration**: Always set `"gpu": true` in the JSON parameters if a CUDA-compatible GPU is available to significantly reduce processing time for large MERSCOPE fields of view.
- **Reproducibility**: Always reuse the same algorithm JSON file across different experiments in the same study to ensure segmentation consistency.

## Reference documentation
- [Cellpose2 plugin for the Vizgen Post-processing Tool](./references/github_com_Vizgen_vpt-plugin-cellpose2.md)
- [Example Analysis Algorithms](./references/github_com_Vizgen_vpt-plugin-cellpose2_tree_develop_example_analysis_algorithm.md)