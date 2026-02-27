---
name: bioconductor-sim
description: This tool performs integrated statistical analysis of two different microarray datasets, such as copy number and gene expression, to identify associations within genomic regions. Use when user asks to link two types of microarray data, perform integrated genomic analysis using the globaltest, or visualize associations between genomic features through p-value plots and z-score heatmaps.
homepage: https://bioconductor.org/packages/release/bioc/html/SIM.html
---


# bioconductor-sim

name: bioconductor-sim
description: Statistical Integration of Microarrays (SIM). Use this skill to perform integrated analysis of two microarray datasets (e.g., copy number and gene expression) measured on the same samples. It uses a random-effects model (globaltest) to identify associations between genomic regions and features.

# bioconductor-sim

## Overview
The `SIM` package provides a statistical framework to link two different types of microarray data, typically DNA copy number (dependent) and gene expression (independent). It uses the `globaltest` to find associations within genomic regions (like chromosome arms) and provides extensive visualization tools for p-values and z-score heatmaps.

## Data Preparation
Both datasets must be normalized and log-transformed. They require specific annotation columns:
- `ID`: Unique probe identifier.
- `CHROMOSOME`: Chromosome number (1-22, X, Y).
- `STARTPOS`: Base pair location.
- `Symbol`: (Optional) Gene symbol.

Samples must be in the same order in both data frames. Use `impute.nas.by.surrounding()` to handle missing values in the dependent (copy number) data before analysis.

## Core Workflow

### 1. Assemble Data
The `assemble.data` function organizes the datasets and creates a directory structure for results.
```r
library(SIM)
assemble.data(
  dep.data = acgh.data, 
  indep.data = expr.data,
  dep.ann = 1:4,      # Column indices for annotation
  indep.ann = 1:4,
  dep.id = "ID", dep.chr = "CHROMOSOME", dep.pos = "STARTPOS",
  run.name = "my_analysis"
)
```

### 2. Integrated Analysis
Run the regression model. You can specify regions like "all arms", "all chrs", or specific coordinates.
```r
integrated.analysis(
  input.regions = "8q",
  zscores = TRUE,       # Required for heatmaps
  method = "full",      # Options: "full", "overlap", "smooth", "window"
  run.name = "my_analysis"
)
```

### 3. Visualizing Results
SIM generates several plot types, usually saved as PDFs in the run directory:
- **Genome-wide P-values**: `sim.plot.pvals.on.genome(input.regions = "all arms", run.name = "my_analysis")`
- **Region-specific P-values**: `sim.plot.pvals.on.region(input.regions = "8q", run.name = "my_analysis")`
- **Association Heatmaps**: Displays z-scores between dependent and independent features.
```r
sim.plot.zscore.heatmap(
  input.regions = "8q",
  z.threshold = 3,
  add.plot = "smooth", # Adds copy number trend panel
  run.name = "my_analysis"
)
```

### 4. Tabulating Features
Extract the top associated features for further study:
- **Dependent**: `tabulate.top.dep.features(input.regions = "8q", run.name = "my_analysis")`
- **Independent**: `tabulate.top.indep.features(input.regions = "8q", run.name = "my_analysis")`

## Tips
- **Multiple Testing**: The default correction is "BY" (Benjamini & Yekutieli), which is appropriate for correlated genomic tests. "BH" is also available.
- **Region Units**: Ensure the `input.regions` unit matches what was used in `integrated.analysis`. If you ran the analysis on "arms", you must plot by "arms".
- **Memory**: SIM saves results to the hard disk to handle high-density arrays efficiently without clogging R's workspace.

## Reference documentation
- [Statistical Integration of Microarrays](./references/SIM.md)