---
name: bioconductor-mobilitytransformr
description: This tool transforms migration time scales in Capillary Electrophoresis-Mass Spectrometry data into effective mobility scales to improve data reproducibility. Use when user asks to convert migration time to effective mobility, handle electroosmotic flow fluctuations, or normalize CE-MS metabolomics and proteomics datasets.
homepage: https://bioconductor.org/packages/3.16/bioc/html/MobilityTransformR.html
---


# bioconductor-mobilitytransformr

name: bioconductor-mobilitytransformr
description: Perform effective mobility transformation of Capillary Electrophoresis-Mass Spectrometry (CE-MS) data. Use this skill when you need to convert migration time (MT) scales to effective mobility (µeff) scales to improve reproducibility and handle EOF fluctuations in metabolomics or proteomics datasets.

# bioconductor-mobilitytransformr

## Overview
`MobilityTransformR` is an R package designed to transform the migration time (MT) scale of CE-MS data into an effective mobility ($µ_{eff}$) scale. This transformation is critical for CE-MS because migration times are often inconsistent due to fluctuations in the Electroosmotic Flow (EOF). The package supports transformation of single values, `Spectra` objects, and `OnDiskMSnExp` objects, allowing for seamless integration with the `xcms` and `MSnbase` ecosystems.

## Core Workflow

### 1. Data Loading
Load CE-MS data (typically .mzML) using `MSnbase` or `Spectra`.

```r
library(MobilityTransformR)
library(xcms)
library(Spectra)

# Load as OnDiskMSnExp
fl <- list.files(system.file("extdata/", package = "MobilityTransformR"), 
                 pattern = ".mzML", full.names = TRUE)
raw_data <- readMSData(files = fl, mode = "onDisk")

# Or load as Spectra object
spectra_data <- Spectra(fl[1], backend = MsBackendMzR())
```

### 2. Determining Marker Migration Times
Before transformation, you must identify the migration times of markers (e.g., Paracetamol for EOF, Procaine for charged markers) in your specific runs.

```r
# Define mz and mt windows for the marker
mz_paracetamol <- c(152.071154 - 0.005, 152.071154 + 0.005)
mt_paracetamol <- c(600, 900)

# Extract and find the exact peak time
paracetamol_mt <- getMtime(raw_data, mz = mz_paracetamol, mt = mt_paracetamol)
```

### 3. Defining Marker Information
Create a data frame containing the migration time (`rtime`) and the known effective mobility (`mobility`) for your markers.

```r
# EOF marker has mobility 0
marker_df <- paracetamol_mt
marker_df$markerID <- "Paracetamol"
marker_df$mobility <- 0
```

### 4. Performing Transformation
The `mobilityTransform` function handles different input types and transformation equations based on the markers provided.

**Option A: Single Marker (requires system parameters)**
Use this if you only have an EOF marker. Requires Voltage ($U$ in kV) and Capillary Length ($L$ in mm).
```r
# Transform a single numeric value
mu_eff <- mobilityTransform(x = 450.239, marker = marker_df[1,], 
                            tR = 3/60, U = 30, L = 800)
```

**Option B: Two Markers (Relative transformation)**
If you provide two markers (e.g., EOF and a secondary charged marker), the system parameters ($U$, $L$) are not required as they cancel out in the equation.
```r
# Add secondary marker to the data frame
procaine_row <- data.frame(rtime = 450.239, fileIdx = 1, 
                           markerID = "Procaine", mobility = 1327.35)
marker_df <- rbind(marker_df, procaine_row)

# Transform whole dataset
mobility_data <- mobilityTransform(x = raw_data, marker = marker_df)
```

### 5. Exporting and Analysis
Transformed data retains its class (`OnDiskMSnExp` or `Spectra`) but the `rtime` slot now contains $µ_{eff}$ values.

```r
# Export to mzML
writeMSData(mobility_data, file = "transformed_data.mzML", copy = FALSE)

# Plotting (Note: x-axis will be µ_eff)
lysine_EIE <- mobility_data |> 
    filterMz(mz = c(147.10, 147.12)) |> 
    filterRt(rt = c(1000, 2500))
plot(chromatogram(lysine_EIE))
```

## Tips and Best Practices
- **Narrow Windows**: When using `getMtime`, keep `mz` and `mt` windows as narrow as possible to avoid picking incorrect peaks.
- **Units**: The resulting unit of effective mobility is $\frac{mm^2}{kV \cdot min}$.
- **Field Ramp**: Use the `tR` parameter (field ramping time in minutes) for more accurate calculations if your CE method includes a significant ramp-up period.
- **Compatibility**: Because the package overwrites the "retention time" field with "effective mobility", standard `xcms` plotting functions will label the x-axis as "retention time" unless manually overridden in the plot call.

## Reference documentation
- [Description and usage of MobilityTransformR](./references/MobilityTransformR.Rmd)
- [Description and usage of MobilityTransformR](./references/MobilityTransformR.md)