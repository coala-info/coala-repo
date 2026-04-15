---
name: bioconductor-test3probe
description: This package provides probe sequence data for the Affymetrix test3 microarray platform. Use when user asks to retrieve probe sequences, perform sequence-specific adjustments, or conduct quality control for test3 microarray data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/test3probe.html
---

# bioconductor-test3probe

## Overview
The `test3probe` package is a Bioconductor annotation data package containing the probe sequences for the Affymetrix test3 microarray platform. This data was automatically generated using `AnnotationForge` and is primarily used for low-level analysis, sequence-specific adjustments, or quality control of microarray data.

## Usage and Workflows

### Loading the Data
To use the probe data, you must first load the library and then use the `data()` function to bring the `test3probe` object into your environment.

```r
library(test3probe)
data(test3probe)
```

### Data Structure
The `test3probe` object is a data frame containing 6,354 rows. Each row represents a single probe. The columns include:

- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate of the probe on the array (integer).
- `y`: The y-coordinate of the probe on the array (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The position within the target sequence (integer).
- `Target.Strandedness`: Whether the target is sense or antisense (factor).

### Common Operations

**Viewing the first few probes:**
```r
head(test3probe)
```

**Filtering by Probe Set:**
If you are interested in a specific gene or probe set, you can subset the data frame:
```r
# Replace 'SET_NAME' with a valid Affymetrix ID
specific_probes <- test3probe[test3probe$Probe.Set.Name == "SET_NAME", ]
```

**Analyzing Sequence Composition:**
You can use standard R functions or Biostrings to analyze the sequences:
```r
# Calculate the length of sequences (should be 25 for Affymetrix)
table(nchar(test3probe$sequence))
```

## Tips
- The `test3probe` object is a standard R `data.frame`. You can use `dplyr` or base R for manipulation.
- This package is specifically for the "test3" array type; ensure your expression data (e.g., from an `.CEL` file) matches this platform before using these sequences for analysis.
- For mapping these probes to genomic coordinates, you may need the corresponding chip definition file (CDF) or a platform-specific `db` package (e.g., `test3.db`).

## Reference documentation
- [test3probe Reference Manual](./references/reference_manual.md)