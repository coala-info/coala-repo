---
name: bioconductor-mouse430a2probe
description: This package provides probe sequence data and array coordinates for the Affymetrix Mouse Genome 430A 2.0 Array. Use when user asks to retrieve nucleotide sequences for mouse430a2 probes, map probe identifiers to physical array positions, or perform sequence-level analysis for this specific microarray platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mouse430a2probe.html
---

# bioconductor-mouse430a2probe

name: bioconductor-mouse430a2probe
description: Provides probe sequence data for the Affymetrix Mouse Genome 430A 2.0 Array (mouse430a2). Use this skill when you need to map Affymetrix probe identifiers to physical sequences, coordinates (x, y), or interrogation positions for mouse genomic studies.

# bioconductor-mouse430a2probe

## Overview

The `mouse430a2probe` package is a Bioconductor annotation data package containing the sequence information for the probes on the Affymetrix mouse430a2 microarray platform. This package is essential for researchers performing sequence-level analysis, such as checking for off-target effects, re-annotating probe sets, or calculating GC content for normalization.

## Loading and Accessing Data

The primary data object in this package is a data frame also named `mouse430a2probe`.

```r
# Install the package if necessary
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("mouse430a2probe")

# Load the library
library(mouse430a2probe)

# Load the probe data object
data(mouse430a2probe)

# View the structure of the data
str(mouse430a2probe)
```

## Data Structure

The `mouse430a2probe` object is a data frame with 249,958 rows and 6 columns:

- `sequence`: The actual nucleotide sequence (character).
- `x`: The x-coordinate of the probe on the array (integer).
- `y`: The y-coordinate of the probe on the array (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The nucleotide position within the target sequence (integer).
- `Target.Strandedness`: Whether the target is Sense or Antisense (factor).

## Common Workflows

### Extracting Sequences for a Specific Probe Set

To retrieve all probe sequences associated with a specific Affymetrix ID:

```r
# Example: Get sequences for a specific probe set
ps_name <- "1415670_at"
subset_probes <- mouse430a2probe[mouse430a2probe$Probe.Set.Name == ps_name, ]
print(subset_probes)
```

### Converting to a Biostrings Object

For advanced sequence analysis (like calculating melting temperature or searching for motifs), convert the sequences to a `DNAStringSet`:

```r
library(Biostrings)
dna_seqs <- DNAStringSet(mouse430a2probe$sequence)
names(dna_seqs) <- mouse430a2probe$Probe.Set.Name
```

### Basic Data Exploration

```r
# View the first few rows
head(mouse430a2probe)

# Count number of probes per probe set
table(head(mouse430a2probe$Probe.Set.Name))
```

## Usage Tips
- This package is a "data-only" package. It does not contain functions for analysis, only the `mouse430a2probe` data frame.
- Ensure the microarray platform used in your experiment is exactly "Mouse Genome 430A 2.0". This is distinct from the "Mouse Genome 430 2.0" (which uses the `mouse4302probe` package).

## Reference documentation

- [mouse430a2probe Reference Manual](./references/reference_manual.md)