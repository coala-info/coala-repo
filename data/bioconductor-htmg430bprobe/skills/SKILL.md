---
name: bioconductor-htmg430bprobe
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/htmg430bprobe.html
---

# bioconductor-htmg430bprobe

## Overview

The `htmg430bprobe` package is a Bioconductor annotation data package containing the sequence information for the probes on the Affymetrix HT_MG-430B microarray. This package is essential for low-level analysis of microarray data, such as GC-content based normalization (e.g., GCRMA) or custom probe-to-gene re-mapping.

The package provides a single data frame named `htmg430bprobe` containing 248,721 rows, where each row represents a specific probe on the chip.

## Usage and Workflows

### Loading the Data

To access the probe sequences, you must load the package and then use the `data()` function to bring the object into your environment.

```r
library(htmg430bprobe)
data(htmg430bprobe)
```

### Data Structure

The `htmg430bprobe` object is a data frame with the following columns:

- `sequence`: The actual nucleotide sequence (character).
- `x`: The x-coordinate of the probe on the array (integer).
- `y`: The y-coordinate of the probe on the array (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The distance from the 5' end of the target sequence (integer).
- `Target.Strandedness`: Whether the target is Sense or Antisense (factor).

### Common Operations

**Viewing a subset of probes:**
```r
# View the first 5 rows
head(htmg430bprobe)

# View specific columns for a subset
htmg430bprobe[1:10, c("Probe.Set.Name", "sequence")]
```

**Filtering by Probe Set:**
If you are interested in the sequences for a specific gene or probe set:
```r
# Replace '1415670_at' with your probe set of interest
subset_probes <- subset(htmg430bprobe, Probe.Set.Name == "1415670_at")
```

**Calculating GC Content:**
This is a common task for normalization workflows:
```r
library(Biostrings)
# Convert sequences to DNAStringSet for efficient calculation
dna_seqs <- DNAStringSet(htmg430bprobe$sequence)
gc_content <- letterFrequency(dna_seqs, letters="GC", as.prob=TRUE)
```

## Tips

- **Memory Management**: The data frame is relatively large (248,721 rows). If you only need specific columns, consider subsetting the data frame immediately after loading to save memory.
- **Coordinate Matching**: The `x` and `y` coordinates are used to match these sequences with the intensity values found in CEL files (often processed via the `affy` or `oligo` packages).
- **Version Consistency**: Ensure that the version of the probe package matches the version of the CDF (Chip Definition File) package you are using for your analysis to avoid mapping errors.

## Reference documentation

- [htmg430bprobe Reference Manual](./references/reference_manual.md)