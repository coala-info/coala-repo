---
name: bioconductor-rtu34probe
description: This package provides probe sequence data and physical coordinates for the Affymetrix rtu34 microarray platform. Use when user asks to retrieve probe sequences, filter probes by set name, or analyze the sequence composition and interrogation positions for the rtu34 chip.
homepage: https://bioconductor.org/packages/release/data/annotation/html/rtu34probe.html
---


# bioconductor-rtu34probe

name: bioconductor-rtu34probe
description: Provides probe sequence data for the Affymetrix rtu34 microarray platform. Use this skill when you need to access, filter, or analyze individual probe sequences, their (x,y) coordinates, or their interrogation positions for the rtu34 chip.

# bioconductor-rtu34probe

## Overview
The `rtu34probe` package is a Bioconductor annotation data package containing the sequence information for the probes on the Affymetrix rtu34 array. Unlike standard annotation packages that map probes to genes, this package provides the physical properties and raw sequences of the probes themselves.

## Usage and Workflows

### Loading the Data
The package contains a single primary data object named `rtu34probe`.

```r
# Install the package if necessary
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("rtu34probe")

# Load the library
library(rtu34probe)

# Load the probe data object
data(rtu34probe)
```

### Data Structure
The `rtu34probe` object is a data frame. You can inspect its structure using standard R functions:

```r
# View the first few rows
head(rtu34probe)

# Check column names and types
str(rtu34probe)
```

The data frame contains the following columns:
- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate of the probe on the array (integer).
- `y`: The y-coordinate of the probe on the array (integer).
- `Probe.Set.Name`: The Affymetrix ID for the probe set (character).
- `Probe.Interrogation.Position`: The position of the interrogation nucleotide (integer).
- `Target.Strandedness`: Whether the target is sense or antisense (factor).

### Common Operations

**Filtering by Probe Set**
To extract all probes associated with a specific Affymetrix ID:
```r
subset_probes <- subset(rtu34probe, Probe.Set.Name == "your_probe_set_id")
```

**Analyzing Sequence Composition**
You can use the sequences with other Bioconductor packages like `Biostrings` for sequence analysis:
```r
library(Biostrings)
probe_seqs <- DNAStringSet(rtu34probe$sequence)
letterFrequency(probe_seqs, letters = "GC", as.prob = TRUE)
```

## Tips
- This package is primarily used for low-level analysis, such as calculating GC content for background correction or identifying potential cross-hybridization.
- For mapping probe sets to gene symbols or GO terms, use the corresponding expression feature annotation package (e.g., `rtu34.db`) instead of this probe package.

## Reference documentation
- [rtu34probe Reference Manual](./references/reference_manual.md)