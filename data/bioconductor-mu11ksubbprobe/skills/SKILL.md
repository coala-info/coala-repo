---
name: bioconductor-mu11ksubbprobe
description: This package provides probe sequences and layout information for the Affymetrix Mu11KsubB mouse microarray. Use when user asks to retrieve probe sequences, find array coordinates, or perform low-level analysis like GC-content normalization for the Mu11KsubB platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mu11ksubbprobe.html
---

# bioconductor-mu11ksubbprobe

name: bioconductor-mu11ksubbprobe
description: Access and use the mu11ksubbprobe annotation data package. Use this skill when you need probe sequence information, array coordinates (x, y), or probe set identifiers for the Affymetrix Mu11KsubB microarray platform.

# bioconductor-mu11ksubbprobe

## Overview
The `mu11ksubbprobe` package is a Bioconductor annotation data package containing the probe sequences and layout information for the Affymetrix Mu11KsubB mouse microarray. This package is essential for low-level analysis tasks such as GC-content based normalization (e.g., GCRMA) or custom probe-to-gene remapping.

## Usage in R

### Loading the Data
The package contains a single primary data object named `mu11ksubbprobe`.

```r
# Load the library
library(mu11ksubbprobe)

# Load the probe data object
data(mu11ksubbprobe)
```

### Data Structure
The `mu11ksubbprobe` object is a data frame containing 119,580 rows. Each row represents a single probe on the array.

Key columns include:
- `sequence`: The actual DNA sequence of the probe (character).
- `x` and `y`: The column and row coordinates of the probe on the microarray chip (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set the probe belongs to (character).
- `Probe.Interrogation.Position`: The nucleotide position within the target sequence (integer).
- `Target.Strandedness`: Whether the target is sense or antisense (factor).

### Common Workflows

#### Inspecting Probes
To view the first few entries of the probe data:
```r
head(mu11ksubbprobe)
```

#### Filtering by Probe Set
To extract all probes associated with a specific Affymetrix ID:
```r
target_probes <- mu11ksubbprobe[mu11ksubbprobe$Probe.Set.Name == "1000_at", ]
```

#### Calculating GC Content
A common use case for probe sequences is calculating GC content for normalization:
```r
# Example using Biostrings to calculate GC content
library(Biostrings)
sequences <- DNAStringSet(mu11ksubbprobe$sequence)
gc_content <- letterFrequency(sequences, letters="GC", as.prob=TRUE)
```

## Tips
- This package is a "probe" package, which is distinct from "CDF" (Chip Definition File) packages. While CDF packages define which probes belong to which sets, the probe package provides the actual sequences and physical coordinates.
- Ensure you have `AnnotationForge` installed if you intend to rebuild or inspect the metadata of how this package was generated.

## Reference documentation
- [mu11ksubbprobe Reference Manual](./references/reference_manual.md)