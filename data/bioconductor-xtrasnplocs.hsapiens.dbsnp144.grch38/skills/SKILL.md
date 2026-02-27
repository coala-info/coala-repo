---
name: bioconductor-xtrasnplocs.hsapiens.dbsnp144.grch38
description: This Bioconductor package provides genomic coordinates and allele information for non-single-base substitutions in the human genome based on NCBI dbSNP Build 144 and GRCh38. Use when user asks to retrieve locations for human in-dels or microsatellites, query extra SNP data by RefSNP ID, or access non-standard variant information for GRCh38.
homepage: https://bioconductor.org/packages/release/data/annotation/html/XtraSNPlocs.Hsapiens.dbSNP144.GRCh38.html
---


# bioconductor-xtrasnplocs.hsapiens.dbsnp144.grch38

name: bioconductor-xtrasnplocs.hsapiens.dbsnp144.grch38
description: Access and query extra SNP locations (non-single-base substitutions like in-dels, microsatellites, and mixed variants) for Homo sapiens from NCBI dbSNP Build 144 mapped to GRCh38. Use this skill when you need to retrieve genomic coordinates, RefSNP IDs, and allele information for human variants that are NOT standard single-nucleotide polymorphisms (SNPs).

# bioconductor-xtrasnplocs.hsapiens.dbsnp144.grch38

## Overview

The `XtraSNPlocs.Hsapiens.dbSNP144.GRCh38` package is a Bioconductor annotation data package containing "extra" molecular variations for the human genome (GRCh38.p2). Unlike the standard `SNPlocs` packages which only contain single-base substitutions (class "snp"), this package provides data for:
- In-dels (insertions/deletions)
- Heterozygous variations
- Microsatellites
- Named-loci
- Mixed and multinucleotide polymorphisms (MNPs)

The data is based on NCBI dbSNP Build 144 and is mapped to chromosomes 1-22, X, Y, and MT.

## Basic Usage

### Loading the Data
To use the package, load the library and assign the main object to a variable for easier access.

```r
library(XtraSNPlocs.Hsapiens.dbSNP144.GRCh38)
snps <- XtraSNPlocs.Hsapiens.dbSNP144.GRCh38
```

### Inspecting the Dataset
Use `snpcount()` to see the distribution of extra SNPs across sequences.

```r
snpcount(snps)
```

### Querying by Sequence Name
Retrieve variants for specific chromosomes using `snpsBySeqname()`. Note that sequence names in this package typically use the "ch" prefix (e.g., "ch1", "chMT").

```r
# Get RefSNP ID and alleles for chromosome 22 and Mitochondrial DNA
my_snps <- snpsBySeqname(snps, c("ch22", "chMT"), columns=c("RefSNP_id", "alleles"))
```

### Querying by RefSNP ID
If you have specific rsIDs, use `snpsById()`.

```r
rsids <- c("rs367617508", "rs398104919", "rs3831697")
my_snps_info <- snpsById(snps, rsids, columns=c("RefSNP_id", "alleles"))
```

## Common Workflows

### Harmonizing Sequence Styles
When working with other Bioconductor objects (like `BSgenome`), you must ensure the `seqlevelsStyle` matches (e.g., "UCSC" vs "NCBI").

```r
library(BSgenome.Hsapiens.UCSC.hg38)
genome <- BSgenome.Hsapiens.UCSC.hg38

# Change style of the SNP object to match the genome
seqlevelsStyle(my_snps) <- seqlevelsStyle(genome)
genome(my_snps) <- "hg38"
```

### Extracting Reference Alleles
Since this package provides the variant alleles but not explicitly the reference allele in a separate column, you can extract it using a `BSgenome` object.

```r
# Extract reference sequence at the variant locations
ref_alleles <- getSeq(genome, my_snps)

# Handle empty strings (often representing deletions in this context)
ref_alleles[ref_alleles == ""] <- "-"

# Add to metadata columns
mcols(my_snps)$ref_allele <- ref_alleles
```

### Parsing Alleles
The `alleles` column is returned as a character string (e.g., "A/G" or "-/T"). To compare them programmatically, split the strings.

```r
all_alleles <- mcols(my_snps)$alleles
allele_list <- CharacterList(strsplit(all_alleles, "/", fixed=TRUE))
```

## Tips
- **Memory Efficiency**: The package uses an on-disk representation. Querying specific chromosomes or IDs is more memory-efficient than loading the entire dataset.
- **Class Filtering**: Remember that this package *excludes* class "snp". If you cannot find a specific rsID here, it is likely a single-base substitution and can be found in `SNPlocs.Hsapiens.dbSNP144.GRCh38`.
- **Coordinate System**: The positions are 1-based.

## Reference documentation
- [XtraSNPlocs.Hsapiens.dbSNP144.GRCh38 Reference Manual](./references/reference_manual.md)