---
name: mindagap
description: MindaGap is a specialized image processing utility designed to rectify artifacts in tiled panoramas.
homepage: https://github.com/ViriatoII/MindaGap
---

# mindagap

## Overview

MindaGap is a specialized image processing utility designed to rectify artifacts in tiled panoramas. When multiple image tiles are stitched together to form a single large image, empty grid lines or gaps often appear at the junctions. This tool uses a neighbor-weighted averaging algorithm to fill these gaps intelligently, ensuring visual continuity. It is particularly useful in bioinformatics and high-resolution imaging workflows where data integrity across tile boundaries is critical for downstream analysis.

## Command Line Usage

### Core Gap Filling
The primary script `mindagap.py` fills empty grid lines using the mean of the immediate neighborhood.

```bash
python mindagap.py INPUT_PANORAMA.tif [BOXSIZE] [LOOPNUM] [--edges True/False]
```

**Parameters:**
- **BOXSIZE** (Default: 3): Determines the search area for neighbors. Increase this value to overcome larger gaps, though higher values may result in a loss of fine detail in the newly filled areas.
- **LOOPNUM** (Default: 40): The number of iterations. Higher numbers yield better results but increase processing time. Small box sizes work best with high loop numbers.
- **--edges** (Default: False): An experimental parameter that applies a blur to the area around the grid to smooth transitions between tiles with different exposures.

### Creating RGB Composites
Use `rgb_from_z_tiles.py` to combine gap-filled grayscale images into a single multi-channel RGB panorama.

```bash
python rgb_from_z_tiles.py -b DAPI.tiff -r red_channel.tiff -g green_channel.tiff
```

### Marking Duplicate Reads
For spatial transcriptomics or similar workflows, `duplicate_finder.py` identifies duplicate reads occurring along gridline edges.

```bash
python duplicate_finder.py XYZ_coordinates.csv [Xtilesize] [Ytilesize] [windowsize] [maxfreq] [minMode] [-p True/False]
```

## Best Practices and Expert Tips

- **Balancing Detail and Gap Size**: If you have very thin gaps (1-2 pixels), stick to the default `BOXSIZE` of 3 but consider increasing `LOOPNUM` to 60 or 80 for maximum smoothness.
- **Handling Large Gaps**: For significant gaps, increment `BOXSIZE` slowly (e.g., to 5 or 7). If the filled area looks "smudged," reduce the box size and increase the loop count instead.
- **Exposure Correction**: If tiles have noticeably different brightness levels, enable `--edges True` to minimize the "patchwork" effect at the boundaries.
- **Performance**: Processing very large TIFF files is memory-intensive. Ensure your environment has sufficient RAM, or use the Docker implementation to manage dependencies like `tifffile` and `opencv-python` consistently.

## Reference documentation
- [MindaGap GitHub Repository](./references/github_com_ViriatoII_MindaGap.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_mindagap_overview.md)