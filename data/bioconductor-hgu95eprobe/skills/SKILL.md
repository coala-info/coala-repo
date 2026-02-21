---
name: bioconductor-hgu95eprobe
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgu95eprobe.html
---

# bioconductor-hgu95eprobe

## Overview

The `hgu95eprobe` package is a Bioconductor annotation data package containing the sequence-level information for the Affymetrix HG-U95E microarray chip. Unlike standard annotation packages that map probes to genes, this package provides the physical properties of the probes themselves, including their sequences and coordinates on the array.

## Loading and Accessing Data

The primary data object is a data frame also named `hgu95eprobe`.

```r
# Load the package
library(hgu95eprobe)

# Load the probe data object
data(hgu95eprobe)

# View the structure of the data
str(hgu95eprobe)
```

## Data Structure

The `hgu95eprobe` data frame contains 201,863 rows and 6 columns:

- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate of the probe on the microarray (integer).
- `y`: The y-coordinate of the probe on the microarray (integer).
- `Probe.Set.Name`: The Affymetrix ID for the probe set (character).
- `Probe.Interrogation.Position`: The position within the target sequence that the probe interrogates (integer).
- `Target.Strandedness`: The orientation of the target (factor).

## Common Workflows

### Filtering by Probe Set
To extract all probe sequences associated with a specific Affymetrix ID:

```r
# Example: Get probes for a specific probe set
ps_name <- "31307_at" # Example ID
probes_in_set <- hgu95eprobe[hgu95eprobe$Probe.Set.Name == ps_name, ]
```

### Sequence Analysis
You can use this data to perform GC content analysis or match probes against updated genome builds:

```r
# Calculate sequence length (should be 25 for Affymetrix)
lengths <- nchar(hgu95eprobe$sequence[1:10])

# Search for a specific motif within the probes
has_motif <- grep("TATA", hgu95eprobe$sequence)
```

### Integration with Biostrings
For advanced sequence manipulation, convert the data to a DNAStringSet:

```r
library(Biostrings)
probe_sequences <- DNAStringSet(hgu95eprobe$sequence)
names(probe_sequences) <- hgu95eprobe$Probe.Set.Name
```

## Usage Tips
- **Memory**: The object is a large data frame. If you only need a subset of columns (e.g., just sequences and IDs), subset the object early to save memory.
- **Coordinates**: The `x` and `y` coordinates are useful for identifying spatial artifacts on the microarray surface when combined with raw intensity data (CEL files).

## Reference documentation

- [hgu95eprobe Reference Manual](./references/reference_manual.md)