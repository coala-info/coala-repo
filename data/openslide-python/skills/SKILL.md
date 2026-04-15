---
name: openslide-python
description: OpenSlide-python provides an interface for reading and manipulating high-resolution digital pathology images through efficient random access. Use when user asks to open whole-slide images, extract specific regions at different zoom levels, access slide metadata, or generate Deep Zoom tiles for analysis.
homepage: http://openslide.org/
metadata:
  docker_image: "quay.io/biocontainers/openslide-python:1.1.1--py36h470a237_0"
---

# openslide-python

## Overview
The `openslide-python` skill provides the procedural knowledge required to handle massive digital pathology images that exceed standard RAM capacities. It allows for efficient, random-access reading of "virtual slides" by leveraging the underlying C library. This skill is essential for tasks involving medical imaging analysis, where only specific regions of interest or specific resolution levels (pyramids) need to be processed without loading the entire multi-gigabyte file into memory.

## Core Usage Patterns

### Opening and Inspecting Slides
Always use the `OpenSlide` object to wrap the slide file. This provides access to metadata and the image pyramid structure.

```python
import openslide

# Open a slide (supports .svs, .ndpi, .mrxs, .czi, .scn, etc.)
slide = openslide.OpenSlide('path/to/slide.svs')

# Access basic properties
dimensions = slide.dimensions  # (width, height) at level 0
level_count = slide.level_count
level_dimensions = slide.level_dimensions # List of (w, h) for each level
level_downsamples = slide.level_downsamples # Rescale factors relative to level 0
```

### Extracting Regions (Cropping)
The `read_region` method is the primary way to get pixel data. 
**Note**: The `location` parameter is always in **Level 0 (baseline) coordinates**, regardless of which level you are reading from.

```python
# Parameters: (x_coord_level0, y_coord_level0), level, (width, height)
# Returns an RGBA PIL Image
tile = slide.read_region((5000, 5000), 2, (256, 256))
tile.show()
```

### Handling Metadata and Properties
Vendor-specific metadata (e.g., objective power, microns per pixel) is stored in the `.properties` dictionary.

```python
# Get all properties
for key, value in slide.properties.items():
    print(f"{key}: {value}")

# Common property: Microns per pixel (MPP)
mpp_x = slide.properties.get(openslide.PROPERTY_NAME_MPP_X)
```

### Deep Zoom Generation
For web-based viewing or tiling for deep learning, use the `DeepZoomGenerator`.

```python
from openslide.deepzoom import DeepZoomGenerator

# Create generator
dz = DeepZoomGenerator(slide, tile_size=254, overlap=1, limit_bounds=False)

# Get total number of levels in the Deep Zoom pyramid
dz_levels = dz.level_count

# Get a specific tile (level, (column, row))
tile_image = dz.get_tile(dz_levels - 1, (0, 0))
```

## Best Practices
- **Coordinate Systems**: Always double-check that your `(x, y)` coordinates for `read_region` are scaled to the highest resolution (Level 0). If you find a coordinate at Level 2, multiply it by `slide.level_downsamples[2]` before passing it to `read_region`.
- **Memory Management**: Do not attempt to convert the entire slide to a single PIL image using `slide.get_thumbnail()` with a very large size, as this will cause memory exhaustion.
- **RGBA to RGB**: OpenSlide returns images in ARGB/RGBA format. If your downstream model requires RGB, convert the PIL image: `img = tile.convert("RGB")`.
- **Closing Files**: While the garbage collector usually handles it, explicitly call `slide.close()` in long-running scripts or loops to free system handles.

## Reference documentation
- [OpenSlide Python API](./references/openslide_org_index.md)
- [Supported Virtual Slide Formats](./references/openslide_org_index.md)