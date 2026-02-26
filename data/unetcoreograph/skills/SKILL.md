---
name: unetcoreograph
description: UNetCoreograph processes Tissue Microarray (TMA) slides by locating tissue cores and generating precise tissue masks. Use when user asks to dearray a TMA, split a TMA image into individual core files, locate tissue cores, create tissue masks, or export core images.
homepage: https://github.com/HMS-IDAC/UNetCoreograph
---


# unetcoreograph

## Overview
UNetCoreograph is a specialized tool for the automated processing of Tissue Microarray (TMA) slides. It utilizes a UNet deep learning model to locate the centers of both complete and incomplete tissue cores and employs active contours to create precise tissue masks. This tool is essential for workflows that require splitting a single large TMA image into individual core files to facilitate downstream single-cell segmentation and analysis. It is optimized for high-resolution data (typically 0.2 microns/pixel) and supports multi-channel extraction.

## Command Line Usage

The primary interface is the `UNetCoreograph.py` script.

### Basic Execution
To dearray a TMA using the default settings (assuming the DAPI channel is the first channel):
```bash
python UNetCoreograph.py --imagePath /path/to/image.ome.tif --outputPath /path/to/output --channel 0
```

### Parameter Guidance
- `--imagePath`: Supports `.tif` and `.ome.tif` formats.
- `--outputPath`: Directory where individual core TIFFs, the `mask` subfolder, and the TMA QC map will be saved.
- `--channel`: Specify the index of the channel to be used for core identification (typically the nuclear/DAPI stain).
- `--downsampleFactor`: Default is `5`. This is calibrated for 0.2 micron/pixel resolution. If your input resolution is significantly different, adjust this factor to ensure the model sees features at a scale similar to its training data (which was downsampled 1/32 from 0.2um/pixel).
- `--buffer`: Default is `2`. This controls the padding around the identified core. A value of 2 adds a buffer equal to twice the width of the core. Decrease this value for high-density TMAs to avoid overlapping crops.
- `--outputChan`: Controls which channels are included in the exported core stacks.
    - Default `-1`: Exports all channels (resource intensive).
    - Single channel: `--outputChan 0`
    - Range: `--outputChan 0 10` (exports channels 0 through 10).

## Best Practices and Expert Tips

### Quality Control
After execution, always inspect the generated TMA map in the output directory. This map shows the labels and outlines of each identified core. If cores are missed or outlines are inaccurate, consider adjusting the `--channel` or `--downsampleFactor`.

### Performance Optimization
- **GPU Usage**: While a GPU is not strictly required, it significantly reduces the computation time for the UNet probability map generation.
- **Channel Selection**: If the DAPI stain is weak or noisy, try an alternative structural marker channel that clearly defines the core boundaries.
- **Memory Management**: Exporting all channels (`--outputChan -1`) on very large multiplexed images can be slow and memory-intensive. If only specific markers are needed for downstream steps, define a specific range.

### Downstream Integration
The binary tissue masks saved in the `mask` subfolder are designed to be used directly as input for single-cell segmentation tools (like Mesmer or CellPose), providing a pre-defined region of interest that excludes background noise.

## Reference documentation
- [UNetCoreograph GitHub Repository](./references/github_com_HMS-IDAC_UNetCoreograph.md)