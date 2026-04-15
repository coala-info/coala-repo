---
name: bioconductor-xlaevis2probe
description: This package provides probe sequence data for the Affymetrix Xenopus laevis 2 microarray. Use when user asks to retrieve probe sequences, calculate GC content for normalization, or map probes to coordinates for the Xenopus laevis 2 platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/xlaevis2probe.html
---

# bioconductor-xlaevis2probe

## Overview
The `xlaevis2probe` package is a Bioconductor annotation data package containing the sequence information for the probes on the Affymetrix Xenopus laevis 2 microarray. This data is essential for low-level analysis tasks such as calculating GC content for normalization, checking probe specificity, or re-mapping probes to updated genome assemblies.

## Usage in R

### Loading the Data
The package contains a single primary data object named `xlaevis2probe`.

```r
# Load the library
library(xlaevis2probe)

# Load the probe data object
data(xlaevis2probe)
```

### Data Structure
The `xlaevis2probe` object is a data frame. You can inspect its structure using standard R functions:

```r
# View the first few rows
head(xlaevis2probe)

# Check column names and types
str(xlaevis2probe)
```

The data frame contains the following columns:
- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate of the probe on the array (integer).
- `y`: The y-coordinate of the probe on the array (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The position of the interrogation nucleotide (integer).
- `Target.Strandedness`: The orientation of the target relative to the probe (factor).

### Common Workflows

#### Filtering by Probe Set
To extract all probes associated with a specific Affymetrix ID:

```r
# Example: Get probes for a specific set
ps_name <- "154321_at" # Example ID
subset_probes <- xlaevis2probe[xlaevis2probe$Probe.Set.Name == ps_name, ]
```

#### Calculating Sequence Statistics
You can use the `Biostrings` package in conjunction with this data to calculate properties like GC content:

```r
library(Biostrings)

# Convert sequences to DNAStringSet
dna_seqs <- DNAStringSet(xlaevis2probe$sequence)

# Calculate GC content
gc_content <- letterFrequency(dna_seqs, letters = "GC", as.prob = TRUE)

# Add back to the data frame
xlaevis2probe$gc <- gc_content
```

#### Mapping to Coordinates
The `x` and `y` columns are used to link sequence data to raw intensity data (CEL files) when performing spatial analysis or custom background corrections.

## Reference documentation
- [xlaevis2probe Reference Manual](./references/reference_manual.md)