---
name: cenplot
description: CenPlot is a specialized tool for the high-resolution visualization of centromeric regions and complex repetitive structures. Use when user asks to visualize Higher-Order Repeats, identify centromeric dip regions, or generate multi-track genomic figures of centromeres.
homepage: https://github.com/logsdon-lab/CenPlot
metadata:
  docker_image: "quay.io/biocontainers/cenplot:0.1.6--pyhdfd78af_0"
---

# cenplot

## Overview

CenPlot is a specialized Python library and command-line tool designed for the high-resolution visualization of centromeric regions. It excels at rendering complex repetitive structures, such as Higher-Order Repeats (HORs), and identifying centromeric dip regions (CDRs). This skill provides guidance on using the `cenplot` CLI to automate the generation of multi-track genomic figures where spatial relationships and repeat identities are critical.

## Installation

Install CenPlot via Bioconda or PyPI:

```bash
# Via Conda
conda install bioconda::cenplot

# Via Pip
pip install cenplot
```

## CLI Usage Patterns

The primary entry point for the command line is `cenplot draw`.

### Basic Plot Generation
To generate a figure, you must provide a track layout file and a specific genomic region.

```bash
cenplot draw \
  -t tracks.toml \
  -c "chm13_chr10:38568472-42561808" \
  -o "plots/centromere_plot.png"
```

### Key Arguments
- `-t, --tracks`: Path to the TOML file defining the track layout and data sources.
- `-c, --chrom`: The genomic coordinates in `chrom:start-end` format.
- `-p, --processes`: Number of threads to use for parallel processing (e.g., `-p 4`).
- `-d, --outdir`: Directory where intermediate or multiple plot files will be saved.
- `-o, --output`: Specific path for the final merged image.

## Expert Tips and Best Practices

- **Region Subsetting**: When working with large centromeric arrays, use the `-c` flag to zoom into specific regions of interest to maintain visual clarity in HOR tracks.
- **Parallelization**: For complex plots with many tracks or high-density identity data, always specify `-p` to significantly reduce rendering time.
- **Track Layouts**: CenPlot relies on TOML files to define tracks. Ensure your data files (BED, BEDPE, etc.) are indexed or formatted correctly as expected by the library's readers.
- **Identity Plots**: When generating self-identity triangles, ensure your plot height allows for a right isosceles triangle for the most accurate spatial representation.
- **Legend Management**: Use the latest version features to aggregate axis legend elements if your plot contains multiple tracks of the same type to avoid clutter.

## Python API Quickstart

For deeper integration into bioinformatics pipelines, use the Python API:

```python
from cenplot import plot_tracks, read_tracks

chrom = "chm13_chr10:38568472-42561808"
# Load layout and settings
track_list, settings = read_tracks("tracks.toml", chrom=chrom)
# Generate the figure
fig, axes, _ = plot_tracks(track_list.tracks, settings)
```

## Reference documentation
- [CenPlot GitHub Repository](./references/github_com_logsdon-lab_CenPlot.md)
- [Bioconda CenPlot Overview](./references/anaconda_org_channels_bioconda_packages_cenplot_overview.md)