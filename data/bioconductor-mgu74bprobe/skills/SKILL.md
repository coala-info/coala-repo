---
name: bioconductor-mgu74bprobe
description: This package provides nucleotide sequence data and array coordinates for probes on the Affymetrix MG-U74B microarray chip. Use when user asks to access probe sequences, calculate GC content for MG-U74B probes, or perform sequence-level analysis of Mouse Genome U74B arrays.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mgu74bprobe.html
---

# bioconductor-mgu74bprobe

name: bioconductor-mgu74bprobe
description: Access and use probe sequence data for the Affymetrix MG-U74B microarray chip. Use this skill when performing low-level analysis of Affymetrix MGU74B arrays, such as calculating GC content, position-dependent binding effects, or re-annotating probe sets based on sequence alignment.

# bioconductor-mgu74bprobe

## Overview

The `mgu74bprobe` package is a Bioconductor annotation data package containing the sequence information for the probes on the Affymetrix MG-U74B (Mouse Genome U74B) microarray. Unlike standard annotation packages that map IDs to gene symbols, this package provides the actual nucleotide sequences and their physical coordinates on the array.

## Loading and Inspecting Data

The primary data object is a data frame also named `mgu74bprobe`.

```r
# Load the package
library(mgu74bprobe)

# Load the probe data object
data(mgu74bprobe)

# View the structure of the data
str(mgu74bprobe)

# Look at the first few rows
head(mgu74bprobe)
```

## Data Structure

The `mgu74bprobe` data frame contains 201,960 rows, where each row represents a single probe. The columns include:

- `sequence`: The 25-mer nucleotide sequence (character).
- `x` and `y`: The physical coordinates of the probe on the array (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The position of the interrogated base in the target sequence (integer).
- `Target.Strandedness`: Whether the target is sense or antisense (factor).

## Common Workflows

### Filtering by Probe Set
To extract all probe sequences associated with a specific Affymetrix ID:

```r
ps_name <- "1000_at"
subset_probes <- mgu74bprobe[mgu74bprobe$Probe.Set.Name == ps_name, ]
```

### Sequence Analysis
You can use this data in conjunction with the `Biostrings` package to perform sequence-level calculations, such as GC content:

```r
library(Biostrings)
# Convert to DNAStringSet
dna_seqs <- DNAStringSet(mgu74bprobe$sequence)

# Calculate GC content
gc_content <- letterFrequency(dna_seqs, letters="GC", as.prob=TRUE)

# Add back to a data frame for analysis
mgu74b_with_gc <- cbind(mgu74bprobe, GC = gc_content)
```

## Usage Tips
- **Memory Management**: The data frame is relatively large. If you only need specific columns (e.g., sequence and Probe.Set.Name), subset them early to save memory.
- **Coordinate Matching**: The `x` and `y` coordinates are used to match these sequences with the intensity values found in CEL files (often processed via the `affy` package).
- **Version Consistency**: Ensure that the version of the probe package matches the version of the CDF (Chip Definition File) package you are using for your analysis.

## Reference documentation

- [mgu74bprobe Reference Manual](./references/reference_manual.md)