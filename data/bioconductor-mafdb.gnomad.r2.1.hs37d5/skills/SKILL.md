---
name: bioconductor-mafdb.gnomad.r2.1.hs37d5
description: This package provides access to minor allele frequency data from gnomAD release 2.1 for the hs37d5 human reference genome. Use when user asks to annotate genetic variants with population frequencies, query allele frequencies by genomic coordinates or rsID, or filter variants based on gnomAD MAF thresholds.
homepage: https://bioconductor.org/packages/release/data/annotation/html/MafDb.gnomAD.r2.1.hs37d5.html
---

# bioconductor-mafdb.gnomad.r2.1.hs37d5

name: bioconductor-mafdb.gnomad.r2.1.hs37d5
description: Access and query minor allele frequency (MAF) data from gnomAD release 2.1 for the hs37d5 (GRCh37) human reference genome. Use this skill when you need to annotate genetic variants with population-specific frequencies, filter variants by MAF thresholds, or retrieve global/population frequencies for specific genomic coordinates or rsIDs.

# bioconductor-mafdb.gnomad.r2.1.hs37d5

## Overview

The `MafDb.gnomAD.r2.1.hs37d5` package is a Bioconductor annotation resource providing minor allele frequencies (MAF) from the Genome Aggregation Database (gnomAD) v2.1, mapped to the hs37d5 (GRCh37/hg19) reference genome. The data is stored as a `GScores` object, which allows for efficient, memory-mapped queries of allele frequencies across different populations.

Note: To save space, MAF values $\ge$ 0.1 are stored with two significant digits, and values < 0.1 are stored with one significant digit.

## Basic Usage

### Loading the Package and Object
The package automatically creates a `GScores` object named the same as the package.

```r
library(MafDb.gnomAD.r2.1.hs37d5)
mafdb <- MafDb.gnomAD.r2.1.hs37d5
mafdb
```

### Checking Available Populations
Use `populations()` to see which gnomAD population groups (e.g., AF, AF_AFR, AF_AMR, AF_ASJ, AF_EAS, AF_FIN, AF_NFE, AF_OTH) are available for querying.

```r
populations(mafdb)
```

## Querying Frequencies

### By Genomic Coordinates
Use `gscores()` with a `GRanges` object. Ensure the chromosome naming style matches (typically UCSC "chr1" or NCBI "1").

```r
library(GenomicRanges)
# Query a specific position on chromosome 15
rng <- GRanges("15:28356859")
gscores(mafdb, rng)
```

### By rsID
To query by rsID, you typically need a SNP location package like `SNPlocs.Hsapiens.dbSNP144.GRCh37`.

```r
library(SNPlocs.Hsapiens.dbSNP144.GRCh37)
snpdb <- SNPlocs.Hsapiens.dbSNP144.GRCh37

# Get coordinates for an rsID
rng <- snpsById(snpdb, ids="rs1129038")

# Retrieve MAF
gscores(mafdb, rng)
```

## Workflow: Annotating a VCF-like Table
If you have a data frame of variants, convert it to `GRanges` first to perform a bulk annotation.

```r
# Example data frame
variants_df <- data.frame(chr="15", pos=28356859)
query_rng <- GRanges(seqnames=variants_df$chr, ranges=IRanges(start=variants_df$pos, width=1))

# Annotate
res <- gscores(mafdb, query_rng)

# Merge back to original data
annotated_variants <- cbind(variants_df, as.data.frame(mcols(res)))
```

## Tips
- **Memory Management**: The package uses lazy loading. It only loads data into memory for the specific chromosomes and populations being queried.
- **Reference Genome**: This package is specific to **hs37d5/GRCh37**. If your data is in GRCh38, use the `MafDb.gnomAD.r2.1.GRCh38` package instead.
- **Metadata**: Use `citation(mafdb)` to get the correct reference for publications.

## Reference documentation
- [MafDb.gnomAD.r2.1.hs37d5 Reference Manual](./references/reference_manual.md)