---
name: bioconductor-hgu133a2probe
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgu133a2probe.html
---

# bioconductor-hgu133a2probe

name: bioconductor-hgu133a2probe
description: Access and use probe sequence data for the Affymetrix Human Genome U133A 2.0 (hgu133a2) microarray. Use this skill when you need to map probe sequences to coordinates, probe set IDs, or interrogation positions for hgu133a2 arrays in R.

# bioconductor-hgu133a2probe

## Overview
The `hgu133a2probe` package is a Bioconductor annotation data package containing the sequence information for the probes on the Affymetrix HG-U133A 2.0 microarray. This package is essential for low-level analysis of microarray data, such as calculating GC content, performing sequence-specific background correction, or re-mapping probes to updated genomic coordinates.

## Installation and Loading
To use this package, it must be installed via `BiocManager` and then loaded into the R session.

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("hgu133a2probe")
library(hgu133a2probe)
```

## Data Structure
The primary object in this package is a data frame also named `hgu133a2probe`. It contains 247,899 rows, where each row represents a single probe.

### Column Definitions
- **sequence**: The actual nucleotide sequence of the probe (character).
- **x**: The x-coordinate of the probe on the array (integer).
- **y**: The y-coordinate of the probe on the array (integer).
- **Probe.Set.Name**: The Affymetrix ID for the probe set (character).
- **Probe.Interrogation.Position**: The position within the target sequence that this probe monitors (integer).
- **Target.Strandedness**: The orientation of the target sequence (factor).

## Common Workflows

### Accessing Probe Data
The data is loaded into the environment using the `data()` function.

```r
# Load the probe data
data(hgu133a2probe)

# View the first few rows
head(hgu133a2probe)

# Check the structure of the data frame
str(hgu133a2probe)
```

### Filtering by Probe Set
To extract all probes associated with a specific Affymetrix Probe Set ID:

```r
# Example: Get probes for a specific ID
target_probes <- subset(hgu133a2probe, Probe.Set.Name == "200000_s_at")
```

### Sequence Analysis
You can use this data to analyze the composition of the probes, which is often used in custom normalization algorithms.

```r
# Calculate the length of sequences (should be 25 for this array)
table(nchar(hgu133a2probe$sequence))

# Example: Find probes containing a specific motif
motif_probes <- hgu133a2probe[grep("TATA", hgu133a2probe$sequence), ]
```

## Tips
- **Memory Management**: The `hgu133a2probe` object is a large data frame. If you only need specific columns (e.g., sequence and Probe.Set.Name), consider subsetting it to save memory.
- **Integration**: This package is typically used in conjunction with the `affy` package or other Bioconductor tools that handle `.CEL` files.
- **Coordinate Mapping**: The `x` and `y` coordinates are used to map the probe intensities from the raw image data to the specific sequences provided here.

## Reference documentation
- [hgu133a2probe Reference Manual](./references/reference_manual.md)