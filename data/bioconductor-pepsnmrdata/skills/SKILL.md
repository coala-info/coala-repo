---
name: bioconductor-pepsnmrdata
description: This package provides raw and pre-processed 1H NMR metabolomic datasets from human urine and serum for use with the PepsNMR workflow. Use when user asks to access example NMR data, demonstrate NMR pre-processing steps, or retrieve reference metabolomics datasets for analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/PepsNMRData.html
---


# bioconductor-pepsnmrdata

name: bioconductor-pepsnmrdata
description: Provides raw and pre-processed 1H NMR metabolomic datasets from human urine and serum. Use when Claude needs example NMR data for the PepsNMR package, wants to demonstrate NMR pre-processing workflows, or requires reference datasets for metabolomics analysis.

# bioconductor-pepsnmrdata

## Overview
PepsNMRData is a Bioconductor experiment data package that provides 1H NMR datasets specifically designed to support the PepsNMR package. It contains raw Free Induction Decays (FIDs), acquisition parameters, and intermediate pre-processed data snapshots for both Human Serum (HS) and Human Urine (HU) samples.

## Loading Data
To use the datasets, first load the package and then use the `data()` function for R objects or `system.file()` for raw Bruker files.

```r
library(PepsNMRData)

# Load a specific dataset
data("FidData_HS")

# Access raw Bruker files in the filesystem
raw_path <- system.file("extdata", package = "PepsNMRData")
list.dirs(raw_path, full.names = FALSE)
```

## Available Datasets

### Raw Data and Metadata
- **FidData_HS / FidData_HU**: Complex matrices containing raw FIDs (32 serum samples, 24 urine samples).
- **FidInfo_HS / FidInfo_HU**: Matrices containing acquisition parameters (Sweep Width, Time Domain, Dwell Time, etc.).
- **Group_HS / Group_HU**: Vectors indicating the class/group membership of the donors.

### Pre-processing Snapshots
The package provides "step-by-step" datasets (`Data_HS_sp` and `Data_HU_sp`) which are lists containing the first 4 FIDs/spectra after every stage of the PepsNMR workflow. This is useful for validating individual processing steps:
- `FidData_..._0`: Raw FIDs
- `FidData_..._1` to `_3`: Phase correction, solvent suppression, apodization.
- `Spectrum_data_..._4` to `_14`: Fourier transform, zero-order phase correction, calibration, baseline correction, warping, bucketing, and normalization.

### Final Processed Spectra
- **FinalSpectra_HS / FinalSpectra_HU**: Complex matrices containing the fully pre-processed spectra ready for statistical analysis.

## Typical Workflow Examples

### Visualizing Raw vs. Processed Data
```r
data("FidData_HS")
data("FinalSpectra_HS")

# Plot a raw FID (Real part)
plot(Re(FidData_HS[1,]), type = "l", main = "Raw FID")

# Plot a processed spectrum
plot(Re(FinalSpectra_HS[1,]), type = "l", main = "Processed Spectrum")
```

### Accessing Acquisition Parameters
Metadata is essential for setting parameters in the `PepsNMR` processing functions.
```r
data("FidInfo_HS")
# View parameters for the first sample
FidInfo_HS[1, ]
# Common parameters: SW (Sweep Width), TD (Time Domain), DT (Dwell Time)
```

## Tips
- **Complex Numbers**: Most NMR data in this package is stored as complex matrices. Use `Re()` to access the real part for standard plotting.
- **Experimental Design**: The Human Serum dataset follows a specific design (4 donors, 8 different days with replicates) which is useful for testing batch effect correction or ANOVA-type models.
- **Urine Specifics**: The `Data_HU_sp` dataset includes an additional step (`_13`) for zone aggregation of the citrate peak, which is a common requirement in urine NMR.

## Reference documentation
- [PepsNMRData Reference Manual](./references/reference_manual.md)