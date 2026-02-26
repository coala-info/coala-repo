---
name: bioconductor-htmg430aprobe
description: This package provides probe sequence data and metadata for the Affymetrix HT_MG-430A microarray. Use when user asks to access probe sequences, map probes to physical coordinates, or retrieve interrogation positions for the htmg430a platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/htmg430aprobe.html
---


# bioconductor-htmg430aprobe

name: bioconductor-htmg430aprobe
description: Provides probe sequence data for the Affymetrix HT_MG-430A microarray. Use this skill when you need to map probe sequences to their physical coordinates (x, y), interrogation positions, or target strandedness for the htmg430a platform in R.

# bioconductor-htmg430aprobe

## Overview
The `htmg430aprobe` package is a Bioconductor annotation data package containing the probe sequences for the Affymetrix HT_MG-430A microarray. This package is primarily used in transcriptomics workflows where researchers need to verify probe-level information, perform sequence-specific analysis, or re-annotate probe sets based on genomic coordinates.

## Loading and Accessing Data
The package provides a single data object named `htmg430aprobe`.

```r
# Install the package if necessary
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("htmg430aprobe")

# Load the package
library(htmg430aprobe)

# Load the probe data object
data(htmg430aprobe)

# View the structure of the data
str(htmg430aprobe)
```

## Data Structure
The `htmg430aprobe` object is a data frame with 249,975 rows and 6 columns:
- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate of the probe on the array (integer).
- `y`: The y-coordinate of the probe on the array (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The nucleotide position within the target sequence that the probe interrogates (integer).
- `Target.Strandedness`: Whether the target is sense or antisense (factor).

## Common Workflows

### Subsetting Probes by Probe Set
To extract all probes associated with a specific Affymetrix ID:
```r
# Example: Get probes for a specific ID
specific_probes <- htmg430aprobe[htmg430aprobe$Probe.Set.Name == "1415670_at", ]
```

### Sequence Analysis
To perform basic analysis on the probe sequences, such as calculating GC content:
```r
# Calculate GC content for the first 10 probes
probes_sample <- htmg430aprobe$sequence[1:10]
gc_content <- sapply(probes_sample, function(seq) {
  sum(gregexpr("[GC]", seq)[[1]] > 0) / nchar(seq)
})
```

### Converting to a Data Frame
While the object behaves like a data frame, you can explicitly convert it for use with tidyverse or other tools:
```r
probe_df <- as.data.frame(htmg430aprobe)
```

## Usage Tips
- **Memory Management**: This dataset is large (nearly 250k rows). If you only need specific columns (e.g., sequences and IDs), subset them early to save memory.
- **Coordinate Mapping**: The `x` and `y` coordinates are essential for spatial analysis of the array or for identifying potential physical artifacts on the chip.
- **Interrogation Position**: Use the `Probe.Interrogation.Position` to understand where the probe aligns relative to the transcript start/end.

## Reference documentation
- [htmg430aprobe Reference Manual](./references/reference_manual.md)