---
name: bioconductor-michip
description: This tool processes and analyzes microRNA expression data from MiChip microarrays. Use when user asks to parse Genepix files, filter unwanted probes, correct quality flags, summarize replicate intensities, or normalize MiChip data into Bioconductor ExpressionSet objects.
homepage: https://bioconductor.org/packages/release/bioc/html/MiChip.html
---

# bioconductor-michip

name: bioconductor-michip
description: Processing and analyzing MiChip microRNA microarray data. Use this skill when loading Genepix (.gpr) files from MiChip platforms, performing flag correction, filtering unwanted probes (e.g., empty spots or non-human controls), summarizing replicate intensities, and normalizing data into Bioconductor ExpressionSet objects.

# bioconductor-michip

## Overview

The `MiChip` package is designed for the analysis of microRNA expression data generated using the MiChip platform (locked nucleic acid capture probes). It streamlines the transition from raw Genepix (.gpr) scanner output to standard Bioconductor `ExpressionSet` objects. Key features include automated parsing of single-color Cy3 hybridizations, specialized filtering for MiChip spotting configurations, and median-based normalization.

## Core Workflow

### 1. Data Loading
Load all `.gpr` files from a directory. The function `parseRawData` subtracts background intensities and handles quality flags.

```r
library(MiChip)
# Load from current directory (default) or specific path
datadir <- "path/to/gpr/files"
rawData <- parseRawData(datadir = datadir, pat = "gpr")
```

### 2. Filtering and Flag Correction
MiChip arrays contain empty spots and various controls. Use these functions to clean the dataset:

*   **Remove Unwanted Rows:** Filter by gene name strings (e.g., "Empty").
    ```r
    # Manual filtering
    cleanData <- removeUnwantedRows(rawData, c("Empty", "Control"))
    
    # Standard filtering for Human MiChip experiments
    humanData <- standardRemoveRows(rawData)
    ```
*   **Flag and Intensity Correction:** Set absent spots (flags < 0) or low-intensity spots to `NA`.
    ```r
    # Set flags < 0 and intensities < 50 to NA
    correctedData <- correctForFlags(humanData, intensityCutoff = 50)
    ```

### 3. Summarizing Replicates
MiChip probes are typically spotted in duplicate or quadruplicate. Summarize these into a single value per feature using the median.

```r
# minSumlength: minimum number of non-NA replicates required
# madAdjust: if TRUE, sets to NA if Median Absolute Deviation > Median
summedData <- summarizeIntensitiesAsMedian(correctedData, minSumlength = 2, madAdjust = FALSE)
```

### 4. Normalization and Visualization
The package provides median normalization per chip. Once in an `ExpressionSet`, you can also use standard Bioconductor tools (like `limma`).

```r
# Median normalization
normData <- normalizePerChipMedian(summedData)

# Visualization (saves plots to disk)
plotIntensitiesScatter(exprs(normData), NULL, "ProjectName", "ScatterPlot")
boxplotData(exprs(normData), "ProjectName", "Normalized")
```

### 5. Exporting Results
Export the annotated expression matrix to a tab-delimited file.

```r
outputAnnotatedDataMatrix(normData, "OutputFilePrefix", "Description", "exprs")
```

## Automated Pipeline
For a rapid standard analysis, use the wrapper function which performs parsing, filtering, flag correction, and normalization in one step:

```r
myEset <- workedExampleMedianNormalize(prefix = "MyAnalysis", intensityCutoff = 50, datadir = "path/to/data")
```

## Tips
*   **ExpressionSet Compatibility:** Since `MiChip` outputs standard `ExpressionSet` objects, you can access expression values via `exprs(myEset)` and feature data via `fData(myEset)`.
*   **Directory Consistency:** Ensure all `.gpr` files in the target directory are of the same MiChip type/version to avoid parsing errors.

## Reference documentation
- [MiChip](./references/MiChip.md)