---
name: bioconductor-simat
description: SIMAT processes Gas Chromatography-Mass Spectrometry data acquired in Selected Ion Monitoring mode for targeted analysis and peak identification. Use when user asks to optimize fragment selection, calibrate retention indices, detect peaks in SIM data, or calculate spectral similarity scores.
homepage: https://bioconductor.org/packages/release/bioc/html/SIMAT.html
---


# bioconductor-simat

## Overview

SIMAT (GC-SIM-MS Analysis Tool) is a specialized Bioconductor package designed for processing Gas Chromatography-Mass Spectrometry data specifically acquired in Selected Ion Monitoring (SIM) mode. Unlike untargeted GC-MS tools, SIMAT focuses on targeted analysis, providing workflows for fragment selection optimization, retention index calibration, and automated peak identification based on spectral libraries.

## Core Workflow

### 1. Data Import and Preparation
Load the library and your experimental data. SIMAT typically works with netCDF raw files and NIST format mass spectral libraries.

```r
library(SIMAT)

# Load raw SIM run data (e.g., from a CDF file)
data(Run) 

# Load target information and background libraries
data(target.table)
data(Library)
data(RItable) # For RI calibration
```

### 2. Target Definition and Fragment Optimization
You can define targets from a library. A key feature is `optFrag`, which suggests the best fragments to monitor to avoid overlapping peaks.

```r
# Get target info from a library and target table
Targets <- getTarget(Method = "library", Library = Library, target.table = target.table)

# Optional: Optimize fragment selection to minimize interference
# Best performed before the actual experiment
optTargets <- optFrag(Library = Library, target.table = target.table, forceOpt = TRUE)
```

### 3. Retention Index (RI) Calibration
To improve identification accuracy, create a calibration function using standard RI tables.

```r
# Create the RI calibration function
calibRI <- getRI(RItable)

# Apply calibration to find peaks in a Run
runPeaksRI <- getPeak(Run = Run, Targets = Targets, calibRI = calibRI)
```

### 4. Peak Detection and Scoring
Extract peaks and evaluate the match quality between the experimental data and the library spectra.

```r
# Get peaks for targets in the run
runPeaks <- getPeak(Run = Run, Targets = Targets)

# Calculate similarity scores (Apex and Area scores)
Scores <- getPeakScore(runPeaks = runPeaks, plot = TRUE)
```

### 5. Visualization
Visualize the Total Ion Chromatogram (TIC) or specific Extracted Ion Chromatograms (EIC) for targets.

```r
# Plot TIC of the run
plotTIC(Run = Run)

# Plot EIC of a specific detected peak (e.g., the first target)
plotEIC(peakEIC = runPeaks[[1]][[1]])
```

## Data Structures

- **Run**: A list containing `rt` (retention time), `sc` (scans), `tic` (total ion chromatogram), and `pk` (scan information/mz-intensity pairs).
- **Library**: Contains `compound`, `rt`, `ri`, `ms` (masses), and `sp` (intensities).
- **runPeaks**: A nested list where each element contains peak metadata: `rtApex`, `intApex`, `scoreApex`, `area`, and the `EIC` data.

## Tips for Success
- **Fragment Selection**: Use `optFrag` during the experimental design phase. It helps select fragments that are unique to your analyte compared to the background library.
- **RI Calibration**: Always use `getRI` if you have standard runs available; it significantly reduces false positives in complex matrices.
- **Score Interpretation**: `getPeakScore` provides a distribution of match qualities. Scores closer to 1.0 indicate high spectral similarity to the library reference.

## Reference documentation
- [SIMAT: GC-SIM-MS Analysis Tool](./references/SIMAT-vignette.md)