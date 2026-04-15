---
name: bioconductor-agprobe
description: The bioconductor-agprobe package provides probe sequence information and spatial coordinates for Affymetrix AG-type microarrays. Use when user asks to retrieve probe sequences, find physical coordinates on the array, or analyze probe set characteristics for AG arrays.
homepage: https://bioconductor.org/packages/release/data/annotation/html/agprobe.html
---

# bioconductor-agprobe

name: bioconductor-agprobe
description: Provides access and usage instructions for the 'agprobe' Bioconductor annotation package. Use this skill when you need to retrieve or analyze probe sequence information, spatial coordinates (x, y), and target characteristics for Affymetrix AG-type microarrays.

# bioconductor-agprobe

## Overview
The `agprobe` package is a Bioconductor data package containing the probe sequence information for Affymetrix AG arrays. It provides a standardized data frame mapping probe sequences to their physical locations on the chip and their corresponding probe sets. This is essential for low-level analysis, such as GC-content adjustment or re-annotation of microarray data.

## Usage and Workflows

### Loading the Data
To use the probe data, you must first load the package and then use the `data()` function to bring the object into your environment.

```r
library(agprobe)
data(agprobe)
```

### Data Structure
The `agprobe` object is a data frame with 131,822 rows and 6 columns. You can inspect the structure using standard R commands:

```r
# View the first few rows
head(agprobe)

# Check column names and types
str(agprobe)
```

The columns include:
- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate on the array (integer).
- `y`: The y-coordinate on the array (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The position of the interrogation base (integer).
- `Target.Strandedness`: The orientation of the target (factor).

### Common Operations

**Filtering by Probe Set:**
To extract all probes associated with a specific gene or probe set:
```r
subset_probes <- subset(agprobe, Probe.Set.Name == "Your_Probe_Set_ID")
```

**Spatial Analysis:**
To analyze the distribution of probes across the physical array:
```r
plot(agprobe$x, agprobe$y, pch=".")
```

**Sequence Analysis:**
To calculate the GC content of the probes (requires `Biostrings`):
```r
library(Biostrings)
dna_seqs <- DNAStringSet(agprobe$sequence)
gc_content <- letterFrequency(dna_seqs, letters="GC", as.prob=TRUE)
```

## Tips
- The `agprobe` object is large. When performing exploratory analysis, work with a subset (e.g., `agprobe[1:100, ]`) to save memory and time.
- This package is typically used in conjunction with other Affymetrix-related Bioconductor packages like `affy` or `oligo` for background correction and normalization.

## Reference documentation
- [agprobe Reference Manual](./references/reference_manual.md)