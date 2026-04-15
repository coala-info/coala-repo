---
name: bioconductor-trackviewer
description: bioconductor-trackviewer is a Bioconductor package for the integrated visualization of multi-omics data, including coverage tracks, gene models, and chromatin interactions. Use when user asks to visualize genomic data as linear tracks, create lollipop or dandelion plots for variants, or generate heatmaps for Hi-C interaction data.
homepage: https://bioconductor.org/packages/release/bioc/html/trackViewer.html
---

# bioconductor-trackviewer

## Overview
The `trackViewer` package is a versatile Bioconductor tool for visualizing multi-omics data. It excels at creating integrated genomic views that combine traditional coverage tracks (BigWig/BAM) with specialized visualizations like lollipop plots for SNPs/methylation and heatmaps for chromatin interactions (Hi-C). It is designed to be more memory-efficient than Gviz for large datasets.

## Core Workflow

### 1. Data Import
Load various genomic formats into track objects.
```R
library(trackViewer)
# Import coverage (WIG, BigWig, BED, bedGraph)
repA <- importScore("file_minus.wig", "file_plus.wig", format="WIG")

# Import BAM files
bamData <- importBam("sample.bam", ranges=gr)

# Import Chromatin Interactions (HiC, Cool, GInteractions)
gi <- importGInteractions("data.hic", format="hic", ranges=gr)
```

### 2. Building Gene Models
Extract gene structures from TxDb objects.
```R
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
library(org.Hs.eg.db)
gr <- GRanges("chr11", IRanges(122929275, 122930122))
trs <- geneModelFromTxdb(TxDb.Hsapiens.UCSC.hg19.knownGene, org.Hs.eg.db, gr=gr)
```

### 3. Visualization
The package uses `viewTracks` for linear tracks and specialized functions for point-data.

**Linear Tracks:**
```R
trackList <- trackList(repA, trs)
# Optimize styles automatically for a clean look
optSty <- optimizeStyle(trackList, theme="col")
viewTracks(optSty$tracks, gr=gr, viewerStyle=optSty$style)
```

**Lollipop Plots (Mutations/SNPs):**
```R
# sample.gr contains scores and colors in mcols
lolliplot(sample.gr, features)
```

**Dandelion Plots (High-density variants):**
```R
dandelion.plot(methy, features, ranges=gr, type="pin")
```

## Key Functions and Parameters

### Styling and Customization
*   `setTrackStyleParam()`: Modify individual track attributes like `ylim`, `color`, `height`, and `ylabpos`.
*   `setTrackViewerStyleParam()`: Modify global viewer settings like `margin`, `xaxis`, and `flip`.
*   `optimizeStyle()`: Quickly apply themes ("bw", "col", "safe").

### Interaction Data
*   `gi2track()`: Convert GInteractions objects to track objects.
*   `addInteractionAnnotation()`: Add TADs, anchors, or polygons to interaction heatmaps.
*   `tracktype`: Set to "heatmap", "link", or `c("heatmap", "link")` for split views.

### Operators
Perform track arithmetic (e.g., subtracting background) directly in the viewer:
```R
viewTracks(trackList(sample, control), operator="-")
```

## Tips for Success
*   **Memory:** For large BigWig files, `trackViewer` is significantly faster than `Gviz` because it parses data only during the plotting phase.
*   **Coordinate Consistency:** Ensure your `GRanges` objects use the same `seqlevelsStyle` (e.g., "UCSC" vs "Ensembl") as your data files.
*   **Interactive Editing:** Use `browseTracks(trackList, gr)` to open an interactive HTML widget where you can tweak styles and export the resulting R code.
*   **Lollipop Scores:** In `lolliplot`, the `score` column in your GRanges metadata determines the height of the lollipop.

## Reference documentation
- [Change the styles of the track plot](./references/changeTracksStyles.md)
- [Plot high dense methylation/mutation/variant data by dandelion plot](./references/dandelionPlot.md)
- [Plot methylation/mutation/variant data by lollipop plot](./references/lollipopPlot.md)
- [Visualize chromatin interactions along with annotation](./references/plotInteractionData.md)
- [trackViewer Package Overview](./references/trackViewer.md)