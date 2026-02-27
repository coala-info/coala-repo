---
name: bioconductor-porcineprobe
description: This package provides probe sequence data and chip coordinates for the Affymetrix Porcine genome microarray. Use when user asks to retrieve porcine probe sequences, map probes to their physical coordinates, or analyze interrogation positions for the Porcine chip.
homepage: https://bioconductor.org/packages/release/data/annotation/html/porcineprobe.html
---


# bioconductor-porcineprobe

name: bioconductor-porcineprobe
description: Provides probe sequence data for Affymetrix Porcine genome microarrays. Use this skill when analyzing porcine (pig) microarray data, mapping probe sequences to genomic locations, or validating probe interrogation positions for the Porcine chip.

# bioconductor-porcineprobe

## Overview
The `porcineprobe` package is a Bioconductor annotation data package containing the sequence information for the probes on the Affymetrix Porcine genome array. It provides a standardized data frame mapping probe sequences to their physical (x, y) coordinates on the chip and their specific interrogation positions.

## Loading and Inspecting Data
The package contains a single primary data object: `porcineprobe`.

```r
# Load the library
library(porcineprobe)

# Load the probe data object
data(porcineprobe)

# View the structure of the data
str(porcineprobe)

# Look at the first few rows
head(porcineprobe)
```

## Data Structure
The `porcineprobe` object is a data frame with 265,635 rows and 6 columns:
- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate of the probe on the microarray (integer).
- `y`: The y-coordinate of the probe on the microarray (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The nucleotide position within the target sequence that the probe targets (integer).
- `Target.Strandedness`: Whether the target is sense or antisense (factor).

## Common Workflows

### Filtering by Probe Set
To extract all probes associated with a specific Affymetrix Probe Set ID:

```r
# Example: Get probes for a specific ID
target_probes <- porcineprobe[porcineprobe$Probe.Set.Name == "Sbi.1.1.S1_at", ]
```

### Sequence Analysis
You can use this data to perform sequence-level checks, such as calculating GC content for specific probes:

```r
library(Biostrings)
# Convert sequences to DNAStringSet for analysis
probe_seqs <- DNAStringSet(porcineprobe$sequence[1:10])
letterFrequency(probe_seqs, as.prob = TRUE, letters = "GC")
```

### Mapping Coordinates
The `x` and `y` coordinates are used to link probe sequences back to raw intensity data (CEL files) when performing low-level array analysis or spatial quality control.

## Reference documentation
- [porcineprobe Reference Manual](./references/reference_manual.md)