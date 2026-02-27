---
name: bioconductor-pviz
description: Bioconductor-pviz visualizes protein sequences and amino-acid based data using track-based plots. Use when user asks to create genomic-style visualizations for protein data, plot peptide microarray results, or display antibody binding frequencies and protein sequence annotations.
homepage: https://bioconductor.org/packages/release/bioc/html/Pviz.html
---


# bioconductor-pviz

name: bioconductor-pviz
description: Visualization of protein sequences and amino-acid based data using track-based plots. Use when Claude needs to create genomic-style visualizations for protein data, including peptide microarrays, antibody binding frequencies, and protein sequence annotations.

## Overview

Pviz is an R package that extends the Gviz framework to handle amino-acid based data. It removes the requirement for genomic coordinates (chromosomes/genomes) and replaces them with protein positions. It is primarily used for visualizing peptide microarray results, antibody binding events, and protein sequence features.

## Core Workflow

1.  **Load the package**: `library(Pviz)`
2.  **Initialize Tracks**: Create individual track objects (Axis, Sequence, Data, or Probes).
3.  **Visualize**: Use the `plotTracks` function to render the combined tracks.

## Track Types

### ProteinAxisTrack
Acts as the scale for the protein sequence.
- `pat <- ProteinAxisTrack(addNC = TRUE, littleTicks = TRUE)`: Displays N-term and C-term indicators and a precise scale.

### ProteinSequenceTrack
Displays the amino acid sequence.
- `st <- ProteinSequenceTrack(sequence = "MVL...", name = "Protein")`
- Note: At wide zoom levels, the sequence automatically simplifies to color blocks or a line to prevent overplotting.

### ATrack and DTrack
Extensions of Gviz's `AnnotationTrack` and `DataTrack`.
- `at <- ATrack(start, end, id, name = "Annotations")`: For discrete features.
- `dt <- DTrack(data, start, width, name = "Frequency", type = "l")`: For continuous data like binding intensity.

### ProbeTrack
Specifically designed for peptide microarray data. It draws rectangles for each peptide, colored by intensity or frequency.
- `pt <- ProbeTrack(sequence, intensity, probeStart)`
- Use `legend = TRUE` in the constructor or `plotTracks` to show the intensity scale.

### CladeTrack
Used to compare binding activity across different groups or clades.
- `ct <- CladeTrack(restab, clade = "A", type = "l")`

## Plotting and Customization

The primary plotting function is `plotTracks`. It accepts a list of tracks and coordinate ranges.

```r
plotTracks(trackList = c(pat, st, pt), from = 1, to = 100, main = "Protein Plot")
```

### Summary Plotting Functions
Pviz provides high-level functions for quick analysis of peptide microarray experiments (often used with `pepStat` results):
- `plot_inter(restab_aggregate)`: Plots the overall results of an experiment.
- `plot_clade(restab, clade = c("A", "B"))`: Performs clade-specific analysis and plotting.

## Tips
- **Gviz Compatibility**: Since Pviz depends on Gviz, you can use standard Gviz `DisplayParameters` (e.g., `cex`, `fontcolor`, `fill`, `background.title`) to customize the look.
- **Coordinate System**: All positions are 1-based amino acid indices.
- **Data Integration**: Pviz works seamlessly with `pepDat` and `pepStat` objects for immunological bioinformatics workflows.

## Reference documentation
- [Pviz](./references/Pviz.md)