---
name: ovrlpy
description: ovrlpy is a specialized Python-based quality control tool designed for spatial biology.
homepage: https://github.com/HiDiHlabs/ovrl.py
---

# ovrlpy

## Overview

ovrlpy is a specialized Python-based quality control tool designed for spatial biology. Because microscopic tissue slices are 3D structures often interpreted as 2D representations, artifacts can occur where biological structures overlap in the thin vertical dimension (Z-axis). ovrlpy identifies these inconsistencies by producing "signal integrity maps" and detecting individual overlap events (doublets), allowing analysts to validate the vertical signal properties of their transcriptomics data.

## Installation

Install the package via PyPI or Bioconda:

```bash
# Using pip
pip install ovrlpy

# Using conda
conda install bioconda::ovrlpy
```

## Core Workflow

### 1. Data Preparation
The input must be a pandas DataFrame containing at least the following columns: `gene`, `x`, `y`, and `z`.

```python
import pandas as pd
import ovrlpy

coordinate_df = pd.read_csv('coordinates.csv')
```

### 2. Model Initialization and Analysis
Initialize the `Ovrlp` object. Key parameters include `n_components` (for PCA) and `n_workers` (for parallel processing).

```python
# Initialize the model
dataset = ovrlpy.Ovrlp(
    coordinate_df, 
    n_components=20, 
    n_workers=4
)

# Run the analysis pipeline
dataset.analyse()
```

### 3. Quality Control Visualization
Generate maps to visualize the spatial distribution of signal integrity.

```python
# Plot pseudocells to verify segmentation/binning
fig_cells = ovrlpy.plot_pseudocells(dataset)

# Plot the signal integrity map
# signal_threshold defines the sensitivity for inconsistency detection
fig_integrity = ovrlpy.plot_signal_integrity(dataset, signal_threshold=4)
```

### 4. Doublet Detection and ROI Inspection
Identify specific overlap events and inspect them at the molecular level.

```python
# Detect individual doublet events
doublets = dataset.detect_doublets(min_signal=4, integrity_sigma=1)

# Visualize a specific region of interest (ROI) around a doublet
# window_size determines the micron area around the coordinates
doublet_idx = 0
x, y = doublets["x", "y"].row(doublet_idx)
fig_roi = ovrlpy.plot_region_of_interest(dataset, x, y, window_size=50)
```

## Best Practices and Expert Tips

- **Component Selection**: The `n_components` parameter (default 20) should be adjusted based on the complexity of your gene panel. For very small panels, fewer components may be sufficient; for large panels (>500 genes), consider increasing this value if the integrity maps appear noisy.
- **Signal Thresholding**: When running `plot_signal_integrity` or `detect_doublets`, the `signal_threshold` (or `min_signal`) is critical. A value of 4 is a standard starting point, but you should calibrate this by inspecting a few ROIs to ensure you aren't capturing background noise or missing genuine overlaps.
- **Performance**: Always utilize the `n_workers` parameter to match your system's CPU core count, as the vertical signal analysis is computationally intensive for high-resolution datasets like Xenium.
- **Z-Coordinate Importance**: Ensure your Z-coordinates are properly scaled relative to X and Y. Inconsistent scaling in the Z-dimension can lead to false positives in the signal integrity map.

## Reference documentation
- [ovrlpy Overview](./references/anaconda_org_channels_bioconda_packages_ovrlpy_overview.md)
- [ovrlpy GitHub Repository](./references/github_com_HiDiHlabs_ovrl.py.md)