---
name: bioconductor-hu35ksubcprobe
description: This package provides probe sequence data and spatial coordinates for the Affymetrix hu35ksubc microarray chip. Use when user asks to access probe sequences, retrieve x/y coordinates, or perform sequence-specific analysis for the hu35ksubc platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hu35ksubcprobe.html
---

# bioconductor-hu35ksubcprobe

name: bioconductor-hu35ksubcprobe
description: Provides probe sequence data for the Affymetrix hu35ksubc microarray chip. Use this skill when you need to access, analyze, or map probe-level information (sequences, x/y coordinates, and target strandedness) for the hu35ksubc platform in R.

# bioconductor-hu35ksubcprobe

## Overview

The `hu35ksubcprobe` package is a Bioconductor annotation data package containing the probe sequences for the Affymetrix hu35ksubc microarray. This package is essential for probe-level analysis, such as GC-content adjustment, sequence-specific background correction, or re-mapping probes to updated genomic coordinates.

## Loading and Accessing Data

The primary data object is a data frame named `hu35ksubcprobe`.

```r
# Load the package
library(hu35ksubcprobe)

# Load the probe data object
data(hu35ksubcprobe)

# View the structure of the data
str(hu35ksubcprobe)
```

## Data Structure

The `hu35ksubcprobe` object is a data frame with 140,008 rows and 6 columns:

- **sequence**: The actual nucleotide sequence of the probe (character).
- **x**: The x-coordinate of the probe on the array (integer).
- **y**: The y-coordinate of the probe on the array (integer).
- **Probe.Set.Name**: The Affymetrix identifier for the probe set (character).
- **Probe.Interrogation.Position**: The position within the target sequence (integer).
- **Target.Strandedness**: Whether the target is sense or antisense (factor).

## Common Workflows

### Inspecting Specific Probes
To view the first few probes of the dataset:
```r
head(hu35ksubcprobe)
```

### Filtering by Probe Set
To extract all probes associated with a specific Affymetrix Probe Set ID:
```r
# Example: Filter for a specific probe set
ps_probes <- subset(hu35ksubcprobe, Probe.Set.Name == "1000_at")
```

### Calculating Sequence Statistics
You can use the sequence column to calculate properties like GC content, which is often used in normalization algorithms:
```r
# Calculate GC count for the first 10 probes
sapply(hu35ksubcprobe$sequence[1:10], function(x) {
  sum(charToRaw(x) %in% charToRaw("GC"))
})
```

## Usage Tips
- **Memory Management**: The dataset contains over 140,000 rows. While manageable on most modern systems, use indexing or `subset()` if you only need data for specific probe sets to keep operations efficient.
- **Coordinate Mapping**: The `x` and `y` coordinates are used to map probe intensities from CEL files to their respective sequences.

## Reference documentation

- [hu35ksubcprobe Reference Manual](./references/reference_manual.md)