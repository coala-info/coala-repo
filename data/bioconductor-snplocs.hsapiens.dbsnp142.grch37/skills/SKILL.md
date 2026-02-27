---
name: bioconductor-snplocs.hsapiens.dbsnp142.grch37
description: This package provides genomic coordinates and alleles for human SNPs from dbSNP Build 142 mapped to the GRCh37 reference genome. Use when user asks to retrieve SNP locations by rs ID, get all SNPs for a specific chromosome, extract IUPAC ambiguity codes for alleles, or inject SNP data into BSgenome objects.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/SNPlocs.Hsapiens.dbSNP142.GRCh37.html
---


# bioconductor-snplocs.hsapiens.dbsnp142.grch37

name: bioconductor-snplocs.hsapiens.dbsnp142.grch37
description: Access and query human SNP locations and alleles from dbSNP Build 142 mapped to the GRCh37 (hg19) reference genome. Use this skill when you need to: (1) Retrieve genomic coordinates for specific rs IDs, (2) Get all SNPs for a specific chromosome, (3) Extract IUPAC ambiguity codes for SNP alleles, or (4) Inject SNP data into BSgenome objects for variant analysis.

# bioconductor-snplocs.hsapiens.dbsnp142.grch37

## Overview

The `SNPlocs.Hsapiens.dbSNP142.GRCh37` package is a Bioconductor annotation data package providing positions and alleles for single-base substitutions (SNPs) in *Homo sapiens*. The data is derived from dbSNP Build 142 and is mapped to the GRCh37.p13 assembly. Note that while GRCh37 is largely compatible with hg19, there are differences in the mitochondrial sequence (MT vs chrM).

## Core Workflows

### Loading the Package
```r
library(SNPlocs.Hsapiens.dbSNP142.GRCh37)
# Assign to a shorter variable for convenience
snps <- SNPlocs.Hsapiens.dbSNP142.GRCh37
```

### Querying by Chromosome
To get all SNPs on a specific chromosome, use `getSNPlocs()`. Chromosome names use the "ch" prefix (e.g., "ch1", "chX", "chMT").

```r
# Get SNP count per chromosome
getSNPcount()

# Get SNPs for chromosome 22 as a data frame (default)
ch22_df <- getSNPlocs("ch22")

# Get SNPs for multiple chromosomes as a GRanges object
ch_gr <- getSNPlocs(c("ch21", "ch22"), as.GRanges=TRUE)
```

### Querying by rs ID
If you have a list of RefSNP IDs (with or without the "rs" prefix), use these specialized functions:

```r
my_rsids <- c("rs2639606", "rs75264089")

# Get coordinates and alleles as a GRanges object
gr <- rsidsToGRanges(my_rsids)

# Get just the locations (returns a named integer vector)
locs <- rsid2loc(my_rsids)

# Get just the alleles as IUPAC codes (returns a named character vector)
alleles <- rsid2alleles(my_rsids)
```

### SNP Injection into BSgenome
You can "inject" these SNPs into a compatible BSgenome object to create a "SNPSuffixed" genome where the reference base is replaced by the IUPAC ambiguity code.

```r
library(BSgenome.Hsapiens.UCSC.hg19)
genome <- BSgenome.Hsapiens.UCSC.hg19

# Inject SNPs (automatically handles chromosome name mapping)
genome_with_snps <- injectSNPs(genome, "SNPlocs.Hsapiens.dbSNP142.GRCh37")
```

## Important Usage Notes

- **Coordinate System**: Locations are 1-based, relative to the 5' end of the plus strand.
- **Strand**: All SNPs in this package are reported with respect to the **plus strand**. If a SNP was reported on the minus strand in dbSNP, its alleles have been complemented.
- **Allele Format**: Alleles are stored as IUPAC ambiguity codes (e.g., "M" for A/C, "R" for A/G, "Y" for C/T). Use `Biostrings::IUPAC_CODE_MAP` to decode them.
- **Filtering**: This package only contains single-base substitutions ("snp"). Indels, microsatellites, and multinucleotide polymorphisms are excluded.
- **Caching**: Functions like `getSNPlocs` and `rsid2loc` have a `caching=TRUE` argument. Use this to speed up repeated lookups at the cost of memory.

## Reference documentation

- [SNPlocs.Hsapiens.dbSNP142.GRCh37 Reference Manual](./references/reference_manual.md)