---
name: bioconductor-asicsdata
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/ASICSdata.html
---

# bioconductor-asicsdata

name: bioconductor-asicsdata
description: Access and use the example 1D NMR dataset from the ASICSdata package. Use this skill when needing sample NMR spectra for testing the ASICS package, demonstrating metabolite identification workflows, or analyzing human metabolome data related to Type 2 Diabetes Mellitus (T2DM).

# bioconductor-asicsdata

## Overview
ASICSdata is a Bioconductor experiment data package providing a subset of 1D 1H NMR spectra from a study on Type 2 Diabetes Mellitus (T2DM). It contains spectra from 50 human subjects (25 healthy volunteers and 25 T2DM patients). This package serves as the primary example dataset for the `ASICS` package, which is used for the automatic identification and quantification of metabolites.

## Loading the Data
The package does not contain R data objects directly in the global environment; instead, it provides raw Bruker spectral files located in the package's installation directory.

To access the data, load the library and locate the external data directory:

```r
library(ASICSdata)

# Get the path to the raw Bruker files
data_path <- system.file("extdata", package = "ASICSdata")
```

## Typical Workflow with ASICS
The main utility of this package is providing input for the `ASICS` analysis pipeline.

1. **Locate Raw Files**: Identify the directory containing the Bruker files.
2. **Import into ASICS**: Use the `readBruker` function from the `ASICS` package to load the spectra.
3. **Pre-processing**: Perform alignment and normalization using `ASICS` functions.

Example of importing the data:

```r
if (!requireNamespace("ASICS", quietly = TRUE)) {
  install.packages("BiocManager")
  BiocManager::install("ASICS")
}
library(ASICS)

# Define path to spectra
spectra_path <- system.file("extdata", package = "ASICSdata")

# List directories (each directory is a sample in Bruker format)
samples <- list.dirs(spectra_path, recursive = FALSE)

# Import spectra using ASICS
# Note: ASICS functions typically expect a directory containing subdirectories of Bruker files
imported_data <- readBruker(spectra_path)
```

## Dataset Details
- **Study**: MTBLS1 (MetaboLights).
- **Population**: 25 Healthy, 25 T2DM patients.
- **Format**: 1D Bruker spectral data.
- **Application**: Used to validate the ASICS algorithm for metabolite quantification in complex mixtures.

## Reference documentation
- [ASICSdata](./references/ASICSdata.md)