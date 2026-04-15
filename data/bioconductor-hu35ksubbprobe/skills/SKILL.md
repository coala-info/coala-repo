---
name: bioconductor-hu35ksubbprobe
description: This package provides probe sequence data and spatial coordinates for the Affymetrix hu35ksubb microarray chip. Use when user asks to retrieve probe sequences, map probes to physical coordinates, or perform sequence-based analysis for the hu35ksubb array.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hu35ksubbprobe.html
---

# bioconductor-hu35ksubbprobe

name: bioconductor-hu35ksubbprobe
description: Provides probe sequence data for the Affymetrix hu35ksubb microarray chip. Use this skill when you need to map Affymetrix probe identifiers to their physical sequences, coordinates (x, y), or interrogation positions for genomic analysis in R.

# bioconductor-hu35ksubbprobe

## Overview

The `hu35ksubbprobe` package is a Bioconductor annotation data package containing the sequence information for the probes on the Affymetrix hu35ksubb array. This package is essential for low-level analysis of microarray data, such as calculating GC content, performing sequence-specific background correction, or re-mapping probes to updated genome assemblies.

## Usage and Workflows

### Loading the Data

The package contains a single primary data object also named `hu35ksubbprobe`.

```r
# Install the package if necessary
# if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
# BiocManager::install("hu35ksubbprobe")

library(hu35ksubbprobe)

# Load the probe data
data(hu35ksubbprobe)
```

### Data Structure

The `hu35ksubbprobe` object is a data frame. You can inspect its structure using standard R functions:

```r
# View the first few rows
head(hu35ksubbprobe)

# Check column names and types
str(hu35ksubbprobe)
```

The data frame contains the following columns:
- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate of the probe on the array (integer).
- `y`: The y-coordinate of the probe on the array (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The position within the target sequence (integer).
- `Target.Strandedness`: Whether the target is sense or antisense (factor).

### Common Tasks

#### Filtering by Probe Set
To extract all probes associated with a specific Affymetrix ID:

```r
target_probes <- subset(hu35ksubbprobe, Probe.Set.Name == "your_probe_set_id")
```

#### Calculating Sequence Statistics
You can use the `Biostrings` package alongside this data to calculate properties like GC content:

```r
library(Biostrings)
sequences <- DNAStringSet(hu35ksubbprobe$sequence)
gc_content <- letterFrequency(sequences, letters="GC", as.prob=TRUE)
hu35ksubbprobe$gc <- gc_content
```

## Tips
- This package is a "probe" package, which differs from "cdf" or "db" annotation packages. It focuses specifically on the physical sequences and coordinates rather than gene symbols or GO terms.
- Because the data frame is large (approx. 140,000 rows), use vectorized operations or `dplyr` for efficient filtering and transformation.

## Reference documentation

- [hu35ksubbprobe Reference Manual](./references/reference_manual.md)