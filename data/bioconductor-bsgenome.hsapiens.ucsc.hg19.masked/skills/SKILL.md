---
name: bioconductor-bsgenome.hsapiens.ucsc.hg19.masked
description: This package provides masked human genome sequences for the hg19 assembly as Biostrings objects for genomic analysis. Use when user asks to access hg19 sequences with assembly gaps, ambiguities, or repeats masked, perform motif searching in non-repetitive regions, or manage genomic sequence masks.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Hsapiens.UCSC.hg19.masked.html
---

# bioconductor-bsgenome.hsapiens.ucsc.hg19.masked

name: bioconductor-bsgenome.hsapiens.ucsc.hg19.masked
description: Provides access to the full masked genome sequences for Homo sapiens (UCSC version hg19, GRCh37.p13) as Biostrings objects. Use this skill when you need to perform genomic analysis on the human hg19 assembly that requires masking of assembly gaps (AGAPS), intra-contig ambiguities (AMB), RepeatMasker regions (RM), or Tandem Repeats Finder (TRF) regions.

# bioconductor-bsgenome.hsapiens.ucsc.hg19.masked

## Overview

This package provides a `BSgenome` object containing the human genome (hg19/GRCh37.p13) with four specific masks applied to the sequences. Unlike the standard `BSgenome.Hsapiens.UCSC.hg19` package, this version allows for the exclusion of repetitive or ambiguous regions during analysis.

The four masks included are:
1.  **AGAPS**: Assembly gaps (active by default).
2.  **AMB**: Intra-contig ambiguities (active by default).
3.  **RM**: Repeats from RepeatMasker (inactive by default).
4.  **TRF**: Repeats from Tandem Repeats Finder (inactive by default).

## Loading and Inspection

To use the genome, load the library and assign the object to a variable:

```r
library(BSgenome.Hsapiens.UCSC.hg19.masked)
genome <- BSgenome.Hsapiens.UCSC.hg19.masked

# Check available sequences and lengths
seqnames(genome)
seqlengths(genome)

# Access a specific chromosome (returns a MaskedDNAString)
chr1 <- genome$chr1
```

## Working with Masks

The sequences in this package are `MaskedDNAString` objects. You can manage which masks are active to control which parts of the sequence are "visible" to functions like `matchPattern` or `alphabetFrequency`.

### Checking and Activating Masks

```r
# See available masks
masknames(chr1)

# Check which masks are currently active
active(masks(chr1))

# Activate RepeatMasker (RM) and Tandem Repeats Finder (TRF) masks
active(masks(chr1))["RM"] <- TRUE
active(masks(chr1))["TRF"] <- TRUE

# Deactivate a mask
active(masks(chr1))["AGAPS"] <- FALSE
```

### Removing Masks

If you need the raw sequence without any masks (equivalent to the unmasked hg19 package):

```r
# Get the unmasked DNAString
unmasked_seq <- unmasked(chr1)
```

## Common Workflows

### Genomic Analysis on Non-Masked Regions

When masks are active, many `Biostrings` functions will only operate on the "visible" (unmasked) parts of the sequence.

```r
# Calculate GC content only in non-masked regions
alphabetFrequency(chr1, as.prob = TRUE)

# Find motifs while avoiding masked repeats/gaps
matchPattern("TATA", chr1)
```

### Extracting Masked Ranges

To see exactly which regions are being hidden by a specific mask:

```r
# Get the ranges of the RepeatMasker regions
rm_ranges <- masks(chr1)[["RM"]]
```

## Tips

- **Default State**: Only `AGAPS` and `AMB` are active by default. If your analysis requires filtering out repeats, you must manually set `active(masks(seq))["RM"] <- TRUE`.
- **Memory Management**: BSgenome objects use a cache. If you iterate through all chromosomes, the cache might fill up. Use `options(verbose=TRUE)` to monitor cache behavior during large loops.
- **Compatibility**: This package is specifically for hg19. For GRCh38/hg38, use `BSgenome.Hsapiens.UCSC.hg38.masked`.

## Reference documentation

- [BSgenome.Hsapiens.UCSC.hg19.masked Reference Manual](./references/reference_manual.md)