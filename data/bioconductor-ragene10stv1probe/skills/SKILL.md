---
name: bioconductor-ragene10stv1probe
description: This package provides probe sequence data and array coordinates for the Affymetrix Rat Gene 1.0 ST v1 microarray. Use when user asks to retrieve probe sequences, find probe coordinates, or perform probe-level analysis for rat genomic studies.
homepage: https://bioconductor.org/packages/release/data/annotation/html/ragene10stv1probe.html
---

# bioconductor-ragene10stv1probe

name: bioconductor-ragene10stv1probe
description: Access and utilize probe sequence data for the Affymetrix Rat Gene 1.0 ST v1 microarray. Use this skill when needing to retrieve specific probe sequences, their x/y coordinates on the array, or interrogation positions for genomic analysis and probe-level preprocessing in R.

# bioconductor-ragene10stv1probe

## Overview

The `ragene10stv1probe` package is a Bioconductor annotation data package containing the sequence information for the probes on the Affymetrix Rat Gene 1.0 ST v1 microarrays. This package is essential for researchers performing probe-level analysis, such as GC-content based normalization (GCRMA) or re-mapping probes to updated genome builds.

## Loading and Accessing Data

The primary data object is a data frame named `ragene10stv1probe`.

```r
# Install the package if necessary
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("ragene10stv1probe")

# Load the library
library(ragene10stv1probe)

# Load the probe data object
data(ragene10stv1probe)

# View the structure of the data
str(ragene10stv1probe)
```

## Data Structure

The `ragene10stv1probe` object is a data frame with 839,213 rows and 6 columns:

1.  **sequence**: The actual nucleotide sequence of the probe (character).
2.  **x**: The x-coordinate of the probe on the array (integer).
3.  **y**: The y-coordinate of the probe on the array (integer).
4.  **Probe.Set.Name**: The Affymetrix identifier for the probe set (character).
5.  **Probe.Interrogation.Position**: The nucleotide position within the target sequence (integer).
6.  **Target.Strandedness**: Whether the target is sense or antisense (factor).

## Common Workflows

### Inspecting Specific Probes
To view the first few entries of the probe data:
```r
as.data.frame(ragene10stv1probe[1:5, ])
```

### Filtering by Probe Set
To extract all probes associated with a specific Affymetrix Probe Set ID:
```r
# Example: Replace '10700001' with a valid Probe Set Name
subset_probes <- subset(ragene10stv1probe, Probe.Set.Name == "10700001")
```

### Calculating GC Content
A common task is calculating the GC content of probes for normalization purposes:
```r
library(Biostrings)
# Convert sequences to DNAStringSet for efficient calculation
sequences <- DNAStringSet(ragene10stv1probe$sequence)
gc_content <- letterFrequency(sequences, letters = "GC", as.prob = TRUE)

# Add GC content back to a sample of the data frame
probe_sample <- head(ragene10stv1probe)
probe_sample$GC <- letterFrequency(DNAStringSet(probe_sample$sequence), "GC", as.prob = TRUE)
```

## Usage Tips
- **Memory Management**: The data frame is large (over 800,000 rows). If you only need specific columns or a subset of probes, filter the data frame early to save memory.
- **Coordinate Matching**: The `x` and `y` coordinates are used to map probe sequences to the raw intensity values found in CEL files.

## Reference documentation

- [ragene10stv1probe Reference Manual](./references/reference_manual.md)