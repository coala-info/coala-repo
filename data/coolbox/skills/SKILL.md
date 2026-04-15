---
name: coolbox
description: CoolBox is a modular toolkit for creating and exploring multi-omics genomic visualizations using a grammar of graphics approach. Use when user asks to visualize genomic tracks, create Hi-C interaction plots, or interactively browse multi-omics data in Jupyter environments.
homepage: https://github.com/GangCaoLab/CoolBox
metadata:
  docker_image: "quay.io/biocontainers/coolbox:0.4.0--pyhdfd78af_0"
---

# coolbox

## Overview
CoolBox is a modular toolkit designed for the visual analysis of genomics data. It bridges the gap between static plotting and interactive exploration by providing a Python-based Embedded Domain Specific Language (EDSL) that follows a "grammar of graphics" approach similar to ggplot2. Users can compose complex multi-omics visualizations by layering different genomic tracks. While it excels in Jupyter environments for interactive browsing, it also provides a command-line interface for automated visualization workflows.

## Installation
Install the toolkit via Bioconda:
```bash
conda install -c bioconda coolbox
```

## Core Python API Patterns
CoolBox uses a declarative syntax where tracks are combined using the `+` operator.

### Basic Visualization Workflow
1. **Import the API**: `from coolbox.api import *`
2. **Define Tracks**: Initialize track objects with your data files (BigWig, BED, Cool, etc.).
3. **Compose Frame**: Combine tracks using `+`.
4. **Render**: Use `.plot()` for static images or `.show()` for interactive Jupyter widgets.

Example pattern:
```python
from coolbox.api import *

# Define tracks
hi_c_track = CoolTrack("data.cool", style="triangle")
genes_track = GTFTrack("genes.gtf")
coverage_track = BigWigTrack("signal.bw")

# Compose and plot a specific region
frame = hi_c_track + genes_track + BigWigTrack("signal.bw")
frame.plot("chr1:10,000,000-11,000,000")
```

## Common Track Types
*   **CoolTrack / HiCTrack**: For Hi-C interaction matrices. Supports "triangle" or "square" styles.
*   **BigWigTrack**: For continuous signal data (e.g., ChIP-seq, RNA-seq coverage).
*   **BedTrack / BedGraphTrack**: For genomic intervals and features.
*   **GTFTrack**: For gene annotations and transcript structures.
*   **TADCoverage**: Specifically for visualizing Topologically Associating Domain boundaries.

## Command Line Interface (CLI)
The CLI allows for quick plotting without writing Python scripts.
*   **Basic Plotting**: Use the `coolbox` command followed by track definitions.
*   **Navigation**: Use the `goto` functionality to jump to specific genomic coordinates.

## Expert Tips and Best Practices
*   **Large Chromosomes**: For chromosomes larger than 512 MB, ensure your Tabix indices use the CSI format rather than TBI to avoid indexing errors.
*   **Performance**: Use the `oxbow` integration (available in newer versions) for faster data fetching from remote or large genomic files.
*   **Interactive Browsing**: In Jupyter, use `frame.show()` to instantiate an interactive browser that allows zooming and panning, rather than re-plotting static frames.
*   **Memory Management**: When working with massive Hi-C files, prefer `.cool` or `.mcool` formats over raw text matrices for significantly better performance.
*   **Coordinate Formatting**: The `Browser.goto()` method and `.plot()` calls accept standard genomic strings (e.g., "chr:start-end"). Ensure commas are removed if passing integers programmatically.

## Reference documentation
- [CoolBox GitHub Repository](./references/github_com_GangCaoLab_CoolBox.md)
- [Bioconda CoolBox Overview](./references/anaconda_org_channels_bioconda_packages_coolbox_overview.md)
- [CoolBox Issues and Troubleshooting](./references/github_com_GangCaoLab_CoolBox_issues.md)