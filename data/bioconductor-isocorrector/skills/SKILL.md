---
name: bioconductor-isocorrector
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/IsoCorrectoR.html
---

# bioconductor-isocorrector

## Overview

IsoCorrectoR is a tool for correcting mass spectrometry (MS) data from stable isotope labeling experiments. It accounts for the natural abundance of isotopes and the isotopic impurity of the tracer substrate. It supports:
- **Normal Resolution**: MS and MS/MS data.
- **High Resolution**: Multiple-tracer experiments (e.g., simultaneous 13C and 15N) where mass defects are resolved.
- **Flexible Tracers**: Works with any tracer element (13C, 15N, 18O, etc.).

## Core Workflow

The primary interface is the `IsoCorrection()` function. It requires three input files (CSV or Excel) and produces corrected data files and a log.

### 1. Basic Function Call

```R
library(IsoCorrectoR)

results <- IsoCorrection(
  MeasurementFile = "path/to/measurements.csv",
  ElementFile = "path/to/elements.csv",
  MoleculeFile = "path/to/molecules.csv",
  DirOut = "./output_folder",
  FileOut = "my_experiment",
  FileOutFormat = "csv", # or "xls"
  ReturnResultsObject = TRUE
)
```

### 2. Input File Requirements

*   **Molecule Information**: Defines the chemical formula of the ions.
    *   Use the prefix `Lab` to identify the tracer element (e.g., `C6H12O2N1LabC2`).
    *   For MS/MS, provide both the product ion and the neutral loss formulas.
*   **Measurement Data**: Contains raw intensities.
    *   Row names must follow the `Molecule_x.y` (MS/MS) or `Molecule_x` (MS) format, where `x` is precursor mass shift and `y` is product mass shift.
    *   High-res names use element notation: `Gly_C2.N1`.
*   **Element Information**: Defines isotope abundances and tracer purity.
    *   Format: `Abundance_MassShift/Abundance_MassShift` (e.g., `0.0107_1/0.9893_0` for Carbon).

### 3. Key Parameters

*   **CorrectTracerImpurity**: Set to `TRUE` if the tracer substrate is not 100% pure (requires purity values in the Element File).
*   **CorrectTracerElementCore**: Usually `TRUE`. Corrects for natural abundance in the atoms that could potentially be labeled.
*   **UltraHighRes**: Set to `TRUE` for high-resolution data. Note: MS/MS is not supported in high-res mode.
*   **CalculateMeanEnrichment**: Automatically calculates the weighted average of labeling for each molecule.

## Handling Results

The function returns a list if `ReturnResultsObject = TRUE`:
- `success`: Boolean/String indicating status.
- `results`: A list of dataframes (Corrected, Fractions, Residuals, etc.).
- `log`: Details of the run.

### Interpreting Residuals
- **Residuals**: Absolute error of the correction.
- **RelativeResiduals**: Residuals divided by corrected values. High values relative to signal suggest poor peak integration or measurement errors.

## Tips for Success

- **Missing Values**: You can leave cells blank in the Measurement File. IsoCorrectoR will perform partial correction for the available isotopologues rather than assuming missing values are zero.
- **Excel Output**: Writing to `.xls` requires a Perl installation (e.g., Strawberry Perl on Windows). Use `csv` to avoid this dependency.
- **Sum Formulas**: Ensure every element has a count, even if it is 1 (e.g., `N1`, not just `N`).
- **High-Res Tracer Order**: In the Measurement File, the order of elements in the name (e.g., `Gly_C2.N1`) must match the order in the Molecule File sum formula (`LabC2LabN1`).

## Reference documentation

- [Introduction to IsoCorrectoR](./references/IsoCorrectoR.md)