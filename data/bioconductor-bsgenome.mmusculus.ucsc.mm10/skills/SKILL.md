---
name: bioconductor-bsgenome.mmusculus.ucsc.mm10
description: This package provides the full genome sequence for the Mus musculus (Mouse) UCSC mm10 assembly for use in R. Use when user asks to retrieve mouse DNA sequences, calculate sequence statistics, or perform genome-wide motif searching for the mm10 assembly.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Mmusculus.UCSC.mm10.html
---

# bioconductor-bsgenome.mmusculus.ucsc.mm10

name: bioconductor-bsgenome.mmusculus.ucsc.mm10
description: Access and analyze the full genome sequences for Mus musculus (Mouse) based on the UCSC mm10 (GRCm38.p6) assembly. Use this skill when you need to retrieve DNA sequences, calculate sequence statistics, or perform genome-wide motif searching for the mm10 mouse genome in R.

# bioconductor-bsgenome.mmusculus.ucsc.mm10

## Overview

The `BSgenome.Mmusculus.UCSC.mm10` package is a data-driven Bioconductor package providing the complete genome sequence for the mouse (Mus musculus) as provided by UCSC. It stores the sequence data in `Biostrings` objects, allowing for efficient sequence manipulation and analysis. This package is essential for bioinformatics workflows involving mouse genomic data, such as peak annotation, sequence extraction, and motif discovery.

## Basic Usage

### Loading the Genome
To use the package, you must first load it into your R session.

```r
library(BSgenome.Mmusculus.UCSC.mm10)
genome <- BSgenome.Mmusculus.UCSC.mm10
```

### Exploring Genome Metadata
You can inspect the chromosomes, their lengths, and the assembly information.

```r
# List all sequences (chromosomes, scaffolds, etc.)
seqnames(genome)

# Get lengths of all sequences
seqlengths(genome)

# View the first few sequence lengths
head(seqlengths(genome))

# Check the genome build and organism
organism(genome)
provider(genome)
release_date(genome)
```

### Accessing Specific Sequences
Sequences can be accessed using the `$` or `[[` operators.

```r
# Access chromosome 1
chr1_seq <- genome$chr1

# Access using a string (useful for programmatic access)
chr_name <- "chrX"
chrx_seq <- genome[[chr_name]]

# View a snippet of the sequence
print(chr1_seq)
```

## Common Workflows

### Extracting Subsequences
Use `getSeq()` to extract specific genomic regions. This is more memory-efficient than loading entire chromosomes.

```r
# Extract a specific region from chr1
# Coordinates are 1-based
my_region <- getSeq(genome, names="chr1", start=1000000, end=1000500)

# Extract multiple regions using a GRanges object
library(GenomicRanges)
gr <- GRanges(seqnames=c("chr1", "chr2"), 
              ranges=IRanges(start=c(500, 1000), end=c(600, 1100)))
multi_seqs <- getSeq(genome, gr)
```

### Sequence Statistics
Since the sequences are `DNAString` objects, you can use `Biostrings` functions.

```r
library(Biostrings)

# Calculate GC content for a specific chromosome
alphabetFrequency(genome$chr1, as.prob=TRUE)[c("C", "G")]

# Count occurrences of a specific k-mer
countPattern("TATAAA", genome$chr1)
```

### Genome-wide Motif Searching
To find all occurrences of a motif across the entire genome:

```r
# Example: Searching for a TATA box pattern
pattern <- "TATAAA"
hits <- vmatchPattern(pattern, genome)

# Convert hits to a GRanges object for further analysis
hits_gr <- as(hits, "GRanges")
```

## Tips and Best Practices
- **Memory Management**: Avoid loading all chromosomes into memory at once. Use `getSeq()` with `GRanges` to extract only the regions of interest.
- **Masking**: Be aware that UCSC genomes may contain "soft-masked" (lowercase) or "hard-masked" (N) sequences for repeats. Check the specific sequence if repeat masking is relevant to your analysis.
- **Consistency**: Ensure your input data (like BED files or BAM files) uses the "chr" prefix (e.g., "chr1") to match the UCSC naming convention used in this package. Use `seqlevelsStyle(x) <- "UCSC"` to convert other styles.

## Reference documentation
- [BSgenome.Mmusculus.UCSC.mm10](./references/reference_manual.md)