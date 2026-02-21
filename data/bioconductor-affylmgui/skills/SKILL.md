---
name: bioconductor-affylmgui
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/affylmGUI.html
---

# bioconductor-affylmgui

## Overview
The `affylmGUI` package provides a Tcl/Tk-based Graphical User Interface for the analysis of Affymetrix microarray data. It acts as a wrapper for the `limma` package, allowing users to perform linear modeling, normalization (RMA, PLM), and identification of differentially expressed genes without extensive command-line knowledge. It also supports advanced users by allowing the extraction of standard Bioconductor objects (AffyBatch, ExpressionSet, MArrayLM) from saved project files for further custom analysis.

## Core Workflows

### Launching the GUI
To start the interactive interface, use the following command in an R session:
```r
library(affylmGUI)
affylmGUI()
```
*Note: On Windows, it is recommended to run R in SDI (Single Document Interface) mode or minimize the main RGui window to avoid focus-stealing issues.*

### Programmatic Data Extraction
Advanced users can extract data from `.lma` (limma) project files, which are standard `.RData` files, to perform command-line analysis.

1. **Load the Project File:**
```r
# .lma files are RData files containing the project state
load("YourProject.lma")
library(affy)
library(limma)
```

2. **Access Raw and Normalized Data:**
- `RawAffyData`: An `AffyBatch` object containing raw probe-level data.
- `NormalizedAffyData`: An `ExpressionSet` (or `exprSet`) object containing normalized values.
- `NormMethod`: A string indicating the normalization used (e.g., "RMA").

3. **Access Linear Model Results:**
Linear model fits and empirical Bayes statistics are stored in `ContrastParameterizationList`.
```r
# Access the first contrast parameterization
fit <- ContrastParameterizationList[[1]]$fit
eb  <- ContrastParameterizationList[[1]]$eb

# Extract moderated t-statistics
t_stats <- eb$t

# Extract p-values
p_vals <- eb$p.value
```

### Customizing the Interface
Advanced users can modify the GUI menus by editing the configuration file:
- **File Location:** `system.file("etc", package="affylmGUI")`
- **Menu Definition:** Edit `affylmGUI-menus.txt` to add or enable menu items.
- **Extensions:** Add `.R` source files to the `etc` directory to define new functions called by custom menu items.

## Tips and Troubleshooting
- **Windows Focus:** If the GUI window disappears behind the R console, switch R to SDI mode (Edit -> GUI Preferences -> SDI) or minimize the R console.
- **Object Classes:** Ensure `library(limma)` and `library(affy)` are loaded when working with extracted objects so that S4 classes are recognized correctly.
- **Annotation:** The `geneNames` vector in the saved project contains the annotation derived from the chip's metadata package.

## Reference documentation
- [Customizing affylmGUI menus](./references/CustMenu.md)
- [About affylmGUI](./references/about.md)
- [affylmGUI Package Vignette](./references/affylmGUI.md)
- [Extracting limma objects from affylmGUI files](./references/extract.md)
- [affylmGUI Index](./references/index.md)
- [Troubleshooting Windows Focus Problems](./references/windowsFocus.md)