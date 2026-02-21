---
name: bioconductor-bsgenome.rnorvegicus.ucsc.rn6
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Rnorvegicus.UCSC.rn6.html
---

# bioconductor-bsgenome.rnorvegicus.ucsc.rn6

name: bioconductor-bsgenome.rnorvegicus.ucsc.rn6
description: Provides full genome sequences for Rattus norvegicus (Rat) based on the UCSC rn6 assembly (July 2014). Use this skill when you need to access, analyze, or manipulate the rat genome in R, including retrieving chromosome sequences, extracting upstream promoter regions, or performing genome-wide motif searching.

# bioconductor-bsgenome.rnorvegicus.ucsc.rn6

## Overview

The `BSgenome.Rnorvegicus.UCSC.rn6` package is a Bioconductor data package containing the complete genome sequence for the rat (*Rattus norvegicus*). The data is stored as a `BSgenome` object, which allows for efficient access to sequences using `Biostrings` infrastructure. This package is essential for bioinformatics workflows involving rat genomic data, such as sequence alignment, SNP analysis, or regulatory element identification.

## Basic Usage

### Loading the Genome
To use the package, load it into your R session. The genome object is named identically to the package.

```r
library(BSgenome.Rnorvegicus.UCSC.rn6)
genome <- BSgenome.Rnorvegicus.UCSC.rn6
```

### Exploring Genome Metadata
You can inspect the sequence names and lengths to understand the assembly structure.

```r
# View sequence names (chromosomes)
seqnames(genome)

# View sequence lengths
seqlengths(genome)

# Check the organism and provider
organism(genome)
provider(genome)
```

### Accessing Specific Sequences
Individual chromosome sequences are stored as `DNAString` objects.

```r
# Access chromosome 1
chr1_seq <- genome$chr1

# Access via string index (useful for loops)
chr_name <- "chrX"
chrx_seq <- genome[[chr_name]]

# Get a specific sub-sequence (e.g., first 100 bases of chr2)
sub_seq <- getSeq(genome, "chr2", start=1, end=100)
```

## Common Workflows

### Extracting Upstream Sequences
A common task is extracting promoter regions (e.g., 1000bp upstream of TSS). This requires a compatible `TxDb` object.

```r
library(GenomicFeatures)

# Create a TxDb object for rn6
txdb <- makeTxDbFromUCSC("rn6", tablename="refGene")

# Extract 1000bp upstream of all genes
up1000seqs <- extractUpstreamSeqs(genome, txdb, width=1000)
```

### Genome-Wide Motif Searching
You can search for specific DNA patterns across the entire genome using `matchPattern` or `vmatchPattern`.

```r
library(Biostrings)

# Define a motif
motif <- DNAString("TATAAT")

# Search on a specific chromosome
matches <- matchPattern(motif, genome$chr1)

# Search across all chromosomes
all_matches <- vmatchPattern(motif, genome)
```

## Tips and Best Practices
- **Memory Management**: `BSgenome` objects use "on-disk" caching. Loading the package doesn't load the entire genome into RAM, but accessing specific chromosomes (e.g., `genome$chr1`) will load that sequence into memory.
- **Compatibility**: Always ensure your annotation objects (like `TxDb` or `GRanges`) use the "rn6" naming convention to match this package. Use `seqlevelsStyle(x) <- "UCSC"` if necessary.
- **Masks**: Check if the genome contains masks (e.g., for assembly gaps or repeats) using `masks(genome$chr1)`.

## Reference documentation
- [BSgenome.Rnorvegicus.UCSC.rn6 Reference Manual](./references/reference_manual.md)