---
name: pygenomeviz
description: "pygenomeviz is a Python-based visualization tool for creating comparative genomics maps and synteny plots using Matplotlib. Use when user asks to visualize genomic features, draw synteny links between multiple genomes, or generate publication-quality comparative genomics figures."
homepage: https://github.com/moshi4/pyGenomeViz/
---


# pygenomeviz

## Overview
pygenomeviz is a Python-based visualization tool built on Matplotlib specifically for comparative genomics. It allows for the precise placement of genomic features across multiple tracks and the drawing of sequence similarity links (synteny) between them. Whether used in a Jupyter notebook for interactive analysis or in a script for automated figure generation, it provides a high degree of control over feature styling, labeling, and output formats including PNG, SVG, PDF, and interactive HTML.

## Core Workflow and API Usage

### 1. Basic Feature Visualization
To visualize a single genomic region, initialize the `GenomeViz` object and add a feature track.

```python
from pygenomeviz import GenomeViz

gv = GenomeViz()
# Add a track (name, size in bp)
track = gv.add_feature_track("Target Region", 1000)
track.add_sublabel()

# Add features: start, end, strand (1 or -1)
track.add_feature(50, 200, 1, label="Gene A", fc="blue")
track.add_feature(250, 460, -1, label="Gene B", fc="red")

gv.savefig("genome_plot.png")
```

### 2. Comparative Genomics (Synteny Links)
To compare multiple genomes, add multiple tracks and define links between coordinates.

```python
gv = GenomeViz(track_align_type="center")

# Define tracks
t1 = gv.add_feature_track("Genome 01", 1000)
t2 = gv.add_feature_track("Genome 02", 1200)

# Add features to tracks...

# Add links: (track_name, start, end) for both sides
gv.add_link(("Genome 01", 150, 300), ("Genome 02", 50, 200), color="grey", alpha=0.5)
# Use curve=True for curved links between tracks
gv.add_link(("Genome 01", 700, 900), ("Genome 02", 800, 1000), curve=True)
```

### 3. Advanced Feature Styling
Customize the visual representation of genes using `plotstyle` and `patch_kws`.

*   **Plot Styles**: `arrow` (default), `bigarrow`, `box`, `bigbox`, `rbox` (rounded box), `bigrbox`.
*   **Styling Parameters**:
    *   `fc`: Face color.
    *   `ec`: Edge color.
    *   `lw`: Line width.
    *   `hatch`: Pattern (e.g., `/`, `\`, `|`, `-`, `+`, `x`, `o`).
    *   `arrow_shaft_ratio`: Adjust the thickness of the arrow body (0.0 to 1.0).

### 4. Visualizing Eukaryotic Genes (Exons/Introns)
Use `add_exon_feature` to represent spliced genes.

```python
exon_regions = [(0, 210), (300, 480), (590, 800)]
track.add_exon_feature(exon_regions, strand=1, label="Spliced Gene", plotstyle="bigarrow")
```

## Expert Tips and Best Practices

*   **Alignment**: When comparing genomes of different sizes, use `GenomeViz(track_align_type="center")` or `"left"` to ensure tracks are visually comparable.
*   **Scale Management**: Always include a scale using `gv.set_scale_bar()` or `gv.set_scale_xticks()` to provide physical context for the genomic distances.
*   **Label Positioning**: Use the `text_kws` dictionary within `add_feature` to control label appearance:
    *   `rotation`: Angle of the text.
    *   `vpos`: Vertical position (`top`, `center`, `bottom`).
    *   `hpos`: Horizontal position (`left`, `center`, `right`).
*   **Interactive Exploration**: For quick data inspection without writing code, use the built-in web interface by running `pgv-gui` in your terminal.
*   **High-Resolution Output**: For publications, save figures in vector formats like `.svg` or `.pdf` to maintain quality during scaling.

## Reference documentation
- [pyGenomeViz Main Documentation](./references/github_com_moshi4_pyGenomeViz.md)
- [Installation and Overview](./references/anaconda_org_channels_bioconda_packages_pygenomeviz_overview.md)