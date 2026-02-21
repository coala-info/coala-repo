---
name: bioconductor-ecoliasv2probe
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/ecoliasv2probe.html
---

# bioconductor-ecoliasv2probe

name: bioconductor-ecoliasv2probe
description: Access and use probe sequence data for the Affymetrix E_coli_Asv2 microarray. Use this skill when analyzing E. coli gene expression data that requires mapping probe sequences to coordinates or probe set identifiers.

# bioconductor-ecoliasv2probe

## Overview
The `ecoliasv2probe` package is a Bioconductor annotation data package containing the probe sequences and location information for the Affymetrix E. coli Asv2 microarray. It provides a standardized data frame mapping each probe to its x/y coordinates on the array, its parent probe set, and its interrogation position.

## Installation
To use this package in R, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("ecoliasv2probe")
```

## Usage and Workflows

### Loading the Data
The package contains a single primary data object. Load it into the R environment using the `data()` function.

```r
library(ecoliasv2probe)
data(ecoliasv2probe)
```

### Data Structure
The `ecoliasv2probe` object is a data frame with 141,629 rows and 6 columns:
- `sequence`: The nucleotide sequence of the probe (character).
- `x`: The x-coordinate on the array (integer).
- `y`: The y-coordinate on the array (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The position of the interrogation base (integer).
- `Target.Strandedness`: The orientation of the target (factor).

### Common Operations

**Previewing the data:**
```r
# View the first few rows
head(ecoliasv2probe)

# View as a data frame for specific rows
as.data.frame(ecoliasv2probe[1:3,])
```

**Filtering by Probe Set:**
If you need to find all probes associated with a specific gene or probe set ID:
```r
target_probes <- subset(ecoliasv2probe, Probe.Set.Name == "your_probe_set_id")
```

**Sequence Analysis:**
You can perform GC content analysis or search for specific motifs within the probe sequences:
```r
# Example: Calculate sequence lengths
seq_lengths <- nchar(ecoliasv2probe$sequence)
table(seq_lengths)
```

## Tips
- This package is primarily used internally by other Bioconductor packages like `affy` for low-level microarray analysis (e.g., calculating background or performing sequence-specific normalization).
- The coordinates (x, y) are essential for spatial analysis of the microarray surface to detect artifacts.

## Reference documentation
- [ecoliasv2probe Reference Manual](./references/reference_manual.md)