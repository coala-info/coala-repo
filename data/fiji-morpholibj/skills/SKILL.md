---
name: fiji-morpholibj
description: MorphoLibJ provides advanced morphological operations and segmentation tools for 2D and 3D image analysis in Fiji. Use when user asks to perform morphological filtering, execute marker-controlled watershed segmentation, or extract quantitative morphometric data from label images.
homepage: http://imagej.net/MorphoLibJ
---


# fiji-morpholibj

## Overview
MorphoLibJ is a specialized library for Fiji/ImageJ that extends standard morphological operations into 3D and adds advanced algorithms like morphological reconstruction and marker-controlled watershed. Use this skill to guide the selection of structuring elements, perform attribute filtering to remove noise without blurring edges, and automate the extraction of quantitative morphometric data from binary or label images.

## Core Workflows and Best Practices

### Morphological Filtering
*   **Structuring Elements (SE):** Choose SE shapes based on the underlying geometry. Use `Squares/Cubes` for grid-aligned data, `Disks/Balls` for isotropic biological structures, and `Linear` elements to detect or enhance directional features.
*   **Grayscale Operations:** Use `Morphological Filters` for basic noise reduction. 
    *   *Opening:* Removes small bright spots (noise).
    *   *Closing:* Fills small dark holes or gaps in bright structures.
*   **Top-Hat Transforms:** Use `White Top-Hat` to extract bright structures smaller than the SE from a non-homogeneous background. Use `Black Top-Hat` for dark structures.

### Morphological Reconstruction
Reconstruction-based filters are superior to standard filters because they preserve the original shape of structures that are not removed.
*   **Hole Filling:** Use `Fill Holes` (reconstruction from the image border) to fill interior cavities in 2D/3D objects without affecting the external boundary.
*   **Border Killing:** Use `Kill Borders` to remove objects touching the image edge, ensuring morphometric statistics are only calculated for complete objects.
*   **Attribute Filtering:** Instead of size-based opening, use `Area Opening` (2D) or `Volume Opening` (3D) to remove objects based on their actual pixel/voxel count while perfectly preserving the contours of remaining objects.

### Watershed Segmentation
*   **Pre-processing:** Always apply a `Morphological Gradient` or `Internal Gradient` to transform intensity images into "basins" for the watershed algorithm.
*   **Marker-Controlled Watershed:** To prevent over-segmentation, use `Regional Minima` or `Extended Minima` as markers. This ensures each biological entity (e.g., a cell nucleus) results in exactly one segment.
*   **Classic Watershed:** Use the `Morphological Segmentation` GUI for interactive adjustment of tolerance levels before committing to a batch processing script.

### 2D/3D Measurements
*   **Label Images:** Ensure images are converted to `Label Images` (where each object has a unique integer ID) before running measurements.
*   **Morphometry:** Use `Analyze > Landini > MorphoLibJ > Analyze Regions` (or similar menu paths) to extract:
    *   *Geometric:* Volume, Surface Area, Sphericity, and Euler Number.
    *   *Intensity:* Mean, Max, and Median intensity per label.
    *   *Orientation:* Inertia Ellipsoid parameters to determine the main axis of elongated structures.

## Scripting and Automation
When scripting MorphoLibJ in Fiji (Jython/Python), use the `inra.ijpb` package.
*   **Importing:** `from inra.ijpb.morphology import Morphology` and `from inra.ijpb.plugins import *`.
*   **Memory Management:** 3D operations are memory-intensive. Prefer `Morphology.reconstruction()` methods over manual iterations for faster performance and lower overhead.

## Reference documentation
- [MorphoLibJ Overview](./references/imagej_net_plugins_morpholibj.md)