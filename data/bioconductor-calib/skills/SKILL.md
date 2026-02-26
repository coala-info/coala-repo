---
name: bioconductor-calib
description: This tool normalizes spotted microarray data using a physically motivated calibration model to estimate absolute transcript levels. Use when user asks to normalize spotted microarrays, estimate absolute expression levels from spike-in controls, or handle dye saturation effects.
homepage: https://bioconductor.org/packages/3.5/bioc/html/CALIB.html
---


# bioconductor-calib

name: bioconductor-calib
description: Normalization of spotted microarray data using a physically motivated calibration model. Use this skill to estimate absolute transcript levels from spike-in controls, handle dye saturation effects, and perform quality control on spotted microarrays.

## Overview

CALIB (Calibration of Microarray Data) provides a mechanistic approach to microarray normalization. Unlike heuristic methods (like loess), CALIB uses a physical model of the hybridization reaction and dye saturation function. It utilizes external control spikes to estimate absolute expression levels for each gene and condition, independent of the number of slides or replicates.

## Data Classes

The package uses three primary data structures:
- **RGList_CALIB**: An extension of `limma::RGList`. It stores raw intensities and includes `RArea` and `GArea` fields for spot areas.
- **SpikeList**: Created via `read.spike()`. Contains raw measurements and known concentrations for external control spikes.
- **ParameterList**: Created via `estimateParameter()`. Stores the estimated calibration model parameters for each array.

## Workflow

### 1. Data Input
Load the library and read the experimental design (targets) and raw intensity data.

```r
library(CALIB)

# Read targets file
targets <- readTargets("targets.txt")

# Read raw intensities (requires specific columns for intensities and areas)
RG <- read.rg(targets$FileName, columns=list(
  Rf="CH1_NBC_INT", Gf="CH2_NBC_INT", 
  Rb="CH1_SPOT_BKGD", Gb="CH2_SPOT_BKGD",
  RArea="CH1_SPOT_AREA", GArea="CH2_SPOT_AREA"
))

# Load annotation and spot types
RG$genes <- read.table("annotation.txt", header=TRUE, sep="\t")
types <- readSpotTypes()
RG$genes$Status <- controlStatus(types, RG$genes)
```

### 2. Spike Handling and QC
Extract spike-in data and visualize the relationship between measured intensity and known concentration.

```r
# Read spike concentrations
spike <- read.spike(RG, file="conc.txt")

# Diagnostic plot for spikes (look for sigmoidal relationship)
plotSpikeCI(spike, array=1)
```

### 3. Parameter Estimation
Estimate the calibration model parameters. This step models the hybridization and saturation effects.

```r
# bc=F (no background correction), area=T (use spot area), errormodel="M" (multiplicative)
parameter <- estimateParameter(spike, RG, bc=FALSE, area=TRUE, errormodel="M")

# Visualize the fit of the model to the spikes
plotSpikeHI(spike, parameter, array=1)
```

### 4. Normalization
Calculate absolute expression levels based on the estimated parameters and experimental design.

```r
# Define experimental design vectors
array_vec <- c(1, 1, 2, 2)
cond_vec <- c(1, 2, 2, 1)
dye_vec <- c(1, 2, 1, 2)

# Normalize data for specific clones or all genes
normdata <- normalizeData(RG, parameter, array_vec, cond_vec, dye_vec, idcol="CLONE_ID")
```

## Tips and Best Practices
- **Spot Areas**: Ensure your image analysis software exports spot area columns, as CALIB uses these to improve intensity calculations.
- **Background Correction**: The calibration model often performs better without manual background subtraction (`bc=FALSE`) as the model accounts for non-specific binding.
- **Model Fit**: Always use `plotSpikeHI` to verify that the black dots (spikes) tightly follow the red/green model curves. Significant deviations suggest poor quality or failed calibration.
- **Documentation**: Use `calibReadMe()` to access the detailed package manual.

## Reference documentation
- [Quick Start Guide for CALIB](./references/quickstart.md)