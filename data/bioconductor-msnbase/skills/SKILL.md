---
name: bioconductor-msnbase
description: MSnbase provides a standardized infrastructure for the manipulation, processing, and visualization of mass spectrometry data and proteomics workflows. Use when user asks to import raw MS data, process spectra, perform isobaric tagging or label-free quantification, and aggregate peptide data into protein-level results.
homepage: https://bioconductor.org/packages/release/bioc/html/MSnbase.html
---


# bioconductor-msnbase

## Overview

`MSnbase` is a core Bioconductor package designed for the manipulation, processing, and visualization of mass spectrometry (MS) data. It provides a standardized infrastructure for proteomics workflows, bridging the gap between raw MS data (spectra) and quantitative results (expression sets). The package is built around two primary data classes: `MSnExp` for raw data (spectra and metadata) and `MSnSet` for quantitative data (feature-by-sample matrices).

## Core Workflows

### 1. Data Import and Management
`MSnbase` supports XML-based formats (mzML, mzXML, mzData) and peak lists (mgf).

*   **Raw Data Import:** Use `readMSData()`. For large datasets, use `mode = "onDisk"` to minimize RAM usage by reading spectra only when needed.
    ```r
    library(MSnbase)
    raw_data <- readMSData("file.mzML", msLevel = 2, mode = "onDisk")
    ```
*   **Quantitative Data Import:** Use `readMSnSet()` for spreadsheets or `readMzTabData()` for mzTab files.
*   **Chromatograms:** Extract TIC or BPC using `chromatogram()`.

### 2. Raw Data Processing
Before quantification, raw spectra often require cleaning or transformation.

*   **Cleaning:** `removePeaks(object, t)` sets intensities below threshold `t` to 0. `clean(object)` removes consecutive 0-intensity peaks.
*   **Filtering:** `filterMz(object, mzlim)` trims spectra to a specific m/z range (useful for focusing on reporter ions).
*   **Smoothing/Picking:** Use `smooth()` and `pickPeaks()` for noise reduction and centroiding.

### 3. Quantification
`MSnbase` excels at isobaric tagging (TMT/iTRAQ) and label-free quantification.

*   **Isobaric Tagging:** Use `quantify()` with a `ReporterIons` object (e.g., `iTRAQ4`, `TMT10`).
    ```r
    qnt <- quantify(raw_data, method = "trap", reporters = TMT10, strict = FALSE)
    ```
*   **Label-free:** Methods include `count` (spectral counting), `SIn` (spectral index), and `NSAF` (normalized spectral abundance factor).
*   **Purity Correction:** Use `purityCorrect()` to adjust for isotopic impurities in reporter reagents using a manufacturer-supplied matrix.

### 4. MSnSet Manipulation (Quantitative Analysis)
Once data is in an `MSnSet`, use standard Bioconductor patterns.

*   **Normalization:** `normalise(qnt, method = "vsn")` (supports "quantiles", "vsn", "max", "sum").
*   **Handling Missing Values:** `filterNA(qnt, pNA = 0)` removes features with NAs. `impute(qnt, method = "knn")` performs data imputation.
*   **Feature Aggregation:** Combine peptide-level data into protein-level data using `combineFeatures()`.
    ```r
    prot_qnt <- combineFeatures(qnt, groupBy = fData(qnt)$ProteinAccession, method = "median")
    ```

### 5. Visualization
*   **Spectra:** `plot(object[[i]])` for individual spectra; `plot(object, reporters = iTRAQ4)` for experiment-wide views.
*   **Quality Control:** `plot2d(object, z = "ionCount")` for RT vs m/z maps. `plotMzDelta(object)` to assess identification suitability.
*   **Comparison:** `compareSpectra(s1, s2, fun = "dotproduct")` to calculate similarity between two spectra.

## Tips for Efficiency
*   **Parallelization:** Many functions (like `quantify`) support parallel processing via `BiocParallel`. Set thresholds with `setMSnbaseParallelThresh()`.
*   **Memory:** Always prefer `mode = "onDisk"` for initial data loading unless you have a specific need to manipulate every spectrum in memory.
*   **Identification:** Integrate search engine results using `addIdentificationData(msnexp, "results.mzid")`.

## Reference documentation
- [Bugs](./references/Bugs.md)
- [Foreword](./references/Foreword.md)
- [Base Functions and Classes for MS-based Proteomics](./references/v01-MSnbase-demo.md)
- [MSnbase Input/Output Capabilities](./references/v02-MSnbase-io.md)
- [MSnbase Centroiding](./references/v03-MSnbase-centroiding.md)
- [Benchmarking MSnbase On-Disk Infrastructure](./references/v04-benchmarking.md)
- [MSnbase Development and Class Structure](./references/v05-MSnbase-development.md)