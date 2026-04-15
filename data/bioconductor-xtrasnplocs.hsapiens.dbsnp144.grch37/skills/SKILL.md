---
name: bioconductor-xtrasnplocs.hsapiens.dbsnp144.grch37
description: This Bioconductor package provides genomic locations and alleles for non-single-base substitution variants from dbSNP Build 144 mapped to the GRCh37 assembly. Use when user asks to retrieve complex variants like indels or microsatellites, query RefSNP IDs for non-standard SNPs, or extract variant alleles for specific genomic coordinates on the GRCh37 reference.
homepage: https://bioconductor.org/packages/release/data/annotation/html/XtraSNPlocs.Hsapiens.dbSNP144.GRCh37.html
---

# bioconductor-xtrasnplocs.hsapiens.dbsnp144.grch37

## Overview

The `XtraSNPlocs.Hsapiens.dbSNP144.GRCh37` package is a Bioconductor annotation data package providing locations and alleles for "extra" SNPs—molecular variations that are NOT single-base substitutions. While the standard `SNPlocs` packages contain only `snp` class variations, this package contains complex variants (in-dels, microsatellites, etc.) from dbSNP Build 144. Data is mapped to the GRCh37.p13 assembly (compatible with UCSC hg19 for chromosomes 1-22, X, and Y).

## Basic Usage

### Loading the Data Object
The package exposes a single `XtraSNPlocs` object named after the package.

```r
library(XtraSNPlocs.Hsapiens.dbSNP144.GRCh37)
snps <- XtraSNPlocs.Hsapiens.dbSNP144.GRCh37
```

### Querying SNP Counts
To see the total number of extra SNPs available:
```r
snpcount(snps)
```

### Retrieving SNPs by Chromosome
Use `snpsBySeqname` to get variants for specific chromosomes. Note that the default naming convention is "ch1", "ch2", ..., "chX", "chY", "chMT".

```r
# Get RefSNP ID and alleles for chromosomes 22 and Y
my_snps <- snpsBySeqname(snps, c("ch22", "chY"), columns = c("RefSNP_id", "alleles"))
```

### Retrieving SNPs by ID
Use `snpsById` to look up specific rsIDs.

```r
rsids <- c("rs367617508", "rs398104919", "rs3831697")
my_snps <- snpsById(snps, rsids, columns = c("RefSNP_id", "alleles"))
```

## Workflows

### Harmonizing with UCSC hg19
If you are working with other Bioconductor objects (like `BSgenome.Hsapiens.UCSC.hg19`) that use "chr" prefixes, you must harmonize the `seqlevelsStyle`.

```r
library(BSgenome.Hsapiens.UCSC.hg19)
genome <- BSgenome.Hsapiens.UCSC.hg19

# Change style from "dbSNP" (ch22) to "UCSC" (chr22)
seqlevelsStyle(my_snps) <- seqlevelsStyle(genome)
genome(my_snps) <- "hg19"

# Note: MT chromosomes are often incompatible between dbSNP and UCSC; 
# it is best practice to drop MT if performing cross-package overlaps.
my_snps <- keepStandardChromosomes(my_snps, pruning.mode = "tidy")
```

### Extracting Reference Alleles
Because these are "extra" SNPs (often indels), the reference allele is not stored directly in the object but can be fetched using a BSgenome object.

```r
ref_alleles <- getSeq(genome, my_snps)
# Handle empty strings (often representing deletions in some contexts)
ref_alleles[ref_alleles == ""] <- "-"
mcols(my_snps)$ref_allele <- ref_alleles
```

### Parsing Alleles
The `alleles` column returns a character string (e.g., "A/G/CT"). To compare them programmatically:

```r
alleles_list <- CharacterList(strsplit(mcols(my_snps)$alleles, "/", fixed = TRUE))
# Check if the reference allele is among the reported dbSNP alleles
is_consistent <- any(as.character(ref_alleles) == alleles_list)
```

## Tips
- **Memory Efficiency**: These objects are large. Use `snpsBySeqname` to load only the data you need for specific genomic regions.
- **Class Filtering**: This package specifically excludes standard single-base substitutions. If you need those, use `SNPlocs.Hsapiens.dbSNP144.GRCh37`.
- **Coordinate System**: Coordinates are 1-based.

## Reference documentation
- [XtraSNPlocs.Hsapiens.dbSNP144.GRCh37](./references/reference_manual.md)