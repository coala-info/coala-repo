---
name: r-wrassp
description: The r-wrassp package provides high-performance signal processing functions for phonetic and speech science analysis within the R environment. Use when user asks to estimate formants, calculate fundamental frequency, perform spectral analysis, or read and write SSFF files.
homepage: https://cloud.r-project.org/web/packages/wrassp/index.html
---


# r-wrassp

## Overview
The `wrassp` package is an R wrapper for the `libassp` library. It provides high-performance signal processing functions for phonetic and speech science. Key capabilities include:
- **Signal Analysis**: Formants, F0, RMS, ZCR, and spectral analysis.
- **File I/O**: Reading and writing common audio formats and SSFF (Simple Signal File Format) files.
- **AsspDataObj**: A specialized S3 class for handling multi-track signal data.

## Installation
```r
install.packages("wrassp")
library(wrassp)
```

## Core Workflows

### 1. Working with AsspDataObj
The `AsspDataObj` is the central data structure. It acts like a list of matrices where each matrix is a "track".

```r
# Read a signal file (wav, au, etc.)
au <- read.AsspDataObj("path/to/file.wav")

# Inspect metadata
dur.AsspDataObj(au)    # Duration in seconds
rate.AsspDataObj(au)   # Sampling rate
numRecs.AsspDataObj(au) # Number of samples/records

# Access data tracks
names(au)              # List track names (e.g., "audio", "fm", "F0")
head(au$audio)         # Access the matrix for a specific track
```

### 2. Signal Processing Functions
Most functions can either return an `AsspDataObj` in memory or write an SSFF file to disk.

| Function | Description | Output Tracks |
| :--- | :--- | :--- |
| `forest()` | Formant estimation | `fm` (frequencies), `bw` (bandwidths) |
| `ksvF0()` | Fundamental frequency | `F0` |
| `rmsana()` | RMS energy analysis | `rms` |
| `zcrana()` | Zero-crossing rate | `zcr` |
| `dftSpectrum()` | DFT spectral analysis | `spec` |

**Example: In-memory analysis**
```r
# Set toFile=FALSE to return an object instead of writing to disk
f0_data <- ksvF0("speech.wav", toFile = FALSE)
plot(f0_data$F0, type='l', main="F0 Contour")
```

**Example: Batch processing to disk**
```r
# Process multiple files; results saved as .rms files
wav_files <- c("s1.wav", "s2.wav")
rmsana(wav_files, outputDirectory = tempdir(), toFile = TRUE)
```

### 3. Metadata and Extensions
Use `wrasspOutputInfos` to look up default extensions and track names for any processing function.

```r
# Check expected output for formant analysis
wrasspOutputInfos$forest
# $ext: "fms"
# $tracks: "fm", "bw"
```

## Tips and Best Practices
- **Time Alignment**: When plotting, calculate time using `(0:(numRecs - 1)) / rate + startTime`. The `startTime` attribute is crucial for windowed analyses.
- **Memory Management**: For very large datasets, use `toFile = TRUE` to avoid filling R's memory, then read specific tracks as needed.
- **SSFF Files**: `wrassp` is the primary tool in R for interacting with the SSFF format used by the EMU-SDMS speech database system.

## Reference documentation
- [An introduction to the wrassp package](./references/wrassp_intro.Rmd)