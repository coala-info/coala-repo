---
name: bioconductor-bsgenome.dvirilis.ensembl.dvircaf1
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Dvirilis.Ensembl.dvircaf1.html
---

# bioconductor-bsgenome.dvirilis.ensembl.dvircaf1

name: bioconductor-bsgenome.dvirilis.ensembl.dvircaf1
description: Provides access to the full genome sequences for Drosophila virilis (assembly dvir_caf1, GenBank GCA_000005245.1) as provided by Ensembl. Use this skill when performing genomic analysis in R that requires the D. virilis reference genome, such as sequence extraction, motif searching, or coordinate-based lookups.

# bioconductor-bsgenome.dvirilis.ensembl.dvircaf1

## Overview

This package is a Bioconductor data resonance (BSgenome) object containing the complete genome sequence for *Drosophila virilis*. It uses the `dvir_caf1` assembly from Ensembl. The data is stored in `Biostrings` formats, allowing for efficient sequence manipulation and genome-wide calculations.

## Loading and Basic Usage

To use the genome in an R session, load the library and assign the provider object to a variable:

```r
library(BSgenome.Dvirilis.Ensembl.dvircaf1)

# Access the genome object
genome <- BSgenome.Dvirilis.Ensembl.dvircaf1

# View metadata
genome
```

## Common Workflows

### Sequence Inspection
Check chromosome/scaffold names and lengths:

```r
seqnames(genome)
seqlengths(genome)

# Access a specific scaffold (e.g., scaffold_13049)
genome$scaffold_13049
# Or using the double bracket notation
genome[["scaffold_13049"]]
```

### Extracting Subsequences
Use `getSeq` to extract specific regions based on coordinates:

```r
# Extract a specific region
my_region <- getSeq(genome, names="scaffold_13049", start=1, end=100)
```

### Genome-wide Motif Searching
The genome object can be used with `matchPattern` or `vmatchPattern` from the `Biostrings` package to find specific DNA motifs:

```r
library(Biostrings)

# Define a motif
motif <- DNAString("TATAAA")

# Search across the entire genome
matches <- vmatchPattern(motif, genome)
```

## Tips for Efficient Use
- **Memory Management**: BSgenome objects use "on-disk" loading (via 2bit files) or caching. Accessing specific scaffolds is memory efficient, but loading the entire genome into a single object may require significant RAM.
- **Coordinate Systems**: Ensure your coordinates match the Ensembl `dvir_caf1` assembly.
- **Integration**: This package integrates seamlessly with `GenomicRanges` for overlap analysis and `Gviz` for visualization.

## Reference documentation
- [BSgenome.Dvirilis.Ensembl.dvircaf1 Reference Manual](./references/reference_manual.md)