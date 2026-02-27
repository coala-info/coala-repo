---
name: bioconductor-rat2302probe
description: This package provides probe sequence data and physical coordinates for the Affymetrix Rat Genome 230 2.0 Array. Use when user asks to retrieve probe sequences, map probes to x/y coordinates, or perform low-level microarray analysis like GC-content normalization for rat genomic studies.
homepage: https://bioconductor.org/packages/release/data/annotation/html/rat2302probe.html
---


# bioconductor-rat2302probe

name: bioconductor-rat2302probe
description: Provides probe sequence data for the Affymetrix Rat Genome 230 2.0 Array (rat2302). Use this skill when you need to map microarray probe sequences to their x/y coordinates, probe set names, or interrogation positions for rat genomic studies.

# bioconductor-rat2302probe

## Overview
The `rat2302probe` package is a Bioconductor annotation data package containing the probe sequences and location information for the Affymetrix Rat Genome 230 2.0 Array. This package is essential for low-level microarray analysis, such as GC-content based normalization (e.g., GCRMA) or re-annotating probes to updated genome builds.

## Installation and Loading
To use this package, it must be installed via `BiocManager` and loaded into the R session.

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("rat2302probe")
library(rat2302probe)
```

## Data Access and Structure
The primary data object is a data frame also named `rat2302probe`. It is loaded into the environment using the `data()` function.

```r
# Load the probe data
data(rat2302probe)

# View the structure of the data
str(rat2302probe)

# Preview the first few rows
head(rat2302probe)
```

### Column Definitions
The data frame contains 342,410 rows and 6 columns:
- **sequence**: The actual nucleotide sequence of the probe (character).
- **x**: The x-coordinate of the probe on the array (integer).
- **y**: The y-coordinate of the probe on the array (integer).
- **Probe.Set.Name**: The Affymetrix identifier for the probe set (character).
- **Probe.Interrogation.Position**: The nucleotide position within the target sequence (integer).
- **Target.Strandedness**: Whether the target is Sense or Antisense (factor).

## Common Workflows

### Filtering Probes by Probe Set
To extract all probes associated with a specific Affymetrix ID:

```r
# Example: Get probes for a specific ID
target_probes <- subset(rat2302probe, Probe.Set.Name == "1367452_at")
```

### Calculating GC Content
Microarray analysis often requires calculating the GC content of probes to account for hybridization biases.

```r
# Calculate GC count for each probe
library(Biostrings)
sequences <- DNAStringSet(rat2302probe$sequence)
gc_content <- letterFrequency(sequences, letters = "GC", as.prob = TRUE)

# Add to the data frame
rat2302probe$gc_content <- as.vector(gc_content)
```

### Spatial Visualization
You can visualize the distribution of probes or specific probe sets across the physical array using the x and y coordinates.

```r
# Plotting the layout of a specific probe set
plot(target_probes$x, target_probes$y, 
     main = "Spatial Layout of Probe Set 1367452_at",
     xlab = "x-coordinate", ylab = "y-coordinate", 
     pch = 19)
```

## Usage Tips
- **Memory Management**: The `rat2302probe` object is large. If you only need specific columns (e.g., sequences and IDs), consider subsetting the data frame to save memory.
- **Integration**: This package is typically used in conjunction with the `affy` package or other Bioconductor tools that handle `.CEL` files for the Rat 230 2.0 platform.

## Reference documentation
- [rat2302probe Reference Manual](./references/reference_manual.md)