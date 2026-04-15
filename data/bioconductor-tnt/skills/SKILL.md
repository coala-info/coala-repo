---
name: bioconductor-tnt
description: The bioconductor-tnt package creates interactive, web-based genomic visualizations directly from Bioconductor objects in R. Use when user asks to visualize genomic data as interactive tracks, create draggable and zoomable genome browsers, or display GRanges and TxDb objects as blocks, lines, and gene models.
homepage: https://bioconductor.org/packages/release/bioc/html/TnT.html
---

# bioconductor-tnt

## Overview

The `TnT` package provides an interactive and flexible approach to visualize genomic data directly in R. It wraps the TnT javascript libraries to create draggable, zoomable, and clickable visualizations (tracks) for common Bioconductor objects. This is particularly useful for exploring genomic features like genes, transcripts, and quantitative data along genomic coordinates without exporting to external genome browsers.

## Core Workflow

The general workflow for using `TnT` involves two main steps:
1. **Construct Tracks**: Convert genomic data (GRanges, TxDb, etc.) into specific track objects.
2. **Display Board**: Combine tracks into a `TnTBoard` or `TnTGenome` for interactive viewing.

### 1. Track Constructors

Choose a constructor based on your data type and desired visualization:

| Constructor | Data Source | Feature Type |
|---|---|---|
| `BlockTrack(gr)` | GRanges | Rectangular blocks |
| `VlineTrack(gr)` | Width-one GRanges | Vertical lines |
| `PinTrack(gr, value)` | Width-one GRanges + values | Pins at specific coordinates |
| `LineTrack(gr, value)` | Width-one GRanges + values | Connected line plot |
| `AreaTrack(gr, value)` | Width-one GRanges + values | Filled area plot |
| `GeneTrackFromTxDb(txdb)` | TxDb | Gene models |
| `TxTrackFromTxDb(txdb)` | TxDb | Transcript models |
| `FeatureTrack(gr)` | GRanges | Generic gene-like features |
| `merge(t1, t2)` | Multiple tracks | Composite track (multiple features in one row) |

### 2. Displaying the Visualization

*   **TnTBoard**: A basic container for a list of tracks.
*   **TnTGenome**: A `TnTBoard` that includes a genomic axis and location labels.

```r
# Basic display
TnTGenome(list(track1, track2))

# Display with specific constraints
TnTGenome(list(track1),
    view.range = GRanges("chr7", IRanges(26550000, 26600000)),
    coord.range = IRanges(26000000, 27000000),
    zoom.allow = IRanges(5000, 500000),
    allow.drag = TRUE
)
```

## Track Manipulation

### Modifying Metadata (Specs)
Use `trackSpec` to get or set the `background`, `height`, and `label` of a track.

```r
trackSpec(mytrack, "height") <- 50
trackSpec(mytrack, "background") <- "white"
trackSpec(mytrack, "label") <- "My Custom Track"
```

### Modifying Data and Tooltips
Track data is stored as `GRanges`. You can access it via `trackData` or use the `$` shortcut for metadata columns.

```r
# Access/Modify data
trackData(mytrack) <- GenomicRanges::shift(trackData(mytrack), 100)

# Modify colors
mytrack$color <- "red"

# Add tooltips (displayed on click)
tooltip(mytrack) <- data.frame(ID = 1:10, Info = "extra info")
```

## Tips for Effective Use

*   **Tooltips**: By default, `mcols` of a GRanges object are converted to tooltips. Ensure your GRanges object has descriptive metadata columns before creating the track.
*   **Coordinate Limits**: If `seqlengths` are defined in your track's `seqinfo`, `TnT` will use them to set the coordinate range automatically.
*   **Composite Tracks**: Use `merge()` to overlay different data types (e.g., a LineTrack over a BlockTrack) within the same horizontal space.

## Reference documentation

- [Introduction to TnT](./references/introduction.Rmd)
- [Introduction to TnT (Markdown)](./references/introduction.md)