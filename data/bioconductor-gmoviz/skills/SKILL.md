---
name: bioconductor-gmoviz
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/gmoviz.html
---

# bioconductor-gmoviz

name: bioconductor-gmoviz
description: Visualise complex genomic variations, tandem insertions, and structural edits in GMOs and edited cell lines using circular (Circos) plots. Use this skill to generate insertion diagrams, feature maps, and plasmid maps, or to build multi-track genomic plots with coverage and numeric data.

## Overview

`gmoviz` is an R package built on the `circlize` framework, specifically designed for characterizing genetically modified organisms. It excels at representing tandem integration events, complex constructs, and structural variations alongside traditional genomic data like coverage and scatterplots.

## Core Workflows

### 1. Visualizing Insertions
The `insertionDiagram` function is the primary tool for showing how a sequence (e.g., a plasmid) has integrated into a target genome.

```r
library(gmoviz)
library(GenomicRanges)

# Define the insertion site and the insert properties
insertion_data <- GRanges(seqnames = "chr12",
                          ranges = IRanges(start = 70905597, end = 70917885),
                          name = "plasmid", 
                          length = 12000, 
                          in_tandem = 11, 
                          shape = "forward_arrow",
                          colour = "blue")

# Basic diagram
insertionDiagram(insertion_data = insertion_data, space_between_sectors = 20)

# Style 2: Emphasis on target sequence size
insertionDiagram(insertion_data, style = 2)
```

### 2. Feature and Plasmid Maps
Use `featureDiagram` for general-purpose maps of genes, exons, or complex constructs.

```r
# Load features from a GFF file
plasmid_features <- getFeatures(gff_file = "path/to/plasmid.gff3", colours = rich_colours)
plasmid_ideogram <- GRanges("plasmid", IRanges(start = 0, end = 3000))

# Plot a continuous circular plasmid map
featureDiagram(plasmid_ideogram, plasmid_features, 
               space_between_sectors = 0, 
               start_degree = 90)
```

### 3. Incremental Plot Building
For complex figures, initialize the plot and add tracks one by one.

```r
# 1. Get Ideogram Data
ideogram <- getIdeogramData(bam_file = "sample.bam", wanted_chr = "chr4")

# 2. Initialize
gmovizInitialise(ideogram, track_height = 0.15)

# 3. Add Numeric Tracks (Scatter/Line)
drawScatterplotTrack(numeric_data_granges)
drawLinegraphTrack(sorted_numeric_data_granges)

# 4. Add Feature Tracks
drawFeatureTrack(feature_granges)
```

### 4. Working with Coverage Data
Coverage can be displayed as "coverage rectangles" to highlight deletions or duplications.

```r
# Read coverage from BAM
cov_data <- getCoverage(regions_of_interest = "chr4", 
                        bam_file = "sample.bam", 
                        window_size = 500, 
                        smoothing_window_size = 400)

# Plot coverage in the ideogram track
gmovizInitialise(ideogram, 
                 coverage_rectangle = "chr4", 
                 coverage_data = cov_data)
```

## Key Functions and Parameters

- `getIdeogramData()`: Extracts sequence lengths from BAM or FASTA files.
- `getFeatures()`: Reads GFF3 files into a format ready for `featureDiagram`.
- `multipleInsertionDiagram()`: Handles up to 8 insertion events around a central genome circle.
- `either_side`: Controls the genomic context shown around an insertion site (accepts bp count, range vector, or GRanges).
- `gmovizPlot()`: A wrapper to save plots (SVG, PNG, PDF) with titles and legends generated via `makeLegends()`.

## Tips and Best Practices

- **Performance**: When plotting coverage, use a `window_size` > 1 (e.g., 100-500) to significantly speed up processing and plotting.
- **Smoothing**: Use `smoothing_window_size` in `getCoverage` to produce cleaner, publication-ready line graphs.
- **Colors**: Use built-in sets like `rich_colours`, `nice_colours`, or `pastel_colours` for consistent aesthetics.
- **Customization**: Since `gmoviz` is based on `circlize`, you can call `circos.text()` or `circos.link()` after a `gmoviz` function to add manual annotations.
- **Zooming**: Use the `zoom_sectors` argument in `gmovizInitialise` to expand small chromosomes or regions without losing the context of the rest of the genome.

## Reference documentation

- [gmoviz: Advanced Usage](./references/gmoviz_advanced.md)
- [gmoviz: Package Overview](./references/gmoviz_overview.md)