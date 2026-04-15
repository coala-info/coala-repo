---
name: bioconductor-hilbertvis
description: This tool visualizes long genomic data vectors by mapping them onto 2D Hilbert space-filling curves to preserve local structures. Use when user asks to transform 1D sequence data into 2D images, visualize large datasets like ChIP-Seq or wiggle tracks, or identify spatial inhomogeneities in genomic data.
homepage: https://bioconductor.org/packages/release/bioc/html/HilbertVis.html
---

# bioconductor-hilbertvis

name: bioconductor-hilbertvis
description: Visualizing extremely long data vectors (e.g., genomic data, ChIP-Seq, wiggle tracks) using Hilbert space-filling curves. Use this skill to transform 1D sequence data into 2D images that preserve locality, allowing for the inspection of global structures and local features in datasets with millions of entries.

## Overview

HilbertVis provides a method to visualize long data vectors by folding them into a 2D square using a Hilbert curve. This approach is superior to standard 1D plots for very large datasets because it utilizes both horizontal and vertical space, ensuring that neighboring parts of the data vector remain close to each other in the 2D representation. It is particularly useful for identifying spatial inhomogeneities, peak distributions, and comparing multiple genomic tracks.

## Core Workflow

### 1. Data Preparation
The package works with long numeric vectors or `Rle` (Run-Length Encoding) objects from the `IRanges` package.

```r
library(HilbertVis)

# Example: Generate random test data (10 million entries)
vec <- makeRandomTestData()

# For genomic data, use makeWiggleVector to read GFF or Wiggle files
# vec <- makeWiggleVector(file, chromosome, start, end)
```

### 2. Generating the Hilbert Image
The `hilbertImage` function transforms the 1D vector into a 2D matrix.

```r
# Generate a 512x512 matrix (level 9 is default: 2^9 x 2^9)
hMat <- hilbertImage(vec)

# Adjust level for higher/lower resolution (e.g., level 10 = 1024x1024)
hMat_high_res <- hilbertImage(vec, level = 10)
```

### 3. Visualization
Use `showHilbertImage` to display the resulting matrix with appropriate color scales.

```r
# Standard lattice-based plot
showHilbertImage(hMat)

# Using EBImage for pixel-perfect display (requires EBImage package)
# showHilbertImage(hMat, mode = "EBImage")
```

## Interactive Exploration (HilbertVisGUI)

If the `HilbertVisGUI` package is available, you can explore the data interactively. This allows for zooming and real-time coordinate tracking.

```r
library(HilbertVisGUI)

# Single vector exploration
hilbertDisplay(vec)

# Comparing two vectors (use 'Next'/'Previous' buttons in GUI)
hilbertDisplay(vec1, vec2)

# Three-channel overlay (RGB)
# Data must be normalized between 0 and 1
hilbertDisplayThreeChannel(vec1/max(vec1), vec2/max(vec1), rep(0, length(vec1)))
```

## Key Functions

- `plotLongVector(vec)`: A faster alternative to `plot(vec, type="h")` for long vectors.
- `hilbertImage(vec, level=9)`: Creates the matrix representation.
- `showHilbertImage(mat)`: Displays the Hilbert curve plot.
- `makeWiggleVector(file, ...)`: Helper to import genomic wiggle/GFF data into a compatible vector format.
- `hilbertDisplay(vec)`: Launches the interactive GTK+ viewer (requires HilbertVisGUI).

## Tips for Interpretation
- **Small dots/features**: Represent individual peaks. The area of the feature corresponds to the width of the peak in the 1D vector.
- **Color intensity**: Represents the maximum value (height) within the bin represented by that pixel.
- **Spatial clusters**: Large-scale patterns or color shifts indicate regions of the sequence with different statistical properties (e.g., higher peak density or wider peaks).

## Reference documentation

- [Visualising very long data vectors with the Hilbert curve](./references/HilbertVis.md)