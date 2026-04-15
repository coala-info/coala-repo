---
name: bioconductor-snplocs.hsapiens.dbsnp141.grch38
description: This package provides access to human SNP locations and alleles from dbSNP Build 141 mapped to the GRCh38 reference genome. Use when user asks to retrieve SNP coordinates by chromosome, look up genomic locations by rsID, inject SNPs into a BSgenome object, or map rsIDs to IUPAC ambiguity codes.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/SNPlocs.Hsapiens.dbSNP141.GRCh38.html
---

# bioconductor-snplocs.hsapiens.dbsnp141.grch38

name: bioconductor-snplocs.hsapiens.dbsnp141.grch38
description: Access and manipulate Human SNP locations and alleles from dbSNP Build 141 mapped to the GRCh38 reference genome. Use this skill when you need to: (1) Retrieve SNP coordinates (1-based) for specific chromosomes, (2) Look up SNP information by rsID, (3) Inject SNPs into a BSgenome object for variant-aware sequence analysis, or (4) Map rsIDs to IUPAC ambiguity codes for alleles.

## Overview
The `SNPlocs.Hsapiens.dbSNP141.GRCh38` package is a Bioconductor annotation data package containing single-base substitutions (SNPs) for Homo sapiens. It is based on dbSNP Build 141 and the GRCh38 (hg38) assembly. It provides efficient storage and retrieval of SNP IDs (rsIDs), their genomic locations, and their alleles (represented as IUPAC ambiguity codes).

## Basic Usage

### Loading the Package
```r
library(SNPlocs.Hsapiens.dbSNP141.GRCh38)
snps <- SNPlocs.Hsapiens.dbSNP141.GRCh38
```

### Counting SNPs per Chromosome
To see the distribution of SNPs across the genome:
```r
snpcount(snps)
```

### Retrieving SNP Locations
You can retrieve SNPs for specific chromosomes. Note that chromosome names are typically prefixed with "ch" (e.g., "ch1", "chX", "chMT").

**As a Data Frame:**
```r
# Returns RefSNP_id, alleles_as_ambig, and loc (1-based)
ch22_df <- snplocs(snps, "ch22")
head(ch22_df)
```

**As a GRanges Object:**
```r
# Recommended for integration with other GenomicRanges workflows
ch22_gr <- snplocs(snps, "ch22", as.GRanges=TRUE)
```

## Working with rsIDs

### Mapping rsIDs to Genomic Coordinates
If you have a list of rsIDs, you can convert them directly to a `GRanges` object:
```r
my_rsids <- c("rs2639606", "rs75264089")
gr <- snpid2grange(snps, my_rsids)
```

### Extracting Alleles
Alleles are stored as IUPAC ambiguity codes (e.g., 'Y' for C/T). To see the actual nucleotides:
```r
library(Biostrings)
# Get codes from the GRanges object metadata
codes <- mcols(gr)$alleles_as_ambig
# Map to nucleotide sets
IUPAC_CODE_MAP[codes]
```

## SNP Injection into BSgenome
You can "inject" these SNPs into a compatible reference genome to create a SNP-aware genome object. This is useful for calculating position-specific frequencies or extracting sequences with variants.

```r
library(BSgenome.Hsapiens.NCBI.GRCh38)
genome <- BSgenome.Hsapiens.NCBI.GRCh38

# Inject SNPs
genome_with_snps <- injectSNPs(genome, "SNPlocs.Hsapiens.dbSNP141.GRCh38")

# Compare nucleotide frequencies (e.g., on chromosome 22)
alphabetFrequency(genome[["22"]])
alphabetFrequency(genome_with_snps[["22"]])
```

## Important Considerations
- **Strand:** All SNPs in this package are reported with respect to the **plus (+) strand** of the reference genome, regardless of the strand reported in dbSNP.
- **SNP Type:** This package only contains single-base substitutions ("snp"). Indels, microsatellites, and multinucleotide polymorphisms are excluded.
- **Coordinate System:** Locations are 1-based.
- **Deprecated Functions:** While `getSNPlocs`, `rsid2loc`, and `rsid2alleles` exist for backward compatibility, the preferred interface is using the `snps` object with `snplocs()` and `snpid2grange()`.
- **Chromosome Naming:** Ensure chromosome strings match the package's internal naming (usually "ch" + number/letter).

## Reference documentation
- [SNPlocs.Hsapiens.dbSNP141.GRCh38 Reference Manual](./references/reference_manual.md)