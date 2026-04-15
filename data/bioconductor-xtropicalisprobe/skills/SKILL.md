---
name: bioconductor-xtropicalisprobe
description: This package provides probe sequence data and spatial coordinates for the Xenopus tropicalis microarray platform. Use when user asks to retrieve probe sequences, access microarray coordinates, filter probes by set name, or analyze sequence properties for Xenopus tropicalis experiments.
homepage: https://bioconductor.org/packages/release/data/annotation/html/xtropicalisprobe.html
---

# bioconductor-xtropicalisprobe

name: bioconductor-xtropicalisprobe
description: Provides probe sequence data for the Xenopus tropicalis (xtropicalis) microarray. Use this skill when you need to access, filter, or analyze Affymetrix probe sequences, coordinates (x,y), probe set names, or interrogation positions for the xtropicalis platform in R.

# bioconductor-xtropicalisprobe

## Overview
The `xtropicalisprobe` package is a Bioconductor annotation data package containing the sequence information for the microarrays of type xtropicalis. This data is essential for tasks such as re-annotating probe sets, calculating GC content, or performing sequence-specific quality control on Xenopus tropicalis microarray experiments.

## Installation
To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("xtropicalisprobe")
```

## Usage and Workflows

### Loading the Data
The package contains a single primary data object named `xtropicalisprobe`.

```r
library(xtropicalisprobe)
data(xtropicalisprobe)
```

### Data Structure
The `xtropicalisprobe` object is a data frame with 648,548 rows and 6 columns:
- `sequence`: The actual nucleotide sequence of the probe.
- `x`: The x-coordinate of the probe on the array.
- `y`: The y-coordinate of the probe on the array.
- `Probe.Set.Name`: The Affymetrix identifier for the probe set.
- `Probe.Interrogation.Position`: The position of the interrogation base.
- `Target.Strandedness`: Whether the target is sense or antisense.

### Common Operations

**Viewing a subset of probes:**
```r
# View the first few rows
head(xtropicalisprobe)

# Convert a subset to a standard data frame for manipulation
probe_df <- as.data.frame(xtropicalisprobe[1:10, ])
```

**Filtering by Probe Set:**
If you are interested in specific genes or Affymetrix IDs:
```r
# Extract all probes for a specific probe set
target_probes <- subset(xtropicalisprobe, Probe.Set.Name == "Xtr.1234.1.S1_at")
```

**Analyzing Sequence Composition:**
You can use this data in conjunction with `Biostrings` to calculate properties like GC content:
```r
library(Biostrings)
# Calculate GC content for the first 100 probes
probes_dna <- DNAStringSet(xtropicalisprobe$sequence[1:100])
letterFrequency(probes_dna, as.prob = TRUE, letters = "GC")
```

## Tips
- **Memory Management**: This dataset is large (over 600,000 rows). If you only need specific columns or rows, subset the data early to save memory.
- **Coordinate Mapping**: The `x` and `y` coordinates are useful for identifying spatial artifacts on the microarray chips when combined with raw intensity data (CEL files).

## Reference documentation
- [xtropicalisprobe Reference Manual](./references/reference_manual.md)