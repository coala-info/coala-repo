---
name: bioconductor-bsgenome
description: This package provides infrastructure for memory-efficient access, manipulation, and searching of full genome sequences in Bioconductor. Use when user asks to load genome data packages, extract chromosome sequences, handle assembly masks, or perform genome-wide pattern matching.
homepage: https://bioconductor.org/packages/release/bioc/html/BSgenome.html
---

# bioconductor-bsgenome

name: bioconductor-bsgenome
description: Infrastructure for Biostrings-based genome data packages. Use when you need to access, manipulate, and search full genome sequences for supported organisms (e.g., Human, Mouse, C. elegans). This skill covers loading BSgenome objects, extracting chromosome sequences, handling sequence masks (assembly gaps/repeats), and performing efficient genome-wide pattern matching.

## Overview

The `BSgenome` package provides the essential infrastructure for handling whole-genome sequences in Bioconductor. It works in tandem with `Biostrings` to provide memory-efficient access to large genomic sequences. Instead of loading an entire genome into RAM, `BSgenome` objects allow for "on-demand" loading of individual chromosomes. It also supports "masked" genomes, which hide assembly gaps (N-blocks) or repeat regions during analysis.

## Core Workflows

### 1. Finding and Loading Genomes

To see available genomes and load a specific one:

```r
library(BSgenome)

# List all available genome packages on Bioconductor
# available.genomes() 

# Load a specific genome (must be installed first)
library(BSgenome.Celegans.UCSC.ce2)
genome <- BSgenome.Celegans.UCSC.ce2
```

### 2. Inspecting Genome Metadata

Use accessor methods to explore the genome object:

```r
organism(genome)      # "Caenorhabditis elegans"
provider(genome)      # "UCSC"
releaseDate(genome)   # "Mar. 2004"
seqnames(genome)      # List chromosome names (chrI, chrII, etc.)
seqinfo(genome)       # Get lengths and circularity of all sequences
```

### 3. Accessing Sequences

Extract specific chromosomes as `DNAString` objects using `$` or `[[`:

```r
# Access chromosome I
chrI <- genome$chrI

# Basic sequence analysis
length(chrI)
alphabetFrequency(chrI, baseOnly = TRUE)
```

### 4. Pattern Matching

#### Single Pattern Search
Use `matchPattern` for a single chromosome or loop through the genome. Note: Always search the forward strand; to search the reverse strand, use `reverseComplement` on the pattern, not the chromosome.

```r
p1 <- "ACCCAGGGC"
# Search forward strand
m1 <- matchPattern(p1, chrI, max.mismatch = 1)

# Search reverse strand
rc_p1 <- reverseComplement(DNAString(p1))
m2 <- matchPattern(rc_p1, chrI)
```

#### Dictionary Search (Multiple Patterns)
For searching many patterns of the same length, `matchPDict` is significantly faster (100x-1000x).

```r
pdict <- PDict(c("ACCCAGGGC", "GCTAAGCTA"))
mindex <- matchPDict(pdict, chrI)
# Extract matches as a list of XStringViews
matches <- extractAllMatches(chrI, mindex)
```

### 5. Working with Masks

Masked genomes (e.g., `BSgenome.Hsapiens.UCSC.hg38.masked`) contain built-in masks for assembly gaps (AGAPS), ambiguities (AMB), and repeats (RM, TRF).

```r
# Load a masked genome
library(BSgenome.Hsapiens.UCSC.hg38.masked)
m_genome <- BSgenome.Hsapiens.UCSC.hg38.masked
chrY <- m_genome$chrY

# Check active masks
masks(chrY)

# Activate/Deactivate masks
active(masks(chrY))["RM"] <- TRUE  # Activate RepeatMasker
active(masks(chrY))["AGAPS"] <- FALSE # Deactivate Gaps

# Mask-aware functions (like alphabetFrequency) will ignore masked regions
alphabetFrequency(chrY)
```

## Tips for Efficiency

- **Memory Management**: Always access chromosomes one at a time (e.g., `genome[[seqname]]`) inside a loop rather than loading all chromosomes into a list.
- **Pre-conversion**: If using the same pattern many times, convert it to a `DNAString` once before calling `matchPattern` to avoid repeated internal conversions.
- **Hard Masking**: If a function is not "mask-aware," you can use `injectHardMask(chrY, letter="N")` to replace masked regions with Ns.
- **Custom Genomes**: To create your own BSgenome data package from FASTA files, use the `BSgenomeForge` package.

## Reference documentation

- [How to forge a BSgenome data package](./references/BSgenomeForge.md)
- [Efficient genome searching with Biostrings and the BSgenome data packages](./references/GenomeSearching.md)