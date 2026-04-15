---
name: bioconductor-snplocs.hsapiens.dbsnp.20120608
description: This package provides access to SNP locations and alleles for Homo sapiens from dbSNP Build 137 mapped to the GRCh37.p5 assembly. Use when user asks to retrieve SNP coordinates by chromosome, query locations and alleles by rs identifier, or inject SNPs into a human reference genome for sequence analysis.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/SNPlocs.Hsapiens.dbSNP.20120608.html
---

# bioconductor-snplocs.hsapiens.dbsnp.20120608

name: bioconductor-snplocs.hsapiens.dbsnp.20120608
description: Access and manipulate SNP locations and alleles for Homo sapiens from dbSNP Build 137 (mapped to GRCh37.p5/hg19). Use this skill when you need to retrieve SNP coordinates, IUPAC ambiguity codes for alleles, or inject SNPs into a reference genome for human genomic analysis in R.

# bioconductor-snplocs.hsapiens.dbsnp.20120608

## Overview
This package provides a data-driven interface to single-base substitution SNPs (single nucleotide polymorphisms) for the human genome, specifically from dbSNP Build 137. It is designed to work with the GRCh37.p5 assembly, which is largely compatible with UCSC hg19. The package allows for efficient retrieval of SNP positions and alleles by chromosome or by specific RefSNP (rs) identifiers.

## Core Workflows

### Loading the Package
```r
library(SNPlocs.Hsapiens.dbSNP.20120608)
```

### Retrieving SNP Counts and Locations
To see how many SNPs are available per chromosome:
```r
getSNPcount()
```

To extract SNPs for a specific chromosome (e.g., Chromosome 22):
```r
# As a data frame (default)
ch22_snps <- getSNPlocs("ch22")

# As a GRanges object (recommended for genomic intervals)
ch22_gr <- getSNPlocs("ch22", as.GRanges=TRUE)
```

### Querying by rs ID
If you have a list of specific rs identifiers, use these functions to find their coordinates or alleles:
```r
my_rsids <- c("rs2639606", "rs75264089")

# Get locations and alleles as a GRanges object
gr <- rsidsToGRanges(my_rsids)

# Get just locations (returns a named integer vector)
locs <- rsid2loc(my_rsids)

# Get just alleles as IUPAC codes (returns a named character vector)
alleles <- rsid2alleles(my_rsids)
```

### SNP Injection into BSgenome
You can "inject" these SNPs into a reference genome to create a SNP-aware genome object. This is useful for sequence analysis where you want to account for known variations.
```r
library(BSgenome.Hsapiens.UCSC.hg19)
genome <- BSgenome.Hsapiens.UCSC.hg19

# Inject SNPs into the genome object
snp_genome <- injectSNPs(genome, "SNPlocs.Hsapiens.dbSNP.20120608")
```

## Important Considerations
- **Coordinate System**: Locations are 1-based, relative to the 5' end of the plus strand.
- **Strand**: All SNPs in this package are reported with respect to the **plus strand**. If a SNP was originally reported on the minus strand in dbSNP, its alleles have been complemented.
- **Chromosome Naming**: The package uses names like `ch1`, `ch2`, ..., `chX`, `chY`, `chMT`. Note that `injectSNPs` automatically handles the mapping between these names and UCSC names (e.g., `chr1`).
- **Genome Compatibility**: These SNPs are mapped to GRCh37.p5. While compatible with hg19 for chromosomes 1-22, X, and Y, the mitochondrial chromosome (`chMT`) differs from the UCSC `chrM` and will typically be excluded during injection into `BSgenome.Hsapiens.UCSC.hg19`.
- **Allele Codes**: Alleles are stored as IUPAC nucleotide ambiguity codes. Use `Biostrings::IUPAC_CODE_MAP` to decode them (e.g., `M` represents `A` or `C`).

## Reference documentation
- [SNPlocs.Hsapiens.dbSNP.20120608 Reference Manual](./references/reference_manual.md)