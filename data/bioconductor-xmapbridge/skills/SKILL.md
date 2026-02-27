---
name: bioconductor-xmapbridge
description: The bioconductor-xmapbridge package enables the visualization of numeric genomic data as interactive tracks in the X:Map genome browser. Use when user asks to plot genomic data in X:Map, create interactive genome browser tracks from R, or visualize sequencing depths and array intensities across genomic coordinates.
homepage: https://bioconductor.org/packages/release/bioc/html/xmapbridge.html
---


# bioconductor-xmapbridge

## Overview

The `xmapbridge` package acts as a bridge between R and the X:Map genome browser. It allows you to plot numeric genomic data (like exon array intensities or sequencing depths) and view them as interactive, scrollable tracks in a web browser. It works by writing data to a local cache directory monitored by a standalone Java application (XMapBridge), which then serves the plots to the X:Map website via the Google Maps API.

## Core Workflow

### 1. Initialization and Setup
By default, the package uses `~/.xmb_cache`. If this doesn't exist, the first plot command will prompt to create it.

```r
library(xmapbridge)
# Optional: Set a custom cache path via environment variable
# Sys.setenv(XMAP_BRIDGE_CACHE = "/path/to/cache")
```

### 2. Simple Plotting
Use `xmap.plot` to create a new project and a new graph in one step. You must specify the genomic coordinates and species.

```r
# Basic line plot on Human Chromosome 1
xmap.plot(x = positions, 
          y = values, 
          chr = "1", 
          species = "homo_sapiens", 
          type = "line", 
          col = "#ff000066")
```

**Supported Plot Types:**
- `scatter`: Standard points.
- `line`: Connected lines.
- `bar`: Vertical bars.
- `step`: Step function.
- `area`: Shaded area from the x-axis.
- `steparea`: Shaded step function.

### 3. Adding Multiple Tracks
To overlay multiple datasets on the same graph, use `xmap.points` after an initial `xmap.plot` call.

```r
# Initial plot (Area)
xmap.plot(x, y1, chr="1", species="homo_sapiens", type="area", col="#ff000033")

# Add second track (Line) to the same graph
xmap.points(x, y2, type="line", col="#0000ffff")
```

### 4. Fine-Grained Project Management
For complex visualizations with multiple genes or projects, use the explicit constructor functions:

```r
# 1. Create a Project
pid <- xmap.project.new("My Experiment")

# 2. Create a Graph within that Project
gid <- xmap.graph.new(projectid = pid, 
                      name = "Gene_A", 
                      chr = "1", 
                      start = 1000, 
                      stop = 5000, 
                      species = "homo_sapiens")

# 3. Add Plots to that Graph
xmap.points(graphid = gid, x = x_data, y = y_data, type = "area", col = "#00ff0055")
```

## Color and Transparency
Colors are defined using 8-digit hex strings: `#RRGGBBAA` (where AA is alpha/transparency).
- `00` is fully transparent.
- `FF` is fully opaque.

The helper function `xmap.col` can be used to apply alpha values to existing color vectors:
```r
library(RColorBrewer)
cols <- brewer.pal(5, "Reds")
transparent_cols <- xmap.col(cols, alpha = 0x55)
```

## Tips and Troubleshooting
- **XMapBridge App:** The Java application must be running on your local machine for the browser to see the data.
- **Refresh Rate:** The Java app scans the cache every few seconds. It may take up to 30 seconds for new graphs to appear in the X:Map "Connect" dropdown menu.
- **Coordinates:** Ensure `x` values are genomic base-pair positions.
- **Species Names:** Use standard Ensembl-style names (e.g., "homo_sapiens", "mus_musculus").

## Reference documentation
- [xmapbridge: Graphically Displaying Numeric Data in the X:Map Genome Browser](./references/xmapbridge.md)