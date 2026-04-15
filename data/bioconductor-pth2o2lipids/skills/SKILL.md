---
name: bioconductor-pth2o2lipids
description: This package provides annotated HPLC-ESI-MS lipidomics data from the marine diatom Phaeodactylum tricornutum under oxidative stress. Use when user asks to load the ptH2O2lipids dataset, access LOBSet or xsAnnotate objects, or demonstrate lipid identification workflows using LOBSTAHS and xcms.
homepage: https://bioconductor.org/packages/release/data/experiment/html/PtH2O2lipids.html
---

# bioconductor-pth2o2lipids

name: bioconductor-pth2o2lipids
description: Access and analyze HPLC-ESI-MS lipidomics data from Phaeodactylum tricornutum under oxidative stress. Use this skill to load the ptH2O2lipids dataset, explore LOBSet and xsAnnotate objects, and demonstrate lipid identification workflows using LOBSTAHS and xcms.

## Overview

The `PtH2O2lipids` package is a Bioconductor data package providing annotated HPLC-ESI-MS lipid data from the marine diatom *Phaeodactylum tricornutum*. The data captures the lipidomic response to hydrogen peroxide (H2O2) treatments (0, 30, and 150 µM) across three timepoints (4, 8, and 24 hours). 

The package is primarily used as a reference dataset for lipidomics workflows, specifically for users working with the `LOBSTAHS`, `xcms`, and `CAMERA` packages. It contains two main objects:
1. `ptH2O2lipids$LOBSet`: A screened peak list with compound assignments and isomer identifications.
2. `ptH2O2lipids$xsAnnotate`: The parent object containing peak groups and pseudospectra used to generate the LOBSet.

## Loading and Accessing Data

To use the dataset, load the package and call the `data()` function:

```r
library(PtH2O2lipids)
data(ptH2O2lipids)

# Explore the structure of the list object
names(ptH2O2lipids)
# [1] "LOBSet"     "xsAnnotate"
```

### Accessing the LOBSet Object
The `LOBSet` object (from the `LOBSTAHS` package) contains the final screened lipid data.

```r
# View peak data
head(ptH2O2lipids$LOBSet@peakdata)

# Access sample names
ptH2O2lipids$LOBSet@sampnames

# Access isomer identification slots
ptH2O2lipids$LOBSet@iso_C3r
```

### Accessing the xsAnnotate and xcmsSet Objects
The `xsAnnotate` object (from the `CAMERA` package) contains the raw peak annotations.

```r
# Access the xsAnnotate object
ptH2O2lipids$xsAnnotate

# Access the underlying xcmsSet object
raw_xcms_set <- ptH2O2lipids$xsAnnotate@xcmsSet
```

## Typical Workflow: Re-screening Data

A common use case is to reproduce the screening process or apply different parameters using the `doLOBscreen` function from the `LOBSTAHS` package.

```r
library(LOBSTAHS)

# Re-generate the LOBSet from the xsAnnotate object
myPtH202LOBSet <- doLOBscreen(
  ptH2O2lipids$xsAnnotate, 
  polarity = "positive",
  database = NULL,        # Uses default LOBSTAHS database
  remove.iso = TRUE, 
  rt.restrict = TRUE, 
  rt.windows = NULL,
  exclude.oddFA = TRUE, 
  match.ppm = 2.5
)
```

## Data Interpretation Tips

- **Experimental Design**: The dataset includes 16 samples. Note that the 4h timepoint for 0 and 150 µM treatments only has a single replicate, while others are in duplicate.
- **Lipid Assignments**: The `LOBSet` includes putative compound assignments. Isomer information is stored in the `iso_C3r`, `iso_C3f`, and `iso_C3c` slots.
- **Missing Data**: This specific dataset does not include Polyunsaturated Aldehyde (PUA) identifications.
- **Downstream Analysis**: Use `getLOBpeaklist(ptH2O2lipids$LOBSet)` to export the data into a standard R data frame for statistical analysis or visualization (e.g., PCA, heatmaps).

## Reference documentation

- [PtH2O2lipids Reference Manual](./references/reference_manual.md)