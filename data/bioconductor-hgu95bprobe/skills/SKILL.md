---
name: bioconductor-hgu95bprobe
description: This package provides probe sequence data and spatial coordinates for the Affymetrix HGU95B microarray chip. Use when user asks to retrieve nucleotide sequences, identify probe coordinates, or perform probe-level analysis for the Human Genome U95B array.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgu95bprobe.html
---

# bioconductor-hgu95bprobe

name: bioconductor-hgu95bprobe
description: Access and use probe sequence data for the Affymetrix HGU95B microarray chip. Use this skill when analyzing Affymetrix GeneChip Human Genome U95B data, specifically for tasks requiring probe-level sequences, spatial coordinates (x, y), or probe set mappings.

# bioconductor-hgu95bprobe

## Overview
The `hgu95bprobe` package is a Bioconductor annotation data package containing the sequence information for the probes on the Affymetrix HGU95B microarray. Unlike standard annotation packages that map probes to genes, this package provides the actual nucleotide sequences and their physical locations on the array.

## Loading and Accessing Data
The primary data object is a data frame also named `hgu95bprobe`.

```r
# Load the package
library(hgu95bprobe)

# Load the probe data object
data(hgu95bprobe)

# View the structure of the data
str(hgu95bprobe)
```

## Data Structure
The `hgu95bprobe` data frame contains 201,862 rows and 6 columns:
- `sequence`: The nucleotide sequence of the probe (character).
- `x`: The x-coordinate of the probe on the array (integer).
- `y`: The y-coordinate of the probe on the array (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The position of the interrogation base (integer).
- `Target.Strandedness`: The orientation of the target sequence (factor).

## Common Workflows

### Extracting Sequences for a Specific Probe Set
To retrieve all probe sequences associated with a specific Affymetrix ID:

```r
# Example: Get probes for a specific ID
target_id <- "1000_at"
subset_probes <- hgu95bprobe[hgu95bprobe$Probe.Set.Name == target_id, ]
print(subset_probes)
```

### Spatial Analysis
The `x` and `y` coordinates can be used to check for spatial artifacts on the microarray chip:

```r
# Plotting probe locations for a specific probe set
plot(subset_probes$x, subset_probes$y, main=target_id, xlab="x", ylab="y")
```

### Integration with Biostrings
For sequence analysis (e.g., GC content calculation), convert the sequences to a `DNAStringSet`:

```r
library(Biostrings)
probe_seqs <- DNAStringSet(hgu95bprobe$sequence)
gc_content <- letterFrequency(probe_seqs, as.prob=TRUE, letters="GC")
```

## Usage Tips
- **Memory Management**: The `hgu95bprobe` object is a large data frame. If you only need a subset of columns or rows, filter it early to save memory.
- **Package Dependency**: This package is typically used in conjunction with `affy` or `oligo` for low-level microarray analysis.
- **Version Consistency**: Ensure that the probe package version matches the CDF (Chip Definition File) version used in your analysis to maintain consistent probe-to-probeset mapping.

## Reference documentation
- [hgu95bprobe Reference Manual](./references/reference_manual.md)