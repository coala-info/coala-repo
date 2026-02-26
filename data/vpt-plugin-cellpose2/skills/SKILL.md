---
name: vpt-plugin-cellpose2
description: The vpt-plugin-cellpose2 performs cell segmentation for MERSCOPE spatial transcriptomics workflows. Use when user asks to segment cells.
homepage: https://github.com/Vizgen/vpt-plugin-cellpose2
---


# vpt-plugin-cellpose2

## Overview

The vpt-plugin-cellpose2 is a specialized extension for the Vizgen Post-processing Tool (VPT) that brings the power of Cellpose 2.0 to MERSCOPE spatial transcriptomics workflows. It enables high-fidelity cell segmentation by allowing users to define complex segmentation logic within a JSON-based algorithm file. This approach separates the data location (provided via CLI) from the scientific parameters (provided via JSON), ensuring that the same segmentation logic can be applied consistently across multiple experiments or shared across research teams.

## Installation and Setup

The plugin can be installed into your VPT environment using standard Python package managers:

- **Conda (Recommended)**: `conda install bioconda::vpt-plugin-cellpose2`
- **Pip**: `pip install vpt-plugin-cellpose2`

Ensure that your environment has the necessary GPU drivers (CUDA) if you intend to run Cellpose with GPU acceleration, as this significantly improves processing speed for large MERSCOPE tiles.

## Core Usage Pattern

The plugin is not run as a standalone executable but is invoked through the main `vpt` command line interface. The standard workflow involves two primary inputs:

1.  **Command Line Arguments**: Define the experiment-specific paths (input data, output directories, and tile specifications).
2.  **Segmentation Algorithm JSON**: Defines the immutable logic of the segmentation (model selection, parameters, and preprocessing steps).

### Common CLI Structure
When running segmentation, you will typically use the `vpt run-segmentation` command (or equivalent VPT entry point) and specify the algorithm:

```bash
vpt run-segmentation \
    --input-path /path/to/merscope/data \
    --output-path /path/to/output \
    --segmentation-algorithm /path/to/cellpose_config.json
```

## Segmentation Algorithm Configuration

The power of this plugin lies in the `.json` configuration. While you should refer to the `example_analysis_algorithm` directory for templates, keep these expert tips in mind:

- **Model Selection**: You can specify models from the Cellpose "model zoo" (e.g., `cyto`, `nuclei`) or provide a path to a custom-trained model.
- **Parameter Tuning**: Key parameters to calibrate in your JSON include:
    - `diameter`: The expected size of your cells in pixels.
    - `cellprob_threshold`: Determines which pixels are considered part of a cell.
    - `flow_threshold`: Controls the maximum allowed error in the predicted flows.
- **Channel Mapping**: Ensure your JSON correctly maps the MERSCOPE image channels (e.g., DAPI, PolyT, or specific protein stains) to the expected Cellpose inputs.

## Expert Tips and Troubleshooting

- **MERSCOPE Ultra Support**: If working with MERSCOPE Ultra datasets, ensure you are using version 1.0.1 or later of the plugin to guarantee compatibility with the updated data formats.
- **Dependency Conflicts**: Be aware of potential version mismatches between `onnx` and `opencv-python`. If you encounter errors during the `cv2.merge` phase or ONNX runtime initialization, verify that your environment meets the requirements specified in the `pyproject.toml`.
- **Reproducibility**: Always version-control your segmentation `.json` files. Since the CLI handles the "where" and the JSON handles the "how," keeping the JSON constant ensures identical results across different compute environments.
- **Memory Management**: For large-scale experiments, monitor GPU memory usage. If you encounter Out-Of-Memory (OOM) errors, consider adjusting the tile size or overlap parameters in the VPT command line settings.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_Vizgen_vpt-plugin-cellpose2.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_vpt-plugin-cellpose2_overview.md)
- [Example Algorithm Templates](./references/github_com_Vizgen_vpt-plugin-cellpose2_tree_develop_example_analysis_algorithm.md)