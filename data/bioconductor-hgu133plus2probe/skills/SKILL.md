---
name: bioconductor-hgu133plus2probe
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgu133plus2probe.html
---

# bioconductor-hgu133plus2probe

name: bioconductor-hgu133plus2probe
description: Access and utilize probe sequence data for the Affymetrix GeneChip Human Genome U133 Plus 2.0 microarray. Use this skill when you need to map probe sequences to coordinates (x, y), probe set names, or interrogation positions for hgu133plus2 arrays in R.

# bioconductor-hgu133plus2probe

## Overview
The `hgu133plus2probe` package is a Bioconductor annotation data package containing the sequence information for the probes on the Affymetrix HG-U133 Plus 2.0 array. This package is essential for low-level analysis of microarray data, such as GC-content based normalization (e.g., GCRMA) or re-annotating probe sets based on updated genome builds.

## Usage in R

### Loading the Data
The package contains a single primary data object of the same name.

```r
# Install the package if necessary
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("hgu133plus2probe")

# Load the library
library(hgu133plus2probe)

# Load the probe data frame
data(hgu133plus2probe)
```

### Data Structure
The `hgu133plus2probe` object is a data frame with over 600,000 rows. Each row represents a single probe.

Key columns include:
- `sequence`: The actual nucleotide sequence of the probe.
- `x` and `y`: The physical coordinates of the probe on the array.
- `Probe.Set.Name`: The Affymetrix ID (e.g., "200000_s_at").
- `Probe.Interrogation.Position`: The position within the target sequence.
- `Target.Strandedness`: Whether the target is sense or antisense.

### Common Workflows

#### Inspecting Probes for a Specific Gene/Probe Set
To extract all probes associated with a specific Affymetrix ID:

```r
# Example: Get probes for a specific probe set
ps_name <- "200000_s_at"
subset_probes <- hgu133plus2probe[hgu133plus2probe$Probe.Set.Name == ps_name, ]
print(subset_probes)
```

#### Converting to a Data Frame
While it loads as a data frame-like object, you can explicitly cast it for use with tidyverse or other tools:

```r
probes_df <- as.data.frame(hgu133plus2probe)
head(probes_df)
```

#### Calculating GC Content
A common task is calculating the GC content of probes for normalization:

```r
# Simple function to calculate GC content
get_gc <- function(seqs) {
  n_gc <- nchar(gsub("[AT]", "", seqs))
  return(n_gc / nchar(seqs))
}

# Apply to the first 10 probes
hgu133plus2probe$gc_content <- get_gc(hgu133plus2probe$sequence[1:10])
```

## Tips
- **Memory Management**: This data frame is large. Avoid making multiple copies of the full object in memory.
- **Matching with Expression Sets**: The `Probe.Set.Name` column matches the `featureNames` found in `ExpressionSet` objects (from `affy` or `limma`) that use the HG-U133 Plus 2.0 platform.
- **Coordinate Mapping**: The `x` and `y` coordinates are zero-indexed and correspond to the locations used in CEL files.

## Reference documentation
- [hgu133plus2probe Reference Manual](./references/reference_manual.md)