---
name: vpt-segmentation-packing
description: This tool is a specialized utility for the Vizgen Post-processing Toolset (VPT).
homepage: https://github.com/Vizgen/vpt-segmentation-packing
---

# vpt-segmentation-packing

## Overview
This tool is a specialized utility for the Vizgen Post-processing Toolset (VPT). Its primary function is to take cell segmentation boundaries—typically generated from image processing algorithms—and "pack" them into the `.vzg2` file format. This step is essential for integrating custom segmentation results back into Vizgen's standard data outputs, enabling compatibility with the MERSCOPE Visualizer and other platform-specific tools.

## Usage Guidelines

### Core Workflow
The tool is typically invoked via the command line to process segmentation output directories. The primary command structure follows the standard VPT plugin architecture.

```bash
vpt-segmentation-packing [OPTIONS] --input-boundaries <PATH> --output-vzg2 <PATH>
```

### Key Parameters
- `--input-boundaries`: Path to the directory or file containing the segmentation boundaries (often in .parquet or .json format depending on the upstream segmentation tool).
- `--output-vzg2`: The target destination for the packed Vizgen geometry file.
- `--segmentation-algorithm`: (Optional) Specify the name of the algorithm used to generate the boundaries for metadata tracking.

### Best Practices
- **Coordinate Consistency**: Ensure that the input boundaries are in the same coordinate space (global microns or stage coordinates) as the corresponding transcript data to avoid alignment issues in the Visualizer.
- **File Permissions**: When running in a containerized or HPC environment, ensure the output directory has write permissions, as `.vzg2` files can be large depending on the number of z-planes and cells.
- **Validation**: After packing, verify the file size. A successful packing of a standard MERSCOPE FOV typically results in a non-zero file that scales with the complexity of the cell polygons.

## Reference documentation
- [vpt-segmentation-packing Overview](./references/anaconda_org_channels_bioconda_packages_vpt-segmentation-packing_overview.md)