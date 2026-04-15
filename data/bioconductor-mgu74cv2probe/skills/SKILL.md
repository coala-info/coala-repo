---
name: bioconductor-mgu74cv2probe
description: This package provides probe sequence data and chip coordinates for the Affymetrix MG-U74Cv2 microarray. Use when user asks to retrieve probe sequences, identify spatial coordinates on the chip, or map probes to their corresponding probe set names for the mgu74cv2 platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mgu74cv2probe.html
---

# bioconductor-mgu74cv2probe

name: bioconductor-mgu74cv2probe
description: Access and use probe sequence data for the Affymetrix MG-U74Cv2 microarray. Use this skill when you need to retrieve specific probe sequences, coordinates (x,y), probe set names, or interrogation positions for the mgu74cv2 platform in R.

# bioconductor-mgu74cv2probe

## Overview
The `mgu74cv2probe` package is a Bioconductor annotation data package containing the probe sequences for the Affymetrix MG-U74Cv2 mouse genome array. It provides a data frame mapping individual probes to their sequences, spatial coordinates on the chip, and their corresponding probe sets.

## Loading and Accessing Data
To use the probe data, you must first load the package and the dataset:

```r
# Load the package
library(mgu74cv2probe)

# Load the probe data object
data(mgu74cv2probe)

# View the structure of the data
str(mgu74cv2probe)
```

## Data Structure
The `mgu74cv2probe` object is a data frame with 182,797 rows and 6 columns:
- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate of the probe on the array (integer).
- `y`: The y-coordinate of the probe on the array (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the gene/transcript cluster (character).
- `Probe.Interrogation.Position`: The nucleotide position within the target sequence (integer).
- `Target.Strandedness`: Whether the probe targets the Sense or Antisense strand (factor).

## Common Workflows

### Filtering by Probe Set
To extract all probes associated with a specific Affymetrix ID:

```r
# Example: Get probes for a specific probe set
ps_probes <- subset(mgu74cv2probe, Probe.Set.Name == "1000_at")
```

### Sequence Analysis
To perform operations on the sequences, such as calculating GC content:

```r
# Calculate GC content for the first 10 probes
library(Biostrings)
probes_sample <- mgu74cv2probe$sequence[1:10]
gc_content <- letterFrequency(DNAStringSet(probes_sample), letters="GC", as.prob=TRUE)
```

### Spatial Mapping
The `x` and `y` columns can be used to identify the physical location of probes on the microarray surface, which is useful for detecting spatial artifacts during quality control.

## Tips
- This package is primarily a data container. For mapping probe sets to gene symbols or GO terms, use the corresponding chip annotation package `mgu74cv2.db`.
- Because the data frame is large, always use `head()` or indexing when inspecting the object to avoid flooding the console.

## Reference documentation
- [mgu74cv2probe Reference Manual](./references/reference_manual.md)