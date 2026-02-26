---
name: bioconductor-bsgenome.tguttata.ucsc.taegut1
description: This package provides the full genome sequences for the Zebra finch based on the UCSC taeGut1 assembly. Use when user asks to retrieve DNA sequences, check chromosome lengths, or perform genome-wide motif searching for Taeniopygia guttata in R.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Tguttata.UCSC.taeGut1.html
---


# bioconductor-bsgenome.tguttata.ucsc.taegut1

name: bioconductor-bsgenome.tguttata.ucsc.taegut1
description: Access and analyze the full genome sequences for Taeniopygia guttata (Zebra finch) as provided by UCSC (assembly taeGut1, Jul. 2008). Use this skill when you need to retrieve DNA sequences, check chromosome lengths, or perform genome-wide motif searching for the Zebra finch in R.

# bioconductor-bsgenome.tguttata.ucsc.taegut1

## Overview

The `BSgenome.Tguttata.UCSC.taeGut1` package is a Bioconductor data package containing the full genome sequences for the Zebra finch (*Taeniopygia guttata*). The sequences are based on the UCSC `taeGut1` assembly and are stored as `Biostrings` objects for efficient manipulation.

## Installation and Loading

To use this package, it must be installed via `BiocManager` and loaded into the R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("BSgenome.Tguttata.UCSC.taeGut1")
library(BSgenome.Tguttata.UCSC.taeGut1)
```

## Basic Usage

### Accessing the Genome Object
The main object is named after the package. You can assign it to a shorter variable for convenience:

```r
genome <- BSgenome.Tguttata.UCSC.taeGut1
genome
```

### Sequence Information
Check the available sequences (chromosomes/scaffolds) and their respective lengths:

```r
# List all sequence names
seqnames(genome)

# Get lengths of all sequences
seqlengths(genome)

# Access a specific chromosome (e.g., Chromosome 1)
genome$chr1 
# OR
genome[["chr1"]]
```

### Sequence Extraction
Extract specific sub-sequences using `getSeq`:

```r
# Extract a specific region from Chromosome 2
# Note: Coordinates are 1-based
sub_seq <- getSeq(genome, "chr2", start=1000, end=2000)
```

## Common Workflows

### Genome-wide Motif Searching
Since the genome is stored as a `BSgenome` object, you can use functions from the `Biostrings` and `BSgenome` software packages to search for patterns.

```r
library(Biostrings)

# Define a pattern (e.g., a restriction site or TATA box)
pattern <- "TATAAA"

# Search on a specific chromosome
matchPattern(pattern, genome$chr1)

# For genome-wide searching, iterate over chromosomes or use 
# specialized functions described in vignette("GenomeSearching", package="BSgenome")
```

### Exporting Sequences
You can export specific chromosomes or regions to FASTA format:

```r
writeXStringSet(DNAStringSet(genome$chr1), file="zebra_finch_chr1.fasta")
```

## Tips
- **Memory Management**: Loading entire chromosomes into memory can be intensive. Use `getSeq` with specific coordinates to minimize memory overhead.
- **Assembly Version**: This package specifically uses `taeGut1` (July 2008). Ensure this matches your experimental data or liftOver requirements.
- **Compatibility**: This package is designed to work seamlessly with `GenomicRanges` for overlap operations and `Biostrings` for sequence analysis.

## Reference documentation

- [BSgenome.Tguttata.UCSC.taeGut1 Reference Manual](./references/reference_manual.md)