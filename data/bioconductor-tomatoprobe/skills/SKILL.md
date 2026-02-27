---
name: bioconductor-tomatoprobe
description: This package provides probe sequence data and layout information for the Affymetrix Tomato Genome Array. Use when user asks to analyze tomato microarray data, map probes to sequences, or retrieve spatial coordinates and interrogation positions for tomato probe sets.
homepage: https://bioconductor.org/packages/release/data/annotation/html/tomatoprobe.html
---


# bioconductor-tomatoprobe

name: bioconductor-tomatoprobe
description: Provides probe sequence data for the Affymetrix Tomato Genome Array. Use when analyzing tomato microarray data, mapping probes to sequences, or requiring spatial coordinates (x, y) and interrogation positions for the tomato probe set.

# bioconductor-tomatoprobe

## Overview
The `tomatoprobe` package is a Bioconductor annotation data package containing the probe sequences and layout information for the Affymetrix Tomato Genome Array. It provides a standardized data frame mapping probe identifiers to their physical sequences, array coordinates, and target strand information.

## Usage and Workflows

### Loading the Data
To use the probe data, you must first load the library and then call the `data()` function to bring the `tomatoprobe` object into your environment.

```r
# Load the package
library(tomatoprobe)

# Load the probe data frame
data(tomatoprobe)

# View the structure
str(tomatoprobe)
```

### Data Structure
The `tomatoprobe` object is a data frame with 112,528 rows and 6 columns:
- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate of the probe on the microarray (integer).
- `y`: The y-coordinate of the probe on the microarray (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The position within the target sequence (integer).
- `Target.Strandedness`: Whether the target is sense or antisense (factor).

### Common Operations

**Viewing a subset of probes:**
```r
# View the first few rows
head(tomatoprobe)

# Access specific probe set data
sub_probes <- subset(tomatoprobe, Probe.Set.Name == "Le.100.1.S1_at")
```

**Exporting for external analysis:**
If you need to use these sequences in external tools like BLAST or for custom alignment:
```r
# Convert to a standard data frame if necessary
df_probes <- as.data.frame(tomatoprobe)

# Example: Get unique sequences for a specific probe set
unique_seqs <- unique(df_probes[df_probes$Probe.Set.Name == "Le.100.1.S1_at", "sequence"])
```

## Tips
- The package is primarily used as a dependency for other Bioconductor tools (like `affy`) that perform background correction or sequence-specific normalization.
- Ensure you have `AnnotationForge` installed if you intend to rebuild or modify the annotation object, though for standard analysis, `tomatoprobe` is sufficient.

## Reference documentation
- [tomatoprobe Reference Manual](./references/reference_manual.md)