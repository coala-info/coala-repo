---
name: bioconductor-bsgenome.ggallus.ucsc.galgal3
description: This package provides the full genome sequences for Gallus gallus (Chicken) based on the UCSC galGal3 assembly for use in Bioconductor. Use when user asks to access chicken genomic sequences, extract specific chromosome data, calculate sequence lengths, or perform genome-wide motif searching for the galGal3 assembly in R.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Ggallus.UCSC.galGal3.html
---


# bioconductor-bsgenome.ggallus.ucsc.galgal3

name: bioconductor-bsgenome.ggallus.ucsc.galgal3
description: Provides the full genome sequences for Gallus gallus (Chicken) as provided by UCSC (build galGal3, May 2006) and stored in Biostrings objects. Use this skill when you need to access chicken genomic sequences, extract specific chromosome data, calculate sequence lengths, or perform genome-wide motif searching for the galGal3 assembly in R.

# bioconductor-bsgenome.ggallus.ucsc.galgal3

## Overview

The `BSgenome.Ggallus.UCSC.galGal3` package is a data-only Bioconductor package containing the complete genome sequence for the chicken (*Gallus gallus*). It is based on the UCSC galGal3 assembly. This package is primarily used as a reference for sequence alignment, genomic feature extraction, and motif analysis within the Bioconductor ecosystem.

## Basic Usage

### Loading the Genome
To use the package, you must first load it into your R session.

```r
library(BSgenome.Ggallus.UCSC.galGal3)
genome <- BSgenome.Ggallus.UCSC.galGal3
```

### Exploring Genome Metadata
You can check the available sequences (chromosomes) and their lengths.

```r
# View the genome object summary
genome

# List all sequence names (chromosomes, scaffolds)
seqnames(genome)

# Get lengths of all sequences
seqlengths(genome)

# Check the organism and provider version
organism(genome)
providerVersion(genome)
```

### Accessing Sequence Data
Sequences are stored as `DNAString` objects. You can access individual chromosomes using `$` or `[[`.

```r
# Access chromosome 1
chr1_seq <- genome$chr1

# Access via string name
chr2_seq <- genome[["chr2"]]

# Get a subsequence (e.g., first 1000 bp of chr1)
sub_seq <- subseq(genome$chr1, start=1, end=1000)
```

## Common Workflows

### Extracting Sequences for Genomic Ranges
Use `getSeq()` from the `BSgenome` package to extract sequences based on coordinates (e.g., from a GRanges object).

```r
library(GenomicRanges)

# Define regions of interest
my_regions <- GRanges(seqnames = c("chr1", "chr2"),
                      ranges = IRanges(start = c(100, 500), end = c(200, 600)))

# Extract sequences
sequences <- getSeq(genome, my_regions)
```

### Extracting Upstream/Promoter Sequences
Since version 3.0, upstream sequences are no longer pre-packaged. You can generate them using `GenomicFeatures`.

```r
library(GenomicFeatures)

# Example: Extracting 1000bp upstream of genes
# Note: Requires a compatible TxDb object for galGal3
txdb <- makeTxDbFromUCSC(genome="galGal3", table="refGene")
gn <- genes(txdb)
up1000 <- flank(gn, width=1000)
up1000seqs <- getSeq(genome, up1000)
```

### Genome-wide Motif Searching
You can search for specific DNA patterns across the entire genome.

```r
# Search for a specific hexamer on chromosome 1
matchPattern("GAATTC", genome$chr1)

# To search across all chromosomes, use vmatchPattern
library(Biostrings)
all_matches <- vmatchPattern("GAATTC", genome)
```

## Tips and Best Practices
- **Memory Management**: BSgenome objects use "lazy loading." The sequence for a chromosome is only loaded into memory when you specifically access it.
- **Coordinate Consistency**: Always ensure your input coordinates (GRanges) match the `galGal3` assembly. Using coordinates from a different assembly (e.g., galGal6) will result in incorrect sequences or out-of-bounds errors.
- **Masks**: Check if the package provides masked versions (e.g., for repeats) if your analysis requires it, though the standard BSgenome package usually provides the unmasked sequences.

## Reference documentation

- [BSgenome.Ggallus.UCSC.galGal3 Reference Manual](./references/reference_manual.md)