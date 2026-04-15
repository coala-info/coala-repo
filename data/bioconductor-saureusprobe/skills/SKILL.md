---
name: bioconductor-saureusprobe
description: This package provides probe sequence data and metadata for the Affymetrix Staphylococcus aureus microarray. Use when user asks to access probe sequences, retrieve x/y coordinates on the array, or analyze probe-level information for S. aureus expression studies.
homepage: https://bioconductor.org/packages/release/data/annotation/html/saureusprobe.html
---

# bioconductor-saureusprobe

name: bioconductor-saureusprobe
description: Provides probe sequence data for the Affymetrix Staphylococcus aureus (saureus) microarray. Use this skill when you need to access, analyze, or map probe-level information for S. aureus expression studies, including probe sequences, x/y coordinates on the array, and target strandedness.

# bioconductor-saureusprobe

## Overview
The `saureusprobe` package is a Bioconductor annotation data package containing the probe sequences for the Affymetrix Staphylococcus aureus microarray. This package is essential for low-level analysis of microarray data, such as GC-content based normalization, probe-set re-annotation, or verifying probe-to-genome alignments.

## Usage and Workflows

### Loading the Data
The package contains a single primary data object named `saureusprobe`.

```r
# Load the library
library(saureusprobe)

# Load the probe data object
data(saureusprobe)
```

### Data Structure
The `saureusprobe` object is a data frame. You can inspect its structure to understand the available metadata for each probe.

```r
# View the first few rows
head(saureusprobe)

# Check column names and types
str(saureusprobe)
```

The data frame contains the following columns:
- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate of the probe on the array (integer).
- `y`: The y-coordinate of the probe on the array (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The position within the target sequence (integer).
- `Target.Strandedness`: Whether the target is sense or antisense (factor).

### Common Operations

#### Filtering by Probe Set
To extract all probes associated with a specific Affymetrix ID:

```r
# Example: Filter for a specific probe set
subset_probes <- saureusprobe[saureusprobe$Probe.Set.Name == "SA0001_at", ]
```

#### Analyzing Sequence Composition
You can use this data to calculate properties like GC content, which is often used in background correction algorithms.

```r
# Calculate sequence length (typically 25bp for Affymetrix)
lengths <- nchar(saureusprobe$sequence)

# Simple GC content calculation example
get_gc <- function(seqs) {
  sapply(seqs, function(x) {
    g <- gregexpr("G", x)[[1]]
    c <- gregexpr("C", x)[[1]]
    (sum(g > 0) + sum(c > 0)) / nchar(x)
  })
}

# Apply to first 10 probes
gc_values <- get_gc(saureusprobe$sequence[1:10])
```

## Tips
- **Memory Management**: The `saureusprobe` data frame contains over 120,000 rows. While manageable on most modern systems, use indexing or `head()` when first exploring the data to avoid flooding the console.
- **Integration**: This package is typically used in conjunction with `affy` or `oligo` for low-level microarray processing.
- **Coordinate Mapping**: The `x` and `y` coordinates are useful for identifying spatial artifacts on the physical array chip.

## Reference documentation
- [saureusprobe Reference Manual](./references/reference_manual.md)