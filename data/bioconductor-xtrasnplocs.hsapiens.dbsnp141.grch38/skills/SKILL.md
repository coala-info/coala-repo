---
name: bioconductor-xtrasnplocs.hsapiens.dbsnp141.grch38
description: This package provides access to non-single-base substitution SNP locations and allele information for Homo sapiens from NCBI dbSNP Build 141 mapped to the GRCh38 reference genome. Use when user asks to retrieve genomic coordinates for in-dels, microsatellites, or multinucleotide polymorphisms, query variants by RefSNP ID, or inspect extra SNP counts per chromosome.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/XtraSNPlocs.Hsapiens.dbSNP141.GRCh38.html
---

# bioconductor-xtrasnplocs.hsapiens.dbsnp141.grch38

name: bioconductor-xtrasnplocs.hsapiens.dbsnp141.grch38
description: Access and query extra SNP locations (non-single-base substitutions like in-dels, microsatellites, and multinucleotide polymorphisms) for Homo sapiens from NCBI dbSNP Build 141 mapped to GRCh38. Use this skill when needing to retrieve genomic coordinates, RefSNP IDs, and allele information for complex variants in the human genome.

# bioconductor-xtrasnplocs.hsapiens.dbsnp141.grch38

## Overview

The `XtraSNPlocs.Hsapiens.dbSNP141.GRCh38` package is a specialized annotation container for "extra" SNPs—molecular variations that are NOT single-base substitutions. While standard SNPlocs packages handle class `snp`, this package provides data for:
- in-del (insertions/deletions)
- heterozygous
- microsatellite
- named-locus
- no-variation
- mixed
- multinucleotide-polymorphism (MNP)

All variants are mapped to the GRCh38 reference genome and were extracted from NCBI dbSNP Build 141.

## Loading and Initialization

To use the data, load the library and assign the provider object to a variable:

```r
library(XtraSNPlocs.Hsapiens.dbSNP141.GRCh38)
snps <- XtraSNPlocs.Hsapiens.dbSNP141.GRCh38
```

## Common Workflows

### 1. Inspecting SNP Counts
Check the number of extra SNPs available per chromosome:

```r
snpcount(snps)
```

### 2. Querying by Chromosome
Retrieve variants for specific sequences. Note that dbSNP often uses "ch" prefixes (e.g., "ch22", "chMT").

```r
# Get location, ID, and alleles for specific chromosomes
my_snps <- snpsBySeqname(snps, c("ch22", "chMT"), columns=c("RefSNP_id", "alleles"))
```

### 3. Querying by RefSNP ID
If you have specific rsIDs, you can fetch their coordinates and alleles directly:

```r
my_rsids <- c("rs367617508", "rs398104919", "rs3831697")
res <- snpsById(snps, my_rsids, columns=c("RefSNP_id", "alleles"))
```

### 4. Integrating with Reference Genomes
To compare dbSNP alleles with the reference genome, use the `BSgenome` framework. Ensure `seqlevelsStyle` matches between the SNP object and the genome object.

```r
library(BSgenome.Hsapiens.NCBI.GRCh38)
genome <- BSgenome.Hsapiens.NCBI.GRCh38

# Align sequence naming styles (e.g., to NCBI style)
seqlevelsStyle(my_snps) <- seqlevelsStyle(genome)

# Extract reference alleles at SNP locations
ref_alleles <- getSeq(genome, my_snps)
```

## Tips and Usage Notes

- **Variant Classes**: This package is specifically for non-single-base substitutions. If you cannot find a specific rsID here, it is likely a standard single-base SNP located in the `SNPlocs.Hsapiens.dbSNP141.GRCh38` package instead.
- **Allele Strings**: Alleles are typically returned as a single string separated by a forward slash (e.g., "A/G/T"). Use `strsplit(alleles, "/", fixed=TRUE)` to parse them into a list.
- **Coordinate System**: The positions are 1-based genomic coordinates relative to the GRCh38 assembly.
- **Filtering**: The package only includes SNPs marked as "notwithdrawn" and those with a single reported location on chromosomes 1-22, X, Y, or MT.

## Reference documentation

- [XtraSNPlocs.Hsapiens.dbSNP141.GRCh38 Reference Manual](./references/reference_manual.md)