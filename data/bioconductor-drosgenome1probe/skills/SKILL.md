---
name: bioconductor-drosgenome1probe
description: This package provides probe sequence and layout data for the Affymetrix DrosGenome1 microarray. Use when user asks to access probe sequences, map probes to coordinates, or perform sequence-level analysis for Drosophila melanogaster gene expression data on the drosgenome1 platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/drosgenome1probe.html
---


# bioconductor-drosgenome1probe

name: bioconductor-drosgenome1probe
description: Access and use probe sequence data for the Affymetrix DrosGenome1 microarray. Use this skill when analyzing Drosophila melanogaster gene expression data that requires mapping probe sequences to coordinates or probe sets for the drosgenome1 platform.

# bioconductor-drosgenome1probe

## Overview
The `drosgenome1probe` package is a Bioconductor annotation data package containing the probe sequences and layout information for the Affymetrix DrosGenome1 microarray. It provides a standardized data frame mapping each probe to its physical location (x, y) on the chip, its sequence, its position within the target, and its associated probe set.

## Loading and Accessing Data
To use the probe data, you must first load the package and then use the `data()` function to load the specific dataset into your R environment.

```r
# Load the package
library(drosgenome1probe)

# Load the probe data object
data(drosgenome1probe)

# View the structure of the data
str(drosgenome1probe)
```

## Data Structure
The `drosgenome1probe` object is a data frame with 195,994 rows and 6 columns:
- `sequence`: The nucleotide sequence of the probe (character).
- `x`: The x-coordinate on the array (integer).
- `y`: The y-coordinate on the array (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The position of the interrogation base (integer).
- `Target.Strandedness`: The orientation of the target (factor).

## Common Workflows

### Inspecting Specific Probes
You can subset the data frame to look at specific probe sets or ranges of probes.

```r
# View the first 5 rows
head(drosgenome1probe, n = 5)

# Extract probes for a specific Probe Set
subset_probes <- drosgenome1probe[drosgenome1probe$Probe.Set.Name == "141214_at", ]

# Convert to a standard data frame for manipulation
df_probes <- as.data.frame(drosgenome1probe[1:10, ])
```

### Sequence Analysis
The package is often used to perform sequence-specific quality control or to re-map probes to updated genomic assemblies.

```r
# Calculate GC content for the first 100 probes (requires Biostrings)
library(Biostrings)
seqs <- DNAStringSet(drosgenome1probe$sequence[1:100])
letterFrequency(seqs, letters = "GC", as.prob = TRUE)
```

## Usage Tips
- **Memory Management**: The dataset is large (nearly 200,000 rows). If you only need specific columns, subset them early to save memory.
- **Coordinate System**: The `x` and `y` coordinates are zero-indexed, following standard Affymetrix conventions.
- **Integration**: This package is typically used in conjunction with `affy` or `limma` for low-level analysis of .CEL files where probe-level sequence effects need to be modeled (e.g., in GCRMA normalization).

## Reference documentation
- [drosgenome1probe Reference Manual](./references/reference_manual.md)