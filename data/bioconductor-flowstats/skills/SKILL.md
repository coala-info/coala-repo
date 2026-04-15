---
name: bioconductor-flowstats
description: This tool provides algorithms for automated gating, normalization, and statistical comparison of flow cytometry data. Use when user asks to identify cell populations automatically, align fluorescence intensities across samples, or perform probability binning to compare multivariate distributions.
homepage: https://bioconductor.org/packages/release/bioc/html/flowStats.html
---

# bioconductor-flowstats

name: bioconductor-flowstats
description: Automated gating and normalization for flow cytometry data. Use when performing statistical analysis on flowFrames, flowSets, or GatingSets, specifically for automated population identification (lymphGate, quadrantGate, rangeGate), data alignment/normalization (warpSet, normalize), and multivariate distribution comparison (probability binning).

# bioconductor-flowstats

## Overview

The flowStats package provides a collection of algorithms for the statistical analysis of flow cytometry data. Its primary strengths lie in automated gating—identifying cell populations without manual boundary setting—and normalization, which aligns fluorescence intensities across different samples to correct for technical variation. It integrates closely with flowCore and flowWorkspace (GatingSet) objects.

## Automated Gating

Use these functions to programmatically define gates based on data density and landmarks.

- lymphGate: Identify T-cells or similar populations in 2D (e.g., CD3 vs SSC). It can use a "preselection" marker (like CD4) to find the correct cluster via back-gating.
- quadrantGate: Automatically estimate a quadGate for two binary markers (e.g., CD4 and CD8). It calculates split points based on data distribution.
- rangeGate: Identify 1D boundaries to separate positive and negative peaks for a single marker.

Example usage with a GatingSet:
lg <- lymphGate(gs_cyto_data(gs), channels=c("CD3", "SSC"), preselection="CD4", filterId="TCells", scale=2.5)
gs_pop_add(gs, lg)
recompute(gs)

## Data Normalization

Normalization is essential when fluorescence intensities shift between samples due to technical factors. The package uses a landmark-based approach (warpSet) to align high-density peaks.

- normalize: The primary method for GatingSet objects. It identifies landmarks (peaks) using curv1Filter, clusters them, and estimates warping functions to align them.
- warpSet: The underlying function for flowSet objects.

Workflow for normalization:
1. Define the populations/channels that need alignment.
2. Call normalize on the GatingSet.
3. Specify minCountThreshold to ensure enough events are present for reliable landmark estimation.

gs <- normalize(gs, populations=c("CD4+CD8+", "CD4-CD8-"), dims=c("CD4", "CD8"), minCountThreshold = 50)

## Probability Binning

Probability binning is used to quantify differences between multivariate distributions (e.g., comparing a patient sample to a control).

1. Create a control: Combine multiple flowFrames or use a representative sample.
2. Generate bins: Use proBin on the control data to create bins where each bin contains an equal number of events.
3. Apply bins: Use binByRef to map experimental samples into the control's bin structure.
4. Calculate statistics: Use calcPearsonChi or calcPBChiSquare to get a metric of how much the sample deviates from the control.

refBins <- proBin(ctrlData, minRow=200, channels=c("CD4", "CD8"))
sampBins <- binByRef(refBins, sampleFrame)
stats <- calcPearsonChi(refBins, sampBins)

## Tips for Success

- Transformation: Always transform fluorescence channels (e.g., asinh or logicle) before using flowStats gating or normalization functions.
- Visualization: Use ggcyto or flowViz to verify that automated gates and normalization results align with biological expectations.
- Landmark Selection: Normalization works best on binary markers where distinct "positive" and "negative" peaks exist across the dataset.

## Reference documentation

- [Getting started with flowStats](./references/GettingStartedWithFlowStats.md)