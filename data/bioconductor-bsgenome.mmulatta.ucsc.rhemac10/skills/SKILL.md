---
name: bioconductor-bsgenome.mmulatta.ucsc.rhemac10
description: This package provides the full genome sequences for Macaca mulatta based on the UCSC rheMac10 assembly. Use when user asks to access the Rhesus macaque reference genome, extract DNA sequences, search for motifs, or perform coordinate-based genomic lookups in R.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Mmulatta.UCSC.rheMac10.html
---


# bioconductor-bsgenome.mmulatta.ucsc.rhemac10

name: bioconductor-bsgenome.mmulatta.ucsc.rhemac10
description: Provides full genome sequences for Macaca mulatta (Rhesus monkey) based on the UCSC rheMac10 assembly (Feb. 2019). Use this skill when performing genomic analysis in R that requires access to the Rhesus macaque reference genome, including sequence extraction, motif searching, and coordinate-based lookups using Biostrings and BSgenome frameworks.

# bioconductor-bsgenome.mmulatta.ucsc.rhemac10

## Overview

The `BSgenome.Mmulatta.UCSC.rheMac10` package is a data-rich Bioconductor annotation package containing the complete genome sequence for *Macaca mulatta*. The sequences are stored as `Biostrings` objects, allowing for efficient manipulation and analysis of large-scale genomic data. This package is essential for bioinformatics workflows involving Rhesus macaque, such as alignment visualization, SNP analysis, or regulatory element identification.

## Getting Started

To use this package, it must be loaded into the R session. The genome object is typically assigned to a variable for easier access.

```r
library(BSgenome.Mmulatta.UCSC.rheMac10)

# Assign the genome object to a shorter variable name
genome <- BSgenome.Mmulatta.UCSC.rheMac10
```

## Common Workflows

### Exploring Genome Metadata
Check the available chromosomes (sequences) and their respective lengths.

```r
# List all sequences (chromosomes, scaffolds, etc.)
seqnames(genome)

# Get lengths of all sequences
seqlengths(genome)

# View the first few sequence lengths
head(seqlengths(genome))
```

### Accessing Specific Sequences
You can retrieve the DNA sequence for a specific chromosome using either the `$` operator or double brackets `[[ ]]`.

```r
# Access chromosome 1
chr1_seq <- genome$chr1

# Alternative access method
chr1_seq <- genome[["chr1"]]

# View a summary of the DNAString object
chr1_seq
```

### Sequence Extraction
Extract specific sub-sequences using coordinates. This is useful for analyzing promoters or specific genomic features.

```r
library(Biostrings)

# Extract a specific region from chromosome 1 (e.g., first 100 nucleotides)
sub_seq <- getSeq(genome, "chr1", start=1, end=100)
```

### Genome-wide Motif Searching
The package integrates with `Biostrings` for pattern matching across the entire genome.

```r
# Example: Searching for a specific DNA pattern on chromosome 1
pattern <- "TATA"
matches <- matchPattern(pattern, genome$chr1)

# To perform genome-wide searching, refer to the 'GenomeSearching' vignette
# in the base BSgenome package.
```

## Tips and Best Practices
- **Memory Management**: BSgenome objects use "masked" sequences and lazy loading, but extracting very large sequences into memory as `DNAString` objects can be resource-intensive.
- **Consistency**: Ensure your input data (like BED files or GRanges objects) uses the "UCSC" style naming convention (e.g., "chr1" instead of "1") to match this package.
- **Compatibility**: This package is designed to work seamlessly with `GenomicRanges`, `GenomicFeatures`, and `Biostrings`.

## Reference documentation

- [BSgenome.Mmulatta.UCSC.rheMac10 Reference Manual](./references/reference_manual.md)