---
name: bioconductor-rgu34bprobe
description: This package provides probe sequence and location data for the Affymetrix Rat Genome U34B microarray. Use when user asks to access probe sequences, retrieve x/y coordinates on the array, or map probes to probe sets for the rgu34b platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/rgu34bprobe.html
---

# bioconductor-rgu34bprobe

name: bioconductor-rgu34bprobe
description: Access and use the rgu34bprobe annotation data package for Affymetrix Rat Genome U34B microarrays. Use this skill when you need probe sequence information, x/y coordinates on the array, or probe set mappings for the rgu34b platform in R.

# bioconductor-rgu34bprobe

## Overview

The `rgu34bprobe` package is a Bioconductor annotation data package containing the probe sequences and location information for the Affymetrix Rat Genome U34B microarray. This package is essential for low-level analysis of microarray data, such as calculating GC content for normalization or identifying specific probe locations for quality control.

## Usage and Workflows

### Loading the Data

To use the probe data, you must first load the package and then use the `data()` function to load the data frame into your environment.

```r
library(rgu34bprobe)
data(rgu34bprobe)
```

### Data Structure

The `rgu34bprobe` object is a data frame containing 140,312 rows. Each row represents a single probe. The columns include:

- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate of the probe on the array (integer).
- `y`: The y-coordinate of the probe on the array (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The position of the interrogation base (integer).
- `Target.Strandedness`: The strandedness of the target (factor).

### Common Tasks

#### Inspecting the Data
To view the first few entries of the probe data:
```r
head(rgu34bprobe)
```

#### Filtering by Probe Set
To extract all probes belonging to a specific Affymetrix Probe Set:
```r
# Example for a specific probe set ID
subset_probes <- subset(rgu34bprobe, Probe.Set.Name == "138944_at")
```

#### Calculating Sequence Statistics
You can use standard R functions or Biostrings to analyze the sequences:
```r
# Calculate the length of sequences (should be 25 for Affymetrix)
table(nchar(rgu34bprobe$sequence))

# Simple GC content calculation example
get_gc <- function(seqs) {
  g <- nchar(gsub("[^G]", "", seqs))
  c <- nchar(gsub("[^C]", "", seqs))
  return((g + c) / nchar(seqs))
}
rgu34bprobe$gc_content <- get_gc(rgu34bprobe$sequence)
```

## Tips
- The package is primarily used as a dependency for other Bioconductor packages like `affy` or `gcrma`.
- If you are performing high-level differential expression analysis, you likely need the `rgu34b.db` package instead of the `probe` package. Use this package only when you need the physical sequence or coordinate data.

## Reference documentation

- [rgu34bprobe Reference Manual](./references/reference_manual.md)