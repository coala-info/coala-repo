---
name: bioconductor-pepstat
description: Bioconductor-pepstat provides a statistical framework for the analysis and normalization of peptide microarray binding data. Use when user asks to analyze antibody binding intensities from .gpr files, normalize data based on peptide physicochemical properties, apply sliding mean smoothing, or make automated positivity calls.
homepage: https://bioconductor.org/packages/release/bioc/html/pepStat.html
---

# bioconductor-pepstat

name: bioconductor-pepstat
description: Analysis of peptide microarray binding data. Use when analyzing antibody binding intensities from .gpr files, performing normalization based on peptide physicochemical properties, applying sliding mean smoothing, and making subject-specific positivity calls.

# bioconductor-pepstat

## Overview
The `pepStat` package provides a statistical framework for analyzing peptide microarray data. It addresses common challenges such as non-specific binding, background noise, and the overlapping nature of peptide sequences. Key features include a normalization method using peptide z-scales, data smoothing via sliding means, and automated positivity calls using False Discovery Rate (FDR) thresholding.

## Workflow

### 1. Data Import and Quality Control
Load `.gpr` files into a `peptideSet` object. A mapping file (CSV or data frame) is required for downstream analysis and must contain columns: `filename`, `ptid`, and `visit` (where `visit` uses "pre" for controls and "post" for cases).

```r
library(pepStat)
library(pepDat)

# Define paths
mapFile <- system.file("extdata/mapping.csv", package = "pepDat")
dirToParse <- system.file("extdata/gpr_samples", package = "pepDat")

# Create peptideSet
pSet <- makePeptideSet(path = dirToParse, mapping.file = mapFile, log = TRUE)

# Optional: Remove controls and empty spots
pSet <- makePeptideSet(path = dirToParse, mapping.file = mapFile, 
                       rm.control.list = c("JPT-control", "Ig", "Cy3"),
                       empty.control.list = c("empty", "blank control"))

# Visualize for spatial artifacts
plotArrayImage(pSet, array.index = 1)
```

### 2. Peptide Annotation
Add sequence position and physicochemical properties. You can create a custom database or use existing collections.

```r
# Create a peptide database from a data frame (columns: peptide, start, end)
peps <- read.csv(system.file("extdata/pep_info.csv", package = "pepDat"))
pep_db <- create_db(peps)

# Summarize replicates and attach position info
psSet <- summarizePeptides(pSet, summary = "mean", position = pep_db)
```

### 3. Normalization and Smoothing
Normalization models non-specific binding based on peptide properties. Smoothing uses a sliding mean to leverage overlapping peptide information.

```r
# Normalize intensities
pnSet <- normalizeArray(psSet)

# Apply sliding mean smoothing (width is the number of peptides)
# split.by.clade = TRUE (default) for clade-specific analysis
psmSet <- slidingMean(pnSet, width = 9)

# Aggregate clades to find general hotspots
psmSetAg <- slidingMean(pnSet, width = 9, split.by.clade = FALSE)
```

### 4. Positivity Calls and Results
`makeCalls` handles paired (PRE/POST) or unpaired samples automatically.

```r
# Generate calls
# freq = TRUE returns response percentage; FALSE returns subject-specific matrix
calls <- makeCalls(psmSet, freq = TRUE, group = "treatment", cutoff = 0.1, method = "FDR")

# Combine results into a summary table
res_table <- restab(psmSet, calls)
head(res_table)
```

## Key Functions

- `makePeptideSet`: Primary constructor. Use `mapping.file` to ensure subject metadata is attached early.
- `normalizeArray`: Corrects for non-biological bias. Requires z-scales (automatically added by `create_db`).
- `slidingMean`: Reduces signal variability. Use a `width` that matches the overlap density of your array design.
- `makeCalls`: The `cutoff` parameter defines the FDR level. It subtracts "pre" from "post" intensities before thresholding.
- `shinyPepStat()`: Launches an interactive GUI for the analysis pipeline.

## Reference documentation
- [pepStat](./references/pepStat.md)