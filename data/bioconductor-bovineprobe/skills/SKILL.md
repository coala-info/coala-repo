---
name: bioconductor-bovineprobe
description: This package provides probe sequence data and spatial coordinates for the Affymetrix Bovine genome array. Use when user asks to retrieve probe-level information, access nucleotide sequences, or perform custom probe-set analysis for bovine microarrays.
homepage: https://bioconductor.org/packages/release/data/annotation/html/bovineprobe.html
---

# bioconductor-bovineprobe

name: bioconductor-bovineprobe
description: Access and use the probe sequence data for the Affymetrix Bovine genome array. Use this skill when you need to retrieve probe-level information, including sequences and (x,y) coordinates, for bovine microarray analysis in R.

# bioconductor-bovineprobe

## Overview
The `bovineprobe` package is a Bioconductor annotation data package containing the probe sequences for microarrays of type "bovine". This data is essential for tasks requiring probe-specific information, such as re-annotation, quality control, or custom probe-set analysis for Affymetrix Bovine arrays.

## Installation and Loading
To use this package, it must be installed via `BiocManager` and then loaded into the R session.

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("bovineprobe")
library(bovineprobe)
```

## Data Structure and Usage
The package provides a single data object named `bovineprobe`. This is a data frame containing the probe sequences and their corresponding locations on the array.

### Loading the Data
Load the dataset into the environment using the `data()` function:

```r
data(bovineprobe)
```

### Data Format
The `bovineprobe` object is a data frame with 265,627 rows and 6 columns:
- **sequence**: The nucleotide sequence of the probe (character).
- **x**: The x-coordinate of the probe on the array (integer).
- **y**: The y-coordinate of the probe on the array (integer).
- **Probe.Set.Name**: The Affymetrix identifier for the probe set (character).
- **Probe.Interrogation.Position**: The position of the interrogation base (integer).
- **Target.Strandedness**: The strandedness of the target (factor).

### Common Workflows

**1. Inspecting the data:**
```r
# View the first few rows
head(bovineprobe)

# Check the structure of the data frame
str(bovineprobe)
```

**2. Filtering by Probe Set:**
If you are interested in a specific gene or probe set, you can filter the data frame:
```r
# Example: Get all probes for a specific Probe Set
my_probes <- subset(bovineprobe, Probe.Set.Name == "Bt.20462.1.S1_at")
```

**3. Exporting sequences for external tools:**
If you need to run BLAST or other sequence analysis tools:
```r
# Extract sequences as a character vector
probes_seqs <- bovineprobe$sequence[1:100]
```

## Tips
- The data object is large (over 260,000 rows). When performing operations, prefer vectorized functions or `subset()` for efficiency.
- This package is specifically for the "Bovine" array. Ensure your microarray data matches this platform before using these sequences for downstream analysis.
- The coordinates (x, y) are useful for spatial bias analysis on the physical array surface.

## Reference documentation
- [bovineprobe Reference Manual](./references/reference_manual.md)