---
name: bioconductor-snplocs.hsapiens.dbsnp149.grch38
description: This package provides SNP locations and alleles for the human genome assembly GRCh38 based on dbSNP build 149. Use when user asks to retrieve SNP positions by chromosome or rs ID, count SNPs across chromosomes, or inject SNPs into a BSgenome object to create a SNP-aware reference.
homepage: https://bioconductor.org/packages/release/data/annotation/html/SNPlocs.Hsapiens.dbSNP149.GRCh38.html
---


# bioconductor-snplocs.hsapiens.dbsnp149.grch38

## Overview

The `SNPlocs.Hsapiens.dbSNP149.GRCh38` package is a Bioconductor annotation data package containing single-base substitutions (SNPs) for the human genome (GRCh38.p7). It includes only "true" SNPs (single-base substitutions) that are mapped to a single location on chromosomes 1-22, X, Y, or MT. All alleles are reported with respect to the **plus strand**.

## Basic Usage

### Loading the Package
```r
library(SNPlocs.Hsapiens.dbSNP149.GRCh38)
snps <- SNPlocs.Hsapiens.dbSNP149.GRCh38
```

### Counting SNPs
To see the distribution of SNPs across chromosomes:
```r
snpcount(snps)
```

### Retrieving SNPs by Chromosome
Use `snpsBySeqname` to get a `GRanges` object containing SNP locations and IUPAC ambiguity codes for specific sequences.
```r
# Get SNPs for chromosome 22
chr22_snps <- snpsBySeqname(snps, "22")

# Get SNPs for multiple chromosomes
multi_snps <- snpsBySeqname(snps, c("X", "Y", "MT"))
```

### Retrieving SNPs by rs ID
Use `snpsById` to look up specific SNPs. The "rs" prefix is optional in the input vector.
```r
my_rsids <- c("rs2639606", "rs75264089")
my_snps <- snpsById(snps, my_rsids)
```

## SNP Injection into BSgenome

One of the primary uses of this package is to "inject" SNPs into a reference genome to create a SNP-aware genome object.

```r
library(BSgenome.Hsapiens.UCSC.hg38)
genome <- BSgenome.Hsapiens.UCSC.hg38

# Inject SNPs
genome_with_snps <- injectSNPs(genome, "SNPlocs.Hsapiens.dbSNP149.GRCh38")

# Compare frequencies (injected genome will show IUPAC codes)
alphabetFrequency(genome$chr22)
alphabetFrequency(genome_with_snps$chr22)
```

## Working with Alleles

Alleles are stored as IUPAC ambiguity codes (e.g., 'M' for A or C, 'R' for A or G). To translate these:

```r
library(Biostrings)
# View the mapping
IUPAC_CODE_MAP

# Get alleles for retrieved SNPs
codes <- mcols(my_snps)$alleles_as_ambig
# Map to nucleotides
IUPAC_CODE_MAP[codes]
```

## Important Technical Notes

1.  **Coordinate System**: Positions are 1-based, relative to the 5' end of the plus strand of the GRCh38 reference sequence.
2.  **Strand**: All SNPs are stored and reported on the **plus strand**. If dbSNP reported a SNP on the minus strand, the package stores the complement.
3.  **Defunct Functions**: Older functions like `getSNPlocs`, `rsid2loc`, and `rsid2alleles` are defunct. Always prefer `snpsBySeqname` and `snpsById`.
4.  **Assembly Compatibility**: This package is based on GRCh38.p7. It is compatible with both `BSgenome.Hsapiens.NCBI.GRCh38` and `BSgenome.Hsapiens.UCSC.hg38` (hg38 and GRCh38 share the same underlying genomic sequences).
5.  **Non-SNP Variants**: Small insertions/deletions (indels), microsatellites, and multinucleotide polymorphisms are NOT in this package. Use `XtraSNPlocs.Hsapiens.dbSNP149.GRCh38` for those variants.

## Reference documentation

- [SNPlocs.Hsapiens.dbSNP149.GRCh38 Reference Manual](./references/reference_manual.md)