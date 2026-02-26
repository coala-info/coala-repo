---
name: bioconductor-biostrings
description: Biostrings provides memory-efficient infrastructure for representing and manipulating large biological sequences like DNA, RNA, and proteins in R. Use when user asks to manipulate biological strings, perform pattern matching, calculate k-mer frequencies, or manage multiple sequence alignments.
homepage: https://bioconductor.org/packages/release/bioc/html/Biostrings.html
---


# bioconductor-biostrings

name: bioconductor-biostrings
description: Expert guidance for the Biostrings R package. Use this skill when you need to manipulate large biological sequences (DNA, RNA, Amino Acids), perform string matching, calculate oligonucleotide frequencies, or manage multiple sequence alignments in R.

# bioconductor-biostrings

## Overview

The `Biostrings` package is the foundational Bioconductor infrastructure for representing and manipulating biological strings. It replaces standard R character vectors with memory-efficient classes (`XString`, `XStringSet`) that use external pointers and bit-level encoding. This allows for high-performance operations on genomic-scale data, including pattern matching, sequence transformation (reverse complement, translation), and alignment management.

## Core Classes

- **XString**: Virtual class for a single sequence. Use subclasses: `DNAString`, `RNAString`, `AAString`, or `BString` (any string).
- **XStringSet**: A container for multiple sequences (e.g., `DNAStringSet`). This is the standard input for most Bioconductor high-throughput analysis functions.
- **XStringViews**: Represents a set of "views" (subsequences) on a single subject string, often used to store match results without copying data.
- **MultipleAlignment**: Classes like `DNAMultipleAlignment` for representing and masking aligned sequences.

## Essential Workflows

### 1. Sequence Creation and Basic Manipulation
```R
library(Biostrings)

# Create sequences
dna <- DNAString("TTGAAAA-CTC-N")
dna_set <- DNAStringSet(c("ATGC", "ATGG", "ATGA"))

# Basic properties
length(dna)      # Number of letters
width(dna_set)   # Vector of lengths for each sequence in set

# Subsetting (use subseq for efficiency)
sub_dna <- subseq(dna, start=3, end=6)

# Transformations
rev_comp <- reverseComplement(dna_set)
prot <- translate(dna_set)
```

### 2. String Matching and Counting
- **matchPattern**: Find all occurrences of a pattern in a single subject.
- **vmatchPattern**: Vectorized version for matching a pattern against an `XStringSet`.
- **matchPDict**: High-performance matching of a large dictionary of patterns (e.g., sequencing reads) against a reference.
- **alphabetFrequency**: Tabulate base/amino acid composition.
- **dinucleotideFrequency / oligonucleotideFrequency**: Count k-mers.

### 3. Working with Multiple Alignments
`MultipleAlignment` objects allow non-destructive manipulation via masking.
```R
# Read an alignment
aln <- readDNAMultipleAlignment(filepath, format="clustal")

# Masking columns (e.g., mask gaps)
colmask(aln) <- IRanges(start=10, end=20)

# Masking rows
rowmask(aln) <- IRanges(start=1, end=3)

# Get consensus
con_str <- consensusString(aln)
```

### 4. File I/O
Use specialized functions for FASTA and FASTQ to ensure memory efficiency.
```R
# Reading
dna_set <- readDNAStringSet("sequences.fasta")

# Writing
writeXStringSet(dna_set, file="output.fasta", format="fasta")
```

## Tips for Efficiency
- **Avoid `toString()` on large objects**: Converting a massive `DNAString` to a standard R character vector consumes significant memory. Use `subseq()` or `XStringViews` instead.
- **Use `baseOnly=TRUE`**: In `alphabetFrequency` or `consensusMatrix`, setting `baseOnly=TRUE` focuses on standard IUPAC codes (A, C, G, T) and is faster.
- **Masking vs. Deleting**: In `MultipleAlignment`, use `rowmask` and `colmask` to hide regions. Functions like `as.matrix()` will respect these masks, allowing you to filter data without destroying the original alignment structure.

## Reference documentation

- [The Biostrings 2 classes](./references/Biostrings2Classes.md)
- [Biostrings Quick Overview](./references/BiostringsQuickOverview.md)
- [MultipleAlignment Objects](./references/MultipleAlignments.md)
- [Pairwise Sequence Alignments](./references/PairwiseAlignments.md)
- [Using oligonucleotide microarray reporter sequence information](./references/matchprobes.md)