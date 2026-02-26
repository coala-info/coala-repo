---
name: bioconductor-canine2probe
description: This package provides probe sequence and coordinate information for the Affymetrix Canine Genome 2.0 Array. Use when user asks to retrieve probe-level sequences, map probe coordinates to probe sets, or perform low-level canine microarray analysis.
homepage: https://bioconductor.org/packages/release/data/annotation/html/canine2probe.html
---


# bioconductor-canine2probe

name: bioconductor-canine2probe
description: Access and use the canine2probe annotation data package for Affymetrix Canine Genome 2.0 Array probe sequences. Use this skill when you need to retrieve probe-level information, including sequences and coordinates, for canine microarray analysis in R.

# bioconductor-canine2probe

## Overview
The `canine2probe` package is a Bioconductor annotation data package containing the probe sequence information for the Affymetrix Canine Genome 2.0 Array. It provides a data frame mapping probe sequences to their specific x/y coordinates on the chip, their associated probe sets, and interrogation positions. This is essential for low-level microarray analysis, such as GC-content normalization or custom probe-set redefinition.

## Loading and Accessing Data
To use the data, you must load the package and then use the `data()` function to bring the object into your environment.

```r
# Load the package
library(canine2probe)

# Load the probe data object
data(canine2probe)

# View the structure of the data
str(canine2probe)
```

## Data Format
The `canine2probe` object is a data frame with 473,162 rows and 6 columns:
- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate on the microarray (integer).
- `y`: The y-coordinate on the microarray (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The nucleotide position within the target sequence (integer).
- `Target.Strandedness`: Whether the target is sense or antisense (factor).

## Common Workflows

### Subsetting Probes
You can extract specific probes or probe sets using standard R data frame indexing.

```r
# View the first few rows
head(canine2probe)

# Extract all probes for a specific Probe Set
target_probes <- subset(canine2probe, Probe.Set.Name == "1582000_at")

# Convert to a standard data frame for manipulation
df_probes <- as.data.frame(canine2probe[1:10, ])
```

### Sequence Analysis
If you need to calculate the GC content of the probes:

```r
# Example: Calculate GC content for the first 5 probes
probes <- canine2probe$sequence[1:5]
gc_content <- sapply(probes, function(x) {
  s <- strsplit(x, NULL)[[1]]
  sum(s %in% c("G", "C")) / length(s)
})
```

## Tips
- **Memory Management**: The `canine2probe` object is large (over 470,000 rows). If you are only interested in specific probe sets, subset the data early to save memory.
- **Coordinate Mapping**: The `x` and `y` coordinates are used to link probe sequences to the raw intensity values found in CEL files (often processed via the `affy` or `oligo` packages).

## Reference documentation
- [canine2probe Reference Manual](./references/reference_manual.md)