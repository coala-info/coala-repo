---
name: bioconductor-mgu74cprobe
description: This package provides probe sequence data and location information for the Affymetrix MG-U74C microarray. Use when user asks to retrieve probe sequences, access x/y coordinates on the array, or identify interrogation positions for specific probe sets on the mgu74c platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mgu74cprobe.html
---

# bioconductor-mgu74cprobe

name: bioconductor-mgu74cprobe
description: Access and manipulate probe sequence data for the Affymetrix MG-U74C microarray. Use this skill when you need to retrieve probe sequences, x/y coordinates, or interrogation positions for specific probe sets on the mgu74c platform for genomic analysis or quality control.

# bioconductor-mgu74cprobe

## Overview

The `mgu74cprobe` package is a Bioconductor annotation data package containing the probe sequences and location information for the Affymetrix MG-U74C microarray. This data is essential for researchers performing sequence-specific analyses, such as calculating GC content, assessing probe hybridization efficiency, or re-mapping probes to updated genome assemblies.

## Loading and Accessing Data

To use the probe data, you must first load the package and the dataset:

```r
# Load the package
library(mgu74cprobe)

# Load the data object
data(mgu74cprobe)

# View the structure of the data
str(mgu74cprobe)
```

## Data Structure

The `mgu74cprobe` object is a data frame containing 201,963 rows and 6 columns:

- `sequence`: The actual DNA sequence of the probe (character).
- `x`: The x-coordinate of the probe on the array (integer).
- `y`: The y-coordinate of the probe on the array (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The nucleotide position within the target sequence (integer).
- `Target.Strandedness`: The orientation of the target relative to the probe (factor).

## Common Workflows

### Filtering by Probe Set
To extract all probes associated with a specific GeneChip ID:

```r
# Example: Get probes for a specific probe set
ps_probes <- subset(mgu74cprobe, Probe.Set.Name == "1000_at")
```

### Sequence Analysis
To calculate the GC content of the probes:

```r
# Simple GC content calculation
calculate_gc <- function(seqs) {
  sapply(seqs, function(x) {
    counts <- table(strsplit(x, "")[[1]])
    (counts["G"] + counts["C"]) / sum(counts)
  })
}

# Apply to the first 10 probes
gc_values <- calculate_gc(mgu74cprobe$sequence[1:10])
```

### Exporting Data
To use this data in external tools or for reporting:

```r
# Export to CSV
write.csv(mgu74cprobe[1:100, ], file = "mgu74c_probes_subset.csv")
```

## Usage Tips
- The dataset is large (over 200,000 rows). When exploring, use `head(mgu74cprobe)` or indexing `mgu74cprobe[1:5, ]` to avoid flooding the console.
- This package is specifically for the **C** version of the MG-U74 array. Ensure your expression data matches this specific array subtype (A, B, and C are different).
- For mapping probes to genomic coordinates, consider using this data in conjunction with the `Biostrings` package.

## Reference documentation

- [mgu74cprobe Reference Manual](./references/reference_manual.md)