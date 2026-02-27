---
name: bioconductor-crisprbwa
description: The crisprBwa package provides an R interface for the BWA-backtrack aligner to perform fast on-target and off-target searches for CRISPR guide RNA sequences. Use when user asks to map CRISPR spacers to a reference genome, build a BWA index, or perform general short-read alignment for sequences like RNAi seeds.
homepage: https://bioconductor.org/packages/release/bioc/html/crisprBwa.html
---


# bioconductor-crisprbwa

## Overview

The `crisprBwa` package provides an R interface for the BWA-backtrack aligner, specifically optimized for CRISPR guide RNA (gRNA) design and short-read mapping. It leverages the `Rbwa` package to provide a platform-independent BWA implementation, meaning no external BWA installation is required. Its primary utility is fast on-target and off-target search for CRISPR nucleases, integrating seamlessly with the `crisprBase` and `crisprDesign` ecosystems.

## Core Workflow

### 1. Building a BWA Index
Before alignment, you must create a BWA index for your reference genome. This is a one-time operation per genome.

```r
library(Rbwa)
# Path to your genome FASTA file
fasta_path <- "path/to/genome.fa"
index_base <- "path/to/output/index_prefix"

Rbwa::bwa_build_index(fasta_path, index_prefix = index_base)
```

### 2. CRISPR-Specific Alignment
Use `runCrisprBwa` to align spacers while considering CRISPR-specific constraints like PAM sequences and nuclease types.

```r
library(crisprBwa)
library(crisprBase)
library(BSgenome.Hsapiens.UCSC.hg38)

# Load nuclease and genome
data(SpCas9, package="crisprBase")
bsgenome <- BSgenome.Hsapiens.UCSC.hg38
index_path <- "path/to/output/index_prefix"

# Define spacers
spacers <- c("AGCTGTCCGTGGGGGTCCGC", "ACGAACTGTAAAAGGCTTGG")

# Run alignment
results <- runCrisprBwa(spacers,
                        bsgenome = bsgenome,
                        crisprNuclease = SpCas9,
                        n_mismatches = 3,
                        canonical = FALSE, # Include non-canonical PAMs (e.g., NAG)
                        bwa_index = index_path)
```

### 3. General Short Read Alignment
For non-CRISPR applications (e.g., RNAi seed mapping), use `runBwa`. This function does not require a nuclease object or PAM constraints.

```r
seeds <- c("GTAAGCGGAGTGT", "AACGGGGAGATTG")
runBwa(seeds, 
       n_mismatches = 2, 
       bwa_index = index_path)
```

## Key Functions

- `runCrisprBwa()`: Maps spacers to a genome. Returns a data frame with spacer, protospacer, PAM, coordinates, strand, and mismatch count.
- `runBwa()`: General purpose short-read aligner. Returns query sequence, coordinates, strand, and mismatch count.
- `Rbwa::bwa_build_index()`: Creates the required BWA index files from a FASTA file.

## Tips and Constraints

- **OS Support**: This package is supported on **macOS and Linux** only.
- **Nuclease Objects**: Use `crisprBase::getAvailableCrisprNucleases()` to see supported nucleases for `runCrisprBwa`.
- **Memory**: While BWA-backtrack is efficient for short sequences (<100bp), ensure the R session has enough memory to load the `BSgenome` object for PAM validation.
- **Mismatches**: The `n_mismatches` argument defines the tolerance for the search; higher values significantly increase computation time.

## Reference documentation

- [crisprBwa: alignment of gRNA spacer sequences using BWA](./references/crisprBwa.md)
- [crisprBwa Vignette Source](./references/crisprBwa.Rmd)