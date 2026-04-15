---
name: bioconductor-citrusprobe
description: This package provides probe sequence data and array coordinates for the Affymetrix Citrus genome microarray. Use when user asks to retrieve probe sequences, access x/y coordinates on the Citrus array, or perform low-level microarray analysis using Bioconductor.
homepage: https://bioconductor.org/packages/release/data/annotation/html/citrusprobe.html
---

# bioconductor-citrusprobe

name: bioconductor-citrusprobe
description: Access and utilize probe sequence data for the Affymetrix Citrus genome array. Use this skill when you need to retrieve probe sequences, x/y coordinates, or interrogation positions for microarray analysis involving the Citrus platform in R.

# bioconductor-citrusprobe

## Overview
The `citrusprobe` package is a Bioconductor annotation data package containing the probe sequences and location information for the Affymetrix Citrus microarray. It provides a standardized data frame mapping probe identifiers to their physical sequences and coordinates on the array, which is essential for low-level analysis, background correction, or custom probe-set redefinition.

## Installation and Loading
To use this data package, it must be installed via `BiocManager` and loaded into the R session.

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("citrusprobe")
library(citrusprobe)
```

## Usage and Data Structure
The package provides a single primary data object named `citrusprobe`. This object is automatically lazily loaded upon calling `data(citrusprobe)`.

### Loading the Data
```r
# Load the probe data
data(citrusprobe)

# View the class (typically a data.frame)
class(citrusprobe)
```

### Data Format
The `citrusprobe` object is a data frame with 341,730 rows and 6 columns:
- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate of the probe on the array (integer).
- `y`: The y-coordinate of the probe on the array (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The position within the target sequence being interrogated (integer).
- `Target.Strandedness`: The orientation of the target (factor).

### Common Workflows

**Inspecting Probe Data:**
```r
# View the first few rows
head(citrusprobe)

# Access specific probe set information
citrus_subset <- subset(citrusprobe, Probe.Set.Name == "Citrus_Example_ID")
```

**Sequence Analysis:**
You can use this data to calculate GC content or search for specific motifs within the probes.
```r
# Example: Calculate sequence length
citrusprobe$length <- nchar(citrusprobe$sequence)

# Example: Filter for probes with specific sequences
high_gc_probes <- citrusprobe[grep("GGGG", citrusprobe$sequence), ]
```

## Tips
- **Memory Management**: The `citrusprobe` object is large (over 340,000 rows). If you only need specific columns or rows, subset the data early to save memory.
- **Integration**: This package is often used in conjunction with `affy` or `oligo` packages for preprocessing `.CEL` files where probe-level sequence information is required for algorithms like GC-RMA.

## Reference documentation
- [citrusprobe Reference Manual](./references/reference_manual.md)