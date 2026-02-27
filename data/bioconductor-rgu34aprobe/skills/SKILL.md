---
name: bioconductor-rgu34aprobe
description: This package provides probe sequence data and spatial coordinates for the Affymetrix Rat Genome U34A microarray. Use when user asks to retrieve probe sequences, map probes to coordinates, or perform sequence-level analysis for rgu34a expression studies.
homepage: https://bioconductor.org/packages/release/data/annotation/html/rgu34aprobe.html
---


# bioconductor-rgu34aprobe

name: bioconductor-rgu34aprobe
description: Access and utilize probe sequence data for the Affymetrix Rat Genome U34A (RG-U34A) microarray. Use this skill when needing to map probe sequences to coordinates, retrieve probe set names, or perform sequence-level analysis for rgu34a expression studies in R.

# bioconductor-rgu34aprobe

## Overview
The `rgu34aprobe` package is a Bioconductor annotation data package containing the sequence information for the probes on the Affymetrix Rat Genome U34A microarray. It provides a data frame mapping each probe to its x/y coordinates on the array, its parent Probe Set Name, the interrogation position, and the target strandedness. This is essential for low-level analysis, such as GC-content normalization or re-annotation of probe sets.

## Installation and Loading
To use this package, it must be installed via `BiocManager` and then loaded into the R session.

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("rgu34aprobe")
library(rgu34aprobe)
```

## Data Usage
The primary object in this package is a data frame also named `rgu34aprobe`.

### Loading the Data
Load the probe data into the environment using the `data()` function:

```r
data(rgu34aprobe)
```

### Data Structure
The `rgu34aprobe` object is a data frame with 140,317 rows and 6 columns:
- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate on the microarray (integer).
- `y`: The y-coordinate on the microarray (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The position of the interrogation base (integer).
- `Target.Strandedness`: The orientation of the target (factor).

### Common Operations
To view the first few entries of the probe data:
```r
head(rgu34aprobe)
```

To filter probes for a specific Probe Set:
```r
# Example: Get all probes for a specific ID
ps_probes <- subset(rgu34aprobe, Probe.Set.Name == "some_probe_set_id")
```

To convert the object to a standard data frame for manipulation (e.g., with `dplyr`):
```r
df <- as.data.frame(rgu34aprobe)
```

## Workflow Integration
This package is typically used in conjunction with the `affy` package or other Bioconductor tools when performing sequence-specific background correction or when verifying the genomic alignment of specific probes.

1. **Load Expression Data**: Use `affy` to load .CEL files.
2. **Retrieve Sequences**: Use `rgu34aprobe` to match the intensities from the .CEL files to their physical sequences.
3. **Analysis**: Perform sequence-based analysis (e.g., calculating melting temperatures or GC content).

## Reference documentation
- [rgu34aprobe Reference Manual](./references/reference_manual.md)