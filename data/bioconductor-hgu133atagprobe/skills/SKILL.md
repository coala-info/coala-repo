---
name: bioconductor-hgu133atagprobe
description: This package provides probe sequence data and mapping information for the Affymetrix HG-U133A_tag microarray. Use when user asks to access probe sequences, map probes to coordinates or probe sets, and perform low-level sequence analysis for the hgu133atag platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgu133atagprobe.html
---

# bioconductor-hgu133atagprobe

name: bioconductor-hgu133atagprobe
description: Access and utilize probe sequence data for the Affymetrix HG-U133A_tag microarray. Use this skill when needing to map probe sequences to coordinates, probe sets, or interrogation positions for the hgu133atag platform in R.

# bioconductor-hgu133atagprobe

## Overview
The `hgu133atagprobe` package is a Bioconductor annotation data package containing the probe sequence information for the Affymetrix HG-U133A_tag array. It provides a data frame mapping individual 25-mer sequences to their specific (x, y) coordinates on the chip, their parent Probe Set ID, and the specific interrogation position within the target sequence.

## Usage and Workflows

### Loading the Data
The package contains a single primary data object. To use it, you must load the library and then use the `data()` function.

```r
library(hgu133atagprobe)
data(hgu133atagprobe)
```

### Data Structure
The `hgu133atagprobe` object is a data frame with 248,152 rows and 6 columns:
- `sequence`: The 25-mer probe sequence (character).
- `x`: The x-coordinate on the array (integer).
- `y`: The y-coordinate on the array (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The nucleotide position within the target sequence (integer).
- `Target.Strandedness`: The orientation of the target (factor).

### Common Operations

**Viewing a subset of probes:**
```r
# View the first few rows
head(hgu133atagprobe)

# Access specific rows as a data frame
as.data.frame(hgu133atagprobe[1:5, ])
```

**Filtering by Probe Set:**
To find all probes associated with a specific gene or probe set:
```r
target_probes <- subset(hgu133atagprobe, Probe.Set.Name == "200000_s_at")
```

**Analyzing Sequence Composition:**
If you need to calculate GC content or search for specific motifs within the probes:
```r
# Example: Get sequences for a specific probe set
probes <- hgu133atagprobe$sequence[hgu133atagprobe$Probe.Set.Name == "200000_s_at"]
```

## Tips
- This package is primarily used for low-level analysis, such as calculating background signal based on GC content or re-annotating probe sets.
- For high-level expression analysis, use this in conjunction with the `hgu133atag.db` (annotation) and `hgu133atagcdf` (layout) packages.
- The data frame is large; when performing iterative operations, prefer vectorized functions or `dplyr` for efficiency.

## Reference documentation
- [hgu133atagprobe Reference Manual](./references/reference_manual.md)