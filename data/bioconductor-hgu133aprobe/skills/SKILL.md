---
name: bioconductor-hgu133aprobe
description: This package provides probe sequence data and physical coordinates for the Affymetrix HG-U133A microarray platform. Use when user asks to retrieve probe sequences, find x/y coordinates on the array, or access interrogation positions for specific probe sets.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgu133aprobe.html
---


# bioconductor-hgu133aprobe

name: bioconductor-hgu133aprobe
description: Access and use probe sequence data for the Affymetrix HG-U133A microarray. Use this skill when you need to retrieve probe sequences, x/y coordinates, or interrogation positions for specific probe sets on the hgu133a platform for genomic or transcriptomic analysis in R.

# bioconductor-hgu133aprobe

## Overview
The `hgu133aprobe` package is a Bioconductor annotation data package containing the probe sequences and location information for the Affymetrix HG-U133A microarray platform. It provides a data frame mapping probe identifiers to their physical sequences and coordinates on the array, which is essential for tasks like re-annotation, sequence-specific bias correction, or custom probe-set definitions.

## Usage and Workflows

### Loading the Data
The package contains a single primary data object. Load it into the R environment using the `data()` function.

```r
library(hgu133aprobe)
data(hgu133aprobe)
```

### Data Structure
The `hgu133aprobe` object is a data frame. You can inspect its structure to understand the available columns:

```r
# View the first few rows
head(hgu133aprobe)

# Check column names and types
str(hgu133aprobe)
```

The data frame contains the following columns:
- `sequence`: The actual nucleotide sequence of the probe (character).
- `x` and `y`: The physical coordinates of the probe on the microarray (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The position of the interrogation nucleotide (integer).
- `Target.Strandedness`: The orientation of the target relative to the probe (factor).

### Common Operations

**Filtering by Probe Set**
To extract all probes associated with a specific Affymetrix ID:
```r
# Example: Get probes for a specific ID
my_probes <- hgu133aprobe[hgu133aprobe$Probe.Set.Name == "200000_s_at", ]
```

**Analyzing Sequence Composition**
You can use standard R functions or Biostrings to analyze the sequences:
```r
# Calculate average GC content of the first 100 probes
probes_subset <- hgu133aprobe$sequence[1:100]
# Simple count of G and C characters
gc_counts <- sapply(probes_subset, function(x) {
  sum(charToRaw(x) %in% charToRaw("GC")) / nchar(x)
})
```

**Exporting Data**
If you need to use the probe sequences in external tools:
```r
write.csv(hgu133aprobe, file = "hgu133a_probe_sequences.csv", row.names = FALSE)
```

## Tips
- **Memory Management**: The data frame has over 247,000 rows. While manageable on most modern systems, avoid making multiple deep copies of the object in memory.
- **Integration**: This package is often used in conjunction with `affy` or `limma` when performing low-level analysis of .CEL files where probe-level sequence information is required for normalization (e.g., GC-RMA).

## Reference documentation
- [hgu133aprobe Reference Manual](./references/reference_manual.md)