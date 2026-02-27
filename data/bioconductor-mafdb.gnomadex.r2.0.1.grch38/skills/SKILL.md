---
name: bioconductor-mafdb.gnomadex.r2.0.1.grch38
description: This package provides minor allele frequency data from the gnomAD exome variant set version 2.0.1 lifted over to the GRCh38 reference genome. Use when user asks to retrieve minor allele frequencies for genomic coordinates, query population-specific allele frequencies, or filter variants by frequency using gnomAD exome data.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MafDb.gnomADex.r2.0.1.GRCh38.html
---


# bioconductor-mafdb.gnomadex.r2.0.1.grch38

## Overview
This package provides an annotation resource containing Minor Allele Frequency (MAF) data derived from the Genome Aggregation Database (gnomAD) exome variant set (v2.0.1). The data is stored as a `GScores` object. While the original gnomAD v2.0.1 data was based on GRCh37, this specific package contains coordinates lifted over to **GRCh38**.

MAF values are stored with optimized precision to save space:
- MAF >= 0.1: Two significant digits.
- MAF < 0.1: One significant digit.

## Basic Usage

### Loading the Package
```r
library(MafDb.gnomADex.r2.0.1.GRCh38)
mafdb <- MafDb.gnomADex.r2.0.1.GRCh38
```

### Inspecting Populations
To see which specific populations (e.g., AF, AF_AFR, AF_AMR, AF_ASJ, AF_EAS, AF_FIN, AF_NFE, AF_OTH, AF_SAS) are available for querying:
```r
populations(mafdb)
```

### Querying by Genomic Coordinates
Use the `gscores()` function from the `GenomicScores` package to retrieve frequencies for specific ranges.
```r
library(GenomicRanges)
# Query a specific position on Chromosome 15
rng <- GRanges("15:28111713")
gscores(mafdb, rng)
```

### Querying by rsID
To query by SNP identifier, you must use a corresponding `SNPlocs` package for GRCh38.
```r
library(SNPlocs.Hsapiens.dbSNP149.GRCh38)
snpdb <- SNPlocs.Hsapiens.dbSNP149.GRCh38

# Get coordinates for an rsID
rng_rs <- snpsById(snpdb, ids="rs1129038")

# Retrieve MAF scores
gscores(mafdb, rng_rs)
```

## Workflows & Tips

### Filtering for Rare Variants
When processing a list of variants, you can append the MAF data to your `GRanges` object and then filter based on a threshold (e.g., < 0.01).
```r
variants <- gscores(mafdb, my_variants_granges)
rare_variants <- variants[variants$AF < 0.01]
```

### Memory Management
The package uses a "lazy loading" approach via the `GScores` class. Data for specific chromosomes is loaded into main memory only when queried. If you are performing genome-wide queries, ensure your R session has sufficient RAM, or process data chromosome by chromosome.

### Metadata and Citations
To check the data source, versioning, and how to cite this specific resource:
```r
citation(mafdb)
mafdb
```

## Reference documentation
- [MafDb.gnomADex.r2.0.1.GRCh38 Reference Manual](./references/reference_manual.md)