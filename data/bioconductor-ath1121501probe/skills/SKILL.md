---
name: bioconductor-ath1121501probe
description: This package provides probe sequence data and array coordinates for the Arabidopsis Thaliana ATH1-121501 Affymetrix microarray. Use when user asks to access probe sequences, map probes to array coordinates, or retrieve interrogation positions for genomic analysis in R.
homepage: https://bioconductor.org/packages/release/data/annotation/html/ath1121501probe.html
---

# bioconductor-ath1121501probe

name: bioconductor-ath1121501probe
description: Access and use probe sequence data for the Arabidopsis Thaliana ATH1-121501 Affymetrix array. Use this skill when needing to map probe sequences to coordinates (x, y), probe set names, or interrogation positions for genomic analysis in R.

# bioconductor-ath1121501probe

## Overview
The `ath1121501probe` package is a Bioconductor annotation data package containing the probe sequence information for the Affymetrix ATH1-121501 microarray (Arabidopsis Thaliana). It provides a standardized data frame mapping individual probes to their sequences, array coordinates, and target probe sets.

## Installation and Loading
To use this package, it must be installed via `BiocManager` and loaded into the R session.

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("ath1121501probe")
library(ath1121501probe)
```

## Data Usage
The package contains a single primary data object: `ath1121501probe`.

### Loading the Data
Load the probe data frame into the environment:
```r
data(ath1121501probe)
```

### Data Structure
The object is a data frame with 251,078 rows and 6 columns:
- `sequence`: The actual nucleotide sequence (character).
- `x`: The x-coordinate on the array (integer).
- `y`: The y-coordinate on the array (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The position within the target sequence (integer).
- `Target.Strandedness`: The orientation of the target (factor).

### Common Workflows

**Previewing the data:**
```r
# View the first few rows
head(ath1121501probe)

# Convert a subset to a standard data frame for manipulation
df_subset <- as.data.frame(ath1121501probe[1:10, ])
```

**Filtering by Probe Set:**
If you are interested in a specific gene or probe set, filter the data frame:
```r
# Example: Filter for a specific Affymetrix ID
my_probes <- subset(ath1121501probe, Probe.Set.Name == "244901_at")
```

**Analyzing Sequence Composition:**
You can use standard R functions or Biostrings to analyze the probe sequences:
```r
# Calculate average length of sequences (usually 25bp for Affymetrix)
mean(nchar(ath1121501probe$sequence))

# Tabulate strandedness
table(ath1121501probe$Target.Strandedness)
```

## Tips
- This package is primarily used as a dependency for other Bioconductor tools (like `affy`) but is useful for custom sequence-level analysis or re-annotation projects.
- The coordinates (x, y) are essential if you are performing spatial analysis of array intensity data.
- Ensure you have sufficient memory, as the data frame contains over 250,000 rows.

## Reference documentation
- [ath1121501probe Reference Manual](./references/reference_manual.md)