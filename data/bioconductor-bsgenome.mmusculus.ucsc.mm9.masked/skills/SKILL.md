---
name: bioconductor-bsgenome.mmusculus.ucsc.mm9.masked
description: This package provides full masked genome sequences for the Mus musculus UCSC mm9 build. Use when user asks to access mouse genomic sequences, retrieve masked DNA strings, or perform sequence analysis excluding assembly gaps and repeats.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Mmusculus.UCSC.mm9.masked.html
---

# bioconductor-bsgenome.mmusculus.ucsc.mm9.masked

name: bioconductor-bsgenome.mmusculus.ucsc.mm9.masked
description: Provides full masked genome sequences for Mus musculus (Mouse) based on the UCSC mm9 build (July 2007). Use this skill when you need to access mouse genomic sequences that include masks for assembly gaps (AGAPS), intra-contig ambiguities (AMB), RepeatMasker (RM), and Tandem Repeats Finder (TRF). It is specifically useful for genomic analysis where repetitive or low-complexity regions should be excluded or identified.

# bioconductor-bsgenome.mmusculus.ucsc.mm9.masked

## Overview

The `BSgenome.Mmusculus.UCSC.mm9.masked` package is a data container for the Mus musculus (mouse) genome, version mm9. It extends the standard `BSgenome.Mmusculus.UCSC.mm9` package by adding four specific masks to the sequences. By default, only the assembly gaps (AGAPS) and intra-contig ambiguities (AMB) masks are active. This package is essential for bioinformatics workflows requiring high-fidelity sequence analysis where masked regions (like repeats) might interfere with mapping or motif discovery.

## Loading and Basic Usage

To use the genome data, load the library and assign the object to a variable:

```r
library(BSgenome.Mmusculus.UCSC.mm9.masked)
genome <- BSgenome.Mmusculus.UCSC.mm9.masked
```

### Inspecting the Genome
- **List chromosomes**: `seqnames(genome)`
- **Check sequence lengths**: `seqlengths(genome)`
- **Access a specific chromosome**: `genome$chr1` (returns a `MaskedDNAString` object)

## Working with Masks

The sequences in this package contain four masks:
1. `AGAPS`: Assembly gaps
2. `AMB`: Intra-contig ambiguities
3. `RM`: RepeatMasker repeats
4. `TRF`: Tandem Repeats Finder repeats

### Managing Active Masks
By default, only `AGAPS` and `AMB` are active. You can check and modify active masks:

```r
# View available masks
masknames(genome)

# Access a chromosome
chr1 <- genome$chr1

# Check currently active masks
active(masks(chr1))

# Activate RepeatMasker (RM) mask
active(masks(chr1))["RM"] <- TRUE

# Deactivate all masks to see the raw sequence
unmasked_seq <- unmasked(chr1)
```

## Common Workflows

### Extracting Sequences
When you access a chromosome, the masked regions are hidden from many operations (like `alphabetFrequency`).

```r
# Get frequency of nucleotides in non-masked regions
alphabetFrequency(genome$chr1)
```

### Motif Searching
To search for motifs while respecting the masks, use the `matchPattern` function from the `Biostrings` package. The search will skip regions covered by active masks.

```r
library(Biostrings)
pattern <- "TATAA"
matchPattern(pattern, genome$chr1)
```

### Iterating Over Chromosomes
To perform an analysis across the entire masked genome:

```r
for (seqname in seqnames(genome)) {
  seq <- genome[[seqname]]
  # Perform analysis on 'seq' (a MaskedDNAString)
  cat("Processing", seqname, "...\n")
}
```

## Tips
- **Memory Management**: BSgenome objects use a cache. If you iterate over many chromosomes, R might consume significant memory. Use `options(verbose=TRUE)` to monitor cache behavior.
- **Unmasking**: If you need the original mm9 sequence without any masks, you can use `unmasked(genome$chr1)` or simply use the `BSgenome.Mmusculus.UCSC.mm9` package.
- **MaskedDNAString**: Remember that `genome$chr1` returns a `MaskedDNAString`, not a standard `DNAString`. Some functions may require you to call `unmasked()` or specifically handle the masks.

## Reference documentation

- [BSgenome.Mmusculus.UCSC.mm9.masked Reference Manual](./references/reference_manual.md)