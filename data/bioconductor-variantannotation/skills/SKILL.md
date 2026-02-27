---
name: bioconductor-variantannotation
description: This package provides tools for reading, writing, filtering, and annotating genetic variants in VCF files within the Bioconductor R environment. Use when user asks to import VCF data, locate variants in genomic regions, predict amino acid changes, or filter large variant files.
homepage: https://bioconductor.org/packages/release/bioc/html/VariantAnnotation.html
---


# bioconductor-variantannotation

name: bioconductor-variantannotation
description: Expert guidance for the Bioconductor R package VariantAnnotation. Use this skill when you need to read, write, filter, or annotate genetic variants in VCF (Variant Call Format) files. This includes importing VCF data into R, locating variants in genomic regions (coding, intron, etc.), predicting amino acid changes, and integrating with external databases like SIFT, PolyPhen, or Ensembl VEP.

# bioconductor-variantannotation

## Overview

The `VariantAnnotation` package is the primary Bioconductor tool for managing Variant Call Format (VCF) files. It provides a robust framework for importing VCF data into specialized S4 objects (`VCF` class), allowing for efficient manipulation of genomic coordinates, genotype data, and metadata. Key capabilities include functional annotation (determining if a variant is in a coding or regulatory region), predicting the consequences of non-synonymous substitutions, and filtering large VCF files based on custom criteria.

## Core Workflows

### 1. Importing VCF Data
Use `readVcf` to load data. For large files, always use `TabixFile` and `ScanVcfParam` to subset by genomic coordinates or specific fields.

```r
library(VariantAnnotation)

# Basic import
fl <- "path/to/file.vcf.gz"
vcf <- readVcf(fl, "hg19")

# Targeted import (efficient for large files)
rng <- GRanges(seqnames="22", ranges=IRanges(50301422, 50312106))
svp <- ScanVcfParam(which=rng, info="LDAF", geno="GT")
vcf_sub <- readVcf(TabixFile(fl), "hg19", param=svp)

# Accessors
rowRanges(vcf) # Genomic positions (GRanges)
info(vcf)      # INFO field data (DataFrame)
geno(vcf)      # Genotype data (List of matrices)
```

### 2. Filtering Variants
The `filterVcf` function allows for memory-efficient filtering of large files by processing them in chunks.

```r
# Define prefilters (string-based, fast) and filters (parsed-based, detailed)
pre <- FilterRules(list(not_dbsnp = function(x) !grepl("dbsnp", x)))
filt <- FilterRules(list(is_snv = isSNV))

# Execute filtering
filterVcf(TabixFile(fl, yieldSize=10000), "hg19", "filtered.vcf", 
          prefilters=pre, filters=filt)
```

### 3. Locating Variants in Gene Models
Use `locateVariants` with a `TxDb` object to identify where variants fall relative to gene structures.

```r
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene

# Find variants in coding regions
loc <- locateVariants(vcf, txdb, CodingVariants())

# Find variants in all regions (intron, UTR, etc.)
all_loc <- locateVariants(vcf, txdb, AllVariants())
```

### 4. Predicting Coding Consequences
For variants in coding regions, `predictCoding` determines amino acid changes.

```r
library(BSgenome.Hsapiens.UCSC.hg19)
coding_changes <- predictCoding(vcf, txdb, seqSource=Hsapiens)

# Results include CONSEQUENCE (synonymous, nonsynonymous, frameshift), 
# REFAA (reference amino acid), and VARAA (variant amino acid).
```

### 5. External Annotations (VEP, SIFT, PolyPhen)
Integrate with external databases to assess variant impact.

*   **Ensembl VEP**: Use `vep_by_region(vcf)` to query the Ensembl REST API.
*   **PolyPhen/SIFT**: Use `select` on pre-computed database packages (e.g., `PolyPhen.Hsapiens.dbSNP131`).

```r
# VEP Example
res <- vep_by_region(vcf[1:100])

# PolyPhen Example
library(PolyPhen.Hsapiens.dbSNP131)
pp <- select(PolyPhen.Hsapiens.dbSNP131, keys=rsids, cols=c("PREDICTION", "PPH2PROB"))
```

## Tips for Success
*   **Coordinate Consistency**: Ensure `seqlevels` match between your VCF and `TxDb` (e.g., "22" vs "chr22"). Use `seqlevels(vcf) <- "chr22"` to fix mismatches.
*   **Memory Management**: Use `yieldSize` in `TabixFile` to iterate through massive files without crashing R.
*   **Structural Variants**: For SVs, the `ALT` field is returned as a `CharacterList` rather than a `DNAStringSet`.
*   **SnpMatrix**: Convert VCF genotypes to `snpStats` format using `genotypeToSnpMatrix(vcf)` for GWAS workflows.

## Reference documentation
- [Introduction to VariantAnnotation](./references/VariantAnnotation.md)
- [ensemblVEP: using the REST API with Bioconductor](./references/ensemblVEP.md)
- [Using filterVcf() to Select Variants from VCF Files](./references/filterVcf.md)