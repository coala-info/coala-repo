---
name: bioconductor-snplocs.hsapiens.dbsnp150.grch38
description: This package provides access to SNP positions and alleles for Homo sapiens from NCBI dbSNP Build 150 mapped to the GRCh38 reference genome. Use when user asks to retrieve genomic coordinates for specific rs IDs, query SNPs by chromosome, or inject SNPs into a BSgenome object for variant-aware analysis.
homepage: https://bioconductor.org/packages/release/data/annotation/html/SNPlocs.Hsapiens.dbSNP150.GRCh38.html
---

# bioconductor-snplocs.hsapiens.dbsnp150.grch38

name: bioconductor-snplocs.hsapiens.dbsnp150.grch38
description: Access and query SNP positions and alleles for Homo sapiens from NCBI dbSNP Build 150 mapped to GRCh38. Use this skill when you need to: (1) Retrieve genomic coordinates for specific rs IDs, (2) Get all SNPs for a specific chromosome in GRCh38, (3) Inject SNPs into a BSgenome object for variant-aware analysis, or (4) Convert between rs IDs and IUPAC ambiguity codes for human variants.

# bioconductor-snplocs.hsapiens.dbsnp150.grch38

## Overview

The `SNPlocs.Hsapiens.dbSNP150.GRCh38` package is a Bioconductor annotation data package containing single-base substitutions (SNPs) for the human genome (GRCh38.p7). It includes only "notwithdrawn" SNPs with a single reported position on chromosomes 1-22, X, Y, or MT. All alleles are reported with respect to the plus strand.

## Core Workflows

### Loading the Package and Data Object
The package exposes a `SNPlocs` object of the same name as the package.

```r
library(SNPlocs.Hsapiens.dbSNP150.GRCh38)
snps <- SNPlocs.Hsapiens.dbSNP150.GRCh38
```

### Querying SNPs by Chromosome
Use `snpsBySeqname` to retrieve all SNPs for specific chromosomes.

```r
# Get SNPs for chromosome 22
chr22_snps <- snpsBySeqname(snps, "22")

# Get SNPs for multiple chromosomes
multi_chr_snps <- snpsBySeqname(snps, c("X", "Y", "MT"))
```

### Querying SNPs by rs ID
Use `snpsById` to retrieve information for specific RefSNP identifiers. Note: The first call may be slow as it builds an internal index.

```r
my_rsids <- c("rs2639606", "rs75264089", "rs73396229")
my_snps <- snpsById(snps, my_rsids)

# Access alleles (IUPAC codes)
alleles <- mcols(my_snps)$alleles_as_ambig
```

### SNP Injection into BSgenome
You can "inject" these SNPs into a compatible BSgenome object (like `BSgenome.Hsapiens.UCSC.hg38`) to create a variant-aware genome object where the reference bases are replaced by IUPAC ambiguity codes.

```r
library(BSgenome.Hsapiens.UCSC.hg38)
genome <- BSgenome.Hsapiens.UCSC.hg38

# Create a new genome object with SNPs injected
genome_with_snps <- injectSNPs(genome, "SNPlocs.Hsapiens.dbSNP150.GRCh38")
```

## Key Functions

- `snpcount(snps)`: Returns a named integer vector of SNP counts per chromosome.
- `snpsBySeqname(snps, seqnames)`: Returns a GRanges object with SNPs for the specified sequences.
- `snpsById(snps, ids)`: Returns a GRanges object for specific rs IDs.
- `rsid2loc(rsids)`: (Defunct-style but available) Returns positions for rs IDs.
- `rsid2alleles(rsids)`: (Defunct-style but available) Returns IUPAC alleles for rs IDs.

## Important Notes

- **Coordinate System**: Positions are 1-based, relative to the 5' end of the plus strand of GRCh38.
- **Alleles**: Alleles are stored as IUPAC ambiguity codes (e.g., 'M' for A/C, 'R' for A/G). Use `Biostrings::IUPAC_CODE_MAP` to decode them.
- **Strand**: All SNPs are stored and reported on the **plus strand**, regardless of the strand reported in the original dbSNP source.
- **Data Classes**: This package only contains single-base substitutions. For indels, microsatellites, or multinucleotide polymorphisms, use the `XtraSNPlocs.Hsapiens.dbSNP150.GRCh38` package.
- **Defunct Warning**: While `getSNPlocs`, `rsid2loc`, and `rsid2alleles` are documented, the preferred modern interface is using `snpsBySeqname` and `snpsById` on the package object.

## Reference documentation

- [SNPlocs.Hsapiens.dbSNP150.GRCh38 Reference Manual](./references/reference_manual.md)