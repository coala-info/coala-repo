---
name: bioconductor-marinerdata
description: This package provides curated Hi-C contact maps and chromatin loop datasets for testing and demonstrating the mariner R package. Use when user asks to access sample Hi-C files, retrieve chromatin loop calls, or load example datasets for testing mariner package workflows.
homepage: https://bioconductor.org/packages/release/data/experiment/html/marinerData.html
---


# bioconductor-marinerdata

## Overview
The `marinerData` package is an ExperimentHub-based data package providing small, curated datasets for testing and demonstrating the `mariner` R package. It primarily contains Hi-C contact maps (.hic) and chromatin loop calls (.txt or .bedpe) from specific biological contexts, such as NHA9-transformed cells and a THP-1 activation timecourse.

## Loading Data
The package uses accessor functions that automatically download (if not cached) and return the local file paths to the datasets.

### Hi-C Files
To retrieve paths to sample Hi-C files:
```r
library(marinerData)

# Access specific Hi-C files
hic_fs <- LEUK_HEK_PJA27_inter_30.hic()
hic_wt <- LEUK_HEK_PJA30_inter_30.hic()

# Combine into a named vector for downstream analysis
hicFiles <- c(FS = hic_fs, WT = hic_wt)
```

### Loop Calls (NHA9)
To retrieve loop calls corresponding to the Hi-C files above:
```r
nha9Loops <- c(
  FS = FS_5kbLoops.txt(),
  WT = WT_5kbLoops.txt()
)
```

### LIMA Timecourse Data
The LPS/IF-G Induced Macrophage Activation (LIMA) dataset contains loop calls across 8 timepoints (0 to 1440 minutes).
```r
# Access specific timepoints
loop_0min <- LIMA_0000.bedpe()
loop_30min <- LIMA_0030.bedpe()
loop_1440min <- LIMA_1440.bedpe()

# Typical workflow: Load all timepoints into a named list
timepoints <- c("0000", "0030", "0060", "0090", "0120", "0240", "0360", "1440")
limaLoops <- sapply(paste0("LIMA_", timepoints, ".bedpe"), do.call, list())
```

## Usage Tips
- **File Paths**: The functions return character strings representing the absolute path to the file in the `ExperimentHub` cache. Use these paths directly in functions like `mariner::binPairs()` or `strawr::readHicBp()`.
- **Caching**: On the first call, the data is downloaded. Subsequent calls load the data from the local cache, which is significantly faster.
- **Integration**: These datasets are specifically designed to work with the `mariner` package for tasks like loop clustering, shuffling, and aggregate peak analysis (APA).

## Reference documentation
- [marinerData](./references/marinerData.md)