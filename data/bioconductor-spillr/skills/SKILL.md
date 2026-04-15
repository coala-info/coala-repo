---
name: bioconductor-spillr
description: bioconductor-spillr compensates signal spillover in mass cytometry data using nonparametric mixture models. Use when user asks to compensate CyTOF data, estimate spillover distributions from bead controls, or correct signal overlap in SingleCellExperiment objects.
homepage: https://bioconductor.org/packages/release/bioc/html/spillR.html
---

# bioconductor-spillr

name: bioconductor-spillr
description: Spillover compensation for mass cytometry (CyTOF) data using nonparametric mixture models. Use when Claude needs to correct signal overlap in CyTOF experiments using single-stained bead controls. This skill provides workflows for estimating spillover distributions from bead experiments and applying corrections to biological samples within the SingleCellExperiment framework.

# bioconductor-spillr

## Overview

The `spillR` package provides a method for compensating signal spillover in mass cytometry (CyTOF). Unlike traditional methods that rely on a fixed spillover matrix of proportions, `spillR` uses a mixture of nonparametric distributions to describe spillover. It assumes that the spillover distribution observed in single-stained bead experiments carries over to biological experiments.

## Installation

Install the package using `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("spillR")
```

## Compensation Workflow

The standard workflow requires two `SingleCellExperiment` (SCE) objects: one for the biological cells and one for the single-stained beads.

### 1. Prepare the Mapping Table

You must create a mapping table (`marker_to_barc`) that links the channels to the barcodes used in the bead experiment.

```r
library(spillR)
library(dplyr)

# Example mapping: channel name to its numeric barcode
marker_to_barc <- data.frame(
  marker = c("Yb171Di", "Yb173Di"), 
  barcode = c(171, 173)
)
```

### 2. Run Compensation

Use `compCytof` to perform the compensation. This function adds `compcounts` and `compexprs` (transformed) assays to the input SCE.

```r
# sce: SCE with real cell data
# sce_bead: SCE with bead experiment data
sce_compensated <- spillR::compCytof(
  sce = sce,
  sce_bead = sce_bead,
  marker_to_barc = marker_to_barc,
  impute_value = NA,
  overwrite = FALSE
)
```

### 3. Diagnostic Visualization

Use `plotDiagnostics` to evaluate the quality of the compensation and the reliability of the spillover estimation.

```r
# Generate diagnostic plots for a specific marker
plots <- spillR::plotDiagnostics(sce_compensated, "Yb173Di")

# plots[[1]]: Frequency polygons before/after compensation
# plots[[2]]: Density plot of spillover markers with estimated probability function (dashed line)
library(cowplot)
plot_grid(plotlist = plots, ncol = 1)
```

## Usage Tips

- **Bead Quality**: The reliability of the compensation depends on the bead experiment. If the black dashed curve in `plotDiagnostics` does not capture the spillover markers well, the estimation may be unreliable.
- **Assays**: After running `compCytof`, the resulting SCE will contain new assays: `compcounts` (raw compensated values) and `compexprs` (arcsinh-transformed compensated values).
- **Integration**: `spillR` is designed to work seamlessly with `CATALYST` and `SingleCellExperiment` objects. Use `CATALYST::prepData` to initialize your SCE objects before compensation.

## Reference documentation

- [spillR Vignette](./references/spillR-vignette.md)