---
name: bioconductor-canineprobe
description: This package provides sequence information and metadata for probes on the Affymetrix Canine microarray. Use when user asks to retrieve probe sequences, calculate GC content for canine probes, or perform sequence-specific background correction for canine microarray data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/canineprobe.html
---

# bioconductor-canineprobe

## Overview
The `canineprobe` package is a Bioconductor annotation data package containing the sequence information for the probes on the Affymetrix Canine array. This package is essential for low-level analysis of microarray data, such as calculating GC content of probes, performing sequence-specific background correction, or re-mapping probes to updated genome assemblies.

## Usage and Workflows

### Loading the Data
The package contains a single primary data object named `canineprobe`.

```r
# Load the library
library(canineprobe)

# Load the data object
data(canineprobe)
```

### Data Structure
The `canineprobe` object is a data frame. You can inspect its structure to understand the available metadata for each probe.

```r
# View the first few rows
head(canineprobe)

# Check the column names and types
str(canineprobe)
```

The data frame contains the following columns:
- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate of the probe on the array (integer).
- `y`: The y-coordinate of the probe on the array (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The position within the target sequence that the probe interrogates (integer).
- `Target.Strandedness`: Whether the target is sense or antisense (factor).

### Common Operations

**Filtering by Probe Set**
To extract all probes associated with a specific Affymetrix ID:
```r
# Example: Get sequences for a specific probe set
subset_probes <- canineprobe[canineprobe$Probe.Set.Name == "131001_at", ]
```

**Sequence Analysis**
If you need to perform sequence-based calculations (e.g., GC content):
```r
# Calculate GC content for the first 10 probes
probes <- canineprobe$sequence[1:10]
gc_content <- sapply(probes, function(x) {
  sum(gregexpr("[GC]", x)[[1]] > 0) / nchar(x)
})
```

**Converting to Biostrings**
For more advanced sequence manipulation, convert the sequences to a `DNAStringSet`:
```r
library(Biostrings)
probe_sequences <- DNAStringSet(canineprobe$sequence)
names(probe_sequences) <- canineprobe$Probe.Set.Name
```

## Tips
- **Memory Management**: The `canineprobe` data frame is large (over 260,000 rows). If you only need specific columns or a subset of probes, filter the data frame early to save memory.
- **Coordinate Mapping**: The `x` and `y` coordinates are useful for identifying spatial artifacts on the microarray chip.
- **Version Consistency**: Ensure that the version of `canineprobe` matches the specific version of the Affymetrix Canine array used in your experiment, as probe sequences and positions can vary between array iterations.

## Reference documentation
- [canineprobe Reference Manual](./references/reference_manual.md)