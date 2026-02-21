---
name: bioconductor-bsgenome.hsapiens.ucsc.hg38.dbsnp151.major
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Hsapiens.UCSC.hg38.dbSNP151.major.html
---

# bioconductor-bsgenome.hsapiens.ucsc.hg38.dbsnp151.major

name: bioconductor-bsgenome.hsapiens.ucsc.hg38.dbsnp151.major
description: Access and manipulate the Homo sapiens (human) genome sequences (UCSC hg38/GRCh38.p12) with major alleles from dbSNP151 injected. Use this skill when performing bioinformatics analyses in R that require a reference genome where standard reference bases are replaced by the most frequent (major) alleles at known Single Nucleotide Variant (SNV) positions.

# bioconductor-bsgenome.hsapiens.ucsc.hg38.dbsnp151.major

## Overview

This package provides a specialized version of the human reference genome (hg38). Unlike the standard reference, this version has been modified to include the major allele (the most frequent allele according to dbSNP151) at every recorded SNV position. It is stored as a `BSgenome` object, allowing for efficient sequence retrieval and integration with the Bioconductor ecosystem (e.g., `Biostrings`, `GenomicRanges`).

## Getting Started

Load the package to make the genome object available:

```r
library(BSgenome.Hsapiens.UCSC.hg38.dbSNP151.major)

# Assign to a shorter variable for convenience
genome_maj <- BSgenome.Hsapiens.UCSC.hg38.dbSNP151.major
```

## Common Workflows

### Inspecting Genome Metadata

Check chromosome names and lengths:

```r
# View sequence lengths
seqlengths(genome_maj)

# View chromosome names
seqnames(genome_maj)
```

### Extracting Sequences

Use `getSeq()` to retrieve specific genomic sequences. The returned sequence will contain the major allele at SNV sites.

```r
# Extract a specific coordinate (e.g., a known SNP site)
chr <- "chr12"
pos <- 25241845
getSeq(genome_maj, names = chr, start = pos, end = pos)
```

### Comparing Major vs. Standard Reference

To identify differences between the major allele genome and the standard UCSC hg38 reference:

```r
library(BSgenome.Hsapiens.UCSC.hg38)
genome_ref <- BSgenome.Hsapiens.UCSC.hg38

# Compare the same position
getSeq(genome_maj, "chr12", 25241845, 25241845) # Major allele
getSeq(genome_ref, "chr12", 25241845, 25241845) # Standard reference allele
```

## Usage Tips

- **SNVs Only**: Note that only Single Nucleotide Variants were considered for injection. Indels and complex variants are not reflected in this modified genome.
- **Coordinate System**: This package uses the UCSC hg38 coordinate system (based on GRCh38.p12). Ensure your input coordinates (BED files, GRanges) match this assembly.
- **Memory Management**: `BSgenome` objects use lazy loading. Sequences are loaded into memory only when requested via `getSeq()` or similar functions.
- **Interoperability**: The object is compatible with any Bioconductor function that accepts a `BSgenome` object, such as `vmatchPattern` for motif searching or `BSgenomeViews` for managing multiple genomic regions.

## Reference documentation

- [BSgenome.Hsapiens.UCSC.hg38.dbSNP151.major](./references/reference_manual.md)