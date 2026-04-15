---
name: bioconductor-moexexonprobesetlocation
description: This package provides annotation data for the Affymetrix Mouse Exon microarray platform, including probe sequences and physical chip coordinates. Use when user asks to retrieve probe sequences, find x/y coordinates on the array, or map probe sets to genomic interrogation positions for MoEx microarrays.
homepage: https://bioconductor.org/packages/release/data/annotation/html/MoExExonProbesetLocation.html
---

# bioconductor-moexexonprobesetlocation

name: bioconductor-moexexonprobesetlocation
description: Access and use the MoExExonProbesetLocation annotation data package. Use this skill when you need to retrieve probe sequences, x/y coordinates, and genomic interrogation positions for Affymetrix Mouse Exon (MoEx) microarrays.

# bioconductor-moexexonprobesetlocation

## Overview

The `MoExExonProbesetLocation` package is a Bioconductor annotation data package providing specific location and sequence information for probes on the Mouse Exon (MoEx) microarray platform. It contains a large dataset mapping probe sets to their physical coordinates on the array and their target sequences.

## Installation and Loading

To use this data package, it must be installed via `BiocManager` and loaded into the R session.

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MoExExonProbesetLocation")
library(MoExExonProbesetLocation)
```

## Data Access and Usage

The package provides a single primary data object: `MoExExonProbesetLocation`.

### Loading the Dataset
The data is not automatically loaded into the global environment upon calling `library()`. Use the `data()` function to make it available.

```r
data(MoExExonProbesetLocation)
```

### Data Structure
The object is a data frame containing over 1.2 million rows. Each row represents a single probe.

| Column | Type | Description |
| :--- | :--- | :--- |
| `sequence` | character | The actual DNA probe sequence |
| `x` | integer | The x-coordinate on the microarray chip |
| `y` | integer | The y-coordinate on the microarray chip |
| `Probe.Set.Name` | character | The Affymetrix Probe Set identifier |
| `Probe.Interrogation.Position` | integer | The position of interrogation |
| `Target.Strandedness` | factor | The strandedness of the target sequence |

### Common Workflows

**Inspecting the data:**
```r
# View the first few rows
head(MoExExonProbesetLocation)

# Check the dimensions
dim(MoExExonProbesetLocation)
```

**Filtering by Probe Set:**
If you have a specific list of Probe Set Names and need their sequences or coordinates:
```r
target_probesets <- c("3831734", "3831735")
subset_data <- MoExExonProbesetLocation[MoExExonProbesetLocation$Probe.Set.Name %in% target_probesets, ]
```

**Converting to Data Frame:**
While it behaves like a data frame, you can explicitly cast it for certain tidyverse operations:
```r
df <- as.data.frame(MoExExonProbesetLocation)
```

## Tips
- **Memory Management:** This dataset is large (1.2M+ rows). Avoid printing the entire object to the console.
- **Coordinate Mapping:** The `x` and `y` coordinates are essential for low-level analysis of CEL files or spatial quality control of the array.
- **Sequence Analysis:** Use the `sequence` column if you need to perform re-alignment or check for GC content/melting temperature of specific probes.

## Reference documentation
- [MoExExonProbesetLocation Reference Manual](./references/reference_manual.md)