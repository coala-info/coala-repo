---
name: bioconductor-bsgenome.hsapiens.ucsc.hg38
description: This package provides the full genomic sequences for the Homo sapiens UCSC hg38 reference genome as a BSgenome object. Use when user asks to access human reference sequences, perform genome-wide motif searching, or retrieve sequence metadata for the hg38 assembly in R.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Hsapiens.UCSC.hg38.html
---

# bioconductor-bsgenome.hsapiens.ucsc.hg38

name: bioconductor-bsgenome.hsapiens.ucsc.hg38
description: Provides full genomic sequences for Homo sapiens (UCSC genome hg38, based on GRCh38.p14). Use this skill when you need to access human reference genome sequences, perform genome-wide motif searching, or retrieve sequence information (lengths, names, and metadata) for hg38 in R.

# bioconductor-bsgenome.hsapiens.ucsc.hg38

## Overview
The `BSgenome.Hsapiens.UCSC.hg38` package is a data package containing the complete genome sequence for *Homo sapiens* as provided by UCSC (assembly hg38/GRCh38.p14). Sequences are stored as `DNAString` objects, allowing for efficient sequence analysis, subsetting, and motif searching within the Bioconductor ecosystem.

## Basic Usage

### Loading the Genome
```r
library(BSgenome.Hsapiens.UCSC.hg38)
bsg <- BSgenome.Hsapiens.UCSC.hg38
```

### Inspecting Genome Metadata
```r
# View sequence lengths
head(seqlengths(bsg))

# View full sequence information (chromosomes, lengths, circularity, genome build)
seqinfo(bsg)

# Check current naming style (usually "UCSC")
seqlevelsStyle(bsg)
```

### Accessing Sequences
Sequences can be accessed using list-style or dollar-sign notation.
```r
# Access chromosome 1
chr1_seq <- bsg$chr1 
# OR
chr1_seq <- bsg[["chr1"]]

# Get sequence statistics
library(Biostrings)
alphabetFrequency(chr1_seq)

# Mitochondrial DNA operations
mt_seq <- bsg$chrM
rev_comp_mt <- reverseComplement(mt_seq)
```

## Common Workflows

### Switching Sequence Naming Conventions
You can toggle between UCSC (e.g., "chr1") and NCBI (e.g., "1") naming styles.
```r
# Switch to NCBI style
seqlevelsStyle(bsg) <- "NCBI"
bsg[["1"]] # Accesses what was "chr1"

# Switch back to UCSC
seqlevelsStyle(bsg) <- "UCSC"
```
*Note: As of GRCh38.p14, two sequences (chr11_KQ759759v1_fix and chr22_KQ759762v1_fix) are technically from GRCh38.p13 but included in the hg38 package.*

### Genome-wide Motif Searching
To find specific patterns across the entire genome, use the `matchPattern` or `vmatchPattern` functions from the `Biostrings` package in conjunction with the BSgenome object.

```r
library(Biostrings)
# Example: Search for a specific DNA pattern on chromosome 1
pattern <- "ATGCA"
matches <- matchPattern(pattern, bsg$chr1)
```

## Tips
- **Memory Management**: Loading entire chromosomes into memory as `DNAString` objects is efficient, but be mindful when working with many large chromosomes simultaneously.
- **Coordinate Systems**: UCSC hg38 uses 1-based coordinates in R/Bioconductor.
- **Package Dependencies**: This package relies on `BSgenome`, `Biostrings`, and `GenomeInfoDb`. Ensure these are loaded for full functionality.

## Reference documentation
- [BSgenome.Hsapiens.UCSC.hg38 Reference Manual](./references/reference_manual.md)