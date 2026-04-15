---
name: bioconductor-ribocrypt
description: bioconductor-ribocrypt provides interactive visualization and analysis of Ribo-seq and other NGS data with sub-codon resolution. Use when user asks to generate multi-omics browser plots, analyze codon dwell times, visualize P-site shifting, or launch the RiboCrypt Shiny application.
homepage: https://bioconductor.org/packages/release/bioc/html/RiboCrypt.html
---

# bioconductor-ribocrypt

name: bioconductor-ribocrypt
description: Expert guidance for the RiboCrypt Bioconductor package. Use this skill for interactive visualization and analysis of Ribo-seq and other NGS data (RNA-seq, CAGE, etc.). It covers creating multi-omics browser plots, sub-codon resolution analysis, P-site shifting visualization, codon dwell time analysis, and differential expression. Use when the user needs to generate publication-quality coverage plots, explore reading frame biases, or launch the RiboCrypt Shiny application.

## Overview
RiboCrypt is a specialized R package for the interactive visualization of translatomics data. It extends the ORFik framework to provide high-resolution, frame-specific coverage plots. Its primary strength lies in its ability to handle sub-codon resolution (P-shifted footprints) and toggle between transcriptomic and genomic coordinates.

## Core Workflow: Data Preparation
RiboCrypt relies on `ORFik` experiment objects (`df`) to manage metadata and file paths.

```r
library(RiboCrypt)
library(ORFik)

# 1. Define the experiment
# Requires a folder with alignment files (ofst, bigWig, or bam)
df <- read.experiment("path/to/experiment_sheet.csv")

# 2. Load annotation
cds <- loadRegion(df, "cds")

# 3. Optimization: Convert to bigWig for faster loading if read-length info isn't needed
convert_to_bigWig(df)
```

## Creating Browser Plots
The `multiOmicsPlot_ORFikExp` function is the primary tool for generating interactive coverage plots.

### Basic Plotting
```r
# Plot a specific gene (e.g., the 3rd CDS in the list)
multiOmicsPlot_ORFikExp(
  range = extendLeaders(extendTrailers(cds[3], 30), 30),
  annotation = cds,
  df = df[df$libtype == "RFP", ],
  frames_type = "columns"
)
```

### Display Types (`frames_type`)
- `columns`: Best for single-nucleotide resolution (zoomed in).
- `lines`: Intuitive for medium distances; use with `kmers` to reduce noise.
- `stacks`: Area under curve, stacked; best for publication figures and large regions.
- `area`: Semitransparent overlapping frames.

### Smoothing with K-mers
To handle the "spiky" nature of Ribo-seq data, use the `kmers` argument to apply a sliding window average.
```r
multiOmicsPlot_ORFikExp(range, annotation, df, frames_type = "lines", kmers = 9)
```

## Launching the Interactive App
RiboCrypt includes a comprehensive Shiny environment for GUI-based exploration.

```r
# Basic launch
RiboCrypt_app()

# Launch with specific default settings
browser_options <- c(
  default_frame_type = "columns",
  default_experiment = "My_Project",
  plot_on_start = TRUE
)
RiboCrypt_app(browser_options = browser_options)
```

## Specialized Analysis
- **Codon Dwell Time**: Analyze ribosome residence time at specific codons to identify translation bottlenecks.
- **Motif Metaplots**: Generate heatmaps of coverage around start/stop codons or custom motifs.
- **Differential Expression**: Perform gene-level differential analysis using DESeq2 or FPKM ratios directly within the app framework.
- **Frame Bias QC**: Check the quality of P-shifting by inspecting 3-nucleotide periodicity across different read lengths.

## Tips for Success
- **P-shifting**: Ensure your Ribo-seq data is P-shifted (using `ORFik::detectRibosomeShifts`) before visualization to see correct reading frame alignment.
- **Genomic vs Transcriptomic**: Use `viewMode = TRUE` in the app or specific range objects to toggle between spliced (transcript) and unspliced (genomic) views.
- **Exporting**: Use the plotly camera icon in the browser view to export SVG files for vector-based editing in Illustrator or Inkscape.

## Reference documentation
- [App Tutorial](./references/RiboCrypt_app_tutorial.md)
- [RiboCrypt Overview](./references/RiboCrypt_overview.md)