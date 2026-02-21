---
name: bioconductor-bsgenome.ptroglodytes.ucsc.pantro2
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Ptroglodytes.UCSC.panTro2.html
---

# bioconductor-bsgenome.ptroglodytes.ucsc.pantro2

name: bioconductor-bsgenome.ptroglodytes.ucsc.pantro2
description: Provides full genome sequences for Pan troglodytes (Chimpanzee) based on the UCSC panTro2 assembly (March 2006). Use this skill when you need to access, analyze, or extract DNA sequences from the chimp genome in R, perform genome-wide motif searching, or handle genomic coordinates specific to the panTro2 build.

# bioconductor-bsgenome.ptroglodytes.ucsc.pantro2

## Overview

The `BSgenome.Ptroglodytes.UCSC.panTro2` package is a data provider package for Bioconductor. It contains the complete genome sequence for the Chimpanzee (*Pan troglodytes*) as represented by the UCSC panTro2 assembly. The sequences are stored as `Biostrings` objects, allowing for efficient sequence manipulation and analysis within the R environment.

## Loading and Basic Usage

To use the genome data, you must load the package and assign the genome object to a variable for easier access.

```r
library(BSgenome.Ptroglodytes.UCSC.panTro2)

# Assign to a shorter variable name
genome <- BSgenome.Ptroglodytes.UCSC.panTro2

# View available chromosomes and sequence lengths
seqlengths(genome)

# Access a specific chromosome (e.g., Chromosome 1)
chr1_seq <- genome$chr1
# Or using double brackets
chr1_seq <- genome[["chr1"]]
```

## Common Workflows

### Extracting Specific Sequences
You can extract sequences for specific genomic ranges using the `getSeq()` function from the `BSgenome` package.

```r
library(GenomicRanges)

# Define a region of interest
my_range <- GRanges("chr1", IRanges(start=100000, end=100100))

# Extract the sequence
dna_seq <- getSeq(genome, my_range)
```

### Extracting Upstream/Promoter Sequences
While upstream sequences are no longer bundled directly in the package, they can be extracted by combining this package with a `TxDb` object.

```r
library(GenomicFeatures)

# Create a TxDb for panTro2 (requires internet connection or local cache)
txdb <- makeTxDbFromUCSC(genome="panTro2", tablename="refGene")

# Get gene coordinates
gn <- genes(txdb)

# Get 1000bp upstream (flanking)
up1000 <- flank(gn, width=1000)

# Extract the actual sequences
up1000seqs <- getSeq(genome, up1000)
```

### Genome-wide Motif Searching
You can search for specific DNA patterns across the entire genome.

```r
# Search for a specific motif on chr22
matchPattern("GATCGATCA", genome$chr22)

# For genome-wide searches, iterate through chromosomes or use vmatchPattern
```

## Tips and Best Practices
- **Coordinate Consistency**: Always ensure that your annotation data (GTF, BED, or TxDb) matches the `panTro2` assembly. Using coordinates from `panTro3` or `panTro4` with this package will result in incorrect data.
- **Memory Management**: BSgenome objects use "lazy loading," meaning sequences are only loaded into memory when accessed. However, extracting very large regions or many sequences simultaneously can still consume significant RAM.
- **Masks**: Check if you need masked sequences (e.g., for repeats). This package provides the standard sequences; for masked versions, look for `BSgenome.Ptroglodytes.UCSC.panTro2.masked`.

## Reference documentation

- [BSgenome.Ptroglodytes.UCSC.panTro2 Reference Manual](./references/reference_manual.md)