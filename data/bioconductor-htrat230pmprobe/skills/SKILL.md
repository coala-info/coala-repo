---
name: bioconductor-htrat230pmprobe
description: This package provides probe sequence data and array coordinates for the Affymetrix HT_Rat230_PM microarray. Use when user asks to access probe sequences, map probes to genomic coordinates, or perform GC-content based normalization for rat genomic studies.
homepage: https://bioconductor.org/packages/release/data/annotation/html/htrat230pmprobe.html
---

# bioconductor-htrat230pmprobe

name: bioconductor-htrat230pmprobe
description: Access and utilize probe sequence data for the Affymetrix HT_Rat230_PM microarray. Use this skill when needing to map probe sequences to coordinates, probe set names, or interrogation positions for rat genomic studies using the htrat230pm platform.

# bioconductor-htrat230pmprobe

## Overview

The `htrat230pmprobe` package is a Bioconductor annotation data package containing the probe sequences for the Affymetrix HT_Rat230_PM array. This package is essential for low-level analysis of microarray data, such as GC-content based normalization (e.g., GCRMA) or custom probe-to-gene remapping.

## Usage and Workflows

### Loading the Data

To use the probe data, you must first load the package and the dataset:

```r
library(htrat230pmprobe)
data(htrat230pmprobe)
```

### Data Structure

The dataset is stored as a data frame named `htrat230pmprobe`. It contains 342,450 rows, where each row represents a single probe.

Key columns include:
- `sequence`: The 25-mer nucleotide sequence of the probe.
- `x` and `y`: The (x, y) coordinates of the probe on the array.
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (e.g., "1367452_at").
- `Probe.Interrogation.Position`: The nucleotide position within the target sequence.
- `Target.Strandedness`: Whether the target is sense or antisense.

### Common Operations

**Viewing a subset of probes:**
```r
# View the first 5 rows
head(htrat230pmprobe, n = 5)

# Convert to a standard data frame for specific manipulation
probe_df <- as.data.frame(htrat230pmprobe[1:10, ])
```

**Filtering by Probe Set:**
```r
# Extract all probes belonging to a specific probe set
specific_probes <- htrat230pmprobe[htrat230pmprobe$Probe.Set.Name == "1367452_at", ]
```

**Calculating GC Content:**
If you need to calculate the GC content of probes for normalization:
```r
# Example using base R to count G and C characters
gc_content <- sapply(htrat230pmprobe$sequence[1:100], function(seq) {
  sum(charToRaw(seq) %in% charToRaw("GC")) / nchar(seq)
})
```

## Tips
- The package is primarily used as a dependency for other Bioconductor packages like `affy` or `gcrma`.
- Ensure your `AffyBatch` object matches this specific array type (`htrat230pm`) before attempting to link probe sequences to your expression data.
- For high-level gene expression analysis, you may prefer the `htrat230pm.db` package, which provides gene-level annotations rather than probe-level sequences.

## Reference documentation
- [htrat230pmprobe Reference Manual](./references/reference_manual.md)