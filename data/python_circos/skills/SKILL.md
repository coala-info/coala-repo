---
name: python_circos
description: The `python_circos` (pyCircos) skill enables the programmatic generation of circular plots directly within Python.
homepage: https://github.com/ponnhide/pyCircos
---

# python_circos

## Overview

The `python_circos` (pyCircos) skill enables the programmatic generation of circular plots directly within Python. Unlike the original Circos software which relies on complex configuration files, pyCircos uses a Matplotlib backend and a coordinate system based on an arbitrary 1000-unit diameter. You define genomic segments as "arcs" and then layer data tracks (lines, bars, heatmaps, or chords) onto those arcs by specifying radial ranges.

## Core API Usage

### 1. Initialize the Circle
The `Gcircle` object is the primary container. It defaults to a drawing space with a diameter of 1000 units.

```python
import pycircos
import matplotlib.pyplot as plt

# Initialize circle
circle = pycircos.Gcircle(figsize=(10, 10))
```

### 2. Define and Add Arcs
Arcs (`Garc`) represent the segments of your circle (e.g., chromosomes).

```python
# Create an arc
# arc_id: unique string identifier
# size: length of the segment (e.g., base pairs)
# inter_gap: gap between this arc and the next
# raxis_range: radial position (0-1000)
arc = pycircos.Garc(arc_id="chr1", size=1000000, inter_gap=0.05, raxis_range=(950, 1000))
circle.add_garc(arc)

# Finalize arc layout (required before plotting data)
circle.set_garcs(start=0, end=360)
```

### 3. Adding Data Tracks
Data is plotted relative to a specific `garc_id`. The `raxis_range` parameter determines which "track" the data occupies.

#### Line Plots
```python
circle.lineplot(garc_id="chr1", data=values, positions=bp_positions, 
                raxis_range=(800, 900), linecolor="blue", linewidth=1)
```

#### Fill Plots (Area charts)
```python
circle.fillplot(garc_id="chr1", data=values, raxis_range=(700, 800), 
                base_value=0, facecolor="red", edgecolor="black")
```

#### Chord Plots (Links)
Used to show relationships between different genomic locations.
```python
# source and destination are tuples: (arc_id, start, end)
circle.chordplot(source=("chr1", 100, 200), destination=("chr2", 500, 600), facecolor="green")
```

## Expert Tips and Best Practices

- **Coordinate System**: Always remember the radial axis is 0 (center) to 1000 (outer edge). Plan your tracks by dividing this 1000-unit space (e.g., Track 1: 900-950, Track 2: 800-850).
- **Data Scaling**: Use the `rlim` parameter in plotting methods to manually set the data floor and ceiling. If omitted, it defaults to the min/max of the provided data.
- **Opacity**: For overlapping tracks or dense chord plots, provide colors in RGBA tuples `(r, g, b, a)` or hex strings with alpha `#XXXXXXXX` to manage transparency.
- **Phylogenetic Trees**: For circular trees, use the `Tcircle` and `Tarc` subclasses instead of the standard `Gcircle`/`Garc`.
- **Multiple Plots**: If you need to arrange multiple Circos plots in one figure, initialize `Gcircle` with an existing figure object using the `fig` parameter: `pycircos.Gcircle(fig=my_matplotlib_fig)`.

## Reference documentation
- [github_com_ponnhide_pyCircos.md](./references/github_com_ponnhide_pyCircos.md)
- [anaconda_org_channels_bioconda_packages_python_circos_overview.md](./references/anaconda_org_channels_bioconda_packages_python_circos_overview.md)