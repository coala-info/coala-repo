---
name: bioconductor-ecoliprobe
description: This package provides probe sequence data and physical coordinates for Affymetrix E. coli microarrays. Use when user asks to access probe sequences, map probes to array coordinates, or analyze sequence-level information for E. coli genomic studies.
homepage: https://bioconductor.org/packages/release/data/annotation/html/ecoliprobe.html
---


# bioconductor-ecoliprobe

name: bioconductor-ecoliprobe
description: Provides probe sequence data for Affymetrix E. coli microarrays. Use this skill when you need to access, filter, or analyze specific probe sequences, coordinates (x, y), or interrogation positions for E. coli genomic studies using Bioconductor.

# bioconductor-ecoliprobe

## Overview
The `ecoliprobe` package is an annotation data package providing sequence-level information for Affymetrix E. coli microarrays. It contains a single primary data object, `ecoliprobe`, which maps probe sequences to their physical locations on the array and their corresponding probe sets. This is essential for low-level analysis, such as calculating GC content, melting temperatures, or re-mapping probes to updated genome assemblies.

## Usage and Workflows

### Loading the Data
To use the probe data, you must first load the package and then call the `data()` function to make the object available in your R environment.

```r
library(ecoliprobe)
data(ecoliprobe)
```

### Data Structure
The `ecoliprobe` object is a data frame. You can inspect its structure using standard R commands:

```r
# View the first few rows
head(ecoliprobe)

# Check column names and types
str(ecoliprobe)
```

The data frame contains the following columns:
- `sequence`: The actual DNA sequence of the probe (character).
- `x` and `y`: The integer coordinates of the probe on the microarray chip.
- `Probe.Set.Name`: The Affymetrix identifier for the gene or transcript being targeted.
- `Probe.Interrogation.Position`: The nucleotide position within the target sequence.
- `Target.Strandedness`: Whether the probe targets the sense or antisense strand.

### Common Operations

**Filtering by Probe Set**
To extract all probes associated with a specific gene or probe set:
```r
# Example: Get probes for a specific ID
subset_probes <- ecoliprobe[ecoliprobe$Probe.Set.Name == "1000_at", ]
```

**Analyzing Sequence Composition**
Since the sequences are provided as characters, you can use them with other Bioconductor tools like `Biostrings`:
```r
library(Biostrings)
# Convert to DNAStringSet for analysis
dna_probes <- DNAStringSet(ecoliprobe$sequence)

# Calculate GC content
gc_content <- letterFrequency(dna_probes, letters="GC", as.prob=TRUE)
```

**Spatial Mapping**
You can use the `x` and `y` coordinates to visualize probe intensity distributions or check for spatial artifacts on the array.

## Tips
- **Memory Management**: The `ecoliprobe` data frame has over 140,000 rows. While manageable on most modern systems, use indexing (e.g., `ecoliprobe[1:10, ]`) when first exploring the data to avoid flooding the console.
- **Integration**: This package is typically used in conjunction with the `affy` package or `AnnotationDbi` for comprehensive microarray analysis.

## Reference documentation
- [ecoliprobe Reference Manual](./references/reference_manual.md)