---
name: bioconductor-ecoli2probe
description: This package provides probe sequence data and spatial coordinates for the Affymetrix ecoli2 microarray. Use when user asks to access probe sequences, filter probes by set name, or analyze nucleotide data for the E. coli 2.0 genome array.
homepage: https://bioconductor.org/packages/release/data/annotation/html/ecoli2probe.html
---

# bioconductor-ecoli2probe

name: bioconductor-ecoli2probe
description: Provides probe sequence data for Affymetrix ecoli2 microarrays. Use this skill when you need to access, filter, or analyze the specific nucleotide sequences, x/y coordinates, and probe set identifiers for the E. coli 2.0 genome array.

# bioconductor-ecoli2probe

## Overview

The `ecoli2probe` package is a Bioconductor annotation data package containing the probe sequences for the Affymetrix ecoli2 microarray. This package is essential for tasks requiring sequence-level analysis of microarray data, such as calculating GC content, assessing cross-hybridization potential, or re-mapping probes to updated genome assemblies.

## Usage

### Loading the Data

The primary data object is a data frame named `ecoli2probe`. To use it, you must first load the library and then call the `data()` function.

```r
library(ecoli2probe)
data(ecoli2probe)
```

### Data Structure

The `ecoli2probe` object is a data frame with 112,488 rows and 6 columns:

- **sequence**: The nucleotide sequence of the probe (character).
- **x**: The x-coordinate of the probe on the array (integer).
- **y**: The y-coordinate of the probe on the array (integer).
- **Probe.Set.Name**: The Affymetrix identifier for the probe set (character).
- **Probe.Interrogation.Position**: The position of the interrogated base (integer).
- **Target.Strandedness**: The orientation of the target (factor).

### Common Workflows

#### Inspecting Probes
To view the first few probes in the dataset:

```r
head(ecoli2probe)
```

#### Filtering by Probe Set
To extract all probes associated with a specific GeneChip probe set:

```r
# Example: Filter for a specific probe set
target_probes <- ecoli2probe[ecoli2probe$Probe.Set.Name == "b0002_at", ]
```

#### Sequence Analysis
You can use standard R strings or `Biostrings` to analyze the probe sequences:

```r
# Calculate the length of sequences (should be 25 for Affymetrix)
table(nchar(ecoli2probe$sequence))

# Find probes containing a specific motif
motif_probes <- ecoli2probe[grep("ATGC", ecoli2probe$sequence), ]
```

## Tips
- The `ecoli2probe` object is a standard R `data.frame`. You can convert it to a `tibble` or `data.table` for faster processing if needed.
- This package is specifically for the **ecoli2** array; for the original E. coli array, use the `ecoliprobe` package.
- Coordinates (x, y) are useful for identifying spatial artifacts on the physical microarray chip.

## Reference documentation

- [ecoli2probe Reference Manual](./references/reference_manual.md)