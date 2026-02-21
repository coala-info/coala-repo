---
name: bioconductor-bsgenome.hsapiens.1000genomes.hs37d5
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Hsapiens.1000genomes.hs37d5.html
---

# bioconductor-bsgenome.hsapiens.1000genomes.hs37d5

name: bioconductor-bsgenome.hsapiens.1000genomes.hs37d5
description: Provides the full 1000 Genomes Project Phase 2 reference genome sequence (hs37d5) as a BSgenome object. Use this skill when you need to access, analyze, or extract sequences from the GRCh37-based human reference assembly used by the 1000 Genomes Project, including decoy sequences and viral genomes (EBV).

# bioconductor-bsgenome.hsapiens.1000genomes.hs37d5

## Overview

The `BSgenome.Hsapiens.1000genomes.hs37d5` package is a data-rich Bioconductor annotation package containing the reference genome sequence used in Phase 2 of the 1000 Genomes Project. It is based on the NCBI GRCh37 assembly but includes specific additions:
- The primary GRCh37 assembly (chromosomes 1-22, X, Y).
- Mitochondrial sequence (rCRS).
- Human herpesvirus 4 type 1 (Epstein-Barr virus).
- Concatenated decoy sequences (hs37d5) used to improve alignment accuracy by soaking up reads that don't belong to the reference.

## Basic Usage

### Loading the Genome
To use the genome in an R session, load the library and assign the object to a variable for easier access.

```r
library(BSgenome.Hsapiens.1000genomes.hs37d5)

# Access the genome object
genome <- BSgenome.Hsapiens.1000genomes.hs37d5
genome
```

### Inspecting Sequence Information
You can check available sequences (chromosomes and decoys) and their lengths.

```r
# List all sequence names (includes 1..22, X, Y, MT, GL*, and hs37d5)
seqnames(genome)

# Get lengths of all sequences
seqlengths(genome)

# Check the genome build and organism
organism(genome)
provider(genome)
release_date(genome)
```

### Extracting Sequences
Use standard `BSgenome` methods to retrieve specific DNA sequences.

```r
# Extract a whole chromosome
chr1_seq <- genome$1

# Extract a specific sub-sequence (e.g., first 100bp of Chromosome 1)
# Note: Coordinates are 1-based
getSeq(genome, "1", start=1, end=100)

# Extract sequences based on a GRanges object
library(GenomicRanges)
my_regions <- GRanges(c("1:100-200", "X:500-600"))
getSeq(genome, my_regions)
```

## Common Workflows

### Sequence Analysis
Since the sequences are returned as `DNAString` or `DNAStringSet` objects, you can use `Biostrings` functions for analysis.

```r
library(Biostrings)

# Calculate GC content for a specific region
region <- getSeq(genome, "1", start=1000000, end=1001000)
letterFrequency(region, letters="GC", as.prob=TRUE)

# Count occurrences of a motif
matchPattern("TATAAA", genome$"1")
```

### Working with Decoy Sequences
The `hs37d5` sequence is a single concatenated entry containing decoy sequences. It is often used in variant calling pipelines to reduce false positives.

```r
# Access the decoy sequence
decoy_seq <- genome[["hs37d5"]]
length(decoy_seq)
```

## Tips
- **Memory Management**: BSgenome objects use "on-disk" caching. Loading the package doesn't load the entire genome into RAM, but extracting very large sequences (like whole chromosomes) will consume memory.
- **Naming Convention**: This package uses NCBI-style naming (e.g., "1", "2", "MT") rather than UCSC-style ("chr1", "chrM"). Use `seqlevelsStyle(genome) <- "UCSC"` if you need to convert styles for compatibility with other datasets.
- **Masks**: Check if masks are available for repeat-masked sequences using `masks(genome$1)`, though standard BSgenome data packages usually provide the unmasked sequence.

## Reference documentation

- [BSgenome.Hsapiens.1000genomes.hs37d5 Reference Manual](./references/reference_manual.md)