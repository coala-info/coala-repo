---
name: bioconductor-yeast2probe
description: This package provides probe sequence data and spatial coordinates for the Affymetrix yeast2 microarray. Use when user asks to retrieve probe sequences, map probes to array coordinates, or perform sequence-based analysis for Saccharomyces cerevisiae genomic data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/yeast2probe.html
---

# bioconductor-yeast2probe

name: bioconductor-yeast2probe
description: Provides probe sequence data for the Affymetrix yeast2 microarray. Use this skill when you need to map Affymetrix probe identifiers to their physical sequences, x/y coordinates on the array, or interrogation positions for Saccharomyces cerevisiae genomic analysis.

# bioconductor-yeast2probe

## Overview

The `yeast2probe` package is a Bioconductor annotation data package containing the sequence information for the probes on the Affymetrix yeast2 array. Unlike standard annotation packages that map probes to genes, this package provides the raw sequence data and spatial coordinates for every probe on the chip. This is essential for tasks such as re-masking probes, calculating GC content, or performing custom sequence-based normalization.

## Usage and Workflows

### Loading the Data

The package contains a single primary data object named `yeast2probe`.

```r
# Load the library
library(yeast2probe)

# Load the probe data object
data(yeast2probe)
```

### Data Structure

The `yeast2probe` object is a data frame. You can inspect its structure using standard R commands:

```r
# View the first few rows
head(yeast2probe)

# Check the column names and types
str(yeast2probe)
```

The data frame contains the following columns:
- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate of the probe on the array (integer).
- `y`: The y-coordinate of the probe on the array (integer).
- `Probe.Set.Name`: The Affymetrix ID for the probe set (character).
- `Probe.Interrogation.Position`: The position of the interrogation base (integer).
- `Target.Strandedness`: Whether the target is sense or antisense (factor).

### Common Operations

#### Filtering by Probe Set
To extract all probes associated with a specific Affymetrix ID:

```r
# Example: Get probes for a specific probe set
subset_probes <- yeast2probe[yeast2probe$Probe.Set.Name == "17693_at", ]
```

#### Sequence Analysis
You can use this data to analyze the composition of probes, which is often useful for background correction models:

```r
# Calculate the length of sequences (should be 25 for Affymetrix)
table(nchar(yeast2probe$sequence))

# Search for specific motifs within probes
has_motif <- grepl("AAAAA", yeast2probe$sequence)
summary(has_motif)
```

#### Integration with Biostrings
For advanced sequence manipulation, convert the sequences to a `DNAStringSet`:

```r
library(Biostrings)
probe_sequences <- DNAStringSet(yeast2probe$sequence)
# Calculate GC content
gc_content <- letterFrequency(probe_sequences, as.prob = TRUE, letters = "GC")
```

## Tips
- **Memory Management**: The `yeast2probe` data frame has over 120,000 rows. While manageable on most modern systems, avoid making multiple deep copies of the object in memory.
- **Coordinate System**: The `x` and `y` coordinates are zero-indexed, following the standard Affymetrix convention.
- **Package Versioning**: This package is specific to the "yeast2" array. Ensure your CEL files were generated using this specific platform before using this annotation.

## Reference documentation

- [yeast2probe Reference Manual](./references/reference_manual.md)