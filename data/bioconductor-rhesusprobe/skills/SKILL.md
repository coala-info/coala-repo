---
name: bioconductor-rhesusprobe
description: This package provides sequence and coordinate information for probes on the Rhesus Macaque microarray. Use when user asks to retrieve probe sequences, perform GC-content normalization, or map Affymetrix probe coordinates for Macaca mulatta.
homepage: https://bioconductor.org/packages/release/data/annotation/html/rhesusprobe.html
---

# bioconductor-rhesusprobe

## Overview
The `rhesusprobe` package is a Bioconductor annotation data package containing the sequence information for probes on the Rhesus Macaque (Macaca mulatta) microarray. This package is essential for researchers performing low-level analysis of Affymetrix arrays, such as GC-content based normalization, probe-level sequence analysis, or re-mapping probes to updated genome assemblies.

## Usage and Workflow

### Loading the Data
The package contains a single primary data object named `rhesusprobe`. To use it, you must load the library and then call the `data()` function.

```r
# Load the package
library(rhesusprobe)

# Load the probe data object
data(rhesusprobe)
```

### Data Structure
The `rhesusprobe` object is a data frame. You can inspect its structure using standard R functions:

```r
# View the first few rows
head(rhesusprobe)

# Check the dimensions (typically ~668,485 rows)
dim(rhesusprobe)

# View column names and types
str(rhesusprobe)
```

The data frame contains the following columns:
- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate of the probe on the array (integer).
- `y`: The y-coordinate of the probe on the array (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The position within the target sequence (integer).
- `Target.Strandedness`: Whether the target is sense or antisense (factor).

### Common Operations

**Filtering by Probe Set**
To extract all probes associated with a specific Affymetrix ID:
```r
# Example: Filter for a specific probe set
my_probes <- rhesusprobe[rhesusprobe$Probe.Set.Name == "12345_at", ]
```

**Converting to Data Frame**
While the object behaves like a data frame, you can explicitly cast subsets for cleaner manipulation:
```r
# Extract the first 10 rows as a standard data frame
df_subset <- as.data.frame(rhesusprobe[1:10, ])
```

**Sequence Analysis**
If you need to calculate the GC content of the probes:
```r
# Simple GC calculation example
library(Biostrings)
sequences <- DNAStringSet(rhesusprobe$sequence[1:100])
letterFrequency(sequences, as.prob = TRUE, letters = "GC")
```

## Tips
- **Memory Management**: The `rhesusprobe` object is large (over 600,000 rows). If you are only interested in specific probe sets, filter the data frame early to save memory.
- **Coordinate Mapping**: The `x` and `y` coordinates are used to map probe intensities from CEL files to their respective sequences.
- **Version Consistency**: Ensure that the version of `rhesusprobe` matches the specific generation of the Rhesus Macaque array you are analyzing, as probe layouts can vary between array versions.

## Reference documentation
- [rhesusprobe Reference Manual](./references/reference_manual.md)