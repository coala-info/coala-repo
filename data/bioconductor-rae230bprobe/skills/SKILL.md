---
name: bioconductor-rae230bprobe
description: This package provides probe sequence and coordinate data for the Affymetrix Rat Expression Set 230B microarray. Use when user asks to retrieve probe sequences, access x/y coordinates on the array, or perform sequence-specific analysis for the rae230b platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/rae230bprobe.html
---


# bioconductor-rae230bprobe

name: bioconductor-rae230bprobe
description: Access and use the rae230bprobe annotation data package for Affymetrix Rat Expression Set 230B microarrays. Use this skill when you need to retrieve probe sequences, x/y coordinates, or interrogation positions for probes on the rae230b platform.

# bioconductor-rae230bprobe

## Overview
The `rae230bprobe` package is a Bioconductor annotation data package containing the probe sequence information for the Affymetrix Rat Expression Set 230B (rae230b) microarray. This package is essential for workflows involving sequence-specific analysis, such as GC-content normalization, probe-level quality control, or re-mapping probes to updated genomic coordinates.

## Loading and Accessing Data
To use the probe data, you must first load the package and then the specific data object.

```r
# Load the package
library(rae230bprobe)

# Load the data object
data(rae230bprobe)

# View the structure of the data
str(rae230bprobe)
```

## Data Structure
The `rae230bprobe` object is a data frame containing 168,984 rows and 6 columns:
- `sequence`: The nucleotide sequence of the probe (character).
- `x`: The x-coordinate of the probe on the array (integer).
- `y`: The y-coordinate of the probe on the array (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The position of the interrogation base (integer).
- `Target.Strandedness`: The orientation of the target (factor).

## Common Workflows

### Inspecting Specific Probes
You can subset the data frame to look at specific probe sets or ranges of probes.

```r
# View the first few rows
head(rae230bprobe)

# Get sequences for a specific Probe Set
subset(rae230bprobe, Probe.Set.Name == "1367452_at")
```

### Converting to a Standard Data Frame
While the object behaves like a data frame, you can explicitly convert it for use with tidyverse or other analysis tools.

```r
df <- as.data.frame(rae230bprobe)
```

### Calculating Sequence Statistics
A common use case is calculating the GC content of the probes.

```r
# Simple function to calculate GC content
calculate_gc <- function(seqs) {
  sapply(seqs, function(x) {
    counts <- table(strsplit(x, "")[[1]])
    (counts["G"] + counts["C"]) / sum(counts)
  })
}

# Apply to the first 10 probes
gc_values <- calculate_gc(rae230bprobe$sequence[1:10])
```

## Reference documentation
- [rae230bprobe Reference Manual](./references/reference_manual.md)