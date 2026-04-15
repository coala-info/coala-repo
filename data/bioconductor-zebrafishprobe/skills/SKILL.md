---
name: bioconductor-zebrafishprobe
description: This package provides probe sequence and location data for Affymetrix zebrafish microarrays. Use when user asks to retrieve probe sequences, find x/y coordinates on a zebrafish array, or access probe set information for low-level microarray analysis.
homepage: https://bioconductor.org/packages/release/data/annotation/html/zebrafishprobe.html
---

# bioconductor-zebrafishprobe

name: bioconductor-zebrafishprobe
description: Access and use the zebrafishprobe annotation data package for Affymetrix zebrafish microarrays. Use this skill when you need to retrieve probe sequences, x/y coordinates, or probe set information for zebrafish genomic studies using Bioconductor.

# bioconductor-zebrafishprobe

## Overview
The `zebrafishprobe` package is a Bioconductor annotation data package containing the probe sequence information for microarrays of type "zebrafish". It provides a mapping between probe sequences, their physical location on the array (x and y coordinates), the associated Affymetrix Probe Set Name, the interrogation position, and the target strandedness. This data is essential for low-level microarray analysis, such as calculating GC content or performing custom probe-level re-annotations.

## Usage and Workflows

### Loading the Data
The package contains a single primary data object named `zebrafishprobe`. To use it, you must load the library and then use the `data()` function.

```r
# Load the package
library(zebrafishprobe)

# Load the probe data object
data(zebrafishprobe)
```

### Data Structure
The `zebrafishprobe` object is a data frame. You can inspect its structure using standard R functions:

```r
# View the first few rows
head(zebrafishprobe)

# Check the dimensions (typically 249,752 rows and 6 columns)
dim(zebrafishprobe)

# View column names
colnames(zebrafishprobe)
```

The data frame contains the following columns:
- `sequence`: The nucleotide sequence of the probe (character).
- `x`: The x-coordinate on the array (integer).
- `y`: The y-coordinate on the array (integer).
- `Probe.Set.Name`: The Affymetrix Probe Set Name (character).
- `Probe.Interrogation.Position`: The position of the probe (integer).
- `Target.Strandedness`: The strandedness of the target (factor).

### Common Operations

**Filtering by Probe Set**
To extract all probes associated with a specific Affymetrix ID:
```r
# Example: Filter for a specific probe set
specific_probes <- zebrafishprobe[zebrafishprobe$Probe.Set.Name == "Dr.1.1.S1_at", ]
```

**Analyzing Sequence Composition**
Since the sequences are provided as characters, you can use them with other Bioconductor tools like `Biostrings` to calculate properties like GC content:
```r
library(Biostrings)
# Convert to DNAStringSet
dna_seqs <- DNAStringSet(zebrafishprobe$sequence[1:100])
# Calculate GC content
letterFrequency(dna_seqs, letters="GC", as.prob=TRUE)
```

## Tips
- The `zebrafishprobe` object is quite large (nearly 250,000 rows). When exploring the data, always use `head()` or indexing (e.g., `zebrafishprobe[1:5, ]`) to avoid flooding the console.
- This package is specifically for the Affymetrix Zebrafish Genome Array. Ensure your experimental data matches this platform before using these annotations.
- For higher-level annotations (like mapping probe sets to Gene Symbols or Entrez IDs), use the `zebrafish.db` package instead.

## Reference documentation
- [zebrafishprobe Reference Manual](./references/reference_manual.md)