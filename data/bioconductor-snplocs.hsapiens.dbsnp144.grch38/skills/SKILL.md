---
name: bioconductor-snplocs.hsapiens.dbsnp144.grch38
description: This package provides access to human SNP locations and alleles from NCBI dbSNP Build 144 mapped to the GRCh38 reference genome. Use when user asks to retrieve SNP coordinates by rs ID, look up IUPAC ambiguity codes for alleles, or inject SNPs into BSgenome objects for genomic analysis.
homepage: https://bioconductor.org/packages/release/data/annotation/html/SNPlocs.Hsapiens.dbSNP144.GRCh38.html
---

# bioconductor-snplocs.hsapiens.dbsnp144.grch38

name: bioconductor-snplocs.hsapiens.dbsnp144.grch38
description: Access and manipulate human SNP locations and alleles from NCBI dbSNP Build 144 mapped to the GRCh38 reference genome. Use this skill when you need to retrieve SNP coordinates (rs IDs), IUPAC ambiguity codes for alleles, or inject SNPs into BSgenome objects for genomic analysis in R.

# bioconductor-snplocs.hsapiens.dbsnp144.grch38

## Overview
The `SNPlocs.Hsapiens.dbSNP144.GRCh38` package is a Bioconductor annotation data package containing single-base substitutions (SNPs) for Homo sapiens. It is based on NCBI dbSNP Build 144 and mapped to the GRCh38.p2 assembly. It provides efficient access to SNP positions and alleles for chromosomes 1-22, X, Y, and MT.

## Core Workflows

### Loading the Package
```r
library(SNPlocs.Hsapiens.dbSNP144.GRCh38)
snps <- SNPlocs.Hsapiens.dbSNP144.GRCh38
```

### Inspecting SNP Counts
To see the distribution of SNPs across chromosomes:
```r
# Returns a named integer vector
snpcount(snps)
```

### Retrieving SNPs by Chromosome
Use `snpsBySeqname` to get all SNPs for specific sequences.
```r
# Get SNPs for chromosome 22
chr22_snps <- snpsBySeqname(snps, "22")

# Get SNPs for multiple chromosomes
multi_snps <- snpsBySeqname(snps, c("X", "Y", "MT"))
```
The result is a `GRanges` object where:
- `pos(obj)`: 1-based location on the plus strand.
- `mcols(obj)$RefSNP_id`: The rs ID (without "rs" prefix).
- `mcols(obj)$alleles_as_ambig`: IUPAC ambiguity code for the alleles.

### Retrieving SNPs by rs ID
Use `snpsById` to look up specific variants.
```r
my_rsids <- c("rs2639606", "rs75264089")
my_snps <- snpsById(snps, my_rsids)
```

### Translating Allele Codes
Alleles are stored as IUPAC codes. To see the actual nucleotides:
```r
library(Biostrings)
IUPAC_CODE_MAP[mcols(my_snps)$alleles_as_ambig]
```

### SNP Injection into BSgenome
You can "inject" these SNPs into a compatible BSgenome object to create a SNP-aware genome.
```r
library(BSgenome.Hsapiens.UCSC.hg38)
genome <- BSgenome.Hsapiens.UCSC.hg38

# Inject SNPs
genome_with_snps <- injectSNPs(genome, "SNPlocs.Hsapiens.dbSNP144.GRCh38")

# Check differences in nucleotide frequencies
alphabetFrequency(genome$chr22)
alphabetFrequency(genome_with_snps$chr22)
```

## Important Considerations
- **Single-Base Substitutions Only**: This package only contains "snp" class variants. For indels, microsatellites, or multinucleotide polymorphisms, use the `XtraSNPlocs.Hsapiens.dbSNP144.GRCh38` package.
- **Plus Strand Convention**: All alleles and positions are reported relative to the plus strand of the reference genome, regardless of the strand reported in dbSNP.
- **Legacy Functions**: While `getSNPlocs()`, `rsid2loc()`, and `rsid2alleles()` exist, the preferred modern interface is using the `snpsBySeqname()` and `snpsById()` methods on the package object.
- **Coordinate System**: Positions are 1-based.

## Reference documentation
- [SNPlocs.Hsapiens.dbSNP144.GRCh38 Reference Manual](./references/reference_manual.md)