---
name: bioconductor-cyanofilter
description: The cyanoFilter package provides a specialized workflow for analyzing flow cytometry data from cyanobacteria. Use when user asks to filter FCS files based on metadata, clean flow cytometry data, remove margin events, filter out debris, or identify phytoplankton populations.
homepage: https://bioconductor.org/packages/release/bioc/html/cyanoFilter.html
---

# bioconductor-cyanofilter

## Overview

The `cyanoFilter` package provides a specialized workflow for the analysis of flow cytometry data, particularly tuned for cyanobacteria. It streamlines the transition from raw FCM files to identified cell populations by providing tools for metadata-driven file selection, data transformation, and a multi-step gating process (margin events -> debris -> phytoplankton).

## Core Workflow

### 1. Metadata Pre-processing and File Selection
Before reading FCS files, use the metadata (CSV) to identify which measurements are valid based on cell concentration.

- `goodFcs()`: Labels measurements as "good" or "bad" based on a desired range of cells per microliter.
- `retain()`: Selects a single file per sample (e.g., the one with the maximum or minimum concentration) from those labeled "good".

```r
# Example: Filter for concentration between 50 and 1000 cells/uL
metafile$Status <- goodFcs(metafile = metafile, col_cpml = "CellspML", mxd_cellpML = 1000, mnd_cellpML = 50)

# Example: Retain the file with the highest concentration per sample group
metafile$Retained <- retain(meta_files = metafile_subset, make_decision = "maxi", Status = "Status", CellspML = "CellspML")
```

### 2. Data Loading and Cleaning
Load files using `flowCore` and prepare them for analysis by removing NA and negative values.

- `noNA()`: Removes rows containing NA values.
- `noNeg()`: Removes rows containing negative values.
- `lnTrans()`: Performs logarithmic transformation on specified channels.

```r
library(flowCore)
flowfile <- read.FCS("path_to_file.fcs", alter.names = TRUE)
flowfile_clean <- noNA(flowfile) %>% noNeg()
flowfile_trans <- lnTrans(flowfile_clean, notToTransform = c("SSC.W", "TIME"))
```

### 3. Visualization
- `ggpairsDens()`: Creates a panel plot of all channels with bivariate kernel smoothed color density.
- `pairs_plot()`: A base-R version of the density scatter plot matrix.

### 4. Gating Sequence

#### Step A: Margin Events
Identify and remove particles that are too large for the detector (margin events) using the width channel.
- `cellMargin()`: Creates a `MarginEvents` object. Use `type = 'estimate'` to automatically find the cut point.
- `reducedFlowframe()`: Extracts the flowFrame containing only non-margin events.

```r
margin_out <- cellMargin(flowframe = flowfile_trans, Channel = 'SSC.W', type = 'estimate')
plot(margin_out)
clean_frame <- reducedFlowframe(margin_out)
```

#### Step B: Debris Removal
Filter out non-living particles/debris by leveraging chlorophyll *a* signatures.
- `debrisNc()`: Identifies debris based on pigment channels (e.g., RED.B.HLin for chlorophyll).

```r
nodebris <- debrisNc(flowframe = clean_frame, ch_chlorophyll = "RED.B.HLin", ch_p2 = "YEL.B.HLin", ph = 0.05)
plot(nodebris)
```

#### Step C: Phytoplankton Gating
The final step clusters the remaining particles into specific populations.
- `phytoFilter()`: Uses peaks in pigment and complexity channels to segment populations.

```r
final_gate <- phytoFilter(flowfile = reducedFlowframe(nodebris),
                          pig_channels = c("RED.B.HLin", "YEL.B.HLin", "RED.R.HLin"),
                          com_channels = c("FSC.HLin", "SSC.HLin"))
plot(final_gate)
```

## Key Classes and Methods
- **MarginEvents**: Result of `cellMargin()`. Contains slots `@fullflowframe`, `@reducedflowframe`, and counts.
- **PhytoFilter**: Result of `phytoFilter()`. Contains slots `@Cell_count` and `@Debris_Count`.
- **Methods**: `plot()`, `summary()`, and `reducedFlowframe()` are implemented for these S4 classes to facilitate easy inspection of gating results.

## Reference documentation
- [cyanoFilter: A Semi-Automated Framework for Identifying Phytplanktons and Cyanobacteria Population in Flow Cytometry](./references/cyanoFilter.md)
- [cyanoFilter Vignette Source](./references/cyanoFilter.Rmd)