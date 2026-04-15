---
name: bioconductor-pasillabamsubset
description: This package provides subsetted BAM files and chromosome sequences from the Pasilla RNA-Seq experiment for testing and teaching purposes. Use when user asks to access sample NGS data, retrieve example single-end or paired-end alignments, or obtain Drosophila melanogaster chromosome 4 reference sequences.
homepage: https://bioconductor.org/packages/release/data/experiment/html/pasillaBamSubset.html
---

# bioconductor-pasillabamsubset

name: bioconductor-pasillabamsubset
description: Provides access to subsetted BAM files and chromosome sequences from the Pasilla RNA-Seq experiment. Use this skill when a user needs sample data for testing NGS bioinformatics workflows in R, specifically for single-end (untreated1) and paired-end (untreated3) alignments to Drosophila melanogaster chromosome 4.

# bioconductor-pasillabamsubset

## Overview
The `pasillaBamSubset` package is a data experiment package providing small, manageable BAM files and FASTA sequences derived from the "Pasilla" knock-down experiment (Brooks et al., 2011). It is primarily used as a teaching and testing resource for Bioconductor packages that handle high-throughput sequencing data, such as `Rsamtools`, `GenomicAlignments`, and `GenomicFeatures`.

The package contains:
- `untreated1_chr4.bam`: Single-end reads aligned to chromosome 4.
- `untreated3_chr4.bam`: Paired-end reads aligned to chromosome 4.
- `dm3_chr4.fa`: DNA sequence for D. melanogaster chromosome 4 (BDGP Release 5/dm3).

## Data Access and Usage
The package provides accessor functions that return the full system path to the data files. These paths are then passed to other Bioconductor tools for analysis.

### Loading the Package
```r
library(pasillaBamSubset)
```

### Retrieving File Paths
Use these functions to locate the bundled files on your local system:
```r
# Get path to single-end BAM
se_bam <- untreated1_chr4()

# Get path to paired-end BAM
pe_bam <- untreated3_chr4()

# Get path to chromosome 4 FASTA
chr4_fasta <- dm3_chr4()
```

### Common Workflows

#### 1. Reading Alignments
Use `GenomicAlignments` to load the data into R:
```r
library(GenomicAlignments)

# Read single-end reads
gal_se <- readGAlignments(untreated1_chr4())

# Read paired-end reads
gal_pe <- readGAlignmentPairs(untreated3_chr4())
```

#### 2. Inspecting BAM Headers
Use `Rsamtools` to check the sequence lengths or scan the BAM file:
```r
library(Rsamtools)

bam_file <- untreated1_chr4()
scanBamHeader(bam_file)
```

#### 3. Working with the Reference Sequence
Load the FASTA file using `Biostrings`:
```r
library(Biostrings)

dna <- readDNAStringSet(dm3_chr4())
# Access the sequence for chr4
chr4_seq <- dna[[1]]
```

## Tips
- **Subset Scope**: Remember that these files only contain data for chromosome 4. If you attempt to overlap these reads with genomic features on other chromosomes, you will get zero results.
- **Coordinate System**: The data is aligned to the `dm3` (BDGP Release 5) assembly. Ensure any annotation objects (like TxDb) used alongside this data also use the `dm3` genome build.
- **Indexing**: The BAM files in this package are typically accompanied by `.bai` index files in the same directory, allowing for immediate use with functions requiring indexed BAMs.

## Reference documentation
- [pasillaBamSubset Reference Manual](./references/reference_manual.md)