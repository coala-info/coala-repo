---
name: bioconductor-mgu74av2probe
description: This package provides probe sequence data and chip coordinates for the Affymetrix MG-U74Av2 murine genome array. Use when user asks to retrieve probe sequences, access physical chip coordinates, or perform low-level analysis for the mgu74av2 platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mgu74av2probe.html
---

# bioconductor-mgu74av2probe

name: bioconductor-mgu74av2probe
description: Access and use probe sequence data for the Affymetrix MG-U74Av2 murine genome array. Use this skill when you need to retrieve probe-level information, including sequences, x/y coordinates, and interrogation positions for the mgu74av2 platform.

# bioconductor-mgu74av2probe

## Overview
The `mgu74av2probe` package is a Bioconductor annotation data package containing the probe sequences for the Affymetrix MG-U74Av2 microarray. This package is essential for low-level analysis of microarray data where individual probe sequences or their physical locations on the chip are required, such as in GC-content normalization or custom probe-set redefinition.

## Usage and Workflows

### Loading the Data
The package contains a single primary data object of the same name.

```r
# Load the library
library(mgu74av2probe)

# Load the probe data object
data(mgu74av2probe)
```

### Data Structure
The `mgu74av2probe` object is a data frame. You can inspect its structure using standard R commands:

```r
# View the first few rows
head(mgu74av2probe)

# Check the column names and types
str(mgu74av2probe)
```

The data frame contains the following columns:
- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate of the probe on the array (integer).
- `y`: The y-coordinate of the probe on the array (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the gene/transcript cluster (character).
- `Probe.Interrogation.Position`: The nucleotide position within the target sequence (integer).
- `Target.Strandedness`: Whether the target is sense or antisense (factor).

### Common Operations

**Filtering by Probe Set**
To extract all probes associated with a specific Affymetrix ID:
```r
# Example: Get probes for a specific ID
specific_probes <- subset(mgu74av2probe, Probe.Set.Name == "1000_at")
```

**Calculating Sequence Statistics**
If you need to calculate the GC content of the probes:
```r
# Simple GC content calculation
get_gc <- function(seqs) {
  sapply(seqs, function(x) {
    counts <- table(strsplit(x, "")[[1]])
    (counts["G"] + counts["C"]) / sum(counts)
  })
}

# Apply to the first 10 probes
gc_values <- get_gc(mgu74av2probe$sequence[1:10])
```

## Tips
- **Memory Management**: This data frame is large (nearly 200,000 rows). If you only need specific columns or a subset of probes, filter the data frame early to save memory.
- **Integration**: This package is typically used in conjunction with the `affy` package or other Bioconductor tools that handle `.CEL` files for the MG-U74Av2 platform.
- **Coordinates**: The `x` and `y` coordinates are 0-indexed, following the standard Affymetrix convention.

## Reference documentation
- [mgu74av2probe Reference Manual](./references/reference_manual.md)