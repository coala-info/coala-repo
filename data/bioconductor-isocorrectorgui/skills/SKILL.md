---
name: bioconductor-isocorrectorgui
description: IsoCorrectoRGUI corrects mass spectrometry data from stable isotope labeling experiments for natural abundance and tracer impurity. Use when user asks to perform isotopic correction on MS or MS/MS data, launch the IsoCorrectoR graphical user interface, or process high-resolution multiple-tracer experiments.
homepage: https://bioconductor.org/packages/release/bioc/html/IsoCorrectoRGUI.html
---


# bioconductor-isocorrectorgui

name: bioconductor-isocorrectorgui
description: Correction of mass spectrometry data from stable isotope labeling experiments for natural abundance and tracer purity. Use this skill when you need to perform isotopic correction on MS or MS/MS data (normal or high resolution) using the IsoCorrectoR algorithm, either via the graphical user interface (GUI) or the R console.

# bioconductor-isocorrectorgui

## Overview

IsoCorrectoRGUI provides a user-friendly interface and R functions for the `IsoCorrectoR` framework. It corrects mass spectrometry data for natural stable isotope abundance and tracer impurity. It supports various tracer isotopes (13C, 15N, 18O, etc.) and can handle both MS1 and MS/MS data. A key feature is its ability to correct high-resolution data from multiple-tracer experiments (e.g., simultaneous 13C and 15N labeling).

## Workflow and Usage

### 1. Launching the GUI
The GUI provides an interactive way to set parameters and select files.
```r
library(IsoCorrectoRGUI)
IsoCorrectionGUI()
```

### 2. Console-Based Correction
For batch processing or integration into R scripts, use the `IsoCorrection()` function.
```r
library(IsoCorrectoR) # Loaded automatically with IsoCorrectoRGUI

results <- IsoCorrection(
  MeasurementFile = "path/to/measurements.csv",
  ElementFile = "path/to/elements.csv",
  MoleculeFile = "path/to/molecules.csv",
  DirOut = "output_folder",
  FileOut = "my_results",
  FileOutFormat = "csv", # or "xls"
  ReturnResultsObject = TRUE,
  CorrectTracerImpurity = TRUE,
  UltraHighRes = FALSE
)
```

### 3. Input File Requirements
The package requires three specific input files (CSV or Excel):

*   **Molecule Information File**: Defines the chemical formula and tracer positions.
    *   Use the prefix `Lab` to mark tracer elements (e.g., `C6H12O2N1LabC2`).
    *   For MS/MS, include both product ion and neutral loss formulas.
*   **Measurement File**: Contains raw intensity data.
    *   Nomenclature: `MoleculeName_x` (MS1) or `MoleculeName_x.y` (MS/MS), where `x` is precursor mass shift and `y` is product mass shift.
    *   High-Res: `MoleculeName_C2.N1` (for 2x 13C and 1x 15N).
*   **Element Information File**: Lists natural abundances and tracer purity.

### 4. Key Parameters
*   `CorrectTracerImpurity`: Set to `TRUE` if the tracer substrate is not 100% pure.
*   `CorrectTracerElementCore`: Usually `TRUE`; accounts for natural abundance in the part of the molecule that incorporates the tracer.
*   `UltraHighRes`: Set to `TRUE` only for high-resolution data where mass defects of different isotopes (e.g., 13C vs 15N) are resolved.
*   `ReturnResultsObject`: If `TRUE`, the function returns a list containing data frames of the results.

### 5. Interpreting Results
The tool generates several output types:
*   **Corrected**: Total amount of labeled species (default).
*   **CorrectedFractions**: Relative distribution of isotopologues.
*   **Residuals**: Indicates goodness of fit; high residuals suggest measurement errors or peak overlaps.
*   **MeanEnrichment**: Calculated weighted average of isotope incorporation.

## Tips for Success
*   **Missing Values**: You can leave cells blank in the measurement file. IsoCorrectoR will perform partial correction for the available species rather than assuming the value is zero.
*   **Excel Support**: To write `.xls` files, a Perl installation (like Strawberry Perl on Windows) is required. CSV output does not require Perl.
*   **High Resolution**: In high-res mode, only tracer elements are relevant; other elements do not need to be provided in the molecule file.

## Reference documentation
- [Introduction to IsoCorrectoR](./references/IsoCorrectoRGUI.md)