---
name: bioconductor-bsgenome.hsapiens.ucsc.hg38.dbsnp151.minor
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Hsapiens.UCSC.hg38.dbSNP151.minor.html
---

# bioconductor-bsgenome.hsapiens.ucsc.hg38.dbsnp151.minor

name: bioconductor-bsgenome.hsapiens.ucsc.hg38.dbsnp151.minor
description: Provides full genome sequences for Homo sapiens (UCSC hg38/GRCh38.p12) with injected minor alleles from dbSNP151. Use this skill when you need to perform sequence analysis, alignment, or variant effect prediction using a human reference genome where common SNVs (MAF > 0.01) have been replaced with their most frequent minor allele.

# bioconductor-bsgenome.hsapiens.ucsc.hg38.dbsnp151.minor

## Overview

This package provides a specialized version of the human genome (hg38) where specific positions have been modified to reflect minor alleles. It is based on dbSNP151 data, specifically targeting common single nucleotide variants (SNVs) with an alternate allele frequency greater than 0.01. For sites with multiple alternate alleles, the most frequent minor allele was selected for injection. This is particularly useful for reducing reference bias in genomic studies or for specific allele-aware bioinformatics workflows.

## Basic Usage

### Loading the Genome
To use the genome, load the package and assign the object to a variable for easier access.

```r
library(BSgenome.Hsapiens.UCSC.hg38.dbSNP151.minor)
genome_min <- BSgenome.Hsapiens.UCSC.hg38.dbSNP151.minor
```

### Inspecting Sequence Information
You can check chromosome names and lengths using standard `BSgenome` methods.

```r
# View available sequences
seqnames(genome_min)

# View chromosome lengths
head(seqlengths(genome_min))
```

### Extracting Sequences
Use `getSeq` to retrieve specific genomic regions. The returned sequence will contain the injected minor alleles at the relevant dbSNP151 positions.

```r
# Example: Getting the nucleotide at a specific SNP position (e.g., rs12813551)
# This position in the 'minor' genome contains the minor allele
chr <- "chr12"
pos <- 25241845
getSeq(genome_min, chr, start=pos, end=pos)
```

## Comparative Workflows

It is often useful to compare the minor allele genome against the standard reference or the major allele version.

### Comparison with Standard hg38
```r
if (require(BSgenome.Hsapiens.UCSC.hg38)) {
  genome_ref <- BSgenome.Hsapiens.UCSC.hg38
  # Compare the same position
  ref_base <- getSeq(genome_ref, chr, start=pos, end=pos)
  min_base <- getSeq(genome_min, chr, start=pos, end=pos)
  print(paste("Reference:", ref_base, "Minor:", min_base))
}
```

### Comparison with Major Allele Genome
```r
if (require(BSgenome.Hsapiens.UCSC.hg38.dbSNP151.major)) {
  genome_maj <- BSgenome.Hsapiens.UCSC.hg38.dbSNP151.major
  maj_base <- getSeq(genome_maj, chr, start=pos, end=pos)
  print(paste("Major Allele:", maj_base))
}
```

## Tips and Best Practices
- **Coordinate System**: This package uses UCSC coordinates (e.g., "chr1", "chr2"). Ensure your input data matches this naming convention.
- **Memory Management**: BSgenome objects use lazy loading, but extracting very large sequences can consume significant RAM.
- **Integration**: This object is compatible with other Bioconductor packages like `GenomicRanges`, `Biostrings`, and `GenomicFeatures`. You can pass `genome_min` as the `genome` argument in many functions.

## Reference documentation
- [BSgenome.Hsapiens.UCSC.hg38.dbSNP151.minor Reference Manual](./references/reference_manual.md)