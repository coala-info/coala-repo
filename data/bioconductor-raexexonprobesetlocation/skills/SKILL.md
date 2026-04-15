---
name: bioconductor-raexexonprobesetlocation
description: This package provides probe sequences and genomic location data for Affymetrix Rat Exon microarrays. Use when user asks to map RaEx probeset names to sequences, find x/y coordinates on the chip, identify interrogation positions, or determine target strandedness for rat genomic studies.
homepage: https://bioconductor.org/packages/release/data/annotation/html/RaExExonProbesetLocation.html
---

# bioconductor-raexexonprobesetlocation

name: bioconductor-raexexonprobesetlocation
description: Provides probe sequence and genomic location data for Affymetrix Rat Exon (RaEx) microarrays. Use this skill when an AI agent needs to map RaEx probeset names to sequences, x/y coordinates on the chip, interrogation positions, or target strandedness for rat genomic studies.

# bioconductor-raexexonprobesetlocation

## Overview

The `RaExExonProbesetLocation` package is a Bioconductor annotation data package. It contains a large data frame providing the physical and genomic characteristics of probes used in Rat Exon (RaEx) microarrays. This is essential for low-level analysis of Affymetrix arrays, such as sequence-specific background correction or verifying probe-to-genome alignments.

## Usage and Workflows

### Loading the Data

The package contains a single primary data object. To use it, you must load the library and then use the `data()` function.

```r
# Load the package
library(RaExExonProbesetLocation)

# Load the dataset into the environment
data(RaExExonProbesetLocation)
```

### Data Structure

The object `RaExExonProbesetLocation` is a data frame with over 1 million rows. Each row represents a single probe.

**Columns:**
- `sequence`: The actual DNA probe sequence (character).
- `x`: The x-coordinate on the microarray chip (integer).
- `y`: The y-coordinate on the microarray chip (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probeset (character).
- `Probe.Interrogation.Position`: The position within the target sequence being interrogated (integer).
- `Target.Strandedness`: The orientation of the target (factor).

### Common Operations

**Inspecting the data:**
```r
# View the first few rows
head(RaExExonProbesetLocation)

# Convert a subset to a standard data frame for manipulation
sub_df <- as.data.frame(RaExExonProbesetLocation[1:10, ])
```

**Filtering by Probeset:**
If you have a specific list of probeset IDs and need their sequences:
```r
# Example: Get all probes for a specific probeset
my_probeset <- "3860001" # Example ID
probes <- RaExExonProbesetLocation[RaExExonProbesetLocation$Probe.Set.Name == my_probeset, ]
```

**Spatial Analysis:**
Using the `x` and `y` coordinates to check for regional artifacts on a chip:
```r
# Summary of chip dimensions
summary(RaExExonProbesetLocation$x)
summary(RaExExonProbesetLocation$y)
```

## Tips
- **Memory Management**: This dataset is large (1,064,709 rows). If you are only interested in specific probesets, filter the data frame immediately to save memory.
- **Data Type**: While it behaves like a data frame, it is often stored as a specialized object for efficiency; use `as.data.frame()` if standard tidyverse or base R functions encounter unexpected behavior.

## Reference documentation
- [RaExExonProbesetLocation Reference Manual](./references/reference_manual.md)