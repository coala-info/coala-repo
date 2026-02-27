---
name: bioconductor-mouse4302probe
description: This package provides probe sequence data and spatial coordinates for the Affymetrix Mouse Genome 430 2.0 Array. Use when user asks to map Affymetrix probe identifiers to nucleotide sequences, retrieve probe coordinates, or perform GC-content based normalization for mouse microarray data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mouse4302probe.html
---


# bioconductor-mouse4302probe

name: bioconductor-mouse4302probe
description: Provides probe sequence data for the Affymetrix Mouse Genome 430 2.0 Array (mouse4302). Use this skill when you need to map Affymetrix probe identifiers to physical sequences, coordinates (x, y), or interrogation positions for mouse microarray data analysis.

# bioconductor-mouse4302probe

## Overview

The `mouse4302probe` package is a Bioconductor annotation data package containing the sequence information for the probes on the Affymetrix Mouse Genome 430 2.0 Array. This package is essential for low-level analysis tasks such as GC-content based normalization (e.g., GCRMA), probe-specific alignment checks, or designing custom CDFs (Chip Definition Files).

## Loading and Inspecting Data

The primary dataset is a data frame named `mouse4302probe`.

```r
# Load the package
library(mouse4302probe)

# Load the probe data object
data(mouse4302probe)

# View the structure of the data
str(mouse4302probe)

# Inspect the first few rows
head(mouse4302probe)
```

## Data Structure

The `mouse4302probe` data frame contains 496,468 rows, where each row represents a single probe. The columns include:

- **sequence**: The actual nucleotide sequence of the probe (character).
- **x**: The x-coordinate of the probe on the array (integer).
- **y**: The y-coordinate of the probe on the array (integer).
- **Probe.Set.Name**: The Affymetrix identifier for the probe set (character).
- **Probe.Interrogation.Position**: The position within the target sequence that this probe interrogates (integer).
- **Target.Strandedness**: Whether the target is sense or antisense (factor).

## Common Workflows

### Filtering Probes by Probe Set
To extract all probe sequences associated with a specific GeneChip ID:

```r
# Example: Get probes for a specific probe set
ps_name <- "1415670_at"
subset_probes <- mouse4302probe[mouse4302probe$Probe.Set.Name == ps_name, ]
```

### Calculating GC Content
A common use case for probe sequences is calculating the GC content for normalization:

```r
# Function to calculate GC content
calc_gc <- function(seqs) {
  sapply(seqs, function(x) {
    tmp <- nchar(gsub("[^GC]", "", x))
    return(tmp / nchar(x))
  })
}

# Apply to a subset
mouse4302probe$gc_content <- calc_gc(mouse4302probe$sequence[1:100])
```

## Usage Tips
- **Memory Management**: The `mouse4302probe` object is large. If you only need specific columns or rows, subset the data frame immediately after loading to save memory.
- **Coordinate Mapping**: The `x` and `y` coordinates are used to link probe sequences to the raw intensity values found in CEL files.
- **Version Consistency**: Ensure that the version of this probe package matches the version of the CDF or platform design you are using for your analysis.

## Reference documentation
- [mouse4302probe Reference Manual](./references/reference_manual.md)