---
name: bioconductor-rgu34cprobe
description: This package provides probe sequence and location data for the Affymetrix Rat Genome U34C microarray. Use when user asks to access probe sequences, map probes to probe sets, or perform sequence-specific analysis for the rgu34c platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/rgu34cprobe.html
---

# bioconductor-rgu34cprobe

name: bioconductor-rgu34cprobe
description: Access and use probe sequence data for the Affymetrix rgu34c (Rat Genome U34C) microarray. Use this skill when needing to map probe sequences to coordinates, probe sets, or genomic positions for the rgu34c platform in R.

# bioconductor-rgu34cprobe

## Overview
The `rgu34cprobe` package is a Bioconductor annotation data package containing the probe sequences and location information for the Affymetrix Rat Genome U34C (rgu34c) microarray. This data is essential for low-level analysis tasks, such as calculating GC content, performing sequence-specific background correction, or re-mapping probes to updated genome assemblies.

## Loading and Accessing Data
The package provides a single data frame object named `rgu34cprobe`.

```r
# Load the package
library(rgu34cprobe)

# Load the probe data object
data(rgu34cprobe)

# View the structure of the data
str(rgu34cprobe)
```

## Data Structure
The `rgu34cprobe` object is a data frame with 140,284 rows and 6 columns:
- `sequence`: The actual DNA sequence of the probe (character).
- `x`: The x-coordinate of the probe on the microarray (integer).
- `y`: The y-coordinate of the probe on the microarray (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The nucleotide position within the target sequence (integer).
- `Target.Strandedness`: Whether the target is Sense or Antisense (factor).

## Common Workflows

### Subsetting Probes by Probe Set
To extract all probes associated with a specific Affymetrix ID:
```r
# Example: Get probes for a specific probe set
ps_probes <- rgu34cprobe[rgu34cprobe$Probe.Set.Name == "138944_at", ]
```

### Exporting to Data Frame
While the object is already a data frame, you can use standard R operations to manipulate or export it:
```r
# View the first few rows
head(rgu34cprobe)

# Convert a subset to a standard data frame for external use
subset_df <- as.data.frame(rgu34cprobe[1:100, ])
```

### Sequence Analysis
You can use this data in conjunction with the `Biostrings` package to perform sequence analysis:
```r
library(Biostrings)
# Calculate GC content for all probes
probe_seqs <- DNAStringSet(rgu34cprobe$sequence)
gc_content <- letterFrequency(probe_seqs, letters="GC", as.prob=TRUE)
```

## Usage Tips
- **Memory Management**: The data frame is relatively large (140k+ rows). If you only need specific columns (e.g., sequences and IDs), subset the data early to save memory.
- **Coordinate Mapping**: The `x` and `y` coordinates are 0-indexed, which is standard for Affymetrix CEL file spatial mapping.

## Reference documentation
- [rgu34cprobe Reference Manual](./references/reference_manual.md)