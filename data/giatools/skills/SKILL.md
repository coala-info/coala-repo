---
name: giatools
description: giatools provides a suite of utilities for Galaxy Image Analysis to handle complex bio-imaging formats and multi-dimensional arrays. Use when user asks to process bio-imaging data, manage multi-dimensional arrays, preserve image metadata, handle large datasets with Dask, or work with OME-Zarr formats.
homepage: https://github.com/BMCV/giatools
---


# giatools

## Overview
giatools is a specialized suite of utilities designed to support Galaxy Image Analysis. It provides a robust framework for handling complex bio-imaging formats, ensuring consistency across image processing pipelines. The tool excels at managing multi-dimensional arrays (including Dask-backed arrays for large datasets), preserving metadata during transformations, and providing a standardized base for building command-line interfaces that interact with Galaxy.

## CLI Usage and Best Practices

### Standardized CLI Development
When building or using tools based on the `giatools.cli` module, leverage the `ToolBaseplate` to ensure consistent behavior across the Galaxy environment.

*   **Verbose Output**: Use the verbose flag (if implemented in the specific tool) to inspect image metadata, including `original_shape` and `original_axes`. This is critical for debugging coordinate transformations.
*   **Dtype Preservation**: When processing images, use the `preserve` hint for `dtype` to ensure that boolean masks or integer-based label images do not undergo unintended type conversion.

### Image Data Handling
giatools uses a specific axis convention. Understanding this is vital for correct spatial analysis.

*   **Axis Ordering**: The default normalized axes follow the `QTZYXC` convention. Ensure your input data is mapped to these dimensions to avoid orientation errors.
*   **Anisotropy**: Use `Image.get_anisotropy()` instead of older isotropy checks to retrieve the physical scaling of the image dimensions, which is essential for accurate spatial measurements.
*   **Joint Iteration**: For operations involving multiple images (e.g., applying a mask to a raw image), use `Image.iterate_jointly`. This method ensures that axes are aligned correctly across different image objects during the loop.

### IO Operations
*   **OME-Zarr Support**: Use the `omezarr` backend for high-performance access to multi-scale, chunked bio-imaging data.
*   **Raw Reading**: Use `io.imreadraw` for low-level access to image data when standard metadata headers are missing or need manual override.
*   **Path Handling**: The `io` and `image` interfaces support `pathlib.Path` objects, allowing for more robust cross-platform script development.

### Large Dataset Processing
*   **Dask Integration**: When working with datasets that exceed memory, giatools integrates with Dask. Ensure you use `Image.astype` and `Image.clip_to_dtype` specifically designed for Dask arrays to prevent eager evaluation that might crash the system.

## Reference documentation
- [giatools GitHub Repository](./references/github_com_BMCV_giatools.md)
- [giatools Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_giatools_overview.md)
- [giatools Commit History (Feature Reference)](./references/github_com_BMCV_giatools_commits_master.md)