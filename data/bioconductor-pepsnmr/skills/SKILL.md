---
name: bioconductor-pepsnmr
description: This tool pre-processes raw 1H NMR metabolomic data to transform Bruker FID signals into interpretable spectra. Use when user asks to read Bruker FIDs, perform group delay correction, suppress solvent signals, apply apodization, or execute a complete NMR spectral processing workflow.
homepage: https://bioconductor.org/packages/release/bioc/html/PepsNMR.html
---


# bioconductor-pepsnmr

name: bioconductor-pepsnmr
description: Pre-processing of 1H NMR metabolomic data using the PepsNMR package. Use this skill to transform raw Bruker FID signals into interpretable spectra through a complete workflow including group delay correction, solvent suppression, apodization, Fourier transform, phase correction, baseline correction, and normalization.

# bioconductor-pepsnmr

## Overview

The `PepsNMR` package provides a comprehensive suite of tools for the pre-processing of 1H NMR (Nuclear Magnetic Resonance) spectroscopy data. It is designed to transform raw Free Induction Decays (FIDs) into high-quality spectra suitable for metabolomic analysis. The package follows a modular approach where each step of the NMR pre-processing pipeline is handled by a specific function, allowing for fine-tuned control over the data transformation.

## Installation

To install the package from Bioconductor:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("PepsNMR")
# PepsNMRData is recommended for example datasets
BiocManager::install("PepsNMRData")
```

## Data Importation

The primary function for loading raw Bruker data is `ReadFids`. It expects a path to a directory containing Bruker NMR experiments.

```r
library(PepsNMR)
# path should point to the parent folder of Bruker experiment numbers
fidList <- ReadFids(path_to_data) 

Fid_data <- fidList[["Fid_data"]] # Matrix of complex FIDs
Fid_info <- fidList[["Fid_info"]] # Metadata required for subsequent steps
```

## Standard Pre-processing Workflow

The recommended sequence of operations is as follows:

1.  **Group Delay Correction**: Removes Bruker digital filter artifacts.
    ```r
    Fid_GDC <- GroupDelayCorrection(Fid_data, Fid_info)
    ```
2.  **Solvent Suppression**: Removes residual water/solvent signals using Whittaker smoothing.
    ```r
    Fid_SS <- SolventSuppression(Fid_GDC)$Fid_data
    ```
3.  **Apodization**: Increases Signal-to-Noise ratio (usually via exponential decay).
    ```r
    Fid_A <- Apodization(Fid_SS, Fid_info)
    ```
4.  **Zero Filling**: Improves digital resolution.
    ```r
    Fid_ZF <- ZeroFilling(Fid_A, fn = ncol(Fid_A))
    ```
5.  **Fourier Transform**: Converts time-domain FIDs to frequency-domain spectra (ppm).
    ```r
    Spec_FT <- FourierTransform(Fid_ZF, Fid_info)
    ```
6.  **Zero Order Phase Correction**: Aligns the real part of the spectrum to absorptive mode.
    ```r
    Spec_ZOPC <- ZeroOrderPhaseCorrection(Spec_FT)
    ```
7.  **Internal Referencing**: Calibrates the ppm scale (e.g., setting TMSP to 0 ppm).
    ```r
    Spec_IR <- InternalReferencing(Spec_ZOPC, Fid_info, ppm.value = 0)$Spectrum_data
    ```
8.  **Baseline Correction**: Removes the spectral baseline using Asymmetric Least Squares.
    ```r
    Spec_BC <- BaselineCorrection(Spec_IR, lambda.bc = 1e8, p.bc = 0.01)$Spectrum_data
    ```
9.  **Negative Values Zeroing**: Sets non-physical negative intensities to zero.
    ```r
    Spec_NVZ <- NegativeValuesZeroing(Spec_BC)
    ```
10. **Warping**: Aligns peaks across samples using Semi-Parametric Time Warping.
    ```r
    Spec_W <- Warping(Spec_NVZ, reference.choice = "fixed")$Spectrum_data
    ```

## Post-processing and Analysis

After the core pre-processing, data reduction and normalization are typically performed:

*   **Window Selection**: `WindowSelection(Spec_W, from.ws = 10, to.ws = 0.2)`
*   **Bucketing**: `Bucketing(Spec_WS, intmeth = "t")`
*   **Region Removal**: `RegionRemoval(Spec_B, typeofspectra = "serum")` (removes water region).
*   **Normalization**: `Normalization(Spec_RR, type.norm = "mean")`

## Visualization

Use the `Draw` function to inspect signals or perform exploratory analysis:

```r
# Plot spectra
Draw(Spec_N, type.draw = "signal", subtype = "stacked")

# PCA Analysis
Draw(Spec_N, type.draw = "pca", type.pca = "scores", Class = metadata_groups)
```

## Reference documentation

- [Application of PepsNMR on the Human Serum dataset](./references/PepsNMR_minimal_example.Rmd)
- [Application of PepsNMR on the Human Serum dataset (Markdown)](./references/PepsNMR_minimal_example.md)