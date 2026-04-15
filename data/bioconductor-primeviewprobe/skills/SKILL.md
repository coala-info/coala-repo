---
name: bioconductor-primeviewprobe
description: This package provides probe sequence data and spatial coordinates for the Affymetrix PrimeView microarray. Use when user asks to access probe sequences, map x/y coordinates on the array, or perform probe-level analysis for PrimeView GeneChips.
homepage: https://bioconductor.org/packages/release/data/annotation/html/primeviewprobe.html
---

# bioconductor-primeviewprobe

name: bioconductor-primeviewprobe
description: Provides probe sequence data for the Affymetrix PrimeView microarray. Use this skill when you need to access, analyze, or map probe-level information (sequences, x/y coordinates, and target strandedness) for PrimeView arrays in R.

# bioconductor-primeviewprobe

## Overview

The `primeviewprobe` package is a Bioconductor annotation data package containing the probe sequences for the Affymetrix PrimeView microarray. This data is essential for tasks requiring probe-level analysis, such as custom background correction, re-annotation, or quality control where the physical location and sequence of each probe on the array are needed.

## Installation and Loading

To use this data package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("primeviewprobe")

# Load the package
library(primeviewprobe)
```

## Usage and Workflows

The package provides a single primary data object: `primeviewprobe`.

### Accessing Probe Data

The data is loaded into the R environment using the `data()` function. It is stored as a data frame.

```r
# Load the probe data
data(primeviewprobe)

# View the structure of the data
str(primeviewprobe)

# Inspect the first few rows
head(primeviewprobe)
```

### Data Frame Structure

The `primeviewprobe` data frame contains 531,754 rows and 6 columns:

1.  **sequence**: The actual nucleotide sequence of the probe (character).
2.  **x**: The x-coordinate of the probe on the array (integer).
3.  **y**: The y-coordinate of the probe on the array (integer).
4.  **Probe.Set.Name**: The Affymetrix ID for the probe set (character).
5.  **Probe.Interrogation.Position**: The position within the target sequence (integer).
6.  **Target.Strandedness**: Whether the target is sense or antisense (factor).

### Common Operations

**Filtering by Probe Set:**
To extract all probes associated with a specific GeneChip probe set:

```r
# Example: Get probes for a specific ID
specific_probes <- subset(primeviewprobe, Probe.Set.Name == "200000_s_at")
```

**Exporting to Data Frame:**
While it behaves like a data frame, you can explicitly cast it for use with tidyverse or other tools:

```r
df <- as.data.frame(primeviewprobe)
```

## Tips

- **Memory Management**: This dataset is large (>500,000 rows). If you only need specific columns or a subset of probes, filter the data early to save memory.
- **Coordinate Mapping**: The `x` and `y` coordinates are useful for spatial quality control (e.g., identifying "bubbles" or physical defects on the chip).
- **Sequence Analysis**: Use the `sequence` column if you are performing GC-content bias correction or checking for cross-hybridization potential.

## Reference documentation

- [primeviewprobe Reference Manual](./references/reference_manual.md)