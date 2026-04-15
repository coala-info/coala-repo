---
name: bioconductor-bsgenome.hsapiens.ucsc.hg38.masked
description: This package provides the full masked genomic sequences for Homo sapiens based on the UCSC hg38/GRCh38.p14 assembly. Use when user asks to access masked human genome sequences, perform sequence analysis accounting for assembly gaps or repeats, and search for motifs in non-masked genomic regions.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Hsapiens.UCSC.hg38.masked.html
---

# bioconductor-bsgenome.hsapiens.ucsc.hg38.masked

name: bioconductor-bsgenome.hsapiens.ucsc.hg38.masked
description: Access and analyze the full masked genomic sequences for Homo sapiens (UCSC hg38/GRCh38.p14). Use this skill when you need to perform sequence analysis on the human genome while accounting for assembly gaps (AGAPS), intra-contig ambiguities (AMB), RepeatMasker regions (RM), or Tandem Repeats Finder (TRF) regions.

# bioconductor-bsgenome.hsapiens.ucsc.hg38.masked

## Overview

This package provides the UCSC hg38 (GRCh38.p14) genome for Homo sapiens with four specific masks applied to the sequences. Unlike the standard `BSgenome.Hsapiens.UCSC.hg38` package, this version returns `MaskedDNAString` objects.

**Available Masks:**
1.  **AGAPS**: Assembly gaps (Active by default).
2.  **AMB**: Intra-contig ambiguities (Active by default).
3.  **RM**: Repeats from RepeatMasker (Inactive by default).
4.  **TRF**: Repeats from Tandem Repeats Finder (Inactive by default).

## Basic Usage

### Loading the Genome
```r
library(BSgenome.Hsapiens.UCSC.hg38.masked)
genome <- BSgenome.Hsapiens.UCSC.hg38.masked

# Check sequence lengths and metadata
seqinfo(genome)
head(seqlengths(genome))
```

### Accessing Sequences
Accessing a chromosome returns a `MaskedDNAString`.
```r
chr1_masked <- genome$chr1
# or
chr1_masked <- genome[["chr1"]]
```

### Managing Masks
By default, only AGAPS and AMB are active. You can toggle masks to change how functions like `alphabetFrequency` or `matchPattern` treat the sequence.

```r
# View available masks
masknames(chr1_masked)

# Activate RepeatMasker (RM) and Tandem Repeats Finder (TRF)
active(masks(chr1_masked))["RM"] <- TRUE
active(masks(chr1_masked))["TRF"] <- TRUE

# Deactivate a mask
active(masks(chr1_masked))["AGAPS"] <- FALSE

# Get the unmasked sequence (returns a DNAString)
chr1_unmasked <- unmasked(chr1_masked)
```

## Common Workflows

### Genome-Wide Analysis
To iterate over chromosomes and perform masked analysis:
```r
for (sname in seqnames(genome)) {
  seq <- genome[[sname]]
  # The masks affect functions like countPattern or alphabetFrequency
  # Masked regions are skipped or handled as 'N' depending on the function
  freq <- alphabetFrequency(seq)
  message(sname, " processed.")
}
```

### Motif Searching
When searching for motifs, `matchPattern` will skip masked regions if the masks are active.
```r
library(Biostrings)
pattern <- "TATAWAW"
# Matches will only be found in non-masked regions
matches <- matchPattern(pattern, genome$chr1)
```

### Extracting Masked Regions
To see exactly what is being hidden by a specific mask:
```r
# Get the IRanges of the AGAPS mask
gaps_ranges <- masks(genome$chr1)[["AGAPS"]]
```

## Tips
- **Memory**: Masked genomes are memory-intensive. Use `mbsg[[seqname]]` to load one chromosome at a time rather than loading the whole genome into a list.
- **Consistency**: Ensure your `seqlevelsStyle` matches your data (e.g., "UCSC" uses "chr1", "Ensembl" uses "1"). Use `seqlevelsStyle(genome) <- "Ensembl"` if necessary.
- **Default State**: If you find no matches in a region where you expect them, check if the RM (RepeatMasker) mask is accidentally active, as it covers a large portion of the human genome.

## Reference documentation
- [BSgenome.Hsapiens.UCSC.hg38.masked Reference Manual](./references/reference_manual.md)