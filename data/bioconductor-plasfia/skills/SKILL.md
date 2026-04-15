---
name: bioconductor-plasfia
description: This package provides a Flow Injection Analysis High-Resolution Mass Spectrometry dataset of human plasma spiked with 40 compounds for benchmarking metabolomics workflows. Use when user asks to access FIA-HRMS datasets, test the proFIA package, or explore Orbitrap Fusion mass spectrometry data.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/plasFIA.html
---

# bioconductor-plasfia

name: bioconductor-plasfia
description: A specialized skill for working with the plasFIA Bioconductor package. Use this skill when analyzing Flow Injection Analysis High-Resolution Mass Spectrometry (FIA-HRMS) data, specifically for accessing the human plasma dataset spiked with 40 compounds. This skill is essential for benchmarking metabolomics workflows, testing the proFIA package, or exploring Orbitrap Fusion mass spectrometry data.

## Overview

The `plasFIA` package provides a high-quality FIA-HRMS dataset consisting of human plasma samples spiked with 40 known compounds at three different concentrations (10, 100, and 1000 ng/mL). It includes raw mzML files (centroid format) and pre-processed `proFIAset` objects. This dataset is primarily used to demonstrate and validate the processing capabilities of the `proFIA` package, which is designed for the untargeted analysis of FIA-HRMS data.

## Loading the Dataset

To use the data provided in the package, load the library and use the `data()` function to bring the objects into the R environment.

```R
library(plasFIA)

# Load the pre-processed proFIAset object
data(plasSet)

# Load information about the 40 spiked molecules
data(plasMols)

# Load information about the 6 plasma samples
data(plasSamples)
```

## Data Objects and Structure

### 1. plasSet (proFIAset object)
This is the core data object containing the signals detected in the mzML files. It was generated using the `analyzeAcquisitionFIA` function from the `proFIA` package with parameters optimized for Orbitrap Fusion (ppm = 2, fracGroup = 0.2, ppmgroup = 0.5).
- **Usage**: Use this to test downstream metabolomics statistics or visualization functions in `proFIA`.
- **Contents**: 3529 detected peaks and 834 grouped features.

### 2. plasMols (Data Frame)
Contains chemical metadata for the 40 spiked compounds.
- **Columns**: `formula`, `names`, `classes` (chemical family), `mass` (monoisotopic), and `mass_M+H`.
- **Purpose**: Use this as a "ground truth" list to verify if your peak picking or annotation workflow correctly identifies the spiked compounds.

### 3. plasSamples (Data Frame)
Contains the experimental design for the 6 samples.
- **Columns**: `filename`, `concentration_ng_ml` (10, 100, or 1000), and `replicate`.
- **Purpose**: Use this to define groups for differential analysis or to build regression models for concentration.

## Typical Workflow

1. **Access Raw Files**:
   The raw mzML files are stored within the package directory. You can locate them using:
   ```R
   mzml_dir <- system.file("mzML", package = "plasFIA")
   list.files(mzml_dir)
   ```

2. **Exploratory Analysis**:
   Combine `plasSet` with `plasSamples` to visualize how signal intensity correlates with the spiked concentrations.
   ```R
   # Example: Extracting the data matrix from the proFIAset
   intensities <- proFIA::groupVariable(plasSet)
   ```

3. **Validation**:
   Compare the m/z values found in `plasSet` features against the theoretical `mass_M+H` values in `plasMols` to calculate mass accuracy or sensitivity.

## Tips
- The `plasSet` object requires the `proFIA` package to be installed for full functionality (e.g., plotting, filtering).
- This dataset is specifically "Positive Ionization" mode data.
- Because the data is already centroided and pre-processed, it is an excellent resource for testing new algorithms for peak grouping or isotope detection without needing to run heavy raw-data processing.

## Reference documentation
- [plasFIA Reference Manual](./references/reference_manual.md)