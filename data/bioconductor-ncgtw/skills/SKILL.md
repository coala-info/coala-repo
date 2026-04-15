---
name: bioconductor-ncgtw
description: The ncGTW package provides a non-rigid alignment algorithm for LC-MS data that uses individualized warping functions and sample acquisition order to correct retention time drift. Use when user asks to align LC-MS data, detect misaligned features in xcms results, or perform refined peak filling using graphical time warping.
homepage: https://bioconductor.org/packages/release/bioc/html/ncGTW.html
---

# bioconductor-ncgtw

## Overview

The `ncGTW` package provides an alignment algorithm for LC-MS data that addresses the limitations of global warping functions. Unlike standard methods that assume all m/z bins in a sample share the same warping function, `ncGTW` uses individualized warping for different compounds and incorporates the sample acquisition order (run order) to model RT drift more accurately. It is specifically designed to work alongside `xcms` to identify misaligned features and provide refined warping functions that significantly improve the quality of downstream analysis like peak-filling.

## Workflow and Key Functions

### 1. Data Preparation and RT Structure
To use `ncGTW` effectively, samples must be ordered by their actual acquisition time.

```r
library(xcms)
library(ncGTW)

# Ensure file paths are sorted by run order
# Example: sorting based on an index in the filename
file_paths <- list.files(path, pattern = "mzxml", full.names = TRUE)
# ... logic to sort file_paths by acquisition order ...
```

### 2. XCMS Preprocessing
`ncGTW` requires two `xcms` grouping results with different bandwidth (`bw`) parameters to detect misalignments.

```r
# Standard xcms workflow
ds <- xcmsSet(file_paths, method="centWave", ppm=ppm, peakwidth=c(min, max))
agds <- retcor(group(ds, bw=RT_drift_max), missing=5)

# Create two grouping versions for detection
# bwLarge: expected maximal RT drift
# bwSmall: near RT sampling resolution (e.g., 0.3)
xcmsLargeWin <- group(agds, bw=bwLarge)
xcmsSmallWin <- group(agds, bw=bwSmall, minfrac=0)
```

### 3. Misaligned Feature Detection
Identify features that were incorrectly grouped or split by `xcms`.

```r
# Detect misaligned features
excluGroups <- misalignDetect(xcmsLargeWin, xcmsSmallWin, ppm)

# Load raw profiles for the detected features
ncGTWinputs <- loadProfile(file_paths, excluGroups)

# Optional: Visualize misalignments
plotGroup(ncGTWinputs[[1]], xcmsLargeWin@rt$corrected, ind=1)
```

### 4. Realignment with ncGTW
Perform the graphical time warping alignment on the detected features.

```r
ncGTWparam <- new("ncGTWparam")
ncGTWoutputs <- vector('list', length(ncGTWinputs))

# Align features (supports parallel computing via bpParam)
for (n in seq_along(ncGTWinputs)) {
    ncGTWoutputs[[n]] <- ncGTWalign(ncGTWinputs[[n]], xcmsLargeWin, 
                                    parSamp=5, ncGTWparam=ncGTWparam)
}
```

### 5. Integrating Results back to XCMS
Generate new warping functions and update the `xcmsSet` object.

```r
ncGTWres <- xcmsLargeWin
for (n in seq_along(ncGTWinputs)) {
    adjustRes <- adjustRT(ncGTWres, ncGTWinputs[[n]], ncGTWoutputs[[n]], ppm)
    peaks(ncGTWres) <- ncGTWpeaks(adjustRes) # Update peak locations
    # Store corrected RTs if needed for plotting
}
```

### 6. Improved Peak Filling
Refined warping functions lead to more accurate peak filling. Note that `ncGTW` provides a specific version of `fillPeaksChromPar` to handle compound-specific warping.

```r
# Replace xcms internal function with ncGTW version
assignInNamespace("fillPeaksChromPar", ncGTW:::fillPeaksChromPar, ns="xcms")

# Perform peak filling with improved RT alignment
ncGTWresFilled <- fillPeaks(ncGTWres)
```

## Tips for Success
- **Sample Order**: The algorithm relies heavily on the "neighbor-wise" constraint. If the sample order does not match the acquisition order, the alignment quality will degrade.
- **Parallelization**: For datasets with >100 samples, use the `parSamp` and `bpParam` arguments in `ncGTWalign` to split samples into sub-groups for efficiency.
- **Validation**: Use `plotGroup()` before and after realignment to visually confirm that the extracted ion chromatograms (EICs) are better aligned.
- **CV Comparison**: Use `compCV()` to compare the coefficient of variation between standard `xcms` results and `ncGTW` results; a lower CV typically indicates better alignment and peak filling.

## Reference documentation
- [ncGTW User Manual](./references/ncGTW.md)
- [ncGTW R Markdown Source](./references/ncGTW.Rmd)