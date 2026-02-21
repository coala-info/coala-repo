---
name: minc-tools
description: The MINC (Medical Image NetCDF) toolkit is a specialized suite for managing N-dimensional medical imaging data.
homepage: https://github.com/BIC-MNI/minc
---

# minc-tools

## Overview

The MINC (Medical Image NetCDF) toolkit is a specialized suite for managing N-dimensional medical imaging data. Built originally on NetCDF and updated to support HDF5 (MINC 2.0), these tools allow for granular control over image headers, voxel intensities, and spatial transformations. Use this skill to perform deterministic image processing tasks, such as resampling volumes to a specific template, calculating voxel-wise statistics, or converting between world and voxel coordinate systems.

## Core Tool Categories

### File Information and Inspection
*   **mincinfo**: Retrieve specific information about dimensions, attributes, or data types.
*   **mincheader**: View the entire header structure in ASCII format.
*   **minchistory**: View the processing history of a file.
*   **mincdiff**: Compare two MINC files to identify differences in headers or data.

### Format Conversion
*   **rawtominc / minctoraw**: Convert between raw binary data and MINC format.
*   **mincextract**: Extract specific slices or hyperslabs from a volume.
*   **mincconvert**: Specifically used to convert between MINC 1.0 (NetCDF) and MINC 2.0 (HDF5).

### Volume Manipulation
*   **mincresample**: Resample a volume using a transformation (.xfm) or to match the grid of another file.
*   **mincreshape**: Change dimension order, flip images, or extract sub-cubes without changing the underlying data resolution.
*   **mincconcat**: Combine multiple files into a single higher-dimensional volume (e.g., creating a 4D time series).

### Voxel Math and Statistics
*   **minccalc**: Perform complex mathematical operations using the `-expr` flag (e.g., `minccalc -expr "A[0] * 2" in.mnc out.mnc`).
*   **mincmath**: Simple arithmetic (add, sub, mult) across multiple files.
*   **mincstats**: Calculate global or ROI-based statistics (mean, stddev, volume, etc.).
*   **mincaverage**: Average multiple MINC volumes into a single output.

## Common CLI Patterns

### Resampling to a Template
To make one image match the dimensions and orientation of another:
`mincresample -like template.mnc input.mnc output.mnc`

### Modifying Headers
To change a specific attribute without rewriting the entire data block:
`minc_modify_header -sattribute "patient:name=JohnDoe" file.mnc`

### Coordinate Conversion
Convert a world coordinate (x,y,z in mm) to a voxel index:
`worldtovoxel input.mnc <x> <y> <z>`

### Generating Previews
Create a 2D PNG/JPG slice from a 3D volume:
`mincpik -slice 50 input.mnc output.png`

## Expert Tips and Best Practices

*   **MINC 2.0 Support**: Most tools support the `-2` flag to force the output into MINC 2.0 (HDF5) format. This is recommended for large datasets or when compression is required.
*   **Compression**: Control output compression by setting the `MINC_COMPRESS` environment variable (0-9). A value of 4 is typically the best balance between speed and size.
*   **Global Attributes**: Use `minc_modify_header` instead of `mincedit` for automated scripts to avoid opening a text editor.
*   **Coordinate Systems**: Always verify if your tools are operating in "world space" (mm) or "voxel space" (indices). Tools like `mincresample` and `mincstats` are world-space aware.
*   **Transformation Inversion**: Use `xfminvert` to reverse a spatial transformation before applying it with `mincresample`.

## Reference documentation
- [MINC Tools Overview](./references/github_com_BIC-MNI_minc-tools.md)
- [MINC 2.0 and Environment Variables](./references/github_com_BIC-MNI_minc.md)