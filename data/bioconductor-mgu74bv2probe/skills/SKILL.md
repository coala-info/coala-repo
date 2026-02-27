---
name: bioconductor-mgu74bv2probe
description: This package provides nucleotide sequence data and chip coordinates for probes on the Affymetrix MG-U74Bv2 microarray. Use when user asks to access probe sequences, map probe identifiers to physical coordinates, or analyze interrogation positions for the Murine Genome U74Bv2 array.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mgu74bv2probe.html
---


# bioconductor-mgu74bv2probe

name: bioconductor-mgu74bv2probe
description: Access and use probe sequence data for the Affymetrix MG-U74Bv2 microarray. Use this skill when needing to map Affymetrix probe identifiers to physical sequences, coordinates (x,y), or interrogation positions for Murine Genome U74Bv2 chips.

# bioconductor-mgu74bv2probe

## Overview

The `mgu74bv2probe` package is a Bioconductor annotation data package containing the sequence information for the probes on the Affymetrix MG-U74Bv2 array. Unlike standard annotation packages that map probes to genes, this package provides the actual nucleotide sequences and their physical locations on the microarray chip.

## Installation and Loading

To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("mgu74bv2probe")
library(mgu74bv2probe)
```

## Data Structure

The primary object in this package is a data frame also named `mgu74bv2probe`. 

### Loading the Data
```r
data(mgu74bv2probe)
```

### Column Definitions
The data frame contains 197,131 rows and 6 columns:
- **sequence**: The actual nucleotide sequence (character).
- **x**: The x-coordinate on the array (integer).
- **y**: The y-coordinate on the array (integer).
- **Probe.Set.Name**: The Affymetrix ID for the probe set (character).
- **Probe.Interrogation.Position**: The position of the interrogation base in the target sequence (integer).
- **Target.Strandedness**: Whether the target is Sense or Antisense (factor).

## Common Workflows

### 1. Inspecting Probe Data
To view the first few entries of the probe data:
```r
head(mgu74bv2probe)
```

### 2. Filtering by Probe Set
To extract all probe sequences associated with a specific Affymetrix Probe Set ID:
```r
# Example for a specific probe set
ps_name <- "1000_at"
probes_for_set <- subset(mgu74bv2probe, Probe.Set.Name == ps_name)
```

### 3. Sequence Analysis
You can use this data to perform GC content analysis or sequence motifs searches across the array:
```r
# Calculate sequence length (should be 25 for Affymetrix)
table(nchar(mgu74bv2probe$sequence))

# Find probes containing a specific motif
motif_probes <- mgu74bv2probe[grep("TATA", mgu74bv2probe$sequence), ]
```

### 4. Integration with Biostrings
For advanced sequence manipulation, convert the sequences to a `DNAStringSet`:
```r
library(Biostrings)
probe_sequences <- DNAStringSet(mgu74bv2probe$sequence)
names(probe_sequences) <- mgu74bv2probe$Probe.Set.Name
```

## Usage Tips
- **Memory**: The `mgu74bv2probe` object is a large data frame. If memory is an issue, subset the data to only the columns or rows required for your specific analysis.
- **Coordinates**: The `x` and `y` coordinates are useful for identifying spatial artifacts on the microarray chip (e.g., using the `affy` package's plotting functions).
- **Version Consistency**: Ensure that the version of the probe package matches the version of the CDF (Chip Definition File) package you are using for your analysis to maintain consistent mapping.

## Reference documentation

- [mgu74bv2probe Reference Manual](./references/reference_manual.md)