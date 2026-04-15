---
name: bioconductor-medicagoprobe
description: This package provides probe sequence data and physical array coordinates for the Affymetrix Medicago microarray. Use when user asks to access probe sequences, map probes to coordinates, or filter probe data by probe set identifiers for Medicago genome analysis.
homepage: https://bioconductor.org/packages/release/data/annotation/html/medicagoprobe.html
---

# bioconductor-medicagoprobe

name: bioconductor-medicagoprobe
description: Provides probe sequence data for the Medicago (Alfalfa) microarray. Use this skill when an AI agent needs to access, analyze, or map Affymetrix probe sequences, coordinates (x, y), and interrogation positions for the Medicago genome platform in R.

# bioconductor-medicagoprobe

## Overview
The `medicagoprobe` package is a Bioconductor annotation data package containing the probe sequences for the Affymetrix Medicago microarray. It provides a large data frame (673,880 rows) mapping probe sequences to their physical array coordinates and specific probe set identifiers. This is essential for low-level microarray analysis, such as re-masking, sequence-specific normalization, or custom probe-to-gene re-annotation.

## Usage and Workflows

### Loading the Data
The package contains a single primary data object. Load it into the R environment using the `data()` function.

```r
library(medicagoprobe)
data(medicagoprobe)
```

### Data Structure
The `medicagoprobe` object is a data frame with the following columns:
- `sequence`: The actual nucleotide sequence of the probe.
- `x` and `y`: The column and row coordinates of the probe on the array.
- `Probe.Set.Name`: The Affymetrix identifier for the probe set.
- `Probe.Interrogation.Position`: The position within the target sequence.
- `Target.Strandedness`: Whether the target is sense or antisense.

### Common Operations

**Viewing a subset of probes:**
```r
# View the first few rows
head(medicagoprobe)

# Convert a slice to a data frame for easier manipulation
as.data.frame(medicagoprobe[1:5, ])
```

**Filtering by Probe Set:**
To find all probes associated with a specific Affymetrix ID:
```r
target_probes <- medicagoprobe[medicagoprobe$Probe.Set.Name == "Mtr.1000.1.S1_at", ]
```

**Sequence Analysis:**
If you need to calculate GC content or search for specific motifs within the probes:
```r
# Example: Get sequences for a specific probe set
probes <- medicagoprobe$sequence[medicagoprobe$Probe.Set.Name == "Mtr.1000.1.S1_at"]
```

## Tips
- **Memory Management**: The data frame is large (over 600,000 rows). Avoid making multiple copies of the full object in memory.
- **Coordinate Mapping**: The `x` and `y` coordinates are used to link probe sequences to the raw intensity data found in CEL files (often handled via the `affy` or `oligo` packages).
- **AnnotationForge**: This package was built using `AnnotationForge`. If you need to create similar probe packages for custom arrays, refer to the `AnnotationForge` documentation.

## Reference documentation
- [medicagoprobe Reference Manual](./references/reference_manual.md)