---
name: bioconductor-yeastrnaseq
description: This package provides access to yeast RNA-Seq experiment data from the Lee et al. (2008) study, including raw FASTQ files, Bowtie alignments, and gene-level counts. Use when user asks to load yeast RNA-Seq datasets, access raw sequencing reads for S. cerevisiae, or retrieve pre-computed gene expression matrices for wild-type and mutant strains.
homepage: https://bioconductor.org/packages/release/data/experiment/html/yeastRNASeq.html
---

# bioconductor-yeastrnaseq

name: bioconductor-yeastrnaseq
description: Access and process yeast RNA-Seq experiment data from the Lee et al. (2008) study. Use this skill to load raw FASTQ reads, Bowtie alignments, and pre-computed gene-level counts for S. cerevisiae wild-type and mutant strains.

## Overview

The `yeastRNASeq` package is an experiment data package providing a subset of RNA-Seq data comparing wild-type yeast to a mutant strain. It includes raw sequence files, aligned reads, and annotation data. This package is primarily used for demonstrating sequencing data analysis workflows in Bioconductor, particularly with `ShortRead` and `IRanges`.

## Data Access and Loading

The package provides data in three formats: raw files (FASTQ/Bowtie), aligned R objects, and summarized count matrices.

### Accessing Raw Files
Raw data files are stored in the package's `reads` directory.
```r
library(yeastRNASeq)
# List available FASTQ and Bowtie alignment files
data_path <- system.file("reads", package = "yeastRNASeq")
list.files(data_path)
```

### Loading Pre-aligned Data
The package includes `yeastAligned`, a list of `AlignedRead` objects (from the `ShortRead` package) for four lanes: `mut_1_f`, `mut_2_f`, `wt_1_f`, and `wt_2_f`.
```r
data(yeastAligned)
# Inspect a specific lane
yeastAligned[["mut_1_f"]]
```

### Loading Annotation and Count Data
- `yeastAnno`: A `data.frame` containing Ensembl gene annotations (ID, chromosome, start, end, strand, and biotype).
- `geneLevelData`: A matrix of raw counts per gene across the four lanes.
```r
data(yeastAnno)
data(geneLevelData)

# View gene biotypes
table(yeastAnno$gene_biotype)

# View top of count matrix
head(geneLevelData)
```

## Typical Workflow: Processing Raw Alignments

To process the raw Bowtie files into R objects manually:

```r
library(ShortRead)
# Identify Bowtie files
files <- list.files(system.file("reads", package = "yeastRNASeq"), 
                    pattern = "bowtie", full.names = TRUE)
names(files) <- gsub("\\.bowtie.*", "", basename(files))

# Read alignments into a list of AlignedRead objects
aligned_list <- lapply(files, readAligned, type = "Bowtie")
```

## Usage Tips
- **Replicates**: Note that the four lanes represent two lanes per condition (mutant vs. wild-type), but they are technical replicates, not biological replicates.
- **Alignment Info**: The reads were aligned to the yeast genome (S. cerevisiae) using Bowtie. The `yeastAligned` object contains approximately 82-86% of the original 500,000 reads per lane.
- **Integration**: This dataset is designed to be used with `Genominator` or `DESeq2` for practicing differential expression analysis, though the lack of biological replicates should be noted in formal statistical contexts.

## Reference documentation

- [yeastRNASeq](./references/yeastRNASeq.md)