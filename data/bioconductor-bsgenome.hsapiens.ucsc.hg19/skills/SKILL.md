---
name: bioconductor-bsgenome.hsapiens.ucsc.hg19
description: This package provides the full genome sequences for the Homo sapiens hg19 assembly from UCSC for use in R. Use when user asks to retrieve DNA sequences, calculate sequence statistics like GC content, or perform motif searching on the hg19 human reference genome.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Hsapiens.UCSC.hg19.html
---

# bioconductor-bsgenome.hsapiens.ucsc.hg19

name: bioconductor-bsgenome.hsapiens.ucsc.hg19
description: Provides the full genome sequences for Homo sapiens (Human) as provided by UCSC (build hg19, based on GRCh37.p13). Use this skill when an AI agent needs to retrieve DNA sequences, calculate sequence statistics (like GC content), or perform motif searching on the hg19 human reference genome within an R/Bioconductor environment.

# bioconductor-bsgenome.hsapiens.ucsc.hg19

## Overview

The `BSgenome.Hsapiens.UCSC.hg19` package is a data-only Bioconductor package containing the complete genome sequence for *Homo sapiens* based on the UCSC hg19 build. It stores sequences as `DNAString` objects, allowing for efficient memory usage and integration with the `Biostrings` and `BSgenome` software infrastructure.

## Basic Usage

### Loading the Genome
To use the genome, you must load the library and assign the provider object to a variable for easier access.

```r
library(BSgenome.Hsapiens.UCSC.hg19)
genome <- BSgenome.Hsapiens.UCSC.hg19
```

### Inspecting Genome Metadata
You can check available chromosomes, sequence lengths, and the genome build version.

```r
# List all sequences (chromosomes, organelle, and unplaced scaffolds)
seqnames(genome)

# Get lengths of all sequences
seqlengths(genome)

# Access specific metadata
provider(genome)      # "UCSC"
releaseDate(genome)   # "Feb. 2009"
```

### Retrieving Sequences
Sequences can be accessed using list-style or dollar-sign notation.

```r
# Access chromosome 1
chr1_seq <- genome$chr1

# Access via string (useful for loops)
chr_name <- "chrM"
mt_seq <- genome[[chr_name]]

# Get a specific sub-sequence (Range-based)
# Note: Coordinates are 1-based
getSeq(genome, "chr1", start=1000000, end=1000050)
```

## Common Workflows

### Sequence Statistics
Calculate the frequency of nucleotides or GC content for a specific chromosome.

```r
library(Biostrings)
chr22 <- genome$chr22
alphabetFrequency(chr22)
letterFrequency(chr22, letters="GC", as.prob=TRUE)
```

### Motif Searching
Search for a specific DNA pattern across a chromosome.

```r
pattern <- "TATA"
match_results <- matchPattern(pattern, genome$chr1)
```

### Working with GenomicRanges
The `getSeq` function is highly efficient when combined with `GRanges` objects to extract multiple regions at once.

```r
library(GenomicRanges)
gr <- GRanges(seqnames=c("chr1", "chr2"), 
              ranges=IRanges(start=c(100, 200), end=c(150, 250)))
sequences <- getSeq(genome, gr)
```

## Tips and Best Practices
- **Memory Management**: Loading an entire chromosome into memory (e.g., `genome$chr1`) consumes significant RAM. Use `getSeq()` with specific coordinates whenever possible to minimize memory footprint.
- **Naming Consistency**: UCSC hg19 uses the "chr" prefix (e.g., "chr1", "chrX"). If your data uses NCBI/Ensembl naming (e.g., "1", "X"), use `seqlevelsStyle(x) <- "UCSC"` to ensure compatibility.
- **Masks**: This package provides the standard sequences. For masked versions (e.g., repeat-masked), look for the `BSgenome.Hsapiens.UCSC.hg19.masked` package.

## Reference documentation

- [BSgenome.Hsapiens.UCSC.hg19 Reference Manual](./references/reference_manual.md)