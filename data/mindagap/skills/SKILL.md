---
name: mindagap
description: "MindaGap repairs tiled panorama images by filling grid gaps and identifying duplicate data points in overlapping regions. Use when user asks to fill empty grid lines in microscopy images, create RGB composites from grayscale channels, or find duplicate reads in coordinate-based datasets."
homepage: https://github.com/ViriatoII/MindaGap
---

# mindagap

## Overview

MindaGap is a specialized toolkit designed to repair and refine tiled panorama images, particularly those generated in high-resolution microscopy and spatial biology. Its primary function is to fill the "gaps" or empty grid lines that often appear between adjacent image tiles by calculating neighbor-weighted values using Gaussian kernels. Beyond image restoration, the tool provides utilities to merge processed single-channel images into RGB composites and an experimental feature to detect and flag duplicate data points (reads) that occur due to tile overlap in coordinate-based datasets.

## Command Line Usage

### 1. Filling Grid Gaps (mindagap.py)
The core script fills empty grid lines (pixels with value 0) in a panorama.

```bash
python mindagap.py INPUT_PANORAMA.tif [BOXSIZE] [LOOPNUM] --edges [True/False]
```

**Parameters:**
- `BOXSIZE` (Default: 3 or 5): The size of the Gaussian kernel. Use larger values for wider gaps, though this may reduce fine detail. Must be an uneven number.
- `LOOPNUM` (Default: 40): The number of iterations. Higher numbers produce smoother results but take longer to process.
- `--edges` (Default: 0/False): When enabled, it blurs the area around the grid to smooth transitions between tiles with different exposures.

### 2. Creating RGB Composites (rgb_from_z_tiles.py)
Combine processed grayscale channels into a single color image.

```bash
python rgb_from_z_tiles.py -b DAPI.tiff -r red_channel.tiff -g green_channel.tiff
```

### 3. Finding Duplicate Reads (duplicate_finder.py)
Identify transcripts that were recorded twice in overlapping tile regions.

```bash
python duplicate_finder.py XYZ_coordinates.csv [Xtilesize] [Ytilesize] [windowsize] [maxfreq] [minMode] -p [True/False]
```

**Parameters:**
- `Xtilesize/Ytilesize`: The distance between gridlines (e.g., 2144 pixels).
- `windowsize`: The search area around the gridline (default 30 pixels).
- `maxfreq`: Threshold to ignore highly common genes when calculating shifts.
- `-p`: Set to True to generate an illustrative plot of duplicated pairs.

## Best Practices and Expert Tips

- **Iterative Refinement**: For small gaps, it is better to use a small `BOXSIZE` (e.g., 3) combined with a high `LOOPNUM` (40+) rather than a large box size. This preserves the biological detail of the surrounding pixels.
- **Handling Exposure Differences**: If your tiles have inconsistent brightness, use the `--edges True` flag. This applies a median blur to the transition zones in the final loops to minimize visible "seams."
- **Memory Management**: MindaGap sets `OPENCV_IO_MAX_IMAGE_PIXELS` to a very high value ($2^{40}$) to accommodate massive panoramas. Ensure your environment has sufficient RAM when processing large TIF files.
- **Coordinate Cleaning**: When using `duplicate_finder.py`, the tool identifies the most common XYZ shift between tiles. It is most effective when you exclude extremely high-frequency genes (via `maxfreq`) that might create noise in the shift calculation.
- **File Formats**: While the tool supports PNG and JPG, it is optimized for TIFF (`.tif` or `.tiff`) to maintain the bit depth required for scientific imaging.



## Subcommands

| Command | Description |
|---------|-------------|
| duplicate_finder.py | Takes a single XYZ_coordinates.txt file and searches for duplicates along grid happening at every 2144 pixels |
| mindagap.py | Takes a single panorama image and fills the empty grid lines with neighbour-weighted values |
| rgb_from_z_tiles.py | Reads 3 3D tif files, extracts desired z layer and creates 3-channel RGB tiff image |

## Reference documentation
- [MindaGap Main Repository](./references/github_com_ViriatoII_MindaGap.md)
- [MindaGap Core Script Documentation](./references/github_com_ViriatoII_MindaGap_blob_main_mindagap.py.md)
- [Duplicate Finder Documentation](./references/github_com_ViriatoII_MindaGap_blob_main_duplicate_finder.py.md)