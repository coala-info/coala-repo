---
name: bioconductor-affyilm
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/affyILM.html
---

# bioconductor-affyilm

## Overview
The `affyILM` package is a specialized preprocessing tool for Affymetrix microarrays. Unlike standard methods (like RMA or MAS5) that provide relative intensity units, `affyILM` uses a physical model based on the Langmuir isotherm to estimate gene expression as actual concentrations measured in picoMolar (pM). It reads raw CEL files directly and does not require data to be pre-formatted into an `AffyBatch` object.

## Core Workflow

### 1. Initialization and Data Loading
Load the library and identify the paths to your CEL files.
```R
library(affyILM)

# Define paths to CEL files
cel_files <- c("sample1.CEL", "sample2.CEL")
```

### 2. Estimating Concentrations (ilm)
The `ilm()` function is the primary entry point. It calculates hybridization free energies and estimates concentrations.
```R
# Basic usage
result <- ilm(cel_files)

# Usage with custom saturation limit (default is 10000)
result_custom <- ilm(cel_files, satLim = 12000)
```

### 3. Extracting Results
The output of `ilm()` is an object of class `ILM`. Use specific accessor functions to retrieve data.

*   **Get Intensities:** Retrieve measured Perfect Match (PM) intensities.
    ```R
    # Get intensities for a specific probeset
    intens <- getIntens(result, "probeset_id")
    ```
*   **Get Concentrations:** Retrieve the estimated expression levels in pM.
    ```R
    # Get probe concentrations
    concs <- getProbeConcs(result, "probeset_id")
    ```
*   **Subsetting:** You can subset `ILM` objects using standard bracket notation for specific probesets or files.
    ```R
    # Subset for one probeset
    sub_res <- result["AFFX-r2-Ec-bioD-5_at"]
    ```

### 4. Visualization
The package provides tools to visualize the raw data and the fit of the Langmuir model.

*   **Intensity Plot:** Plot PM intensities for a probeset.
    ```R
    plotIntens(result, "probeset_id", "filename.CEL")
    ```
*   **Langmuir Isotherm Plot:** Visualize the isotherm fit and retrieve calculated thermodynamic values (deltaG, alpha, etc.).
    ```R
    # Returns a list of computed values and generates a plot
    isotherm_data <- plotILM(result, "probeset_id", "filename.CEL")
    ```

## Tips and Requirements
*   **Dependencies:** Ensure `affxparser`, `affy`, `Biobase`, and `gcrma` are installed.
*   **Probe Packages:** `affyILM` requires chip-specific probe packages (e.g., `hgfocusprobe`). If missing, R will attempt to download them automatically during the `ilm()` call if an internet connection is available.
*   **Memory:** Reading many CEL files simultaneously can be memory-intensive; ensure your environment has sufficient RAM for large datasets.
*   **Background:** In the current release, the default background estimation ($I_0$) is 0.

## Reference documentation
- [affyILM](./references/affyILM.md)