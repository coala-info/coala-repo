---
name: bioconductor-flowcut
description: The flowCut package automatically detects and removes technical artifacts and outliers from flow cytometry data by analyzing statistical measures across time segments. Use when user asks to clean flow cytometry data, remove technical artifacts from FCS files, or perform quality control on flow cytometry experiments.
homepage: https://bioconductor.org/packages/release/bioc/html/flowCut.html
---


# bioconductor-flowcut

## Overview

The `flowCut` package is designed to automatically detect and remove technical artifacts in flow cytometry data. It works by partitioning a `flowFrame` into segments (default 500 events) and calculating eight statistical measures for each segment across specified channels. By analyzing the density of these summed measures, `flowCut` identifies and removes segments that are statistically different from the rest of the file. It also handles low-density event removal and flags files that fail specific quality control tests (e.g., non-monotonic time, sudden fluorescence jumps, or gradual drift).

## Core Workflow

### 1. Loading the Library and Data
```R
library(flowCut)
# Load example data provided by the package
data(flowCutData)
# flowCutData is a list of flowFrames
fcs_file <- flowCutData[[1]]
```

### 2. Basic Cleaning
The primary function is `flowCut()`. By default, it processes the flowFrame and returns a list containing the cleaned frame and metadata.

```R
res <- flowCut(fcs_file, 
               Segment = 500, 
               Plot = "All", 
               FileID = "Sample_01",
               PrintToConsole = TRUE)

# Access the cleaned flowFrame
cleaned_frame <- res$frame

# Access indices of removed events
removed_indices <- res$ind

# Check quality control metrics and pass/fail status
print(res$data)
```

### 3. Interpreting the Output Data
The `$data` element provides a summary of the cleaning process:
- **Has the file passed**: "T" or "F" indicating overall quality.
- **% of events removed**: Total percentage of data filtered out.
- **Worst channel**: The channel exhibiting the most drift.
- **Flagging codes**: A four-character string (e.g., "TTTF") representing the four internal tests (Monotonic time, Sudden jumps, Gradual drift in all channels, Large drift in one channel).

## Advanced Configuration

### Handling Persistent Drift
If a file is flagged after the first pass, or if outliers are masked by a single bad channel, use `AllowFlaggedRerun` and `UseOnlyWorstChannels`.

```R
res <- flowCut(fcs_file, 
               AllowFlaggedRerun = TRUE, 
               UseOnlyWorstChannels = TRUE)
```

### Adjusting Sensitivity
- **MaxPercCut**: Default is 0.3. Increase this if you are willing to lose more than 30% of events to achieve a clean file.
- **MaxValleyHgt**: Controls the gating threshold on the density of summed measures. Increasing this (e.g., to 0.1) makes the algorithm more aggressive in cutting segments.
- **LowDensityRemoval**: Default is 0.1. Removes events in regions where density is less than 10% of the maximum density.

### Segment Size Optimization
- **Small files**: Ensure `Total Events / Segment` is at least 100.
- **Large files with high variance**: If the "mean line" (brown line in plots) is too jittery, increase `Segment` (e.g., to 2000 or 5000) to stabilize statistics.

### Selecting Channels and Measures
By default, `flowCut` uses all channels and 8 statistical measures (percentiles, mean, median, variance, skewness).
- **Channels**: Pass a vector of indices to `channels`.
- **Measures**: Pass a subset of `1:8` to the `Measures` parameter.

## Tips for Success
- **Visualization**: Always set `Plot = "All"` or `Plot = "Flagged Only"` during exploratory analysis to inspect the "Density of summed measures" plot.
- **GateLineForce**: If the automated threshold fails, use `GateLineForce` to manually set the cutoff on the summed measures distribution.
- **Time Channel**: Ensure your `flowFrame` has a valid `Time` channel, as `flowCut` relies on the temporal ordering of events.

## Reference documentation
- [flowCut](./references/flowCut.md)