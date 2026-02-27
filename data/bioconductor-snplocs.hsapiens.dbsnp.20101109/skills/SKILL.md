---
name: bioconductor-snplocs.hsapiens.dbsnp.20101109
description: This package provides SNP locations and alleles for Homo sapiens from dbSNP Build 132 mapped to the GRCh37/hg19 reference genome. Use when user asks to retrieve SNP coordinates by chromosome, look up alleles by rsID, or inject SNPs into a BSgenome object for sequence analysis.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/SNPlocs.Hsapiens.dbSNP.20101109.html
---


# bioconductor-snplocs.hsapiens.dbsnp.20101109

## Overview

The `SNPlocs.Hsapiens.dbSNP.20101109` package is a Bioconductor annotation resource containing SNP locations and alleles for Homo sapiens extracted from dbSNP Build 132. The data is mapped to the GRCh37 (hg19) reference genome. It provides efficient access to millions of single-base substitutions, allowing for coordinate lookups and integration with `BSgenome` objects.

## Basic Usage

Load the package to access the SNP data:

```r
library(SNPlocs.Hsapiens.dbSNP.20101109)
```

### Summary Statistics
Get the number of SNPs available for each sequence (chromosome):

```r
getSNPcount()
```

## Retrieving SNP Data

### By Chromosome
Use `getSNPlocs` to retrieve all SNPs for a specific chromosome. Note that chromosome names use the "ch" prefix (e.g., "ch1", "chX").

```r
# Return as a data frame (default)
ch22_snps <- getSNPlocs("ch22")

# Return as a GRanges object
ch22_gr <- getSNPlocs("ch22", as.GRanges=TRUE)
```

### By rs ID
If you have specific RefSNP IDs, use these specialized functions:

```r
my_rsids <- c("rs2639606", "rs75264089")

# Get positions (returns a named integer vector)
locs <- rsid2loc(my_rsids)

# Get alleles as IUPAC codes (returns a named character vector)
alleles <- rsid2alleles(my_rsids)

# Get as GRanges object
snps_gr <- rsidsToGRanges(my_rsids)
```

## SNP Injection into BSgenome

You can "inject" these SNPs into a reference genome to create a SNP-aware genome object. This is useful for analyzing how variants affect sequence composition or motif binding.

```r
library(BSgenome.Hsapiens.UCSC.hg19)

# Inject SNPs into hg19
# Note: injectSNPs handles the mapping between dbSNP names (ch1) and UCSC names (chr1)
hg19_with_snps <- injectSNPs(Hsapiens, "SNPlocs.Hsapiens.dbSNP.20101109")

# Check nucleotide frequencies in the modified genome
alphabetFrequency(unmasked(hg19_with_snps$chr22))
```

## Important Considerations

- **Genome Build:** This package is strictly for **GRCh37/hg19**. Do not use it with GRCh38/hg38 coordinates.
- **Chromosome Naming:** The package uses "ch1", "ch2", etc. This differs from the UCSC "chr1" convention.
- **Mitochondrial DNA:** While the package contains "chMT", it is generally incompatible with the UCSC `chrM` sequence in `BSgenome.Hsapiens.UCSC.hg19` due to assembly differences.
- **IUPAC Codes:** Alleles are stored as IUPAC ambiguity codes (e.g., 'M' for A or C). Use `Biostrings::IUPAC_CODE_MAP` to decode them.
- **SNP Types:** This package only contains single-base substitutions ("snp"). Indels and other variant types are excluded.

## Reference documentation

- [SNPlocs.Hsapiens.dbSNP.20101109 Reference Manual](./references/reference_manual.md)