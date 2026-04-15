---
name: bioconductor-riceprobe
description: This package provides probe sequence and location data for the Affymetrix Rice Genome Array. Use when user asks to retrieve probe sequences, find physical coordinates on the chip, or map probes to specific probe set names for rice microarray analysis.
homepage: https://bioconductor.org/packages/release/data/annotation/html/riceprobe.html
---

# bioconductor-riceprobe

name: bioconductor-riceprobe
description: Access and use the riceprobe annotation data package for Affymetrix Rice Genome arrays. Use this skill when you need to retrieve probe sequences, coordinates (x, y), probe set names, interrogation positions, or target strandedness for rice microarray analysis in R.

# bioconductor-riceprobe

## Overview
The `riceprobe` package is a Bioconductor annotation data package containing the probe sequence information for the Affymetrix Rice Genome Array. It provides a large data frame mapping individual probes to their physical locations on the chip and their corresponding probe sets. This is essential for low-level analysis, such as GC-content calculations, background correction, or re-annotation of probe sets.

## Installation and Loading
To use this package, it must be installed via `BiocManager` and then loaded into the R session.

```r
# Install the package
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("riceprobe")

# Load the package
library(riceprobe)
```

## Usage and Workflows

### Accessing the Probe Data
The primary data object is named `riceprobe`. It is automatically available upon loading the library, but can be explicitly loaded using `data()`.

```r
# Load the dataset
data(riceprobe)

# View the structure of the data
str(riceprobe)

# Preview the first few rows
head(riceprobe)
```

### Data Frame Structure
The `riceprobe` object is a data frame with 631,066 rows and 6 columns:
- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate of the probe on the array (integer).
- `y`: The y-coordinate of the probe on the array (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The position of the interrogation base (integer).
- `Target.Strandedness`: The orientation of the target (factor).

### Common Operations

**Filtering by Probe Set:**
To extract all probes associated with a specific Affymetrix ID:
```r
# Example: Get probes for a specific ID
subset_probes <- riceprobe[riceprobe$Probe.Set.Name == "Os.100.1.S1_at", ]
```

**Extracting Sequences for Analysis:**
If you need to perform sequence-specific analysis (like calculating GC content):
```r
# Get the first 10 sequences
probe_seqs <- riceprobe$sequence[1:10]
```

**Converting to a Standard Data Frame:**
While `riceprobe` behaves like a data frame, you can explicitly cast it for use with tidyverse or other tools:
```r
df_rice <- as.data.frame(riceprobe[1:100, ])
```

## Tips
- **Memory Management:** The `riceprobe` object is quite large (over 600,000 rows). Avoid printing the entire object to the console. Use `head()`, `tail()`, or indexing to inspect the data.
- **Coordinate System:** The `x` and `y` coordinates are used to map probes to their physical location on the CEL file intensity grid.
- **AnnotationForge:** This package was generated using `AnnotationForge`. If you need to create similar probe packages for custom arrays, refer to the `AnnotationForge` documentation.

## Reference documentation
- [riceprobe Reference Manual](./references/reference_manual.md)