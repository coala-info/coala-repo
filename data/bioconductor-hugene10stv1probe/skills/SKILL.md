---
name: bioconductor-hugene10stv1probe
description: This package provides probe sequence data and metadata for the Affymetrix Human Gene 1.0 ST v1 microarray. Use when user asks to retrieve probe sequences, access x/y coordinates on the array, identify probe set names, or perform sequence-level analysis for the hugene10stv1 platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hugene10stv1probe.html
---


# bioconductor-hugene10stv1probe

name: bioconductor-hugene10stv1probe
description: Access and use probe sequence data for the Affymetrix Human Gene 1.0 ST v1 microarray. Use this skill when you need to retrieve specific probe sequences, their x/y coordinates on the array, probe set identifiers, interrogation positions, or target strandedness for the hugene10stv1 platform.

# bioconductor-hugene10stv1probe

## Overview

The `hugene10stv1probe` package is a Bioconductor annotation data package containing the probe sequences for the Affymetrix Human Gene 1.0 ST v1 microarray. This data is essential for low-level analysis of microarray experiments, such as calculating GC content, performing sequence-specific background correction, or re-mapping probes to updated genome assemblies.

The package provides a single primary data object, `hugene10stv1probe`, which is a data frame containing 861,493 rows.

## Usage in R

### Loading the Data

To use the probe data, you must first load the library and then use the `data()` function to load the specific dataset into your environment.

```r
# Load the package
library(hugene10stv1probe)

# Load the probe data object
data(hugene10stv1probe)
```

### Data Structure

The `hugene10stv1probe` object is a data frame with the following columns:

- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate of the probe on the array (integer).
- `y`: The y-coordinate of the probe on the array (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The position within the target sequence that the probe interrogates (integer).
- `Target.Strandedness`: The orientation of the target (factor).

### Common Workflows

#### Inspecting the Data
You can view the first few rows of the data frame to understand its structure:

```r
# View the first 5 probes
head(hugene10stv1probe)

# Convert a subset to a standard data frame for easier manipulation
as.data.frame(hugene10stv1probe[1:3,])
```

#### Filtering by Probe Set
If you are interested in the sequences for a specific gene or probe set:

```r
# Extract probes for a specific Probe Set
target_probes <- subset(hugene10stv1probe, Probe.Set.Name == "7900001")
```

#### Sequence Analysis
You can use the `Biostrings` package in conjunction with this data to perform sequence analysis, such as calculating GC content:

```r
library(Biostrings)

# Convert sequences to DNAStringSet
dna_seqs <- DNAStringSet(hugene10stv1probe$sequence[1:100])

# Calculate GC content
letterFrequency(dna_seqs, letters="GC", as.prob=TRUE)
```

## Tips
- **Memory Management**: The data frame is large (over 860,000 rows). If you only need specific columns or a subset of probes, filter the data early to save memory.
- **Coordinate Mapping**: The `x` and `y` coordinates are useful for identifying spatial artifacts on the microarray surface when combined with intensity data from CEL files (usually handled via the `affy` or `oligo` packages).

## Reference documentation

- [hugene10stv1probe Reference Manual](./references/reference_manual.md)