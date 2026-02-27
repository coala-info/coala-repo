---
name: bioconductor-vitisviniferaprobe
description: This package provides sequence information and microarray coordinates for probes on the Affymetrix Vitis vinifera chip. Use when user asks to retrieve probe sequences, perform low-level microarray analysis, or calculate GC content for Vitis vinifera probe sets.
homepage: https://bioconductor.org/packages/release/data/annotation/html/vitisviniferaprobe.html
---


# bioconductor-vitisviniferaprobe

## Overview
The `vitisviniferaprobe` package is a Bioconductor annotation data package containing the sequence information for the probes on the Affymetrix Vitis vinifera chip. This data is essential for low-level analysis of microarray experiments, such as calculating GC content of probes, performing custom background corrections, or re-mapping probes to updated genome assemblies.

## Usage in R

### Loading the Data
The package contains a single primary data object. To use it, you must load the library and then call the `data()` function.

```r
library(vitisviniferaprobe)
data(vitisviniferaprobe)
```

### Data Structure
The `vitisviniferaprobe` object is a data frame. You can inspect its structure using standard R commands:

```r
# View the first few rows
head(vitisviniferaprobe)

# Check column names and types
str(vitisviniferaprobe)
```

The data frame contains the following columns:
- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate of the probe on the microarray (integer).
- `y`: The y-coordinate of the probe on the microarray (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The position within the target sequence (integer).
- `Target.Strandedness`: Whether the target is sense or antisense (factor).

### Common Workflows

#### Extracting Sequences for a Specific Probe Set
If you are interested in the sequences for a specific gene or probe set:

```r
# Filter for a specific probe set
ps_name <- "136755_at" # Example ID
subset_probes <- vitisviniferaprobe[vitisviniferaprobe$Probe.Set.Name == ps_name, ]
```

#### Converting to a Biostrings Object
For sequence analysis (like calculating melting temperature or GC content), convert the sequences to a `DNAStringSet`:

```r
library(Biostrings)
probe_sequences <- DNAStringSet(vitisviniferaprobe$sequence)
names(probe_sequences) <- vitisviniferaprobe$Probe.Set.Name

# Calculate GC content
gc_content <- letterFrequency(probe_sequences, letters="GC", as.prob=TRUE)
```

## Tips
- **Memory Management**: This data frame is large (over 260,000 rows). If you only need a subset of columns or rows, filter them early to save memory.
- **Coordinate Matching**: The `x` and `y` coordinates are used to map these sequences back to the raw intensity data found in CEL files (often handled via the `affy` or `oligo` packages).

## Reference documentation
- [Reference Manual](./references/reference_manual.md)