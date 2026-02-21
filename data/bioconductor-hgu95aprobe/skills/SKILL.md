---
name: bioconductor-hgu95aprobe
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgu95aprobe.html
---

# bioconductor-hgu95aprobe

name: bioconductor-hgu95aprobe
description: Access and use probe sequence data for the Affymetrix Human Genome U95A (hgu95a) microarray. Use this skill when you need to map Affymetrix probe identifiers to genomic sequences, coordinates (x, y) on the array, or interrogation positions for the HGU95A platform.

# bioconductor-hgu95aprobe

## Overview
The `hgu95aprobe` package is a Bioconductor annotation data package containing the sequence information for the probes on the Affymetrix HGU95A microarray. Unlike standard annotation packages that map probes to Genes (like `hgu95a.db`), this package provides the actual 25-mer oligonucleotide sequences and their physical location on the chip.

## Usage and Workflows

### Loading the Data
The package contains a single data object also named `hgu95aprobe`.

```r
# Install if necessary
# BiocManager::install("hgu95aprobe")

# Load the library
library(hgu95aprobe)

# Load the data object into the workspace
data(hgu95aprobe)
```

### Data Structure
The `hgu95aprobe` object is a data frame. You can inspect its structure using standard R functions:

```r
# View the first few rows
head(hgu95aprobe)

# Check column names and types
str(hgu95aprobe)
```

The data frame contains the following columns:
- `sequence`: The actual 25-mer probe sequence (character).
- `x`: The x-coordinate of the probe on the array (integer).
- `y`: The y-coordinate of the probe on the array (integer).
- `Probe.Set.Name`: The Affymetrix ID (e.g., "100_at") (character).
- `Probe.Interrogation.Position`: The position of the interrogation base (integer).
- `Target.Strandedness`: Whether the target is Sense or Antisense (factor).

### Common Operations

**Filtering by Probe Set**
To extract all probe sequences associated with a specific Affymetrix ID:

```r
# Get sequences for a specific probe set
my_probes <- subset(hgu95aprobe, Probe.Set.Name == "100_at")
```

**Converting to Biostrings**
For sequence analysis, it is often useful to convert the character sequences into a `DNAStringSet` from the `Biostrings` package:

```r
library(Biostrings)
probe_sequences <- DNAStringSet(hgu95aprobe$sequence)
names(probe_sequences) <- hgu95aprobe$Probe.Set.Name
```

## Tips
- **Memory Management**: This data frame has over 200,000 rows. While manageable on modern systems, avoid making multiple unnecessary copies of the full object.
- **Coordinate Mapping**: The `x` and `y` coordinates are useful for identifying spatial artifacts on the microarray chips when combined with raw intensity data (CEL files).
- **Annotation Matching**: Use this package in conjunction with `hgu95a.db` if you need to link specific probe sequences to Entrez Gene IDs or Symbol names.

## Reference documentation
- [hgu95aprobe Reference Manual](./references/reference_manual.md)