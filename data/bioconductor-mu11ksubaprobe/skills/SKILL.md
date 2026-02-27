---
name: bioconductor-mu11ksubaprobe
description: This package provides probe sequence data for the Affymetrix Mu11KsubA microarray. Use when user asks to access probe sequences, perform probe-level analysis, or conduct quality control for Mu11KsubA expression data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mu11ksubaprobe.html
---


# bioconductor-mu11ksubaprobe

name: bioconductor-mu11ksubaprobe
description: Access and utilize probe sequence data for the Affymetrix Mu11KsubA microarray. Use this skill when performing probe-level analysis, sequence alignment, or quality control for Mu11KsubA expression data in R.

# bioconductor-mu11ksubaprobe

## Overview

The `mu11ksubaprobe` package is a Bioconductor annotation data package containing the sequence information for the probes on the Affymetrix Mu11KsubA chip. It provides a standardized data frame mapping probe sequences to their physical coordinates and target probe sets.

## Loading and Accessing Data

To use the probe data, load the library and the dataset:

```r
library(mu11ksubaprobe)
data(mu11ksubaprobe)
```

## Data Structure

The `mu11ksubaprobe` object is a data frame with 131,280 rows and 6 columns:

- **sequence**: The actual nucleotide sequence of the probe.
- **x**: The x-coordinate of the probe on the array.
- **y**: The y-coordinate of the probe on the array.
- **Probe.Set.Name**: The Affymetrix identifier for the probe set.
- **Probe.Interrogation.Position**: The nucleotide position within the target sequence.
- **Target.Strandedness**: Whether the probe targets the Sense or Antisense strand.

## Common Workflows

### Inspecting Probe Data
View the first few entries of the probe table:

```r
head(mu11ksubaprobe)
```

### Filtering by Probe Set
Extract all probes associated with a specific gene or probe set:

```r
# Example: Filter for a specific probe set
subset_probes <- subset(mu11ksubaprobe, Probe.Set.Name == "1000_at")
```

### Sequence Analysis
Calculate the GC content of the probes (requires `Biostrings`):

```r
library(Biostrings)
probes_dna <- DNAStringSet(mu11ksubaprobe$sequence)
gc_content <- letterFrequency(probes_dna, letters="GC", as.prob=TRUE)
```

## Usage Tips
- This package is primarily used as a dependency for other Bioconductor tools like `affy` or `gcrma`.
- The data frame is large; when performing operations, consider using vectorized functions or `dplyr` for efficiency.
- Ensure the array type (Mu11KsubA) matches your experimental data exactly, as probe sequences are specific to this chip design.

## Reference documentation

- [mu11ksubaprobe Reference Manual](./references/reference_manual.md)