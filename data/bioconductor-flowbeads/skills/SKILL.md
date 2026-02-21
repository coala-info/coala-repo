---
name: bioconductor-flowbeads
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/flowBeads.html
---

# bioconductor-flowbeads

name: bioconductor-flowbeads
description: Bead-based normalization for flow cytometry data using the flowBeads package. Use this skill to load bead data, gate bead populations, and perform absolute (MEF/MESF) or relative normalization to ensure consistency across different instruments or time points.

## Overview

The `flowBeads` package extends `flowCore` to handle bead data used for instrument quality control and normalization. It allows users to transform Mean Fluorescence Intensity (MFI) into Molecules of Equivalent Fluorochrome (MEF) units. This process corrects for shifts in detector sensitivity and background noise, enabling valid comparisons between flow cytometry samples acquired under different conditions.

## Core Workflow

### 1. Loading Bead Data
Bead data is loaded into a `BeadFlowFrame` object. You must provide both the FCS file and a configuration file (CSV) containing the manufacturer's MEF values.

```r
library(flowBeads)

# Load built-in MEF configuration for Dakocytomation beads
data(dakomef) 

# Create BeadFlowFrame
beads <- BeadFlowFrame(
  fcs.filename = "path/to/beads.fcs",
  bead.filename = "path/to/dakomef.csv"
)

# Inspect the object
getDate(beads)
getParams(beads)
getMEFparams(beads)
```

### 2. Gating Bead Populations
The package uses k-means clustering to automatically identify the distinct bead populations (usually 6) defined in the MEF file.

```r
# Gate the beads
gbeads <- gateBeads(beads)

# Visualize gating results
plot(gbeads)
plot(gbeads, "APC") # Plot specific channel

# Extract clustering statistics (count, mean, sd, cv)
stats <- getClusteringStats(gbeads)
```

### 3. Absolute Normalization (MEF)
To convert experimental data to MEF units, extract the transform from the gated beads and apply it to your sample `flowFrame`.

```r
# Get the MEF transform parameters (alpha and beta)
mef.transform <- getMEFtransform(gbeads)

# Apply normalization to a flowFrame (flow.data)
# This normalizes channels where MEF values were provided
norm.data <- toMEF(gbeads, flow.data)
```

### 4. Relative Normalization
If MEF values are unavailable, you can perform relative normalization to align the MFIs of two different bead runs (e.g., Day 1 vs Day 2).

```r
# Compute transform to align gbeads1 to gbeads2
rel.transforms <- relativeNormalise(gbeads1, gbeads2)

# Apply the transform function for a specific channel
apc.fun <- rel.transforms$APC$fun
normalized_mfi <- apc.fun(original_mfi)
```

### 5. Reporting
Generate an automated HTML report to review gating quality and transformation parameters.

```r
generateReport(gbeads, output.file='bead_report.html')
```

## Key Functions and Objects

- `BeadFlowFrame`: S4 class for bead data and MEF metadata.
- `GatedBeadFlowFrame`: S4 class containing gated populations and calculated transforms.
- `gateBeads()`: Automated clustering of bead populations.
- `getMEFtransform()`: Calculates the affine transform $f(MEF) = \beta \times f(MFI) + \alpha$.
- `toMEF()`: High-level function to transform a `flowFrame` into MEF space.
- `relativeNormalise()`: Calculates transforms to align two bead sets without absolute MEF values.

## Reference documentation

- [HowTo-flowBeads](./references/HowTo-flowBeads.md)