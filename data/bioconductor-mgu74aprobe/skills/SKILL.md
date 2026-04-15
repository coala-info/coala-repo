---
name: bioconductor-mgu74aprobe
description: This package provides probe sequence data and spatial coordinates for the Affymetrix MG-U74A murine genome microarray. Use when user asks to access probe sequences, retrieve probe coordinates, or perform sequence-specific analysis for the mgu74a platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mgu74aprobe.html
---

# bioconductor-mgu74aprobe

name: bioconductor-mgu74aprobe
description: Provides probe sequence data for the Affymetrix MG-U74A (Murine Genome U74A) microarray. Use this skill when you need to access, analyze, or map specific probe sequences, coordinates (x,y), or interrogation positions for the mgu74a platform in R.

# bioconductor-mgu74aprobe

## Overview
The `mgu74aprobe` package is a Bioconductor annotation data package containing the sequence information for the probes on the Affymetrix MG-U74A murine genome array. This package is essential for sequence-specific analysis of microarray data, such as calculating GC content, performing custom background corrections, or re-mapping probes to updated genome assemblies.

## Loading and Accessing Data
The package contains a single primary data object also named `mgu74aprobe`.

```r
# Install the package if necessary
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("mgu74aprobe")

# Load the package
library(mgu74aprobe)

# Load the probe data object
data(mgu74aprobe)

# View the structure
str(mgu74aprobe)
```

## Data Structure
The `mgu74aprobe` object is a data frame with the following columns:
- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate of the probe on the array (integer).
- `y`: The y-coordinate of the probe on the array (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the gene/transcript cluster (character).
- `Probe.Interrogation.Position`: The nucleotide position within the target sequence (integer).
- `Target.Strandedness`: Whether the probe targets the Sense or Antisense strand (factor).

## Common Workflows

### Subsetting and Inspection
To look at specific probes for a known Probe Set:
```r
# Get all probes for a specific Probe Set
target_probes <- mgu74aprobe[mgu74aprobe$Probe.Set.Name == "1000_at", ]
print(target_probes)
```

### Sequence Analysis
To perform basic sequence analysis, such as calculating the length or GC content:
```r
# Example: Calculate sequence lengths (typically 25bp for Affymetrix)
table(nchar(mgu74aprobe$sequence))

# Example: Simple GC content calculation for the first 10 probes
probes_sample <- mgu74aprobe$sequence[1:10]
gc_content <- sapply(probes_sample, function(seq) {
  sum(gregexpr("[GC]", seq)[[1]] > 0) / nchar(seq)
})
```

### Integration with Biostrings
For more advanced sequence manipulation, convert the data to a `DNAStringSet`:
```r
library(Biostrings)
probe_sequences <- DNAStringSet(mgu74aprobe$sequence)
names(probe_sequences) <- mgu74aprobe$Probe.Set.Name
# Now you can use Biostrings functions like letterFrequency or matchPDict
```

## Tips
- The `mgu74aprobe` object is large (over 200,000 rows). When inspecting it, always use `head()` or indexing (e.g., `mgu74aprobe[1:5, ]`) to avoid flooding the console.
- This package provides *probe-level* information. For *gene-level* annotations (symbols, GO terms, etc.), use the corresponding annotation package `mgu74a.db`.

## Reference documentation
- [mgu74aprobe Reference Manual](./references/reference_manual.md)