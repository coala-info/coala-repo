---
name: bioconductor-mirna10probe
description: This package provides probe sequence data and chip coordinates for the Affymetrix miRNA-1.0 microarray. Use when user asks to map Affymetrix probe identifiers to sequences, retrieve probe coordinates, or perform sequence-based analysis for miRNA expression data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mirna10probe.html
---


# bioconductor-mirna10probe

name: bioconductor-mirna10probe
description: Provides probe sequence data for Affymetrix miRNA-1_0 microarrays. Use this skill when you need to map Affymetrix probe identifiers to their physical sequences, x/y coordinates on the array, or interrogation positions for miRNA expression analysis.

# bioconductor-mirna10probe

## Overview
The `mirna10probe` package is a Bioconductor annotation data package containing the sequence information for the probes on the Affymetrix miRNA-1_0 array. This package is essential for low-level analysis of microarray data, such as GC-content based normalization or custom probe-set redefinition.

## Loading the Data
To use the probe data, you must first load the library and then use the `data()` function to bring the data frame into your environment.

```r
# Install the package if necessary
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("mirna10probe")

# Load the package
library(mirna10probe)

# Load the probe data object
data(mirna10probe)
```

## Data Structure
The `mirna10probe` object is a data frame containing 46,227 rows. Each row represents a single probe on the array.

Key columns include:
- `sequence`: The actual nucleotide sequence of the probe.
- `x` and `y`: The physical coordinates of the probe on the microarray chip.
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (e.g., the miRNA name).
- `Probe.Interrogation.Position`: The position within the target sequence that this probe interrogates.
- `Target.Strandedness`: Whether the target is sense or antisense.

## Common Workflows

### Inspecting Probe Sequences
You can view the first few entries of the probe data to understand the mapping:

```r
# View the first 5 rows
head(mirna10probe)

# Convert a subset to a data frame for cleaner viewing
as.data.frame(mirna10probe[1:5, ])
```

### Filtering for Specific miRNAs
If you are interested in the probes associated with a specific miRNA, you can filter the data frame by the `Probe.Set.Name`:

```r
# Example: Get all probes for a specific miRNA
target_mirna <- "hsa-miR-21"
mirna_probes <- mirna10probe[mirna10probe$Probe.Set.Name == target_mirna, ]
```

### Sequence Analysis
You can perform basic sequence analysis, such as calculating the GC content of the probes:

```r
# Calculate GC content for all probes
library(Biostrings)
sequences <- DNAStringSet(mirna10probe$sequence)
gc_content <- letterFrequency(sequences, letters="GC", as.prob=TRUE)

# Add GC content back to the data frame
mirna10probe$GC <- gc_content
```

## Tips
- The `mirna10probe` object is a standard R data frame, so all base R subsetting and manipulation functions (like `subset`, `merge`, or `dplyr` verbs) work as expected.
- This package is specifically for the version 1.0 miRNA array. Ensure your CEL files match this array type before using this annotation.

## Reference documentation
- [mirna10probe Reference Manual](./references/reference_manual.md)