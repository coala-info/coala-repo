---
name: bioconductor-bsgenome.mmusculus.ucsc.mm39
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Mmusculus.UCSC.mm39.html
---

# bioconductor-bsgenome.mmusculus.ucsc.mm39

name: bioconductor-bsgenome.mmusculus.ucsc.mm39
description: Access and analyze the full genome sequences for Mus musculus (Mouse) based on the UCSC mm39 (GRCm39) assembly. Use this skill when performing genomic analysis in R that requires mouse reference sequences, chromosome lengths, or sequence extraction for specific genomic coordinates.

# bioconductor-bsgenome.mmusculus.ucsc.mm39

## Overview
This package provides a structured BSgenome object containing the complete genome sequence for the Mus musculus (mouse) mm39 assembly. It is built on the Biostrings framework, allowing for efficient sequence retrieval, pattern matching, and integration with other Bioconductor objects like GRanges.

## Installation and Loading
To use this genome data, ensure the package is installed and loaded:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("BSgenome.Mmusculus.UCSC.mm39")

library(BSgenome.Mmusculus.UCSC.mm39)
```

## Basic Usage

### Accessing the Genome Object
The genome can be accessed using the package name or the shorthand alias:

```r
genome <- BSgenome.Mmusculus.UCSC.mm39
# Or simply
# genome <- Mmusculus
```

### Inspecting Genome Metadata
Check chromosome names, lengths, and assembly information:

```r
# List all sequences (chromosomes, scaffolds)
seqnames(genome)

# Get lengths of all sequences
seqlengths(genome)

# View specific metadata
provider(genome)
release_date(genome)
```

### Retrieving Sequences
Extract whole chromosomes or specific sub-sequences:

```r
# Access a full chromosome (returns a DNAString object)
chr1_seq <- genome$chr1

# Extract a specific sub-sequence using coordinates
# Note: Coordinates are 1-based
getSeq(genome, "chr1", start=1000000, end=1000500)

# Extract multiple regions using a GRanges object
library(GenomicRanges)
gr <- GRanges(seqnames="chr2", ranges=IRanges(start=c(100, 500), end=c(200, 600)))
getSeq(genome, gr)
```

## Common Workflows

### Genome-wide Motif Searching
Search for specific DNA patterns across the entire mouse genome:

```r
library(Biostrings)
pattern <- "TATAWAW" # Example motif
matchPattern(pattern, genome$chr1)

# To search across all chromosomes
lapply(seqnames(genome), function(chr) {
    matchPattern(pattern, genome[[chr]])
})
```

### Calculating Nucleotide Frequency
Analyze the composition of specific chromosomes:

```r
alphabetFrequency(genome$chr1, baseOnly=TRUE)
# Calculate GC content
letterFrequency(genome$chr1, letters="GC", as.prob=TRUE)
```

## Tips
- **Memory Management**: BSgenome objects use "on-disk" caching. Loading `genome$chr1` loads the sequence into memory. If working with many chromosomes, clear the R workspace or use `gc()` if memory becomes an issue.
- **Coordinate Systems**: UCSC mm39 uses "chr" prefixes (e.g., "chr1", "chrX"). Ensure your GRanges objects match this naming convention or use `seqlevelsStyle(gr) <- "UCSC"`.
- **Masks**: Check if the genome contains masks (e.g., for assembly gaps or repeats) using `masks(genome$chr1)`.

## Reference documentation
- [BSgenome.Mmusculus.UCSC.mm39 Reference Manual](./references/reference_manual.md)