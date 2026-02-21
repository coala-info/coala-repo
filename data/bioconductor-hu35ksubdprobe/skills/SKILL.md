---
name: bioconductor-hu35ksubdprobe
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hu35ksubdprobe.html
---

# bioconductor-hu35ksubdprobe

name: bioconductor-hu35ksubdprobe
description: Access and use probe sequence data for the Affymetrix hu35ksubd microarray chip. Use this skill when needing to map probe sequences to coordinates, probe sets, or genomic targets for the hu35ksubd platform in R.

# bioconductor-hu35ksubdprobe

## Overview
The `hu35ksubdprobe` package is a Bioconductor annotation data package containing the probe sequences and layout information for the Affymetrix hu35ksubd microarray. It provides a standardized data frame mapping each probe to its x/y coordinates on the array, its parent probe set, and its interrogation position.

## Loading and Accessing Data
The package primarily provides a single data object named `hu35ksubdprobe`.

```r
# Install the package if necessary
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("hu35ksubdprobe")

# Load the package
library(hu35ksubdprobe)

# Load the probe data object
data(hu35ksubdprobe)

# View the structure
str(hu35ksubdprobe)
```

## Data Structure
The `hu35ksubdprobe` object is a data frame with 139,985 rows and 6 columns:

- **sequence**: The actual nucleotide sequence of the probe (character).
- **x**: The x-coordinate of the probe on the microarray (integer).
- **y**: The y-coordinate of the probe on the microarray (integer).
- **Probe.Set.Name**: The Affymetrix identifier for the probe set (character).
- **Probe.Interrogation.Position**: The nucleotide position within the target sequence (integer).
- **Target.Strandedness**: Whether the target is sense or antisense (factor).

## Common Workflows

### Inspecting Specific Probes
To view the first few probes in the dataset:
```r
head(hu35ksubdprobe)
```

### Filtering by Probe Set
To extract all probes associated with a specific Affymetrix Probe Set:
```r
# Example: Filter for a specific probe set
subset_probes <- subset(hu35ksubdprobe, Probe.Set.Name == "1000_at")
```

### Sequence Analysis
You can use this data to perform GC content analysis or sequence matching by treating the `sequence` column as a character vector:
```r
# Calculate sequence lengths (should be 25 for Affymetrix)
table(nchar(hu35ksubdprobe$sequence))
```

## Usage Tips
- This package is typically used in conjunction with `affy` or `oligo` for low-level microarray analysis where probe-level sequence information is required (e.g., background correction or custom CDF generation).
- For mapping probe sets to gene symbols or Entrez IDs, use the corresponding platform annotation package (e.g., `hu35ksubd.db`).

## Reference documentation
- [hu35ksubdprobe Reference Manual](./references/reference_manual.md)