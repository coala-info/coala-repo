---
name: bioconductor-bsgenome.drerio.ucsc.danrer7.masked
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Drerio.UCSC.danRer7.masked.html
---

# bioconductor-bsgenome.drerio.ucsc.danrer7.masked

name: bioconductor-bsgenome.drerio.ucsc.danrer7.masked
description: Provides full masked genome sequences for Danio rerio (Zebrafish) based on the UCSC danRer7 assembly (Jul. 2010). Use this skill when you need to perform genomic analysis on Zebrafish that requires masked sequences, such as repeat-masking (RepeatMasker/TRF) or handling assembly gaps and ambiguities.

# bioconductor-bsgenome.drerio.ucsc.danrer7.masked

## Overview

The `BSgenome.Drerio.UCSC.danRer7.masked` package is a Bioconductor data package containing the full genome of *Danio rerio* (Zebrafish) as provided by UCSC (version danRer7). This package is an extension of the standard `BSgenome.Drerio.UCSC.danRer7` package, with the addition of four specific masks:
1.  **AGAPS**: Assembly gaps.
2.  **AMB**: Intra-contig ambiguities.
3.  **RM**: Repeats from RepeatMasker.
4.  **TRF**: Repeats from Tandem Repeats Finder.

By default, only the **AGAPS** and **AMB** masks are active.

## Loading and Basic Usage

To use the genome in an R session:

```r
library(BSgenome.Drerio.UCSC.danRer7.masked)

# Assign to a shorter variable for convenience
genome <- BSgenome.Drerio.UCSC.danRer7.masked

# List available sequences (chromosomes)
seqnames(genome)

# Get sequence lengths
seqlengths(genome)
```

## Working with Masked Sequences

Accessing a chromosome returns a `MaskedDNAString` object rather than a standard `DNAString`.

```r
# Access chromosome 1
chr1 <- genome$chr1

# View active masks
active(masks(chr1))

# Toggle masks (e.g., activate RepeatMasker and TRF)
active(masks(chr1))["RM"] <- TRUE
active(masks(chr1))["TRF"] <- TRUE

# To get the unmasked sequence (identical to the non-masked BSgenome package)
unmasked_seq <- unmasked(chr1)
```

## Common Workflows

### Checking Assembly Gaps
You can verify that assembly gaps (AGAPS) contain only "N" characters:

```r
# Example for a single chromosome
seq <- genome$chr1
masks(seq) <- gaps(masks(seq)["AGAPS"])
uniqueLetters(seq) # Should return "N" if gaps are correctly masked
```

### Genome-Wide Analysis
Iterating through all chromosomes to perform analysis while respecting masks:

```r
for (seqname in seqnames(genome)) {
    seq <- genome[[seqname]]
    # Perform analysis on 'seq' which respects active masks
    # ...
}
```

## Tips
- **Memory Management**: These objects are large. Use `genome[[seqname]]` to load one chromosome at a time into memory.
- **Mask Persistence**: Changes to mask activity states are local to the object in your current session.
- **Downstream Compatibility**: Many Biostrings and GenomicRanges functions (like `matchPattern` or `vcountPattern`) respect active masks, automatically skipping masked regions.

## Reference documentation
- [BSgenome.Drerio.UCSC.danRer7.masked](./references/reference_manual.md)