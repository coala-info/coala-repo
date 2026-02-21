---
name: bioconductor-hgu133bprobe
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgu133bprobe.html
---

# bioconductor-hgu133bprobe

name: bioconductor-hgu133bprobe
description: Access and use probe sequence data for the Affymetrix HG-U133B microarray platform. Use this skill when needing to map probe sequences to coordinates, probe set IDs, or interrogation positions for hgu133b arrays in R.

# bioconductor-hgu133bprobe

## Overview

The `hgu133bprobe` package is a Bioconductor annotation data package containing the sequence information for the probes on the Affymetrix HG-U133B microarray. It provides a data frame mapping each probe to its x/y coordinates on the array, its parent Probe Set Name, the interrogation position, and the target strandedness.

## Installation and Loading

To use this package in R:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("hgu133bprobe")

# Load the package
library(hgu133bprobe)
```

## Data Usage

The primary data object is a data frame also named `hgu133bprobe`.

### Loading the Data Object
```r
# Load the probe data into the workspace
data(hgu133bprobe)
```

### Data Structure
The dataset contains 249,502 rows and 6 columns:
- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate on the array (integer).
- `y`: The y-coordinate on the array (integer).
- `Probe.Set.Name`: The Affymetrix ID for the gene/transcript cluster (character).
- `Probe.Interrogation.Position`: The nucleotide position within the target sequence (integer).
- `Target.Strandedness`: Whether the target is Sense or Antisense (factor).

### Common Workflows

**1. Previewing the data:**
```r
# View the first few rows
head(hgu133bprobe)

# View as a data frame for specific rows
as.data.frame(hgu133bprobe[1:5,])
```

**2. Filtering by Probe Set:**
If you have a specific Affymetrix ID (e.g., from a `Biobase::ExpressionSet`), you can extract all probes associated with it:
```r
target_probes <- subset(hgu133bprobe, Probe.Set.Name == "200000_s_at")
```

**3. Analyzing Probe GC Content:**
Since the sequences are provided, you can calculate sequence-specific properties:
```r
library(Biostrings)
# Calculate GC content for the first 10 probes
probes <- DNAStringSet(hgu133bprobe$sequence[1:10])
letterFrequency(probes, as.prob = TRUE, letters = "GC")
```

## Tips
- The object `hgu133bprobe` is a standard R `data.frame`. You can use standard `dplyr` or base R subsetting to manipulate it.
- This package is specifically for the **B** version of the HG-U133 array. Ensure your data is not from the HG-U133A or HG-U133 Plus 2.0 platforms, which require different probe packages.
- Use this package in conjunction with the `hgu133b.db` package if you need to map these probes to Entrez IDs, Gene Symbols, or GO terms.

## Reference documentation
- [hgu133bprobe Reference Manual](./references/reference_manual.md)