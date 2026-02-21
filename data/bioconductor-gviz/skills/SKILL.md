---
name: bioconductor-gviz
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/Gviz.html
---

# bioconductor-gviz

name: bioconductor-gviz
description: Visualization of genomic data using the Gviz framework. Use this skill to create high-quality, track-based genomic plots in R, including ideograms, genome axes, gene models (from TxDb, EnsDb, or Biomart), and numeric data tracks (BigWig, BAM, etc.).

# bioconductor-gviz

## Overview
The `Gviz` package provides a structured framework for plotting genomic data along coordinates using a track-based approach. Each data type (e.g., gene models, numeric coverage, chromosome ideograms) is represented by a specific track object. These tracks are aligned to a common genomic coordinate system and rendered using the `plotTracks` function.

## Core Workflow

1.  **Initialize Tracks**: Create individual track objects for each data type.
2.  **Set Display Parameters**: Customize colors, stacking, and visualization types (e.g., histograms vs. lines).
3.  **Plot**: Use `plotTracks` to render a list of tracks for a specific genomic range.

## Track Classes and Constructors

### 1. Reference Tracks
*   **`IdeogramTrack(genome, chromosome)`**: Displays chromosome staining bands and highlights the current region. Requires an internet connection for UCSC data or local data.
*   **`GenomeAxisTrack()`**: Adds a genomic coordinate axis with tick marks. Use `scale` parameter for a simple scale bar instead of a full axis.

### 2. Annotation Tracks
*   **`AnnotationTrack(range, name, ...)`**: General purpose track for genomic features (e.g., CpG islands). Supports grouping of elements.
*   **`GeneRegionTrack(range, genome, chromosome, name, ...)`**: Specialized for gene models.
    *   Can be built from `TxDb` or `EnsDb` objects.
    *   Supports collapsing transcripts (`collapseTranscripts = TRUE`, `"longest"`, or `"meta"`).
    *   Distinguishes between coding and non-coding regions (UTRs) via `thinBoxFeature`.
*   **`BiomartGeneRegionTrack(genome, chromosome, start, end, ...)`**: Fetches gene models directly from Ensembl via `biomaRt`.

### 3. Data Tracks
*   **`DataTrack(range, data, name, ...)`**: For numeric data (e.g., ChIP-seq coverage, methylation levels).
    *   **Plot Types**: Set via `type` argument (e.g., `"p"` for points, `"l"` for lines, `"h"` for histogram, `"boxplot"`, `"heatmap"`, `"horizon"`).
    *   **Grouping**: Use the `groups` argument to color-code or aggregate data by sample type.
    *   **Aggregation**: Use `window` and `aggregation` (e.g., `"mean"`, `"max"`) to summarize dense data.

### 4. Sequence Tracks
*   **`SequenceTrack(BSgenome, chromosome)`**: Displays DNA sequences. At high zoom levels, it shows individual nucleotides.

## File-Based Streaming
`Gviz` can stream data directly from indexed files to save memory:
*   **BAM files**: `DataTrack(range = "file.bam", type = "l")` for coverage or `AnnotationTrack` for individual reads.
*   **BigWig/bedGraph**: `DataTrack(range = "file.bw")`.

## Key Functions and Parameters

### `plotTracks(trackList, from, to, ...)`
*   `from`, `to`: Define the genomic window to display.
*   `extend.left`, `extend.right`: Add padding to the view (absolute or relative).
*   `reverseStrand`: Set to `TRUE` to flip the orientation (5' -> 3' becomes right-to-left).
*   `main`: Add a plot title.

### Display Parameters (`displayPars`)
Parameters can be set during construction or via `displayPars(track) <- list(...)`.
*   `background.title`: Color of the track label background.
*   `col`, `fill`: Border and fill colors for features.
*   `stacking`: Controls overlapping features (`"squish"`, `"dense"`, `"hide"`).
*   `cex`, `fontsize`: Control text sizes.

## Tips for Effective Visualization
*   **Coordinate Consistency**: Ensure all tracks use the same chromosome naming convention (e.g., "chr7" vs "7"). Use `options(ucscChromosomeNames = FALSE)` if not using UCSC style.
*   **Overplotting**: For dense annotation tracks, use `showOverplotting = TRUE` to see where features are being collapsed.
*   **Schemes**: Use `addScheme` and `options(Gviz.scheme = "myScheme")` to apply consistent styling across multiple plots.

## Reference documentation
- [The Gviz User Guide](./references/Gviz.md)