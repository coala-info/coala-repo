---
name: tifffile
description: Tifffile is a library for high-performance reading, writing, and managing TIFF image data, especially large and complex scientific formats. Use when user asks to 'read TIFF images', 'write TIFF images', 'handle large TIFF files', 'inspect TIFF metadata', 'preview TIFF images', 'compress TIFF files', or 'write OME-TIFF files'.
homepage: https://github.com/cgohlke/tifffile
---



# tifffile

## Overview

Tifffile is a specialized library designed for high-performance handling of Tagged Image File Format (TIFF) data, particularly in scientific, medical, and bioimaging contexts. It provides the ability to store large NumPy arrays in TIFF files and extract image data and metadata from a wide variety of TIFF-based formats that standard image libraries often cannot handle. Use this skill to manage high-bit depth images, multi-page volumetric data, and pyramidal datasets that exceed the 4GB limit (BigTIFF).

## Core Usage Patterns

### Python API

The most common way to interact with tifffile is through its Python interface.

*   **Basic Reading**: Use `imread` to load a TIFF file directly into a NumPy array.
    ```python
    import tifffile
    image = tifffile.imread('image.tif')
    ```
*   **Basic Writing**: Use `imwrite` to save a NumPy array as a TIFF.
    ```python
    import numpy as np
    data = np.random.randint(0, 255, (256, 256), 'uint8')
    tifffile.imwrite('output.tif', data)
    ```
*   **Handling Large Files (BigTIFF)**: When writing files likely to exceed 4GB, explicitly enable BigTIFF.
    ```python
    tifffile.imwrite('large.tif', data, bigtiff=True)
    ```
*   **Advanced Inspection**: Use the `TiffFile` class to access metadata and individual pages without loading the entire image into memory.
    ```with tifffile.TiffFile('image.tif') as tif:
        for page in tif.pages:
            shape = page.shape
            dtype = page.dtype
            metadata = page.tags
    ```

### Command Line Interface

Tifffile provides a CLI for quick inspection and previewing of files.

*   **Inspect Metadata**: View the structure and tags of a TIFF file.
    ```bash
    python -m tifffile --info image.tif
    ```
*   **Preview**: Open a brief preview of the image data.
    ```bash
    python -m tifffile --preview image.tif
    ```

## Expert Tips and Best Practices

*   **Compression**: To use compression (LZW, JPEG, Zstd, etc.), ensure the `imagecodecs` package is installed. Specify compression in `imwrite` using the `compression` argument.
*   **OME-TIFF**: When working with bioimaging data, use the `ome=True` flag in `imwrite` to write OME-XML metadata, making the file compatible with software like Bio-Formats and ImageJ.
*   **Memory Mapping**: For extremely large files that do not fit in RAM, use `imread(..., out='memmap')` to access the data on disk.
*   **Performance**: When writing multi-page TIFFs, using a `TiffWriter` object is more efficient than calling `imwrite` repeatedly.
    ```python
    with tifffile.TiffWriter('volume.tif') as tif:
        for frame in frames:
            tif.write(frame)
    ```
*   **Data Types**: Tifffile supports a wide range of bit depths (8, 16, 32, 64-bit) and floating-point formats. Ensure your NumPy array `dtype` matches your precision requirements before saving.

## Reference documentation

- [Tifffile README](./references/github_com_cgohlke_tifffile.md)