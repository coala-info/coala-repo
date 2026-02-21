---
name: bioconductor-hu35ksubaprobe
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hu35ksubaprobe.html
---

# bioconductor-hu35ksubaprobe

name: bioconductor-hu35ksubaprobe
description: Provides probe sequence data for the Affymetrix hu35ksuba microarray. Use this skill when needing to map Affymetrix probe identifiers to physical sequences, coordinates (x, y), or genomic interrogation positions for the hu35ksuba chip type.

# bioconductor-hu35ksubaprobe

## Overview
The `hu35ksubaprobe` package is a Bioconductor annotation package containing the sequence information for the probes on the Affymetrix hu35ksuba array. This data is essential for workflows involving sequence-specific analysis, such as calculating GC content, identifying potential cross-hybridization, or re-mapping probes to updated genome builds.

## Usage and Workflows

### Loading the Probe Data
The package contains a single primary data object also named `hu35ksubaprobe`.

```r
# Load the library
library(hu35ksubaprobe)

# Load the data frame into the environment
data(hu35ksubaprobe)

# View the structure
str(hu35ksubaprobe)
```

### Data Structure
The `hu35ksubaprobe` object is a data frame with 140,010 rows and 6 columns:
- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate of the probe on the array (integer).
- `y`: The y-coordinate of the probe on the array (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The position within the target sequence (integer).
- `Target.Strandedness`: Whether the target is sense or antisense (factor).

### Common Operations

**Filtering by Probe Set:**
To extract all probes associated with a specific Affymetrix ID:
```r
subset_probes <- subset(hu35ksubaprobe, Probe.Set.Name == "1000_at")
```

**Converting to Biostrings:**
For sequence analysis, it is often useful to convert the character sequences into a `DNAStringSet`:
```r
library(Biostrings)
probe_sequences <- DNAStringSet(hu35ksubaprobe$sequence)
names(probe_sequences) <- hu35ksubaprobe$Probe.Set.Name
```

**Accessing specific rows:**
```r
# View the first 5 probes
head(hu35ksubaprobe, n = 5)
```

## Tips
- This package is a "probe" package, which differs from "cdf" or "db" annotation packages. It focuses strictly on the physical sequences and array coordinates.
- Ensure you have `AnnotationForge` installed if you intend to rebuild or modify these types of annotation objects.
- The coordinates (x, y) are zero-indexed, which is standard for Affymetrix array geometry.

## Reference documentation
- [hu35ksubaprobe Reference Manual](./references/reference_manual.md)