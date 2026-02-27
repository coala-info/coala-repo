---
name: bioconductor-snplocs.hsapiens.dbsnp151.grch38
description: This Bioconductor package provides genomic positions and IUPAC ambiguity codes for single-base substitutions from dbSNP Build 151 mapped to the GRCh38 human reference genome. Use when user asks to retrieve SNP locations by chromosome, look up SNP coordinates by rsID, or inject SNPs into a GRCh38 BSgenome object.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/SNPlocs.Hsapiens.dbSNP151.GRCh38.html
---


# bioconductor-snplocs.hsapiens.dbsnp151.grch38

## Overview

The `SNPlocs.Hsapiens.dbSNP151.GRCh38` package is a Bioconductor annotation data package containing single-base substitutions (SNPs) for the human genome (GRCh38.p7). It includes only "notwithdrawn" SNPs that map to a single position on chromosomes 1-22, X, Y, or MT. All alleles are reported relative to the plus strand using IUPAC ambiguity codes.

## Core Workflows

### 1. Loading the Package and Data Object
The package provides a `SNPlocs` object named exactly like the package.

```r
library(SNPlocs.Hsapiens.dbSNP151.GRCh38)
snps <- SNPlocs.Hsapiens.dbSNP151.GRCh38
```

### 2. Inspecting SNP Counts
To see the distribution of SNPs across chromosomes:

```r
# Get a named vector of SNP counts per sequence
counts <- snpcount(snps)
print(counts["22"])
```

### 3. Retrieving SNPs by Chromosome
Use `snpsBySeqname` to get all SNPs for specific chromosomes. This returns a `GPos` object (a memory-efficient representation of genomic positions).

```r
# Get SNPs for chromosome 22
chr22_snps <- snpsBySeqname(snps, "22")

# Get SNPs for multiple chromosomes
multi_snps <- snpsBySeqname(snps, c("X", "Y", "MT"))
```

### 4. Looking up SNPs by rsID
To find specific SNPs using their RefSNP identifiers:

```r
my_rsids <- c("rs2639606", "rs75264089")

# Returns a GPos object with metadata columns for RefSNP_id and alleles_as_ambig
# Note: The first call may be slow due to index building
found_snps <- snpsById(snps, my_rsids)

# Convert IUPAC codes to nucleotides
library(Biostrings)
IUPAC_CODE_MAP[mcols(found_snps)$alleles_as_ambig]
```

### 5. SNP Injection into BSgenome
You can "inject" these SNPs into a compatible reference genome to create a new genome object where the reference bases are replaced by IUPAC ambiguity codes at SNP positions.

```r
library(BSgenome.Hsapiens.UCSC.hg38)
genome <- BSgenome.Hsapiens.UCSC.hg38

# Create a new genome object with SNPs injected
genome_with_snps <- injectSNPs(genome, "SNPlocs.Hsapiens.dbSNP151.GRCh38")

# Compare nucleotide frequencies to see the effect
alphabetFrequency(genome$chr22)
alphabetFrequency(genome_with_snps$chr22)
```

## Important Notes

- **Defunct Functions**: Older functions like `getSNPlocs`, `rsid2loc`, and `rsid2alleles` are defunct. Always use `snpsBySeqname` and `snpsById`.
- **Coordinate System**: Positions are 1-based, relative to the 5' end of the plus strand.
- **Strand**: All SNPs are stored and reported on the **plus strand**, regardless of the strand reported in the original dbSNP source.
- **SNP Classes**: This package only contains single-base substitutions. For other variations (in-dels, microsatellites, etc.), use the `XtraSNPlocs.Hsapiens.dbSNP151.GRCh38` package.
- **Assembly Compatibility**: While based on GRCh38.p7, these SNPs are compatible with both `BSgenome.Hsapiens.NCBI.GRCh38` and `BSgenome.Hsapiens.UCSC.hg38`.

## Reference documentation
- [SNPlocs.Hsapiens.dbSNP151.GRCh38](./references/reference_manual.md)