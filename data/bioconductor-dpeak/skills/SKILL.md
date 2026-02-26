---
name: bioconductor-dpeak
description: Bioconductor-dpeak identifies high-resolution protein binding sites by deconvolving overlapping binding events within ChIP-seq peak regions using parametric mixture models. Use when user asks to load peak lists and aligned reads, fit mixture models to identify multiple binding events, visualize binding site estimates, or export high-resolution coordinates to BED or GFF formats.
homepage: https://bioconductor.org/packages/3.11/bioc/html/dpeak.html
---


# bioconductor-dpeak

name: bioconductor-dpeak
description: Precise identification of protein binding sites at high resolution using ChIP-seq data. Use this skill when you need to perform dPeak analysis in R, specifically for: (1) Loading peak lists and aligned reads (SET or PET), (2) Fitting parametric mixture models to identify multiple binding events within a single peak region, (3) Visualizing binding site estimates and goodness-of-fit, and (4) Exporting high-resolution binding site coordinates to TXT, BED, or GFF formats.

## Overview

The `dpeak` package implements a parametric mixture modeling approach to deconvolve overlapping binding events within ChIP-seq peak regions. While standard peak callers identify broad regions of enrichment, `dpeak` provides higher spatial resolution by identifying the specific coordinates of one or more protein-DNA binding sites within those regions. It supports both Single-End Tag (SET) and Paired-End Tag (PET) data and uses the Bayesian Information Criterion (BIC) to determine the optimal number of binding events per peak.

## Workflow

### 1. Data Loading and Preprocessing

Use `dpeakRead` to import your peak list (typically from a standard peak caller like MACS2) and the corresponding aligned reads.

```R
library(dpeak)

# For Single-End Tag (SET) data
data <- dpeakRead(
  peakfile = "peaks.bed",      # No header, first 3 cols: chr, start, end
  readfile = "reads.sam",      # Aligned reads file
  fileFormat = "sam",          # "sam", "bam", "bed", "bowtie", "eland_result", etc.
  PET = FALSE,                 # SET data
  fragLen = 150                # Average fragment length
)

# For Paired-End Tag (PET) data
# Note: PET currently primarily supports "eland_result" format in dpeakRead
data_pet <- dpeakRead(
  peakfile = "peaks.bed",
  readfile = "reads_pet.txt",
  fileFormat = "eland_result",
  PET = TRUE
)
```

### 2. Exploratory Data Analysis

Before fitting the model, visualize the read distribution within the peaks.

```R
# Summary of the loaded data
data

# Export plots to PDF
# strand=TRUE shows forward/reverse reads separately (useful for SET)
exportPlot(data, filename = "eda_plots.pdf", strand = TRUE, extension = 1, smoothing = TRUE)
```

### 3. Model Fitting

The `dpeakFit` function identifies the binding sites. It can utilize multiple cores for faster processing.

```R
# Fit the model
# maxComp: maximum number of binding sites to consider per peak
fit <- dpeakFit(data, maxComp = 5, nCore = 4)

# Summary of the fit (e.g., median binding events found)
fit
```

### 4. Visualization of Results

Verify the model fit by inspecting the estimated binding sites and Goodness of Fit (GOF) plots.

```R
# Plot estimated binding sites (blue dashed lines)
exportPlot(fit, filename = "results_fit.pdf", plotType = "fit")

# Plot Goodness of Fit (compares observed vs. simulated fragments)
exportPlot(fit, filename = "results_gof.pdf", plotType = "GOF")
```

### 5. Exporting Results

Export the high-resolution binding site coordinates to standard formats.

```R
# Export as TXT (includes binding strength/pi)
exportPeakList(fit, type = "txt", filename = "binding_sites.txt")

# Export as BED or GFF (score = estimated strength * 1000)
exportPeakList(fit, type = "bed", filename = "binding_sites.bed")
exportPeakList(fit, type = "gff", filename = "binding_sites.gff")
```

## Tips and Best Practices

- **Peak File Format**: Ensure the `peakfile` does not have a header. The first three columns must be Chromosome, Start, and End.
- **Fragment Length**: For SET data, providing an accurate `fragLen` is crucial for the model to correctly estimate the shift between forward and reverse strand peaks.
- **Parallelization**: Always use `nCore` in `dpeakFit` if working with a large number of peaks to significantly reduce computation time.
- **Model Selection**: `dpeak` uses BIC to choose the number of components. If you suspect very complex binding patterns, you may increase `maxComp`, though this increases computation time.

## Reference documentation
- [dpeak-example](./references/dpeak-example.md)