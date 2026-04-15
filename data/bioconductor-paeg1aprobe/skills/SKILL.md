---
name: bioconductor-paeg1aprobe
description: This package provides probe sequence data and chip coordinates for the Affymetrix paeg1a microarray. Use when user asks to retrieve probe sequences, access x/y coordinates on the array, or perform sequence-level analysis for the Pseudomonas aeruginosa PAO1 genome.
homepage: https://bioconductor.org/packages/release/data/annotation/html/paeg1aprobe.html
---

# bioconductor-paeg1aprobe

name: bioconductor-paeg1aprobe
description: Access and use the probe sequence data for the Affymetrix paeg1a microarray chip. Use this skill when you need to retrieve probe sequences, x/y coordinates, or interrogation positions for the Pseudomonas aeruginosa PAO1 genome (paeg1a) array.

# bioconductor-paeg1aprobe

## Overview
The `paeg1aprobe` package is a Bioconductor annotation data package containing the probe sequences for the Affymetrix paeg1a microarray. This package is essential for low-level analysis of microarray data, such as calculating GC content of probes, performing sequence-specific background correction, or re-mapping probes to updated genome assemblies.

## Loading and Inspecting Data
The primary data object is a data frame named `paeg1aprobe`.

```r
# Load the package
library(paeg1aprobe)

# Load the probe data object
data(paeg1aprobe)

# View the structure of the data
str(paeg1aprobe)

# Inspect the first few rows
head(paeg1aprobe)
```

## Data Structure
The `paeg1aprobe` data frame contains 77,674 rows and 6 columns:
- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate of the probe on the array (integer).
- `y`: The y-coordinate of the probe on the array (integer).
- `Probe.Set.Name`: The Affymetrix ID for the probe set (character).
- `Probe.Interrogation.Position`: The position of the interrogation nucleotide (integer).
- `Target.Strandedness`: The orientation of the target (factor).

## Common Workflows

### Filtering by Probe Set
To extract all probes associated with a specific gene or probe set:
```r
# Example: Get probes for a specific Probe Set
subset_probes <- subset(paeg1aprobe, Probe.Set.Name == "12345_at")
```

### Sequence Analysis
You can use the sequence data to calculate properties like GC content, which is often used in normalization:
```r
# Calculate GC content for each probe
library(Biostrings)
sequences <- DNAStringSet(paeg1aprobe$sequence)
gc_content <- letterFrequency(sequences, letters="GC", as.prob=TRUE)
paeg1aprobe$GC <- gc_content
```

### Spatial Visualization
The `x` and `y` coordinates can be used to check for spatial artifacts on the chip:
```r
# Simple plot of probe distribution
plot(paeg1aprobe$x, paeg1aprobe$y, pch=".", main="paeg1a Probe Layout")
```

## Reference documentation
- [paeg1aprobe Reference Manual](./references/reference_manual.md)