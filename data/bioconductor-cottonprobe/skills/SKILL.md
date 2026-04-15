---
name: bioconductor-cottonprobe
description: This package provides probe sequences and layout information for the Affymetrix Cotton genome microarray. Use when user asks to retrieve probe sequences, find probe coordinates, or access interrogation positions for the Cotton microarray platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/cottonprobe.html
---

# bioconductor-cottonprobe

name: bioconductor-cottonprobe
description: Provides access and usage instructions for the 'cottonprobe' Bioconductor annotation package. Use this skill when a user needs to retrieve or analyze probe sequence information, coordinates (x, y), or interrogation positions for the Affymetrix Cotton microarray platform in R.

# bioconductor-cottonprobe

## Overview
The `cottonprobe` package is a Bioconductor annotation data package containing the probe sequences and layout information for the Affymetrix Cotton genome array. It is primarily used in transcriptomics workflows to map specific probes to their physical locations on the chip or to perform sequence-specific analyses (e.g., GC content calculation or cross-hybridization checks).

## Installation and Loading
To use this package, it must be installed via `BiocManager` and then loaded into the R session.

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("cottonprobe")
library(cottonprobe)
```

## Accessing Probe Data
The package provides a single primary data object named `cottonprobe`. This object is a data frame containing the sequence-level details for the microarray.

### Loading the Dataset
```r
# Load the data object into the environment
data(cottonprobe)

# View the structure of the data
str(cottonprobe)
```

### Data Format
The `cottonprobe` object is a data frame with 265,516 rows and 6 columns:
- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate of the probe on the array (integer).
- `y`: The y-coordinate of the probe on the array (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The position within the target sequence being interrogated (integer).
- `Target.Strandedness`: The orientation of the target sequence (factor).

## Common Workflows

### Inspecting Specific Probes
To view the first few entries or subset the data by a specific Probe Set:
```r
# View the first 5 probes
head(cottonprobe, 5)

# Subset probes for a specific Probe Set
target_probes <- subset(cottonprobe, Probe.Set.Name == "Ghi.1.1.S1_at")
```

### Converting to Data Frame
While `cottonprobe` behaves like a data frame, you can explicitly convert subsets for use in tidyverse or other data manipulation frameworks:
```r
probe_df <- as.data.frame(cottonprobe[1:100, ])
```

### Spatial Analysis
Using the `x` and `y` coordinates, you can visualize the distribution of probes or check for spatial artifacts on the array:
```r
plot(cottonprobe$x[1:1000], cottonprobe$y[1:1000], 
     main="Probe Layout Subset", xlab="X", ylab="Y")
```

## Usage Tips
- **Memory Management**: The dataset is large (over 260,000 rows). If you only need specific columns (e.g., sequences), subset the object early to save memory.
- **Integration**: This package is typically used in conjunction with the `affy` or `limma` packages when performing low-level analysis of .CEL files for Cotton samples.

## Reference documentation
- [cottonprobe Reference Manual](./references/reference_manual.md)