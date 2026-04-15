---
name: bioconductor-flowdensity
description: This tool performs automated sequential gating of flow cytometry data by analyzing density distributions to identify cell populations. Use when user asks to perform automated gating, find density thresholds, remove margin events, or visualize flow cytometry populations in R.
homepage: https://bioconductor.org/packages/release/bioc/html/flowDensity.html
---

# bioconductor-flowdensity

name: bioconductor-flowdensity
description: Automated sequential gating of flow cytometry data using density-based thresholds. Use when Claude needs to perform automated gating, find density peaks, remove margin events, or visualize flow cytometry populations in R using the flowDensity package.

# bioconductor-flowdensity

## Overview
The `flowDensity` package provides tools for automated sequential gating of flow cytometry data. It mimics manual gating strategies by analyzing the density distribution of cell populations to identify peaks, valleys, and inflection points, which are then used to set gating thresholds.

## Core Workflow

1.  **Pre-processing**: Remove margin events (debris/artifacts) using `nmRemove`.
2.  **1D Gating**: Use `deGate` to find optimal thresholds for a single channel.
3.  **2D Gating**: Use `flowDensity` to extract specific cell populations based on two channels and a desired position (e.g., +/-).
4.  **Population Extraction**: Use `getflowFrame` to retrieve the gated data for downstream analysis.
5.  **Visualization**: Use `plotDens` to create density-colored scatter plots with optional gate overlays.

## Key Functions and Usage

### Data Cleaning
`nmRemove` removes events on the axes (margin events) which are often artifacts.
```r
# Remove margin events from FSC-A and SSC-A
f_clean <- nmRemove(f_frame, channels = c("FSC-A", "SSC-A"))
```

### 1D Thresholding with deGate
`deGate` calculates a 1D threshold. It is highly flexible:
- `sd.threshold = TRUE`: Uses standard deviation (multiplied by `n.sd`).
- `use.percentile = TRUE`: Uses a specific `percentile`.
- `bimodal = TRUE`: Splits populations closer to 50-50 when multiple peaks exist.
- `after.peak = TRUE`: Sets the gate after the maximum peak.

```r
# Find threshold for CD19
gate_cd19 <- deGate(f_frame, channel = "PerCP-Cy5-5-A")
```

### 2D Gating with flowDensity
The `flowDensity` function is the primary tool for extracting populations. It returns a `CellPopulation` object.
- `channels`: Vector of two channel names/indices.
- `position`: Vector of two logicals (TRUE for +, FALSE for -, NA for ignoring a dimension).

```r
# Gate Lymphocytes (FSC-A high, SSC-A low/NA)
lymph <- flowDensity(f_frame, channels = c("FSC-A", "SSC-A"), position = c(TRUE, NA))

# Extract the flowFrame from the result
f_lymph <- getflowFrame(lymph)
```

### Complementary Gating
`notSubFrame` is used to get the complement of a population (e.g., gating out a specific subset).
```r
# Gate out CD20- populations
cd20_pos <- notSubFrame(f_frame, channels = c("APC-H7-A", "PerCP-Cy5-5-A"), 
                        position = c(FALSE, NA), gates = c(gate_cd20, NA))
```

### Visualization
`plotDens` provides a scatter plot where colors represent density.
```r
# Plot CD3 vs CD19
plotDens(f_frame, c("V450-A", "PerCP-Cy5-5-A"))
# Add a gate line
abline(v = gate_cd3, col = "red")
```

## Tips for Success
- **Sequential Gating**: Always use the output of one gating step (via `getflowFrame`) as the input for the next to maintain the hierarchy.
- **Peak Finding**: If `deGate` fails to find the expected peak, try adjusting `tinypeak.removal` (default 1/25) or `adjust.dens` (smoothness).
- **Control Samples**: Use the `control` argument in `flowDensity` to calculate thresholds on a control sample and apply them to the experimental sample.
- **CellPopulation Slots**: The `CellPopulation` object contains useful metadata: `@proportion` (of parent), `@cell.count`, and `@gates`.

## Reference documentation
- [flowDensity Reference Manual](./references/reference_manual.md)