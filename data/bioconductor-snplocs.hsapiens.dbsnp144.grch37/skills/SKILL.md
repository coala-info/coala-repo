---
name: bioconductor-snplocs.hsapiens.dbsnp144.grch37
description: "This package provides access to SNP positions and alleles for Homo sapiens from NCBI dbSNP Build 144 mapped to the GRCh37 reference genome. Use when user asks to retrieve SNP locations by rsID, get SNPs for specific chromosomes, or inject SNPs into a BSgenome object for genomic analysis."
homepage: https://bioconductor.org/packages/release/data/annotation/html/SNPlocs.Hsapiens.dbSNP144.GRCh37.html
---


# bioconductor-snplocs.hsapiens.dbsnp144.grch37

name: bioconductor-snplocs.hsapiens.dbsnp144.grch37
description: Access and query SNP positions and alleles for Homo sapiens from NCBI dbSNP Build 144 mapped to the GRCh37 (hg19) reference genome. Use this skill when you need to retrieve SNP locations by rsID, get all SNPs for specific chromosomes, or inject SNPs into a BSgenome object for genomic analysis.

# bioconductor-snplocs.hsapiens.dbsnp144.grch37

## Overview

The `SNPlocs.Hsapiens.dbSNP144.GRCh37` package is a Bioconductor annotation data package containing single-base substitution SNPs (class 'snp') for the human genome. It is based on NCBI dbSNP Build 144 and is mapped to the GRCh37.p13 assembly. This package is essential for workflows involving variant annotation, SNP-aware sequence analysis, and genomic range overlaps where GRCh37 coordinates are required.

## Core Workflows

### Loading the Package
```r
library(SNPlocs.Hsapiens.dbSNP144.GRCh37)
snps <- SNPlocs.Hsapiens.dbSNP144.GRCh37
```

### Querying SNP Counts
To see the distribution of SNPs across chromosomes:
```r
snpcount(snps)
```

### Retrieving SNPs by Chromosome
Use `snpsBySeqname` to get all SNPs for specific sequences. Chromosome names do not use the "chr" prefix (e.g., use "1", "X", "MT").
```r
# Get SNPs for chromosome 22
chr22_snps <- snpsBySeqname(snps, "22")

# Get SNPs for multiple chromosomes
multi_snps <- snpsBySeqname(snps, c("X", "Y"))
```

### Retrieving SNPs by rsID
Use `snpsById` to look up specific variants. The function accepts character vectors with or without the "rs" prefix.
```r
my_rsids <- c("rs2639606", "rs75264089")
my_snps <- snpsById(snps, my_rsids)
```

### Interpreting Alleles
Alleles are stored as IUPAC ambiguity codes (e.g., 'M' for A/C, 'R' for A/G). To decode them:
```r
library(Biostrings)
# View the mapping
IUPAC_CODE_MAP

# Apply to query results
alleles <- mcols(my_snps)$alleles_as_ambig
IUPAC_CODE_MAP[alleles]
```

### SNP Injection into BSgenome
You can "inject" these SNPs into a compatible BSgenome object (like `BSgenome.Hsapiens.UCSC.hg19`) to create a SNP-aware genome object where the reference base is replaced by the IUPAC code.
```r
library(BSgenome.Hsapiens.UCSC.hg19)
genome <- BSgenome.Hsapiens.UCSC.hg19
genome_with_snps <- injectSNPs(genome, "SNPlocs.Hsapiens.dbSNP144.GRCh37")
```

## Important Considerations

- **Coordinate System**: All positions are 1-based, relative to the 5' end of the plus strand.
- **Strand**: All SNPs are reported with respect to the **plus strand**, regardless of how they are reported in dbSNP.
- **SNP Class**: This package only contains single-base substitutions. For indels, microsatellites, or other variant types, use the `XtraSNPlocs.Hsapiens.dbSNP144.GRCh37` package.
- **Legacy Functions**: While functions like `getSNPlocs`, `rsid2loc`, and `rsid2alleles` exist, the preferred modern interface is using `snpsBySeqname` and `snpsById` on the package object.
- **Genome Compatibility**: While mapped to GRCh37.p13, these SNPs are compatible with UCSC hg19 for chromosomes 1-22, X, and Y. Note that the mitochondrial chromosome (MT/chrM) differs between GRCh37 and hg19.

## Reference documentation

- [SNPlocs.Hsapiens.dbSNP144.GRCh37 Reference Manual](./references/reference_manual.md)