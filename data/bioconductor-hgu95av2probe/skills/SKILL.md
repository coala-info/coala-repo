---
name: bioconductor-hgu95av2probe
description: This package provides probe sequence data and array coordinates for the Affymetrix Human Genome U95Av2 microarray. Use when user asks to access probe sequences, map probes to x/y coordinates, or identify interrogation positions for hgu95av2 chips.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgu95av2probe.html
---

# bioconductor-hgu95av2probe

name: bioconductor-hgu95av2probe
description: Access and use probe sequence data for the Affymetrix Human Genome U95Av2 microarray. Use when needing to map probe sequences to coordinates, probe set names, or interrogation positions for hgu95av2 chips.

# bioconductor-hgu95av2probe

## Overview
The `hgu95av2probe` package is a Bioconductor annotation data package containing the sequence information for the probes on the Affymetrix HG-U95Av2 microarray. It provides a data frame mapping each probe to its x/y coordinates on the array, its parent Probe Set Name, the specific interrogation position, and the target strandedness.

## Usage and Workflows

### Loading the Data
The package contains a single primary data object. To use it, you must load the library and then call the `data()` function.

```r
library(hgu95av2probe)
data(hgu95av2probe)
```

### Data Structure
The `hgu95av2probe` object is a data frame. You can inspect its structure using standard R commands:

```r
# View the first few rows
head(hgu95av2probe)

# Check column names and types
str(hgu95av2probe)
```

The data frame contains the following columns:
- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate on the array (integer).
- `y`: The y-coordinate on the array (integer).
- `Probe.Set.Name`: The Affymetrix ID for the probe set (character).
- `Probe.Interrogation.Position`: The position within the target sequence (integer).
- `Target.Strandedness`: Whether the target is sense or antisense (factor).

### Common Operations

**Filtering by Probe Set**
To extract all probes associated with a specific Affymetrix ID:
```r
subset_probes <- subset(hgu95av2probe, Probe.Set.Name == "100_at")
```

**Exporting to Data Frame**
If you need to manipulate the data using `tidyverse` or other tools, ensure it is treated as a standard data frame:
```r
df <- as.data.frame(hgu95av2probe)
```

**Finding Specific Sequences**
To find the coordinates of a specific probe sequence:
```r
target_probe <- hgu95av2probe[hgu95av2probe$sequence == "TCTCCTTTGCGGAAGGTCTTTTGAA", ]
```

## Tips
- This package is primarily used for low-level analysis, such as calculating GC content of probes or performing custom background corrections (e.g., GCRMA).
- For mapping Probe Set IDs to Gene Symbols or Entrez IDs, use the corresponding annotation package `hgu95av2.db` instead of this probe package.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)