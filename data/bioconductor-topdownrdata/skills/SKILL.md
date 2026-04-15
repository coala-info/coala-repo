---
name: bioconductor-topdownrdata
description: This package provides example top-down proteomics datasets for testing and demonstrating workflows in the topdownr package. Use when user asks to access sample top-down mass spectrometry data, retrieve file paths for protein datasets, or test fragmentation condition optimization workflows.
homepage: https://bioconductor.org/packages/release/data/experiment/html/topdownrdata.html
---

# bioconductor-topdownrdata

name: bioconductor-topdownrdata
description: Access and use example top-down proteomics datasets from the topdownrdata package. Use this skill when a user needs sample data for top-down mass spectrometry analysis, specifically for testing the topdownr package workflows, including fragmentation condition optimization and fragment coverage analysis.

## Overview

The `topdownrdata` package is an ExperimentData package for Bioconductor that provides high-quality example datasets generated on a Thermo Orbitrap Fusion Lumos MS device. These datasets are specifically designed to be used with the `topdownr` package to investigate fragmentation conditions and maximize fragment coverage in top-down proteomics.

The package includes data for five proteins:
- Horse myoglobin
- Bovine carbonic anhydrase (CA)
- Histone H3.3
- Histone H4
- C3a recombinant protein

## Data Structure

Each protein dataset consists of four essential file types required by the `topdownr` workflow:
1. **.fasta**: Protein sequence information for in-silico fragmentation.
2. **.mzML**: Deconvoluted spectra containing experimental fragments.
3. **.experiments.csv**: Metadata regarding MS method settings and fragmentation conditions.
4. **.txt**: Scan header files with additional spectra information (m/z, injection time, etc.).

## Typical Workflow

### 1. Locating Data
Use `topDownDataPath()` to retrieve the local file system path for a specific protein dataset.

```r
library(topdownrdata)

# Get path for myoglobin data
myo_path <- topDownDataPath("myoglobin")

# Available options: "myoglobin", "ca", "h3_3", "h4", "c3a"
```

### 2. Loading Data into topdownr
The primary use case is passing this path to `topdownr::readTopDownFiles()`. You can use regex patterns to subset the files to reduce processing time.

```r
library(topdownr)

# Load a subset of myoglobin data
tds <- readTopDownFiles(
  path = topDownDataPath("myoglobin"),
  pattern = ".*fasta.gz$|1211_.*1e6_1" # Example pattern to limit files
)
```

### 3. Basic Data Processing
Once loaded as a `TopDownSet` object, you can perform standard filtering and normalization:

```r
# Filter by intensity threshold (10%)
tds <- filterIntensity(tds, threshold = 0.1)

# Filter by Coefficient of Variation (CV) across replicates
tds <- filterCv(tds, threshold = 30)

# Normalize by Total Ion Current (TIC) and aggregate replicates
tds <- normalize(tds)
tds <- aggregate(tds)
```

### 4. Visualization
To visualize fragment coverage, coerce the object to an `NCBSet` and use `fragmentationMap()`:

```r
fragmentationMap(as(tds, "NCBSet"))
```

## Tips
- **Memory Management**: These datasets contain hundreds of files. Always use the `pattern` argument in `readTopDownFiles()` if you only need to test a specific condition or replicate.
- **Protein Keys**: Use the exact strings `"myoglobin"`, `"ca"`, `"h3_3"`, `"h4"`, or `"c3a"` in the `topDownDataPath()` function.
- **Vignettes**: For a full analysis walkthrough using this data, refer to `vignette("analysis", package="topdownr")`.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)