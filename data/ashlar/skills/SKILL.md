---
name: ashlar
description: Ashlar (Alignment by Simultaneous Harmonization of Layer/Adjacency Registration) is a specialized tool for handling high-resolution microscopy data.
homepage: https://github.com/sorgerlab/ashlar
---

# ashlar

## Overview
Ashlar (Alignment by Simultaneous Harmonization of Layer/Adjacency Registration) is a specialized tool for handling high-resolution microscopy data. Unlike general image editors, it focuses on the precise spatial alignment of individual image "tiles" into a seamless mosaic. It is particularly powerful for cyclic imaging workflows where the same sample is imaged multiple times with different markers; Ashlar ensures that these layers are perfectly aligned across cycles. It requires raw, unstitched tiles as input and produces high-performance OME-TIFF files suitable for downstream analysis.

## Installation
Ashlar can be installed via pip or conda:
- **Pip**: `pip install ashlar`
- **Conda**: `conda install -c bioconda ashlar`

## Common CLI Patterns

### Basic Single-Cycle Stitching
To stitch a single round of microscopy tiles into a pyramidal OME-TIFF:
```bash
ashlar -o stitched_output.ome.tif input_tiles.tif
```

### Multi-Cycle Registration
To align multiple rounds of imaging (e.g., Cycle 1, Cycle 2, and Cycle 3) using the first cycle as the spatial reference:
```bash
ashlar -o registered_output.ome.tif cycle1.tif cycle2.tif cycle3.tif
```

### Specifying Alignment Channels
By default, Ashlar uses channel 0 for alignment. If your nuclear stain (e.g., DAPI) is in a different channel, specify it with `-c`:
```bash
ashlar -c 1 -o output.ome.tif cycle1.tif cycle2.tif
```

### Illumination Correction
Apply flat-field (FFP) or dark-field (DFP) profiles to correct for uneven lighting across tiles:
```bash
ashlar --ffp ffp_profile.tif --dfp dfp_profile.tif -o corrected.ome.tif input.tif
```

### Outputting Individual TIFFs
If you do not want a single OME-TIFF, you can output a series of plain TIFF files using placeholders:
```bash
ashlar -o output_dir/cycle{cycle}_channel{channel}.tif input.tif
```

## Expert Tips and Best Practices

- **Input Requirements**: Ashlar is not designed for images that have already been stitched by microscope software. It requires the original, individual tile images to calculate overlaps and alignment.
- **Maximum Shift**: If your microscope stage has significant jitter or positioning errors, increase the `--maximum-shift` (default is 15 microns) to allow Ashlar to search a wider area for tile overlaps.
- **Memory Management**: For extremely large datasets, Ashlar's OME-TIFF output is preferred because it is "pyramidal," meaning it stores multiple resolutions of the image for fast viewing in software like QuPath or napari.
- **Plate Mode**: When working with High-Throughput Screening (HTS) data from multi-well plates, use the `--plates` flag to enable specific handling for plate-based metadata.
- **Filter Sigma**: If your images are noisy, use `--filter-sigma` (e.g., `--filter-sigma 1.5`) to apply a Gaussian blur before alignment, which can improve the robustness of the registration.

## Reference documentation
- [ASHLAR: Alignment by Simultaneous Harmonization of Layer/Adjacency Registration](./references/github_com_labsyspharm_ashlar.md)
- [ashlar - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_ashlar_overview.md)