---
name: bioconductor-hthgu133aprobe
description: This package provides probe sequence data and spatial coordinates for the Affymetrix HT_HG-U133A microarray. Use when user asks to access probe sequences, map probes to probe sets, identify spatial coordinates on the array, or analyze probe interrogation positions and strandedness for the hthgu133a platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hthgu133aprobe.html
---

# bioconductor-hthgu133aprobe

name: bioconductor-hthgu133aprobe
description: Access and use probe sequence data for the Affymetrix HT_HG-U133A microarray. Use this skill when needing to map probe sequences to probe sets, identify spatial coordinates (x, y) on the array, or analyze probe interrogation positions and strandedness for the hthgu133a platform.

# bioconductor-hthgu133aprobe

## Overview

The `hthgu133aprobe` package is a Bioconductor annotation data package containing the probe sequences for the Affymetrix HT_HG-U133A microarray. This package is essential for sequence-specific analysis, such as re-annotating probe sets, calculating GC content, or investigating probe-level hybridization biases.

## Loading and Accessing Data

To use the probe data, load the library and use the `data()` function to bring the data frame into the environment.

```r
# Load the package
library(hthgu133aprobe)

# Load the probe dataset
data(hthgu133aprobe)

# View the structure of the data
str(hthgu133aprobe)
```

## Data Structure

The `hthgu133aprobe` object is a data frame with approximately 247,719 rows and 6 columns:

- **sequence**: The actual 25-mer probe sequence (character).
- **x**: The x-coordinate of the probe on the microarray (integer).
- **y**: The y-coordinate of the probe on the microarray (integer).
- **Probe.Set.Name**: The Affymetrix identifier for the probe set (character).
- **Probe.Interrogation.Position**: The nucleotide position within the target sequence that the probe interrogates (integer).
- **Target.Strandedness**: Whether the target is sense or antisense (factor).

## Common Workflows

### Filtering by Probe Set
To extract all probes associated with a specific Affymetrix ID:

```r
# Example: Get probes for a specific set
specific_probes <- hthgu133aprobe[hthgu133aprobe$Probe.Set.Name == "200000_s_at", ]
```

### Sequence Analysis
To perform sequence-level calculations, such as determining the GC content of probes:

```r
# Calculate GC content for the first 10 probes
probes_sample <- hthgu133aprobe$sequence[1:10]
gc_content <- sapply(probes_sample, function(seq) {
  sum(charToRaw(seq) %in% charToRaw("GC")) / nchar(seq)
})
```

### Spatial Mapping
Use the `x` and `y` columns to visualize or analyze spatial artifacts on the microarray chip.

```r
# Summary of coordinates
summary(hthgu133aprobe[, c("x", "y")])
```

## Usage Tips
- The dataset is large; when exploring, use `head(hthgu133aprobe)` or indexing (e.g., `hthgu133aprobe[1:5, ]`) to avoid flooding the console.
- This package is specifically for the **HT_HG-U133A** array. Ensure the platform matches your expression data (often found in the `annotation` slot of an ExpressionSet).

## Reference documentation

- [hthgu133aprobe Manual](./references/reference_manual.md)