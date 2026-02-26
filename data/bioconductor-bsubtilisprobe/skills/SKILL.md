---
name: bioconductor-bsubtilisprobe
description: This package provides probe sequence data and array coordinates for the Affymetrix Bacillus subtilis microarray. Use when user asks to access probe sequences, filter data by probe set name, or analyze probe-level properties for B. subtilis genomic studies.
homepage: https://bioconductor.org/packages/release/data/annotation/html/bsubtilisprobe.html
---


# bioconductor-bsubtilisprobe

name: bioconductor-bsubtilisprobe
description: Provides probe sequence data for the Affymetrix Bacillus subtilis (bsubtilis) microarray. Use this skill when you need to access, filter, or analyze specific probe sequences, coordinates (x, y), or target strandedness for B. subtilis genomic studies using Bioconductor.

# bioconductor-bsubtilisprobe

## Overview
The `bsubtilisprobe` package is a Bioconductor annotation data package containing the sequence information for the probes on the Affymetrix bsubtilis microarray. It is primarily used in conjunction with expression datasets to map probe-level intensities to specific genomic sequences or to validate probe properties.

## Loading and Accessing Data
The package contains a single primary data object: `bsubtilisprobe`.

```r
# Load the package
library(bsubtilisprobe)

# Load the probe data object
data(bsubtilisprobe)

# View the structure of the data
str(bsubtilisprobe)
```

## Data Format
The `bsubtilisprobe` object is a data frame with 100,229 rows and 6 columns:
- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate of the probe on the array (integer).
- `y`: The y-coordinate of the probe on the array (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The position within the target sequence (integer).
- `Target.Strandedness`: Whether the target is Sense or Antisense (factor).

## Common Workflows

### Inspecting Specific Probes
To view the first few probes in the dataset:
```r
head(bsubtilisprobe)
```

### Filtering by Probe Set
If you have a specific Affymetrix ID and want to retrieve all associated probe sequences:
```r
# Example: Filter for a specific probe set
target_probes <- subset(bsubtilisprobe, Probe.Set.Name == "BSU00010_at")
```

### Sequence Analysis
You can use the `sequence` column for downstream bioinformatics tasks, such as calculating GC content or checking for cross-hybridization:
```r
# Example: Get the sequence of the first 5 probes
probe_seqs <- bsubtilisprobe$sequence[1:5]
```

## Usage Tips
- **Memory Management**: The dataset is relatively large (over 100k rows). If you only need specific columns, subset the data frame early to save memory.
- **Integration**: This package is often used alongside the `affy` package. While `affy` handles the intensity data (CEL files), `bsubtilisprobe` provides the underlying sequence context for those intensities.

## Reference documentation
- [bsubtilisprobe Reference Manual](./references/reference_manual.md)