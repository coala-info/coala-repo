---
name: bioconductor-hthgu133pluspmprobe
description: This package provides probe sequence data and location information for the Affymetrix HT_HG-U133_Plus_PM microarray platform. Use when user asks to access nucleotide sequences, map probe coordinates to probe set names, or perform GC-content based normalization for HT-HG-U133 Plus PM arrays.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hthgu133pluspmprobe.html
---

# bioconductor-hthgu133pluspmprobe

name: bioconductor-hthgu133pluspmprobe
description: Access and use the probe sequence data for the Affymetrix HT_HG-U133_Plus_PM microarray platform. Use this skill when you need to map probe sequences to coordinates (x, y), probe set names, or interrogation positions for high-throughput GeneChip HG-U133 Plus PM arrays.

# bioconductor-hthgu133pluspmprobe

## Overview
The `hthgu133pluspmprobe` package is a Bioconductor annotation data package containing the probe sequences and location information for the Affymetrix HT_HG-U133_Plus_PM microarray. This package is essential for low-level analysis of microarray data, such as GC-content based normalization (e.g., GCRMA) or custom probe-to-gene re-mapping.

## Usage and Workflows

### Loading the Data
The package contains a single primary data object of the same name. To use it, you must load the library and then call the `data()` function.

```r
library(hthgu133pluspmprobe)
data(hthgu133pluspmprobe)
```

### Data Structure
The `hthgu133pluspmprobe` object is a data frame. You can inspect its structure using standard R commands:

```r
# View the first few rows
head(hthgu133pluspmprobe)

# Check column names and types
str(hthgu133pluspmprobe)
```

The data frame contains 519,370 rows and 6 columns:
- `sequence`: The actual nucleotide sequence (character).
- `x`: The x-coordinate on the array (integer).
- `y`: The y-coordinate on the array (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The position of the interrogation nucleotide (integer).
- `Target.Strandedness`: Whether the target is sense or antisense (factor).

### Common Tasks

#### Filtering by Probe Set
To extract all probe sequences associated with a specific Affymetrix ID:

```r
target_probes <- subset(hthgu133pluspmprobe, Probe.Set.Name == "200000_s_at")
```

#### Calculating GC Content
A common use case for probe sequences is calculating GC content for normalization:

```r
# Example using Biostrings to calculate GC content
library(Biostrings)
seqs <- DNAStringSet(hthgu133pluspmprobe$sequence)
gc_content <- letterFrequency(seqs, letters="GC", as.prob=TRUE)
```

#### Mapping Coordinates to Sequences
If you have specific x/y coordinates from a CEL file and need the sequence:

```r
# Find sequence at specific coordinates
probe_info <- hthgu133pluspmprobe[hthgu133pluspmprobe$x == 124 & hthgu133pluspmprobe$y == 350, ]
```

## Tips
- **Memory Management**: This data frame is large (over 500,000 rows). If you only need specific columns, consider subsetting them immediately to save memory.
- **Integration**: This package is often used in conjunction with `affy` or `gcrma` packages for preprocessing raw `.CEL` files.
- **Coordinate System**: Affymetrix coordinates are 0-indexed. Ensure your analysis pipeline matches this convention.

## Reference documentation
- [hthgu133pluspmprobe](./references/reference_manual.md)