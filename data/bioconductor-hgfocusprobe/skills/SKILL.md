---
name: bioconductor-hgfocusprobe
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgfocusprobe.html
---

# bioconductor-hgfocusprobe

## Overview
The `hgfocusprobe` package is a Bioconductor annotation data package containing the sequence information for the probes on the Affymetrix HG-Focus human genome array. It provides a standardized data frame mapping probe sequences to their (x,y) coordinates on the chip and their corresponding Affymetrix Probe Set IDs.

## Loading and Inspecting Data
The package contains a single primary data object: `hgfocusprobe`.

```r
# Load the package
library(hgfocusprobe)

# Load the probe data object
data(hgfocusprobe)

# View the structure of the data
str(hgfocusprobe)

# View the first few rows
head(hgfocusprobe)
```

## Data Structure
The `hgfocusprobe` object is a data frame with 98,149 rows and 6 columns:
- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate of the probe on the microarray (integer).
- `y`: The y-coordinate of the probe on the microarray (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The position of the interrogated base in the target sequence (integer).
- `Target.Strandedness`: Whether the target is sense or antisense (factor).

## Common Workflows

### Filtering by Probe Set
To extract all probes associated with a specific Affymetrix ID:
```r
# Example: Get probes for a specific Probe Set
ps_probes <- hgfocusprobe[hgfocusprobe$Probe.Set.Name == "200000_s_at", ]
```

### Sequence Analysis
You can use this data to perform GC content analysis or sequence-specific background correction:
```r
# Calculate sequence length (should be 25 for Affymetrix)
table(nchar(hgfocusprobe$sequence))

# Convert to Biostrings for advanced analysis
if (requireNamespace("Biostrings", quietly = TRUE)) {
    dna_seqs <- Biostrings::DNAStringSet(hgfocusprobe$sequence)
    gc_content <- Biostrings::letterFrequency(dna_seqs, letters = "GC", as.prob = TRUE)
}
```

### Integration with Expression Sets
This package is often used in conjunction with `affy` or `oligo` packages when performing probe-level models (PLM) or custom chip definition file (CDF) analysis.

## Usage Tips
- This is a static data package. It does not contain functions, only the `hgfocusprobe` data frame.
- Ensure the version of this package matches the array type used in your experiment (HG-Focus).
- For mapping probes to updated genomic coordinates, consider using this sequence data as input for alignment tools like BLAT or Bowtie.

## Reference documentation
- [hgfocusprobe Reference Manual](./references/reference_manual.md)