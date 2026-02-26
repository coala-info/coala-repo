---
name: bioconductor-hcg110probe
description: This package provides sequence-level data and array coordinates for the Affymetrix hcg110 microarray chip. Use when user asks to retrieve probe sequences, access x/y coordinates, or perform sequence-level analysis for the hcg110 platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hcg110probe.html
---


# bioconductor-hcg110probe

name: bioconductor-hcg110probe
description: Access and use probe sequence data for the Affymetrix hcg110 microarray chip. Use this skill when needing to retrieve probe sequences, x/y coordinates, or interrogation positions for the hcg110 platform in Bioconductor.

# bioconductor-hcg110probe

## Overview
The `hcg110probe` package is an annotation data package providing sequence-level information for the Affymetrix hcg110 microarray platform. It contains a data frame mapping probe identifiers to their physical sequences and coordinates on the array. This is primarily used for low-level analysis, such as calculating GC content, background correction, or re-mapping probes to updated genomic coordinates.

## Usage and Workflows

### Loading the Data
The package contains a single primary data object named `hcg110probe`.

```r
# Load the library
library(hcg110probe)

# Load the probe data object
data(hcg110probe)

# View the structure
str(hcg110probe)
```

### Data Structure
The `hcg110probe` object is a data frame with the following columns:
- `sequence`: The actual nucleotide sequence of the probe.
- `x` and `y`: The column and row coordinates of the probe on the array.
- `Probe.Set.Name`: The Affymetrix ID for the probe set.
- `Probe.Interrogation.Position`: The position within the target sequence.
- `Target.Strandedness`: Whether the probe targets the Sense or Antisense strand.

### Common Operations

**1. Accessing specific probe sets:**
```r
# Filter for a specific probe set
ps_data <- hcg110probe[hcg110probe$Probe.Set.Name == "100_g_at", ]
```

**2. Converting to a standard Data Frame:**
For manipulation with `dplyr` or other tools, ensure it is treated as a standard data frame.
```r
df <- as.data.frame(hcg110probe)
head(df, n = 5)
```

**3. Sequence Analysis:**
If you need to calculate the GC content of the probes:
```r
library(Biostrings)
sequences <- DNAStringSet(hcg110probe$sequence)
gc_content <- letterFrequency(sequences, letters = "GC", as.prob = TRUE)
```

## Tips
- This package is a "probe" package, which is distinct from "cdf" (layout) or "db" (annotation) packages. It is specifically for sequence-level data.
- The data object is large (30,313 rows); use `head()` or indexing when inspecting to avoid flooding the console.
- Ensure the `AnnotationForge` package is installed if you intend to rebuild or modify these types of annotation objects.

## Reference documentation
- [hcg110probe Reference Manual](./references/reference_manual.md)