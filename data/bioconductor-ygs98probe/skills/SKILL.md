---
name: bioconductor-ygs98probe
description: This package provides probe sequence data and microarray coordinates for the Affymetrix Yeast Genome S98 platform. Use when user asks to retrieve probe sequences, access x/y coordinates, or perform sequence-level analysis for YGS98 microarrays.
homepage: https://bioconductor.org/packages/release/data/annotation/html/ygs98probe.html
---


# bioconductor-ygs98probe

name: bioconductor-ygs98probe
description: Access and use the ygs98probe annotation package for Affymetrix Yeast Genome S98 microarrays. Use this skill when you need to retrieve probe sequences, x/y coordinates, and interrogation positions for the ygs98 array type in R.

# bioconductor-ygs98probe

## Overview
The `ygs98probe` package is a Bioconductor annotation data package containing the probe sequence information for the Affymetrix Yeast Genome S98 (YGS98) platform. This data is essential for low-level analysis tasks, such as calculating GC content, performing sequence-specific background correction, or re-mapping probes to updated genomic coordinates.

## Usage in R

### Loading the Data
The package contains a single data frame object named `ygs98probe`.

```r
# Install the package if necessary
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("ygs98probe")

# Load the library
library(ygs98probe)

# Load the probe data object
data(ygs98probe)
```

### Data Structure
The `ygs98probe` object is a data frame with 138,412 rows and 6 columns. You can inspect the structure using standard R commands:

```r
# View the first few rows
head(ygs98probe)

# Check column names and types
str(ygs98probe)
```

### Column Definitions
- **sequence**: The actual nucleotide sequence of the probe (character).
- **x**: The x-coordinate of the probe on the microarray (integer).
- **y**: The y-coordinate of the probe on the microarray (integer).
- **Probe.Set.Name**: The Affymetrix identifier for the probe set (character).
- **Probe.Interrogation.Position**: The position of the interrogation nucleotide within the target sequence (integer).
- **Target.Strandedness**: Whether the target is sense or antisense (factor).

### Common Workflows

#### Filtering by Probe Set
To extract all probes associated with a specific gene or probe set:

```r
# Example: Get probes for a specific ID
my_probes <- ygs98probe[ygs98probe$Probe.Set.Name == "1000_at", ]
```

#### Calculating Sequence Statistics
You can use the `Biostrings` package alongside this data to calculate properties like GC content:

```r
library(Biostrings)
# Convert sequences to DNAStringSet
dna_seqs <- DNAStringSet(ygs98probe$sequence)
# Calculate GC content
gc_content <- letterFrequency(dna_seqs, letters="GC", as.prob=TRUE)
```

## Tips
- The `ygs98probe` object is large. When performing exploratory analysis, use `as.data.frame(ygs98probe[1:n, ])` to view a subset.
- This package is specifically for probe sequences. For probe-to-gene mappings or functional annotations, use the corresponding CDF or annotation package (e.g., `ygs98.db`).

## Reference documentation
- [ygs98probe Reference Manual](./references/reference_manual.md)