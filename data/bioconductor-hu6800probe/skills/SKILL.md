---
name: bioconductor-hu6800probe
description: This package provides probe sequence data and array coordinates for the Affymetrix hu6800 microarray platform. Use when user asks to map probe identifiers to sequences, retrieve array coordinates, or analyze interrogation positions for hu6800 chips.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hu6800probe.html
---

# bioconductor-hu6800probe

name: bioconductor-hu6800probe
description: Provides probe sequence data for Affymetrix hu6800 microarrays. Use this skill when needing to map Affymetrix probe identifiers to physical sequences, coordinates (x,y), or genomic interrogation positions for the hu6800 platform.

# bioconductor-hu6800probe

## Overview
The `hu6800probe` package is a Bioconductor annotation data package containing the sequence information for the probes on the Affymetrix hu6800 chip. It provides a standardized data frame mapping probe sets to their physical sequences and array coordinates, which is essential for custom pre-processing, sequence-specific analysis, or cross-platform mapping.

## Loading and Inspecting Data
To use the probe data, you must load the package and the specific dataset:

```r
# Load the library
library(hu6800probe)

# Load the data object
data(hu6800probe)

# Check the structure
str(hu6800probe)
```

## Data Structure
The `hu6800probe` object is a data frame with 131,541 rows and 6 columns:
- `sequence`: The actual nucleotide sequence (character).
- `x`: The x-coordinate on the array (integer).
- `y`: The y-coordinate on the array (integer).
- `Probe.Set.Name`: The Affymetrix ID for the probe set (character).
- `Probe.Interrogation.Position`: The position within the target sequence (integer).
- `Target.Strandedness`: Whether the target is sense or antisense (factor).

## Common Workflows

### Subsetting Probe Data
To view specific probes or a range of probes:
```r
# View the first 5 rows
head(hu6800probe, n = 5)

# Extract probes for a specific Probe Set
ps_name <- "A28102_at"
specific_probes <- hu6800probe[hu6800probe$Probe.Set.Name == ps_name, ]
```

### Sequence Analysis
You can use the sequence data for GC content calculation or other sequence-specific biases:
```r
# Example: Get sequences for the first 10 probes
probes_seqs <- hu6800probe$sequence[1:10]

# Convert to DNAStringSet if using Biostrings package
# library(Biostrings)
# dna_seqs <- DNAStringSet(hu6800probe$sequence)
```

### Integration with Expression Sets
If you have an ExpressionSet or probe-level intensities (e.g., from `affy`), you can use the `x` and `y` coordinates to map intensities back to their sequences.

## Tips
- The package is primarily a data container; it does not contain complex functions, only the `hu6800probe` data frame.
- Ensure your probe set IDs match the Affymetrix naming convention (e.g., ending in `_at` or `_s_at`).
- For large-scale operations, treat `hu6800probe` as a standard R data frame for filtering and merging.

## Reference documentation
- [hu6800probe Reference Manual](./references/reference_manual.md)