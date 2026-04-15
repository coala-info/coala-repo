---
name: bioconductor-scale4c
description: This tool performs scale-space transformation and visualization of 4C-seq data to identify stable genomic features across multiple smoothing scales. Use when user asks to identify peaks and valleys in 4C-seq data, generate fingerprint maps, track singularities, or produce 2D tessellation maps for qualitative signal analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/Scale4C.html
---

# bioconductor-scale4c

name: bioconductor-scale4c
description: Scale-space transformation and visualization of 4C-seq data using Witkin's scale-space filtering. Use this skill to identify stable genomic features (peaks and valleys) across multiple smoothing scales (sigma), generate fingerprint maps, track singularities, and produce 2D tessellation maps for qualitative 4C-seq signal analysis.

# bioconductor-scale4c

## Overview
Scale4C applies scale-space filtering to 4C-seq data to describe signals qualitatively. By smoothing the signal with Gauss kernels of increasing $\sigma$, the package tracks inflection points to create a "fingerprint map." It identifies "singularities" (points where features appear or disappear) to build a ternary tree structure representing the hierarchy of peaks and valleys. This allows for the identification of genomic interactions that are robust across different levels of data smoothing.

## Typical Workflow

### 1. Data Import and Initialization
Scale4C requires a `GRanges` object containing "reads" and "meanPosition" metadata columns.

```R
library(Scale4C)

# Import from Basic4Cseq output or custom CSV
csvFile <- "path/to/fragment_data.csv"
liverReads <- importBasic4CseqData(csvFile, viewpoint = 21160072, 
                                   viewpointChromosome = "chr10", distance = 1000000)

# Initialize Scale4C object
liverData <- Scale4C(rawData = liverReads, viewpoint = 21160072, viewpointChromosome = "chr10")

# Optional: Add Points of Interest (POI) for orientation
poiFile <- "path/to/vp.txt"
pointsOfInterest(liverData) <- addPointsOfInterest(liverData, read.csv(poiFile, sep = "\t"))
```

### 2. Scale-Space Transformation
The transformation involves calculating the fingerprint map and identifying singularities.

```R
# 1. Calculate Scale Space and Fingerprint Map
# maxSQSigma defines the maximum smoothing (sigma squared)
liverData <- calculateFingerprintMap(liverData, maxSQSigma = 2000)

# 2. Find Singularities
# guessViewpoint=TRUE can help if the maxSQSigma is low
singularities(liverData) <- findSingularities(liverData, 1, guessViewpoint = FALSE)
```

### 3. Manual Correction of Singularities
Automated tracking may occasionally fail at high $\sigma$ or near the viewpoint. You can manually inspect and correct the `singularities` slot (a `GRanges` object).

```R
# Inspect singularities
tail(singularities(liverData))

# Example: Manually add a missing viewpoint singularity
newVP <- GRanges("chr10", IRanges(39, 42), "*", 
                 sqsigma = 2000, left = 40, right = 41, type = "peak")
singularities(liverData) <- c(singularities(liverData), newVP)
```

### 4. Visualization and Export
The final step is visualizing the tessellation and exporting the identified features.

```R
# Plot the 2D tessellation map
plotTesselation(liverData, fileName = "tessellation_plot.pdf")

# Plot a specific 'slice' of smoothing (e.g., sigma = 2)
plotInflectionPoints(liverData, 2, plotIP = TRUE)

# Export the scale-space tree as a GRanges object
peaks <- outputScaleSpaceTree(liverData, outputPeaks = TRUE, useLog = FALSE)
```

## Key Functions
- `calculateFingerprintMap`: Computes inflection points across the scale space.
- `findSingularities`: Identifies and tracks the points where features merge or split.
- `plotTesselation`: Generates the 2D map of peaks (brown) and valleys (blue).
- `plotTraceback`: Visualizes the fingerprint map and the tracking of singularities.
- `outputScaleSpaceTree`: Converts the hierarchical results into a tabular format or `GRanges`.

## Tips for Success
- **Sigma Selection**: If the viewpoint contours do not meet, increase `maxSQSigma` or use `guessViewpoint = TRUE` in `findSingularities`.
- **Quality Control**: Use `plotTraceback` to ensure singularities are correctly located on the top of inflection point curves.
- **Feature Stability**: Look for peaks that persist over a wide range of $\sigma$ values in the tessellation plot; these represent the most robust structural features in the 4C-seq data.

## Reference documentation
- [Scale4C: an R/Bioconductor package for scale-space transformation of 4C-seq data](./references/vignette.md)