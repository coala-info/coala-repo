---
name: bioconductor-celegansprobe
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/celegansprobe.html
---

# bioconductor-celegansprobe

name: bioconductor-celegansprobe
description: Access and use the probe sequence data for the Affymetrix C. elegans (celegans) microarray. Use this skill when you need to retrieve probe sequences, x/y coordinates, or probe set identifiers for C. elegans gene expression analysis in R.

# bioconductor-celegansprobe

## Overview
The `celegansprobe` package is a Bioconductor annotation data package containing the probe sequence information for the Affymetrix C. elegans genome array. It provides a data frame mapping each probe to its physical location on the chip, its sequence, and its corresponding probe set.

## Usage and Workflows

### Loading the Data
To use the probe data, you must first load the package and then use the `data()` function to load the dataset into your R environment.

```r
library(celegansprobe)
data(celegansprobe)
```

### Data Structure
The `celegansprobe` object is a data frame. You can inspect its structure using standard R functions:

```r
# View the first few rows
head(celegansprobe)

# Check the column names and types
str(celegansprobe)
```

The data frame contains the following columns:
- `sequence`: The nucleotide sequence of the probe (character).
- `x`: The x-coordinate of the probe on the array (integer).
- `y`: The y-coordinate of the probe on the array (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The position of the interrogation base (integer).
- `Target.Strandedness`: Whether the target is sense or antisense (factor).

### Common Operations

**Filtering by Probe Set**
To extract all probes associated with a specific Affymetrix ID:
```r
subset_probes <- subset(celegansprobe, Probe.Set.Name == "171434_at")
```

**Accessing Specific Sequences**
To get the sequences for a range of probes:
```r
probe_sequences <- celegansprobe$sequence[1:10]
```

**Integration with affy Package**
This package is typically used in conjunction with the `affy` package for low-level analysis. While `affy` handles much of this internally, you can use `celegansprobe` to verify specific probe sequences during quality control or custom normalization.

## Tips
- The dataset is large (over 240,000 rows). When previewing, always use `head()` or indexing (e.g., `celegansprobe[1:5, ]`) to avoid flooding the console.
- This package provides *probe-level* information. For *gene-level* annotations (like symbols or GO terms), use the corresponding annotation package `celegans.db`.

## Reference documentation
- [celegansprobe Reference Manual](./references/reference_manual.md)