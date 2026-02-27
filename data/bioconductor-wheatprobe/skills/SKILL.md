---
name: bioconductor-wheatprobe
description: This package provides sequence-level information and array coordinates for the Affymetrix Wheat Genome Array. Use when user asks to retrieve probe sequences, access x/y coordinates, or obtain interrogation positions for the wheat microarray platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/wheatprobe.html
---


# bioconductor-wheatprobe

name: bioconductor-wheatprobe
description: Access and use the Affymetrix Wheat Genome Array probe sequence data. Use this skill when a user needs to retrieve probe sequences, x/y coordinates, or interrogation positions for the 'wheat' microarray platform in R.

# bioconductor-wheatprobe

## Overview
The `wheatprobe` package is an annotation data package providing sequence-level information for the Affymetrix Wheat Genome Array. It contains a single data object, `wheatprobe`, which maps probe set identifiers to their physical sequences and array coordinates. This is essential for tasks such as re-masking arrays, calculating GC content, or performing custom sequence alignment against updated genome assemblies.

## Loading the Data
To use the probe data, you must first load the library and then call the `data()` function to load the data frame into your environment.

```r
library(wheatprobe)
data(wheatprobe)
```

## Data Structure
The `wheatprobe` object is a data frame with 674,353 rows and 6 columns. Each row represents a single probe on the array.

- **sequence**: The actual nucleotide sequence of the probe (character).
- **x**: The x-coordinate of the probe on the array (integer).
- **y**: The y-coordinate of the probe on the array (integer).
- **Probe.Set.Name**: The Affymetrix identifier for the probe set (character).
- **Probe.Interrogation.Position**: The position within the target sequence that the probe interrogates (integer).
- **Target.Strandedness**: The orientation of the target sequence (factor).

## Common Workflows

### Inspecting Probes
To view the first few probes of the dataset:
```r
head(wheatprobe)
```

### Filtering by Probe Set
To extract all probes associated with a specific Affymetrix Probe Set ID:
```r
# Example: Filter for a specific probe set
target_probes <- wheatprobe[wheatprobe$Probe.Set.Name == "Ta.1.1.S1_at", ]
```

### Sequence Analysis
If you need to calculate the GC content of the probes:
```r
# Requires Biostrings package
library(Biostrings)
probe_seqs <- DNAStringSet(wheatprobe$sequence)
gc_content <- letterFrequency(probe_seqs, letters="GC", as.prob=TRUE)
```

## Tips
- **Memory Management**: The `wheatprobe` object is large (over 600,000 rows). If you only need a subset of columns or rows, subset the data frame early to save memory.
- **Coordinate Mapping**: The `x` and `y` coordinates are used to map probe intensities from CEL files to their specific sequences.
- **AnnotationForge**: This package was built using `AnnotationForge`. If you need to create similar probe packages for other species, refer to the `AnnotationForge` documentation.

## Reference documentation
- [wheatprobe Reference Manual](./references/reference_manual.md)