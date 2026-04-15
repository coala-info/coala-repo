---
name: bioconductor-chickenprobe
description: This package provides probe sequence data and physical array coordinates for Affymetrix Chicken genome microarrays. Use when user asks to map Affymetrix probe identifiers to sequences, retrieve probe coordinates on the array, or perform sequence-level analysis for Gallus gallus genomic studies.
homepage: https://bioconductor.org/packages/release/data/annotation/html/chickenprobe.html
---

# bioconductor-chickenprobe

name: bioconductor-chickenprobe
description: Provides probe sequence data for Affymetrix Chicken microarrays. Use this skill when you need to map Affymetrix probe identifiers to their physical sequences, x/y coordinates on the array, or interrogation positions for Gallus gallus genomic analysis.

# bioconductor-chickenprobe

## Overview

The `chickenprobe` package is a Bioconductor annotation data package containing the sequence information for the probes on the Affymetrix Chicken genome array. Unlike standard annotation packages that map probes to genes, this package provides the raw sequence data and physical array coordinates for each probe. This is essential for tasks such as re-masking arrays, calculating GC content, or performing custom sequence alignments to updated genome builds.

## Loading and Accessing Data

The package contains a single primary data object also named `chickenprobe`.

```r
# Install the package if necessary
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("chickenprobe")

# Load the library
library(chickenprobe)

# Load the data object
data(chickenprobe)

# View the structure
str(chickenprobe)
```

## Data Structure

The `chickenprobe` object is a data frame with over 400,000 rows. Each row represents a single probe with the following columns:

- `sequence`: The actual nucleotide sequence (character).
- `x`: The x-coordinate on the microarray (integer).
- `y`: The y-coordinate on the microarray (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The nucleotide position within the target sequence (integer).
- `Target.Strandedness`: Whether the target is sense or antisense (factor).

## Common Workflows

### Subsetting Probes by Probe Set
To extract all probe sequences associated with a specific Affymetrix ID:

```r
# Example: Get sequences for a specific probe set
ps_name <- "121_at"
subset_probes <- chickenprobe[chickenprobe$Probe.Set.Name == ps_name, ]
print(subset_probes)
```

### Converting to Biostrings
For sequence analysis, it is often useful to convert the data frame sequences into a `DNAStringSet` object:

```r
library(Biostrings)
probe_sequences <- DNAStringSet(chickenprobe$sequence)
names(probe_sequences) <- chickenprobe$Probe.Set.Name
```

### Spatial Analysis
You can use the `x` and `y` coordinates to check for spatial artifacts on the array:

```r
# Plotting a subset of probe locations
plot(chickenprobe$x[1:1000], chickenprobe$y[1:1000], 
     main="Probe Spatial Distribution (Subset)",
     xlab="X-coordinate", ylab="Y-coordinate", pch=".")
```

## Usage Tips
- **Memory Management**: The `chickenprobe` object is large. If you only need specific columns (e.g., sequences and IDs), subset the data frame early to save memory.
- **Coordinate System**: The x and y coordinates are 0-indexed, following the standard Affymetrix convention.
- **Updates**: This package is static; it represents the probe design as defined by Affymetrix. For updated gene mappings, use the corresponding chip annotation package (e.g., `chicken.db`).

## Reference documentation

- [chickenprobe Reference Manual](./references/reference_manual.md)