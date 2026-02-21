---
name: bioconductor-htmg430pmprobe
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/htmg430pmprobe.html
---

# bioconductor-htmg430pmprobe

name: bioconductor-htmg430pmprobe
description: Access and utilize probe sequence data for the Affymetrix HT_MG-430_PM microarray chip. Use this skill when analyzing GeneChip HT Mouse Genome 430 PM arrays in R, specifically for tasks requiring probe-level sequences, (x,y) coordinates, or probe set mappings.

# bioconductor-htmg430pmprobe

## Overview

The `htmg430pmprobe` package is a Bioconductor annotation data package containing the probe sequences for the Affymetrix HT_MG-430_PM microarray. This package is essential for low-level microarray analysis, such as calculating GC content for background correction, re-mapping probes to updated genomic coordinates, or performing sequence-specific quality control.

## Usage and Workflows

### Loading the Data

The primary data object is a data frame named `htmg430pmprobe`.

```r
# Load the package
library(htmg430pmprobe)

# Load the probe data object
data(htmg430pmprobe)

# View the structure
str(htmg430pmprobe)
```

### Data Structure

The `htmg430pmprobe` data frame contains 496,508 rows and 6 columns:

- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate of the probe on the array (integer).
- `y`: The y-coordinate of the probe on the array (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The position within the target sequence (integer).
- `Target.Strandedness`: The orientation of the target (factor).

### Common Operations

#### Inspecting Specific Probes
To view the first few probes of the dataset:
```r
as.data.frame(htmg430pmprobe[1:5, ])
```

#### Filtering by Probe Set
To extract all probes associated with a specific GeneChip ID:
```r
# Example: Filter for a specific probe set
subset_probes <- subset(htmg430pmprobe, Probe.Set.Name == "1415670_at")
```

#### Calculating Sequence Statistics
If you need to calculate the GC content of the probes (often used in normalization):
```r
# Simple GC count example
sequences <- htmg430pmprobe$sequence[1:10]
gc_content <- sapply(sequences, function(s) {
  sum(nchar(gsub("[^GC]", "", s))) / nchar(s)
})
```

## Tips
- **Memory Management**: This data frame is large (~500k rows). If you only need specific columns (e.g., sequences and IDs), subset the object early to save memory.
- **Integration**: This package is typically used in conjunction with `affy` or `oligo` packages for probe-level analysis.
- **Coordinate System**: The `x` and `y` coordinates are zero-indexed, following standard Affymetrix conventions.

## Reference documentation

- [htmg430pmprobe Reference Manual](./references/reference_manual.md)