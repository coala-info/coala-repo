---
name: bioconductor-barley1probe
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/barley1probe.html
---

# bioconductor-barley1probe

name: bioconductor-barley1probe
description: Provides probe sequence data for the Affymetrix Barley1 microarray. Use when needing to retrieve, analyze, or map probe sequences, coordinates (x, y), and probe set identifiers for barley genomic studies using Bioconductor.

# bioconductor-barley1probe

## Overview
The `barley1probe` package is a Bioconductor annotation data package containing the probe sequences and location information for the Affymetrix Barley1 microarray. It is primarily used in transcriptomics workflows to map specific probes to their sequences or to verify probe interrogation positions.

## Loading and Accessing Data
The package contains a single primary data object, `barley1probe`.

```r
# Load the library
library(barley1probe)

# Load the probe data object
data(barley1probe)

# View the structure of the data
str(barley1probe)
```

## Data Structure
The `barley1probe` object is a data frame with 251,437 rows and 6 columns:
- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate of the probe on the array (integer).
- `y`: The y-coordinate of the probe on the array (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The nucleotide position being interrogated (integer).
- `Target.Strandedness`: The orientation of the target (factor).

## Common Workflows

### Subsetting Probes by Probe Set
To extract all probes associated with a specific gene or probe set:

```r
# Example: Get probes for a specific Probe Set
subset_probes <- barley1probe[barley1probe$Probe.Set.Name == "Contig1_at", ]
head(subset_probes)
```

### Exporting Sequences
To export the probe sequences for use in external alignment tools (like BLAST):

```r
# Extract sequences as a vector
sequences <- barley1probe$sequence

# View the first few sequences
head(sequences)
```

### Spatial Analysis
The `x` and `y` coordinates can be used to check for spatial artifacts on the microarray chip:

```r
# Summary of coordinates
summary(barley1probe[, c("x", "y")])
```

## Tips
- The package is a "data-only" package. It does not contain complex functions, but rather provides the raw data frame used by other Bioconductor tools like `affy`.
- Because the data frame is large (over 250,000 rows), use `head()` or indexing when inspecting the object to avoid flooding the R console.

## Reference documentation
- [barley1probe Reference Manual](./references/reference_manual.md)