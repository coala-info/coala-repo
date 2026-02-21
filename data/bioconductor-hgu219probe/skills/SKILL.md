---
name: bioconductor-hgu219probe
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgu219probe.html
---

# bioconductor-hgu219probe

name: bioconductor-hgu219probe
description: Provides probe sequence data for Affymetrix Human Genome U219 (hgu219) microarrays. Use this skill when you need to map Affymetrix probe identifiers to their physical sequences, coordinates (x, y), or interrogation positions for genomic analysis in R.

# bioconductor-hgu219probe

## Overview

The `hgu219probe` package is a Bioconductor annotation data package containing the sequence information for the probes on the Affymetrix hgu219 array. This data is essential for tasks such as sequence-specific bias correction, GC content analysis, or re-mapping probes to updated genomic coordinates.

## Installation

To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("hgu219probe")
```

## Usage and Workflows

### Loading the Data

The primary data object is a data frame named `hgu219probe`. It is loaded into the R environment using the `data()` function.

```r
library(hgu219probe)
data(hgu219probe)
```

### Data Structure

The `hgu219probe` object is a data frame with 548,517 rows and 6 columns:

- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate of the probe on the microarray (integer).
- `y`: The y-coordinate of the probe on the microarray (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The nucleotide position within the target sequence (integer).
- `Target.Strandedness`: Whether the target is sense or antisense (factor).

### Common Operations

**1. Previewing the data:**
```r
# View the first few rows
head(hgu219probe)

# Check the structure
str(hgu219probe)
```

**2. Filtering by Probe Set:**
If you have a specific list of Affymetrix IDs and need their sequences:
```r
my_probes <- c("200000_s_at", "200001_at")
subset_data <- hgu219probe[hgu219probe$Probe.Set.Name %in% my_probes, ]
```

**3. Analyzing GC Content:**
A common use case for probe sequences is calculating GC content to account for hybridization affinity:
```r
# Example using base R to calculate GC count for the first 10 probes
sequences <- hgu219probe$sequence[1:10]
gc_content <- sapply(sequences, function(x) {
  sum(strsplit(x, NULL)[[1]] %in% c("G", "C")) / nchar(x)
})
```

## Tips

- **Memory Management**: The `hgu219probe` object is large (over 500k rows). If you only need specific columns or a subset of probes, filter the data frame early to save memory.
- **Coordinate Mapping**: The `x` and `y` coordinates are useful for identifying spatial artifacts on the microarray chips during quality control.
- **Package Origin**: This package was automatically generated using `AnnotationForge`.

## Reference documentation

- [hgu219probe Reference Manual](./references/reference_manual.md)