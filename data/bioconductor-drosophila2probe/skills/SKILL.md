---
name: bioconductor-drosophila2probe
description: This package provides the nucleotide sequence data and array coordinates for probes on the Affymetrix Drosophila Genome 2.0 Array. Use when user asks to access probe sequences, map probes to probe sets, or perform sequence-specific analysis for Drosophila melanogaster microarrays.
homepage: https://bioconductor.org/packages/release/data/annotation/html/drosophila2probe.html
---

# bioconductor-drosophila2probe

name: bioconductor-drosophila2probe
description: Access and use the probe sequence data for the Affymetrix Drosophila Genome 2.0 Array. Use this skill when you need to map probe sequences to coordinates, probe sets, or genomic positions for Drosophila melanogaster microarray analysis.

# bioconductor-drosophila2probe

## Overview

The `drosophila2probe` package is a Bioconductor annotation data package containing the sequence information for the probes on the Affymetrix Drosophila 2.0 microarray. It provides a standardized data frame mapping each probe to its physical location on the array (x, y coordinates), its parent probe set, and its orientation. This is essential for low-level analysis, such as GC-content normalization, background correction, or re-mapping probes to updated genome assemblies.

## Usage and Workflows

### Loading the Data

The package contains a single primary data object. To use it, you must load the library and then use the `data()` function.

```r
# Load the package
library(drosophila2probe)

# Load the probe data object
data(drosophila2probe)

# Check the class (it is a data.frame)
class(drosophila2probe)
```

### Data Structure

The `drosophila2probe` object is a data frame with 265,400 rows and 6 columns:

1.  **sequence**: The actual nucleotide sequence of the probe (character).
2.  **x**: The x-coordinate of the probe on the array (integer).
3.  **y**: The y-coordinate of the probe on the array (integer).
4.  **Probe.Set.Name**: The Affymetrix identifier for the probe set (character).
5.  **Probe.Interrogation.Position**: The position of the interrogated base (integer).
6.  **Target.Strandedness**: The orientation of the target relative to the probe (factor).

### Common Operations

**Viewing a subset of probes:**
```r
# View the first few rows
head(drosophila2probe)

# Access specific probe set sequences
ps_name <- "141214_at"
subset_probes <- drosophila2probe[drosophila2probe$Probe.Set.Name == ps_name, ]
```

**Calculating GC Content:**
If you need to perform sequence-specific analysis, you can use the `Biostrings` package alongside this data:
```r
library(Biostrings)
sequences <- DNAStringSet(drosophila2probe$sequence)
gc_content <- letterFrequency(sequences, letters="GC", as.prob=TRUE)
```

## Tips

- **Memory Management**: The data frame is relatively large (265,400 rows). If you only need specific probe sets, subset the data frame early to save memory.
- **Coordinate Matching**: The `x` and `y` coordinates are 0-indexed, which is standard for Affymetrix CEL file data.
- **Integration**: This package is typically used in conjunction with `affy` or `oligo` for low-level preprocessing, or `drosophila2.db` for high-level gene annotations.

## Reference documentation

- [drosophila2probe Reference Manual](./references/reference_manual.md)