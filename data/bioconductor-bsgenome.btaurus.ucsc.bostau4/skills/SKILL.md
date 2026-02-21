---
name: bioconductor-bsgenome.btaurus.ucsc.bostau4
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Btaurus.UCSC.bosTau4.html
---

# bioconductor-bsgenome.btaurus.ucsc.bostau4

name: bioconductor-bsgenome.btaurus.ucsc.bostau4
description: Provides full genome sequences for Bos taurus (Cow) based on the UCSC bosTau4 assembly (Oct. 2007). Use this skill when you need to perform genomic analysis on the cow genome, including sequence extraction, motif searching, or coordinate-based lookups using Bioconductor's BSgenome framework.

# bioconductor-bsgenome.btaurus.ucsc.bostau4

## Overview

The `BSgenome.Btaurus.UCSC.bosTau4` package is a data provider package for the Bioconductor `BSgenome` infrastructure. It contains the complete genome sequence for *Bos taurus* as provided by UCSC (assembly bosTau4). The sequences are stored as `DNAString` objects, allowing for efficient memory usage and integration with other Bioconductor tools like `Biostrings`, `GenomicRanges`, and `GenomicFeatures`.

## Basic Usage

### Loading the Genome
To use the genome, you must load the package and assign the genome object to a variable for easier access.

```r
library(BSgenome.Btaurus.UCSC.bosTau4)
genome <- BSgenome.Btaurus.UCSC.bosTau4
```

### Exploring Genome Metadata
You can inspect the available chromosomes and their lengths:

```r
# List all sequences (chromosomes/scaffolds)
seqnames(genome)

# Get lengths of all sequences
seqlengths(genome)

# Access a specific chromosome
genome$chr1  # or genome[["chr1"]]
```

## Common Workflows

### Extracting Sequences
Use the `getSeq()` function to extract specific regions. This is often done using `GRanges` objects.

```r
library(GenomicRanges)

# Define a region of interest
my_region <- GRanges("chr1", IRanges(start=10000, end=10500))

# Extract the sequence
seq_data <- getSeq(genome, my_region)
```

### Extracting Upstream/Promoter Sequences
Since version 3.0, upstream sequences are not pre-packaged but can be extracted using a `TxDb` object that matches the `bosTau4` assembly.

```r
library(GenomicFeatures)

# Create a TxDb from UCSC for bosTau4
txdb <- makeTxDbFromUCSC(genome="bosTau4", table="refGene")

# Get gene coordinates
gn <- genes(txdb)

# Get 1000bp upstream (promoters)
up1000 <- flank(gn, width=1000)
up1000seqs <- getSeq(genome, up1000)
```

### Genome-wide Motif Searching
You can search for specific DNA patterns across the entire genome using `matchPattern`.

```r
library(Biostrings)

# Define a motif
motif <- DNAString("ATGCATGC")

# Search on a specific chromosome
matches <- matchPattern(motif, genome$chr1)

# To search across the whole genome, iterate through seqnames
# or use vmatchPattern for multiple regions
```

## Tips and Best Practices
- **Coordinate Consistency**: Always ensure your annotation data (GTF/GFF/TxDb) matches the `bosTau4` assembly. Using coordinates from a different assembly (e.g., bosTau9) will result in incorrect sequences.
- **Memory Management**: Accessing specific chromosomes via `genome$chr1` loads that sequence into memory. For large-scale operations, consider using `BSgenomeViews`.
- **Masks**: Check if the package provides masked versions (e.g., for repeats) if your analysis is sensitive to repetitive elements.

## Reference documentation
- [BSgenome.Btaurus.UCSC.bosTau4 Reference Manual](./references/reference_manual.md)