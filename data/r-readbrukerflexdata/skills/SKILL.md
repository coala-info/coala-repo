---
name: r-readbrukerflexdata
description: This tool reads raw mass spectrometry data from Bruker Daltonics *flex series MALDI-TOF instruments into R. Use when user asks to import .fid files, read entire directories of mass spectra, or extract metadata and m/z ratios for analysis.
homepage: https://cloud.r-project.org/web/packages/readBrukerFlexData/index.html
---


# r-readbrukerflexdata

name: r-readbrukerflexdata
description: Reads mass spectrometry data from Bruker Daltonics *flex series (autoflex, microflex, ultraflex) MALDI-TOF instruments. Use this skill when an AI agent needs to import raw Bruker .fid files or entire directories of mass spectra into R for analysis, including handling of High Precision Calibration (HPC) and metadata extraction.

# r-readbrukerflexdata

## Overview
The `readBrukerFlexData` package is designed to read raw data files acquired by Bruker Daltonics' matrix-assisted laser desorption/ionization-time-of-flight (MALDI-TOF) mass spectrometers. It supports the *flex series and can process both individual `fid` files and recursive directory structures. It extracts mass-to-charge (m/z) ratios, intensities, and extensive metadata from the `acqu` files.

## Installation
To install the package from CRAN:
```R
install.packages("readBrukerFlexData")
```

## Main Functions

### readBrukerFlexFile
Reads a single mass spectrum from a specific `fid` file path.
- **Usage**: `readBrukerFlexFile(fidFile, removeMetaData = FALSE, useHpc = TRUE)`
- **Returns**: A list containing `spectrum$mass`, `spectrum$tof`, `spectrum$intensity`, and a `metaData` list.

### readBrukerFlexDir
Recursively scans a directory and reads all Bruker XMASS format data found.
- **Usage**: `readBrukerFlexDir(brukerFlexDir, removeCalibrationScans = TRUE)`
- **Returns**: A list of spectra, where each element follows the structure of `readBrukerFlexFile`.

## Workflows

### Reading a Single Spectrum
```R
library(readBrukerFlexData)

# Path to the 'fid' file
fid_path <- "path/to/your/experiment/1/1SLin/fid"

# Read the data
spec <- readBrukerFlexFile(fid_path)

# Basic Plot
plot(spec$spectrum$mass, spec$spectrum$intensity, type="l", 
     xlab="m/z", ylab="Intensity", main=spec$metaData$sampleName)
```

### Batch Processing a Directory
```R
library(readBrukerFlexData)

# Path to the top-level directory containing multiple runs
data_dir <- "path/to/mass_spec_data/"

# Read all spectra recursively
spectra_list <- readBrukerFlexDir(data_dir)

# Access the first spectrum's metadata
print(spectra_list[[1]]$metaData$fullName)
```

## Metadata and Calibration
- **HPC (High Precision Calibration)**: By default, `useHpc = TRUE`. The package automatically looks for HPC constants in the `acqu` file to improve mass accuracy.
- **Metadata**: The package imports a vast array of parameters including laser shots (`$NoSHOTS`), acquisition date (`$DATE`), and instrument type (`$INSTRUM`).
- **Memory Management**: If you are processing thousands of spectra and do not need the technical acquisition parameters, set `removeMetaData = TRUE` to save memory.

## Tips
- **Zero Intensities**: By default, the package keeps zero intensities. Changing `filterZeroIntensities` is generally not recommended unless trying to match specific legacy CompassXport behavior.
- **Negative Intensities**: MALDI data can sometimes contain negative values due to baseline offsets. These are replaced by zero by default (`keepNegativeIntensities = FALSE`).
- **Integration with MALDIquant**: This package is often used as the first step before processing data with the `MALDIquant` package.

## Reference documentation
- [Package Manual](./references/reference_manual.md)