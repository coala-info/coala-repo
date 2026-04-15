---
name: bioconductor-rae230aprobe
description: This package provides probe sequence data and chip coordinates for the Affymetrix RAE230A rat expression microarray. Use when user asks to map Affymetrix probe identifiers to nucleotide sequences, retrieve probe x and y coordinates, or perform probe-level genomic analysis for the RAE230A array.
homepage: https://bioconductor.org/packages/release/data/annotation/html/rae230aprobe.html
---

# bioconductor-rae230aprobe

name: bioconductor-rae230aprobe
description: Access and utilize probe sequence data for the Affymetrix RAE230A (Rat Expression 230A) microarray. Use this skill when needing to map Affymetrix probe identifiers to physical sequences, coordinates (x, y), or interrogation positions for genomic analysis in R.

# bioconductor-rae230aprobe

## Overview

The `rae230aprobe` package is a Bioconductor annotation data package containing the sequence information for the probes on the Affymetrix RAE230A rat expression array. This data is essential for tasks such as sequence-specific bias correction, probe-level analysis, or verifying target alignments. The package provides a single data frame object named `rae230aprobe`.

## Usage and Workflows

### Loading the Data

To use the probe data, you must first load the library and then call the `data()` function to bring the object into your environment.

```r
library(rae230aprobe)
data(rae230aprobe)
```

### Data Structure

The `rae230aprobe` object is a data frame. You can inspect its structure using standard R commands:

```r
# View the first few rows
head(rae230aprobe)

# Check the column names and types
str(rae230aprobe)
```

The data frame contains the following columns:
- `sequence`: The actual nucleotide sequence (character).
- `x`: The x-coordinate on the microarray (integer).
- `y`: The y-coordinate on the microarray (integer).
- `Probe.Set.Name`: The Affymetrix ID for the probe set (character).
- `Probe.Interrogation.Position`: The position of the interrogation base (integer).
- `Target.Strandedness`: The orientation of the target (factor).

### Common Operations

#### Filtering by Probe Set
To extract all probes associated with a specific Affymetrix ID:

```r
# Example: Get probes for a specific ID
specific_probes <- rae230aprobe[rae230aprobe$Probe.Set.Name == "1367452_at", ]
```

#### Converting to a Standard Data Frame
While the object behaves like a data frame, you can explicitly convert subsets for cleaner manipulation:

```r
probe_subset <- as.data.frame(rae230aprobe[1:10, ])
```

#### Integration with Biostrings
If you need to perform sequence analysis (e.g., GC content calculation), convert the sequences to a `DNAStringSet`:

```r
library(Biostrings)
probe_seqs <- DNAStringSet(rae230aprobe$sequence)
# Calculate GC content
gc_content <- letterFrequency(probe_seqs, letters="GC", as.prob=TRUE)
```

## Tips
- **Memory Management**: The data frame has over 175,000 rows. While manageable on most modern systems, avoid making multiple deep copies of the full object in memory.
- **Coordinate Mapping**: The `x` and `y` coordinates are useful for identifying spatial artifacts on the physical array chips.
- **Version Consistency**: Ensure that the version of `rae230aprobe` matches the version of the `rae230a` CDF or annotation packages you are using to maintain consistency in probe-to-probeset mapping.

## Reference documentation

- [rae230aprobe Reference Manual](./references/reference_manual.md)