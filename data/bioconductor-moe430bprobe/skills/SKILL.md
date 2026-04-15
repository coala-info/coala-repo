---
name: bioconductor-moe430bprobe
description: This package provides probe sequence data and array coordinates for the Affymetrix Mouse Expression 430B microarray. Use when user asks to retrieve probe sequences, find probe x/y coordinates, or access interrogation positions for MOE430B genomic analysis and annotation.
homepage: https://bioconductor.org/packages/release/data/annotation/html/moe430bprobe.html
---

# bioconductor-moe430bprobe

name: bioconductor-moe430bprobe
description: Access and use probe sequence data for the Affymetrix Mouse Expression 430B (MOE430B) microarray. Use this skill when you need to retrieve specific probe sequences, their x/y coordinates on the array, or their interrogation positions for genomic analysis and annotation of MOE430B chips.

# bioconductor-moe430bprobe

## Overview
The `moe430bprobe` package is a Bioconductor annotation data package containing the probe sequences for the Affymetrix Mouse Expression 430B microarray. This package is essential for researchers performing low-level analysis of microarray data, such as sequence-specific background correction or re-annotation of probe sets based on updated genome builds.

## Usage and Workflows

### Loading the Data
The primary data object is a data frame named `moe430bprobe`.

```r
# Load the package
library(moe430bprobe)

# Load the probe data object
data(moe430bprobe)
```

### Data Structure
The `moe430bprobe` object is a data frame with 248,704 rows and 6 columns:
- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate of the probe on the array (integer).
- `y`: The y-coordinate of the probe on the array (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The position of the interrogation base (integer).
- `Target.Strandedness`: The orientation of the target (factor).

### Common Operations

**Viewing a subset of probes:**
```r
# View the first few rows
head(moe430bprobe)

# Convert a specific range to a data frame for inspection
as.data.frame(moe430bprobe[1:10, ])
```

**Filtering by Probe Set:**
To find all probes associated with a specific Affymetrix ID:
```r
target_probes <- moe430bprobe[moe430bprobe$Probe.Set.Name == "1415670_at", ]
```

**Analyzing GC Content:**
A common task is calculating the GC content of probes for normalization:
```r
# Example using Biostrings
library(Biostrings)
sequences <- DNAStringSet(moe430bprobe$sequence)
gc_content <- letterFrequency(sequences, letters="GC", as.prob=TRUE)
```

## Tips
- This package is specifically for the **430B** array. If you are working with the 430A or 430 2.0 arrays, you will need the `moe430aprobe` or `mouse4302probe` packages respectively.
- The coordinates (x, y) are used to map probe intensities from CEL files to their corresponding sequences.
- Ensure you have `AnnotationForge` installed if you intend to rebuild or modify these annotation objects.

## Reference documentation
- [moe430bprobe Reference Manual](./references/reference_manual.md)