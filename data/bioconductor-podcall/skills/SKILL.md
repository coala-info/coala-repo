---
name: bioconductor-podcall
description: PoDCall is an R package that uses Gaussian Mixture Models and Likelihood Ratio Tests to automatically set thresholds and analyze DNA methylation droplet digital PCR data. Use when user asks to import ddPCR amplitude data, set positive droplet thresholds, calculate DNA concentrations, or visualize ddPCR results using scatterplots and histograms.
homepage: https://bioconductor.org/packages/release/bioc/html/PoDCall.html
---


# bioconductor-podcall

## Overview
PoDCall (Positive Droplet Caller) is an R package designed for the analysis of DNA methylation droplet digital PCR (ddPCR) data, specifically from Bio-Rad platforms (QuantaSoft or QX Manager). It uses Gaussian Mixture Models (GMM) and Likelihood Ratio Tests (LRT) to automatically and robustly set thresholds for positive and negative droplets. It handles both single-channel and multi-channel (multiplexed) setups, providing normalized concentrations and visualization tools.

## Core Workflow

### 1. Data Import
PoDCall expects `.csv` files containing amplitude data. All files in a directory should belong to the same 96-well plate to avoid ID conflicts.

```r
library(PoDCall)

# Import amplitude data from a directory
path_to_amps <- "path/to/csv_directory/"
ampData <- importAmplitudeData(dataDirectory = path_to_amps, software = "QX Manager")

# Optional: Import sample sheet (requires columns: Well, Sample, TargetType, Target)
sampleSheetPath <- "path/to/Sample_names.csv"
well_ids <- names(ampData)
info <- importSampleSheet(sampleSheet = sampleSheetPath, well_id = well_ids, software = "QX Manager")
```

### 2. Running the Main Pipeline
The `podcallDdpcr` function is the primary wrapper for the entire workflow.

```r
# Set seed for reproducibility due to random sampling in GMM fitting
set.seed(123)

results <- podcallDdpcr(
  dataDirectory = "path/to/data/",
  software = "QX Manager",
  resultsToFile = TRUE, # Saves .csv results
  plots = TRUE          # Saves .pdf plots
)
```

### 3. Manual Thresholding and Metrics
If you prefer step-by-step control, use `podcallThresholds`.

```r
# Calculate thresholds and concentrations
# B: permutations for LRT (default 200)
# Q: outlier calling parameter (default 9; higher = stricter threshold)
thresholdTable <- podcallThresholds(plateData = ampData, B = 200, Q = 9)

# View results
head(thresholdTable)
```

## Visualization
PoDCall provides several plotting functions to validate thresholding.

*   **Channel Plot**: Combined scatterplot and histogram for a specific channel.
    ```r
    podcallChannelPlot(channelData = ampData$A04[,1], thr = thresholdTable["A04", "thr_target"], channel = 1, plotId = "Well A04 Target")
    ```
*   **Multiplot**: Faceted scatterplots for comparing multiple wells.
    ```r
    podcallMultiplot(plateData = ampData, thresholds = thresholdTable, channel = "target", colCh = 1)
    ```
*   **Individual Components**: Use `podcallScatterplot()` or `podcallHistogram()` for specific views.

## Key Parameters
*   **software**: Must be "QuantaSoft" or "QX Manager". This handles differences in file headers and skip-lines.
*   **Q**: The sensitivity parameter. If thresholds are too low (capturing noise), increase Q. If too high (missing positives), decrease Q.
*   **refwell**: The well used as a baseline reference (default is the first well).

## Interactive Analysis
To launch the user-friendly Shiny interface for interactive threshold adjustment and visualization:
```r
podcallShiny()
```

## Reference documentation
- [PoDCall: Positive Droplet Caller for DNA Methylation ddPCR](./references/PoDCall.md)