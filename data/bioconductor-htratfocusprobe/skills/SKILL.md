---
name: bioconductor-htratfocusprobe
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/htratfocusprobe.html
---

# bioconductor-htratfocusprobe

name: bioconductor-htratfocusprobe
description: Provides probe sequence data for the Affymetrix HT_Rat-Focus microarray. Use this skill when you need to access, filter, or analyze specific probe sequences, coordinates (x, y), or interrogation positions for the htratfocus platform in R.

# bioconductor-htratfocusprobe

## Overview
The `htratfocusprobe` package is a Bioconductor annotation data package containing the sequence information for the probes on the Affymetrix HT_Rat-Focus array. This data is essential for genomic analyses that require mapping probe-level intensities back to specific sequences or genomic locations, or for performing sequence-specific quality control.

## Installation and Loading
To use this data package, it must be installed via `BiocManager` and loaded into the R session.

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("htratfocusprobe")
library(htratfocusprobe)
```

## Accessing Probe Data
The package provides a single primary data object: `htratfocusprobe`. This is a data frame containing the probe sequences and their metadata.

### Loading the Data Object
```r
# Load the dataset into the environment
data(htratfocusprobe)

# View the structure of the data
str(htratfocusprobe)
```

### Data Format
The `htratfocusprobe` data frame contains 266,962 rows and 6 columns:
- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate of the probe on the microarray (integer).
- `y`: The y-coordinate of the probe on the microarray (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The position within the target sequence being interrogated (integer).
- `Target.Strandedness`: Whether the target is sense or antisense (factor).

## Common Workflows

### Inspecting Specific Probe Sets
To extract all probes associated with a specific GeneChip probe set ID:
```r
# Example: Extract probes for a specific ID
subset_probes <- htratfocusprobe[htratfocusprobe$Probe.Set.Name == "1367452_at", ]
head(subset_probes)
```

### Sequence Analysis
You can use this package in conjunction with `Biostrings` to perform sequence analysis, such as calculating GC content:
```r
library(Biostrings)

# Convert sequences to DNAStringSet
probe_seqs <- DNAStringSet(htratfocusprobe$sequence[1:100])
# Calculate GC content
letterFrequency(probe_seqs, letters="GC", as.prob=TRUE)
```

### Spatial Mapping
The `x` and `y` columns can be used to identify the physical location of probes on the chip, which is useful for detecting regional artifacts (e.g., "bubbles" or "smudges" on the array).

## Tips
- **Memory Management**: The `htratfocusprobe` object is a large data frame. If you only need a subset of columns (e.g., just sequences and IDs), consider subsetting it to save memory.
- **Version Consistency**: Ensure that the version of `htratfocusprobe` matches the version of the CDF or annotation packages (like `htratfocuscdf`) you are using for your analysis to ensure probe-to-probeset mapping consistency.

## Reference documentation
- [htratfocusprobe Reference Manual](./references/reference_manual.md)