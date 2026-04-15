---
name: bioconductor-bsgenome.rnorvegicus.ucsc.rn5.masked
description: This package provides the masked genome sequences for Rattus norvegicus based on the UCSC rn5 assembly. Use when user asks to access rat genome sequences with assembly gaps, ambiguities, or repeat masks, manage active sequence masks, or analyze non-masked genomic regions.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Rnorvegicus.UCSC.rn5.masked.html
---

# bioconductor-bsgenome.rnorvegicus.ucsc.rn5.masked

## Overview

This package provides a `BSgenome` object containing the masked genome sequences for *Rattus norvegicus* (UCSC version rn5). Unlike the standard `BSgenome.Rnorvegicus.UCSC.rn5` package, this version includes four layers of masks:
1. **AGAPS**: Assembly gaps.
2. **AMB**: Intra-contig ambiguities.
3. **RM**: Repeats from RepeatMasker.
4. **TRF**: Repeats from Tandem Repeats Finder.

By default, only the **AGAPS** and **AMB** masks are active.

## Loading and Basic Usage

To use the genome in an R session:

```r
library(BSgenome.Rnorvegicus.UCSC.rn5.masked)

# Assign to a shorter variable for convenience
genome <- BSgenome.Rnorvegicus.UCSC.rn5.masked

# List available sequences (chromosomes)
seqnames(genome)

# Get sequence lengths
seqlengths(genome)

# Access a specific chromosome (returns a MaskedDNAString object)
chr1 <- genome$chr1
```

## Working with Masks

Because the sequences are `MaskedDNAString` objects, you can manage which masks are active or retrieve the underlying unmasked sequence.

### Managing Active Masks
```r
# View available mask names
masknames(chr1)

# Check which masks are currently active
active(masks(chr1))

# Activate RepeatMasker (RM) and Tandem Repeats Finder (TRF) masks
active(masks(chr1))["RM"] <- TRUE
active(masks(chr1))["TRF"] <- TRUE

# Deactivate a mask
active(masks(chr1))["AGAPS"] <- FALSE
```

### Retrieving Unmasked Sequences
If you need the raw sequence without any masks applied:
```r
# Returns a DNAString object
unmasked_chr1 <- unmasked(genome$chr1)
```

## Common Workflows

### Analyzing Non-Masked Regions
To perform operations only on the visible (unmasked) parts of the genome:
```r
# Calculate GC content of non-masked regions on chr1
library(Biostrings)
letterFrequency(chr1, letters="GC", as.prob=TRUE)
```

### Exporting Masked Sequences
If you need to export the sequence while respecting the active masks (e.g., replacing masked regions with Ns):
```r
# Inject Ns into masked positions
masked_to_n <- injectHardMask(chr1, letter="N")
```

## Tips
- **Memory Management**: Loading entire chromosomes as `MaskedDNAString` objects can be memory-intensive. Use `BSgenomeViews` if you only need specific genomic ranges.
- **Default State**: Remember that RM and TRF masks are present but **inactive** by default. You must manually activate them if your analysis requires repeat masking.
- **Compatibility**: This package is designed to work seamlessly with `GenomicRanges`, `Biostrings`, and `BSgenome` infrastructure.

## Reference documentation
- [BSgenome.Rnorvegicus.UCSC.rn5.masked](./references/reference_manual.md)