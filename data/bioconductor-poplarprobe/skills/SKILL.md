---
name: bioconductor-poplarprobe
description: This package provides probe sequence data and layout information for the Affymetrix Poplar microarray. Use when user asks to retrieve probe sequences, map probe coordinates, or analyze interrogation positions for the Poplar array platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/poplarprobe.html
---


# bioconductor-poplarprobe

name: bioconductor-poplarprobe
description: Provides probe sequence data for Affymetrix Poplar microarrays. Use this skill when a user needs to retrieve, analyze, or map probe sequences, coordinates (x, y), or interrogation positions for the Poplar array platform in R.

# bioconductor-poplarprobe

## Overview
The `poplarprobe` package is a Bioconductor annotation data package containing the probe sequences and layout information for the Affymetrix Poplar microarray. It is primarily used in transcriptomics workflows to map specific probes to their target sequences or to perform sequence-specific analysis (e.g., GC content calculation or cross-hybridization checks).

## Loading the Data
The package contains a single primary data object also named `poplarprobe`.

```r
# Install the package if necessary
# BiocManager::install("poplarprobe")

# Load the library
library(poplarprobe)

# Load the probe data object
data(poplarprobe)
```

## Data Structure
The `poplarprobe` object is a data frame with 674,330 rows and 6 columns. Each row represents a single probe on the array.

- **sequence**: The actual nucleotide sequence of the probe (character).
- **x**: The x-coordinate of the probe on the array (integer).
- **y**: The y-coordinate of the probe on the array (integer).
- **Probe.Set.Name**: The Affymetrix identifier for the probe set (character).
- **Probe.Interrogation.Position**: The position within the target sequence that the probe interrogates (integer).
- **Target.Strandedness**: Whether the target is sense or antisense (factor).

## Common Workflows

### Inspecting Probes
To view the first few probes in the dataset:
```r
head(poplarprobe)
```

### Filtering by Probe Set
To extract all probes associated with a specific Affymetrix Probe Set ID:
```r
# Example: Filter for a specific probe set
target_probes <- subset(poplarprobe, Probe.Set.Name == "PtpAffx.2.1.S1_at")
```

### Sequence Analysis
Since the sequences are provided as characters, you can use standard R strings or `Biostrings` to analyze them:
```r
# Calculate sequence length for the first 10 probes
nchar(poplarprobe$sequence[1:10])

# Convert to DNAStringSet for advanced Biostrings operations
# library(Biostrings)
# dna_probes <- DNAStringSet(poplarprobe$sequence)
```

## Tips
- **Memory Management**: This dataset is large (over 670,000 rows). If you only need specific columns (e.g., sequences and IDs), subset the data frame early to save memory.
- **Coordinate Mapping**: The `x` and `y` coordinates are essential if you are performing spatial analysis of the chip or background correction based on physical location.

## Reference documentation
- [poplarprobe Reference Manual](./references/reference_manual.md)