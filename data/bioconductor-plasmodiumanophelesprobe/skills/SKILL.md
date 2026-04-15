---
name: bioconductor-plasmodiumanophelesprobe
description: This package provides probe sequence data and coordinate mapping for the Affymetrix Plasmodium_Anopheles microarray. Use when user asks to access probe sequences, map probes to coordinates, or perform sequence-specific analysis for Plasmodium falciparum and Anopheles gambiae gene expression data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/plasmodiumanophelesprobe.html
---

# bioconductor-plasmodiumanophelesprobe

name: bioconductor-plasmodiumanophelesprobe
description: Access and use probe sequence data for the Affymetrix Plasmodium_Anopheles microarray. Use this skill when analyzing Plasmodium or Anopheles gene expression data that requires mapping probe sequences to coordinates or probe set identifiers.

# bioconductor-plasmodiumanophelesprobe

## Overview

The `plasmodiumanophelesprobe` package is a Bioconductor annotation data package containing the sequence information for the probes on the Affymetrix Plasmodium_Anopheles chip. This chip is designed for studying *Plasmodium falciparum* (malaria parasite) and *Anopheles gambiae* (mosquito vector). The package provides a data frame mapping each probe to its x/y coordinates on the array, its probe set name, and its interrogation position.

## Loading and Inspecting Data

To use the probe data, load the package and the dataset:

```r
# Load the package
library(plasmodiumanophelesprobe)

# Load the data object
data(plasmodiumanophelesprobe)

# Inspect the structure
str(plasmodiumanophelesprobe)

# View the first few rows
head(plasmodiumanophelesprobe)
```

## Data Structure

The `plasmodiumanophelesprobe` object is a data frame with 250,758 rows and 6 columns:

- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate of the probe on the microarray (integer).
- `y`: The y-coordinate of the probe on the microarray (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The position of the interrogation nucleotide (integer).
- `Target.Strandedness`: Whether the target is sense or antisense (factor).

## Common Workflows

### Filtering by Probe Set
To extract all probes associated with a specific gene or probe set:

```r
# Example: Get probes for a specific ID
target_probes <- subset(plasmodiumanophelesprobe, Probe.Set.Name == "12345_at")
```

### Sequence Analysis
You can use this data to perform GC content analysis or sequence-specific bias corrections:

```r
# Calculate sequence length (should be 25 for Affymetrix)
lengths <- nchar(plasmodiumanophelesprobe$sequence)

# Simple GC content calculation example
get_gc <- function(seqs) {
  sapply(seqs, function(x) {
    counts <- table(strsplit(x, "")[[1]])
    (sum(counts[c("G", "C")], na.rm=TRUE) / sum(counts)) * 100
  })
}

# Apply to first 10 probes
gc_content <- get_gc(plasmodiumanophelesprobe$sequence[1:10])
```

### Integration with Biobase
This package is typically used in conjunction with `affy` or `Biobase` when performing low-level analysis of .CEL files where probe-level sequence information is required for normalization (like GC-RMA).

## Reference documentation

- [Reference Manual](./references/reference_manual.md)