---
name: sopa
description: Sopa is a Python-based suite for high-throughput spatial-omics analysis that transforms raw spatial data into single-cell resolution insights using various segmentation algorithms. Use when user asks to align multimodal images, create image or transcript patches, perform cell segmentation, or export data for interactive visualization in Xenium Explorer.
homepage: https://gustaveroussy.github.io/sopa
---


# sopa

## Overview

Sopa is a specialized Python-based suite designed for high-throughput spatial-omics analysis. It provides a unified framework for transforming raw spatial data into single-cell resolution insights by integrating various segmentation algorithms (like Cellpose, Baysor, and Proseg) with the `SpatialData` ecosystem. Sopa is optimized for memory efficiency, allowing it to process terabyte-scale images on standard hardware, and offers robust tools for aligning multimodal images and exporting results for interactive visualization.

## Usage Guidelines

### Installation and Setup
Install the core package via pip or conda. Use "extras" to include specific segmentation engines:
- **Core**: `pip install sopa`
- **With Segmentation**: `pip install 'sopa[cellpose,baysor,stardist]'`
- **WSI Support**: `pip install 'sopa[wsi]'`

### Common CLI Patterns
The `sopa` command-line interface is primarily used for pipeline orchestration and explorer interoperability.

**Aligning external images to SpatialData:**
Use this after generating a transformation matrix in Xenium Explorer or napari.
```bash
sopa explorer add-aligned <SDATA_PATH> <IMAGE_PATH> <TRANSFORMATION_MATRIX_PATH>
```

### API Best Practices
For custom workflows, use the Python API. Sopa follows a standard sequence: Read -> Patch -> Segment -> Aggregate.

**1. Efficient Data Handling**
Always write your `SpatialData` object to a `.zarr` store early. This enables "lazy loading" and significantly speeds up downstream processing.
```python
import spatialdata
import sopa

sdata = sopa.io.xenium("path/to/data")
sdata.write("data.zarr")
sdata = spatialdata.read_zarr("data.zarr")
```

**2. Patching Strategy**
Segmentation is performed on patches to save memory.
- **Image-based (Cellpose/Stardist)**: Use `sopa.make_image_patches(sdata, patch_width=1200, patch_overlap=50)`.
- **Transcript-based (Baysor/Proseg)**: Use `sopa.make_transcript_patches(sdata)`.

**3. Technology-Specific Tips**
- **Xenium/MERSCOPE**: Use `prior_shapes_key="auto"` in transcript patching to leverage vendor-provided boundaries as priors for Baysor or Proseg.
- **MACSima/PhenoCycler**: Run `sopa.segmentation.tissue(sdata)` first to create a mask, preventing Cellpose from wasting time on empty slide areas.
- **Cellpose Parameters**: A `diameter` of 35 pixels is a standard starting point for many technologies, but always validate on a small crop first.

### Xenium Explorer Interoperability
Sopa allows you to update Explorer files without re-converting the entire dataset.

**Updating only cell categories (e.g., after clustering):**
```python
# mode="+o" updates only the observations/table file
sopa.io.explorer.write(explorer_path, sdata, mode="+o")
```

**Updating everything except heavy image/transcript files:**
```python
sopa.io.explorer.write(explorer_path, sdata, mode="-it")
```

### Expert Tips
- **Parallelization**: Set `sopa.settings.parallelization_backend = "dask"` to speed up segmentation across multiple patches.
- **Memory Management**: If working with 1TB+ images, ensure your `SpatialData` object is backed by Zarr to avoid OOM (Out of Memory) errors.
- **Coordinate Systems**: Be aware that Cellpose typically outputs in pixel coordinates, while transcript-based tools like Baysor often use microns. Sopa handles the transformation, but verify your `coordinate_system` when plotting.

## Reference documentation
- [Getting Started](./references/gustaveroussy_github_io_sopa_getting_started.md)
- [API Usage](./references/gustaveroussy_github_io_sopa_tutorials_api_usage.md)
- [Technology-specific advice](./references/gustaveroussy_github_io_sopa_tutorials_techno_specific.md)
- [Xenium Explorer usage](./references/gustaveroussy_github_io_sopa_tutorials_xenium_explorer_explorer.md)