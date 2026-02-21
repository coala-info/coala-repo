---
name: bioconductor-limmagui
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/limmaGUI.html
---

# bioconductor-limmagui

name: bioconductor-limmagui
description: Graphical User Interface for the limma R package. Use this skill to perform microarray data analysis including normalization, diagnostic plotting, and linear modeling for differential expression using a point-and-click interface or by interacting with limmaGUI's internal R environment.

## Overview
`limmaGUI` provides a Tcl/Tk-based graphical interface for the `limma` package, specifically designed for the analysis of two-color cDNA microarray data. It simplifies complex workflows such as background correction, normalization (within and between arrays), and fitting linear models to experimental designs. While primarily a GUI, it maintains an internal R environment (`limmaGUIenvironment`) that allows advanced users to extract `MAList` and `MArrayLM` objects for command-line manipulation.

## Getting Started
To launch the interface from an R session:
```R
library(limmaGUI)
limmaGUI()
```
*Note for Windows users: If the GUI loses focus to Rgui, switch R to SDI mode or minimize the main Rgui window.*

## Data Input Requirements
The package requires specific tab-delimited text files to define the experiment:

1.  **Targets File**: Maps slides to RNA sources.
    *   Essential columns: `SlideNumber`, `FileName`, `Cy3`, `Cy5`.
    *   For ImaGene: Use `FileNameCy3` and `FileNameCy5`.
2.  **Spot Types File** (Optional): Defines spot categories (e.g., genes, controls, blanks).
    *   Essential columns: `SpotType`, `ID`, `Name`, `Color`.
    *   Uses wildcards (`*`) for pattern matching in ID/Name columns.
3.  **GAL File**: GenePix Array List for gene annotation and layout. Optional if layout is in image-analysis files.

## Typical Workflow
1.  **Project Initialization**: `File -> New` to start a project and load the Targets file.
2.  **Loading Data**: Select image-analysis output (Spot, GenePix, ImaGene, etc.).
3.  **Diagnostics**: Use `Plot` menu for M-A plots, spatial plots, and log-intensity distributions.
4.  **Normalization**: 
    *   Within-array: `printtiploess`, `loess`, `median`.
    *   Between-array: `scale`, `quantile`.
5.  **Linear Modeling**:
    *   Define a parameterization (design matrix).
    *   Compute the model using `Linear Model -> Compute Linear Model`.
    *   View results via `Linear Model -> Compute EB Statistics` and `Toptables`.

## Advanced R Interaction
You can extract data from a saved `.lma` file (which is a standard `.RData` file) for use in standard `limma` scripts:

```R
# Load a limmaGUI project file
load("MyProject.lma")
library(limma)

# Access the internal environment
# Objects are stored in limmaGUIenvironment
ls(limmaGUIenvironment)

# Common objects to extract:
raw_data <- limmaGUIenvironment$RG          # RGList
norm_data <- limmaGUIenvironment$MAboth     # MAList (normalized)
fit <- limmaGUIenvironment$ParameterizationList[[1]]$fit # MArrayLM
```

## Customization
Advanced users can modify the GUI menus by editing `limmaGUI-menus.txt` located in the package's `etc` directory:
```R
system.file("etc", package="limmaGUI")
```
You can add custom R scripts to this directory to extend the GUI's functionality.

## Reference documentation
- [About limmaGUI](./references/about.md)
- [limmaGUI Input Files](./references/InputFiles.md)
- [Linear Models in Microarrays: An Introduction](./references/LinModIntro.md)
- [Extracting limma objects from limmaGUI files](./references/extract.md)
- [Importing MA Data into LimmaGUI](./references/import.md)
- [LimmaGUI Developers' Guide](./references/lgDevel.md)
- [Customizing the menus in limmaGUI](./references/CustMenu.md)
- [Troubleshooting Window Focus Problems](./references/windowsFocus.md)