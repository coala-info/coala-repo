---
name: bioconductor-soybeanprobe
description: This package provides sequence and coordinate information for probes on the Affymetrix Soybean genome array. Use when user asks to retrieve probe sequences, map probes to physical chip coordinates, or perform sequence-based analysis for soybean microarray data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/soybeanprobe.html
---


# bioconductor-soybeanprobe

## Overview

The `soybeanprobe` package is a Bioconductor annotation data package containing the sequence information for the probes on the Affymetrix Soybean genome array. It provides a mapping between probe sequences, their physical coordinates (x, y) on the chip, and their corresponding Affymetrix Probe Set IDs. This is essential for researchers performing low-level analysis, such as GC-content background correction or re-mapping probes to updated genome assemblies.

## Usage

### Loading the Data

The package contains a single primary data object named `soybeanprobe`.

```r
# Install the package if necessary
# if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
# BiocManager::install("soybeanprobe")

library(soybeanprobe)

# Load the probe data
data(soybeanprobe)
```

### Data Structure

The `soybeanprobe` object is a data frame. You can inspect its structure using standard R functions:

```r
# View the first few rows
head(soybeanprobe)

# Check column names and types
str(soybeanprobe)
```

The data frame contains the following columns:
- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate of the probe on the array (integer).
- `y`: The y-coordinate of the probe on the array (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The position of the interrogation base (integer).
- `Target.Strandedness`: Whether the target is sense or antisense (factor).

### Common Workflows

#### Filtering by Probe Set
To extract all probes associated with a specific gene or probe set:

```r
# Example: Get probes for a specific ID
target_probes <- soybeanprobe[soybeanprobe$Probe.Set.Name == "Gma.1.1.S1_at", ]
```

#### Sequence Analysis
You can convert the sequences to a `DNAStringSet` (from the `Biostrings` package) for more advanced sequence analysis:

```r
library(Biostrings)
probe_sequences <- DNAStringSet(soybeanprobe$sequence)
# Calculate GC content
gc_content <- letterFrequency(probe_sequences, letters = "GC", as.prob = TRUE)
```

## Tips
- **Memory Management**: This data frame is large (over 670,000 rows). If you only need a subset of columns or rows, filter the data early to save memory.
- **Coordinate Matching**: The `x` and `y` coordinates are used to match probe sequences with intensity values found in CEL files (often processed via the `affy` package).

## Reference documentation

- [soybeanprobe Reference Manual](./references/reference_manual.md)