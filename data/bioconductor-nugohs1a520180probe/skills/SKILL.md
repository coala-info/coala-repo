---
name: bioconductor-nugohs1a520180probe
description: This package provides probe sequence data for the Affymetrix nugohs1a520180 microarray platform. Use when user asks to map probe sequences to physical coordinates, retrieve probe set names, calculate GC content for normalization, or perform low-level microarray analysis.
homepage: https://bioconductor.org/packages/release/data/annotation/html/nugohs1a520180probe.html
---

# bioconductor-nugohs1a520180probe

name: bioconductor-nugohs1a520180probe
description: Provides probe sequence data for the Affymetrix nugohs1a520180 microarray platform. Use this skill when you need to map probe sequences to their physical coordinates (x, y), probe set names, interrogation positions, or target strandedness for genomic analysis in R.

# bioconductor-nugohs1a520180probe

## Overview

The `nugohs1a520180probe` package is a Bioconductor annotation data package containing the probe sequences for the nugohs1a520180 microarray. This package is essential for low-level analysis of microarray data, such as GC-content normalization, background correction, or re-mapping probes to updated genome assemblies.

## Loading and Inspecting Data

The primary data object is a data frame named `nugohs1a520180probe`.

```R
# Load the package
library(nugohs1a520180probe)

# Load the probe data object
data(nugohs1a520180probe)

# View the structure of the data
str(nugohs1a520180probe)

# Preview the first few rows
head(nugohs1a520180probe)
```

## Data Structure

The `nugohs1a520180probe` data frame contains 265,687 rows and 6 columns:

- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate of the probe on the array (integer).
- `y`: The y-coordinate of the probe on the array (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The nucleotide position within the target sequence (integer).
- `Target.Strandedness`: Whether the target is Sense or Antisense (factor).

## Common Workflows

### Filtering by Probe Set
To extract all probe sequences associated with a specific Probe Set ID:

```R
# Example: Get probes for a specific set
ps_name <- "some_probe_set_id"
subset_probes <- nugohs1a520180probe[nugohs1a520180probe$Probe.Set.Name == ps_name, ]
```

### Calculating GC Content
If you need to calculate the GC content of the probes for normalization:

```R
library(Biostrings)
sequences <- DNAStringSet(nugohs1a520180probe$sequence)
gc_content <- letterFrequency(sequences, letters="GC", as.prob=TRUE)
nugohs1a520180probe$gc_content <- gc_content
```

### Mapping to Coordinates
To find the sequence at a specific physical location on the chip:

```R
# Find probe at x=100, y=200
target_probe <- subset(nugohs1a520180probe, x == 100 & y == 200)
```

## Usage Tips
- This package is a "data-only" package. It does not contain functions, only the `nugohs1a520180probe` data frame.
- Ensure you are using this package with the correct microarray platform (nugohs1a520180). Using it with data from other chips will result in incorrect mappings.
- For higher-level annotations (like gene symbols or GO terms), use the corresponding annotation package (e.g., `nugohs1a520180.db`).

## Reference documentation

- [nugohs1a520180probe Reference Manual](./references/reference_manual.md)