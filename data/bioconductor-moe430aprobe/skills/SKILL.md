---
name: bioconductor-moe430aprobe
description: This package provides probe sequence data and physical mapping information for the Affymetrix Mouse Expression 430A microarray. Use when user asks to retrieve probe sequences, find x/y coordinates on the array, or access interrogation positions for specific probe sets on the MOE430A platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/moe430aprobe.html
---


# bioconductor-moe430aprobe

name: bioconductor-moe430aprobe
description: Access and use probe sequence data for the Affymetrix Mouse Expression 430A (MOE430A) microarray. Use this skill when you need to retrieve probe sequences, x/y coordinates, or interrogation positions for specific probe sets on the moe430a platform for genomic analysis in R.

# bioconductor-moe430aprobe

## Overview
The `moe430aprobe` package is a Bioconductor annotation data package containing the probe sequence information for the Affymetrix Mouse Expression 430A microarray. It provides a centralized data frame mapping probe sequences to their physical locations on the chip and their corresponding probe sets.

## Installation and Loading
To use this package in R:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("moe430aprobe")
library(moe430aprobe)
```

## Data Usage
The primary data object is a data frame also named `moe430aprobe`.

### Loading the Data
```r
# Load the dataset into the workspace
data(moe430aprobe)
```

### Data Structure
The dataset contains 249,958 rows and 6 columns:
- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate on the array (integer).
- `y`: The y-coordinate on the array (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The position within the target sequence (integer).
- `Target.Strandedness`: Whether the target is sense or antisense (factor).

## Common Workflows

### Inspecting Probes
To view the first few entries:
```r
head(moe430aprobe)
```

### Filtering by Probe Set
To extract all probes associated with a specific gene or probe set ID:
```r
# Example: Filter for a specific Affymetrix ID
target_probes <- subset(moe430aprobe, Probe.Set.Name == "1415670_at")
```

### Sequence Analysis
You can use this data to perform GC content analysis or sequence matching:
```r
# Calculate sequence length for the first 10 probes
nchar(moe430aprobe$sequence[1:10])
```

## Tips
- This package is a "data-only" package. It does not contain complex functions, but rather provides the raw data frame used by other Bioconductor tools (like `affy` or `limma`) for low-level analysis.
- Because the data frame is large (250k+ rows), use `subset()` or indexing rather than printing the whole object to the console.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)