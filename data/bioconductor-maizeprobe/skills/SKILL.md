---
name: bioconductor-maizeprobe
description: This package provides probe sequence data and physical coordinates for the Affymetrix Maize microarray. Use when user asks to retrieve probe-level sequences, access x/y coordinates on the chip, or identify interrogation positions for maize genomic studies.
homepage: https://bioconductor.org/packages/release/data/annotation/html/maizeprobe.html
---

# bioconductor-maizeprobe

name: bioconductor-maizeprobe
description: Access and use the probe sequence data for the Affymetrix Maize microarray. Use this skill when you need to retrieve probe-level information, including sequences, x/y coordinates, and interrogation positions for maize genomic studies using Bioconductor.

# bioconductor-maizeprobe

## Overview
The `maizeprobe` package is a Bioconductor annotation data package containing the sequence information for the probes on the Affymetrix Maize microarray. Unlike metadata packages that map probes to genes, this package provides the physical properties of the probes themselves, such as their nucleotide sequences and their specific coordinates on the chip.

## Loading and Accessing Data
The package contains a single primary data object also named `maizeprobe`.

```r
# Load the library
library(maizeprobe)

# Load the data object
data(maizeprobe)

# View the structure of the data
str(maizeprobe)
```

## Data Structure
The `maizeprobe` object is a data frame with 265,682 rows and 6 columns:
- **sequence**: The actual nucleotide sequence of the probe (character).
- **x**: The x-coordinate of the probe on the array (integer).
- **y**: The y-coordinate of the probe on the array (integer).
- **Probe.Set.Name**: The Affymetrix identifier for the probe set (character).
- **Probe.Interrogation.Position**: The position within the target sequence that the probe interrogates (integer).
- **Target.Strandedness**: The orientation of the target (factor).

## Common Workflows

### Subsetting Probes by Probe Set
To extract all probes associated with a specific Affymetrix Probe Set ID:
```r
# Example: Get probes for a specific ID
specific_probes <- maizeprobe[maizeprobe$Probe.Set.Name == "12345_at", ]
```

### Exporting to Data Frame
For standard data manipulation (e.g., using `dplyr`), ensure the object is treated as a data frame:
```r
df <- as.data.frame(maizeprobe[1:10, ])
```

### Sequence Analysis
You can use this data to perform GC content analysis or sequence alignment for specific probes:
```r
# Calculate sequence length (should be 25 for Affymetrix)
lengths <- nchar(maizeprobe$sequence[1:5])
```

## Tips
- **Memory Management**: The `maizeprobe` object is large (over 260,000 rows). If you only need specific probe sets, subset the data early to save memory.
- **Coordinate Mapping**: The `x` and `y` coordinates are essential for spatial analysis of the array or for identifying potential regional artifacts on the chip.
- **Integration**: This package is typically used in conjunction with the `affy` package or other Bioconductor tools for low-level microarray analysis.

## Reference documentation
- [maizeprobe Reference Manual](./references/reference_manual.md)