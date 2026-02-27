---
name: bioconductor-olingui
description: This tool provides a graphical user interface and functions for the visualization, normalization, and quality testing of two-channel microarray data. Use when user asks to perform exploratory data analysis, conduct statistical bias testing using ANOVA or FDR, or apply optimized local intensity-dependent normalization to microarray objects.
homepage: https://bioconductor.org/packages/release/bioc/html/OLINgui.html
---


# bioconductor-olingui

name: bioconductor-olingui
description: Graphical user interface for visualization, normalization, and quality testing of two-channel microarray data. Use this skill when the user needs to perform exploratory data analysis (EDA), statistical bias testing (ANOVA, FDR), or optimized local intensity-dependent normalization (OLIN) on marrayRaw or marrayNorm objects using a GUI or the underlying OLIN functions.

# bioconductor-olingui

## Overview

The `OLINgui` package provides a Tcl/Tk graphical user interface for the `OLIN` package. It is designed for the analysis of two-channel microarray data. The workflow typically involves loading `marray` objects, visualizing spatial and intensity-dependent biases, performing statistical tests to identify experimental artifacts, and applying various normalization schemes (including optimized local regression).

While the package is centered around a GUI launched by `OLINgui()`, it relies on `marray` objects and `OLIN` functions. This skill covers both the GUI workflow and the programmatic execution of the underlying analysis.

## Typical Workflow

### 1. Starting the Interface
To launch the interactive GUI:
```r
library(OLINgui)
OLINgui()
```

### 2. Loading Data
The package requires data to be in `marrayRaw` or `marrayNorm` format.
- **Marray Objects**: Can be imported from the global environment or loaded from an R data file (.RData).
- **XY List**: Some spatial functions (like `mxy2.plot`) require a list with "X" and "Y" coordinates of spots.
- **Example Data**:
  ```r
  data(sw)    # Load target marrayRaw object
  data(sw.xy) # Load corresponding spatial coordinates
  ```

### 3. Visualization
Use these functions to inspect data quality:
- **fgbg.visu**: Displays spatial distribution of foreground and background intensities.
- **MA plot**: Displays log-fold change (M) vs. average intensity (A).
- **mxy.plot**: Visualizes spatial distribution of M using row/column indices.
- **mxy2.plot**: Visualizes spatial distribution of M using actual X/Y coordinates.

### 4. Statistical Bias Testing
Identify if normalization is required by testing for systematic errors:
- **ANOVA**: Assess bias based on Plate, Pin (print-tip), Intensity (A), or Spatial location.
- **FDR/Permutation Tests**:
  - `fdr.int` / `p.int`: Test for intensity-dependent dye bias.
  - `fdr.spatial` / `p.spatial`: Test for location-dependent dye bias.
- **Tip**: Low FDR or p-values (often plotted as -log10) indicate significant experimental bias.

### 5. Normalization
The package supports several schemes via the `olin` function:
- **IN**: Local regression (loess) on intensity.
- **LIN**: Local regression on intensity and location.
- **OIN/OLIN**: Optimized versions of the above using Generalized Cross-Validation (GCV) to find the best smoothing parameters.
- **OSLIN**: Optimized scaling and local intensity-dependent normalization.

**Key Parameters:**
- **Smoothing**: A scalar (for LIN) or a vector of values (for OLIN/OIN) to be tested via GCV.
- **Scaling**: Determines the weight of Y-direction vs X-direction smoothing.
- **Iterations**: Usually 3 iterations are sufficient for convergence.

### 6. Exporting Results
After normalization in the GUI, the resulting `maNorm` object must be exported back to the global environment or saved to a file to be used in downstream Bioconductor pipelines (e.g., `limma`).

## Tips
- **Data Classes**: Ensure your data is a `marrayRaw` or `marrayNorm` object. If you have `ExpressionSet` or `FeatureSet` objects, they must be converted first.
- **One at a time**: The GUI processes one data set at a time. To visualize normalized data, you must export it and then reload it as the active data set.
- **Coordinate Lists**: If your microarray layout is non-standard, ensure your XY list matches the dimensions of the marray object exactly.

## Reference documentation
- [Introduction to OLINgui](./references/OLINgui.md)