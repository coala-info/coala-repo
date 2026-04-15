---
name: bioconductor-txcutr
description: This tool truncates transcriptome annotations to a specific length from the 3' end. Use when user asks to truncate transcriptomes, prepare annotations for 3'-end tag RNA-sequencing data, or export truncated GTF and FASTA files.
homepage: https://bioconductor.org/packages/release/bioc/html/txcutr.html
---

# bioconductor-txcutr

name: bioconductor-txcutr
description: Truncate transcriptome annotations to specific lengths from the 3' end. Use when processing 3'-end tag RNA-sequencing data (e.g., 10X Chromium, Lexogen Quant-Seq) to improve quantification accuracy by focusing on the relevant transcript regions.

# bioconductor-txcutr

## Overview

The `txcutr` package is designed to truncate transcriptome annotations, specifically focusing on the 3' ends of transcripts. This is particularly useful for 3'-end tag-based RNA-seq methods where reads are concentrated at the 3' terminus. By truncating the annotation to a fixed length (e.g., 500 nucleotides), users can simplify downstream analysis and improve the accuracy of transcript-level quantification.

## Installation

Install the package using `BiocManager`:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("txcutr")
```

## Core Workflow

### 1. Prepare a TxDb Object
`txcutr` operates on `TxDb` objects. You can load existing ones or create them from GTF/GFF files using `txdbmaker`.

```r
library(GenomicFeatures)
library(TxDb.Scerevisiae.UCSC.sacCer3.sgdGene)
txdb <- TxDb.Scerevisiae.UCSC.sacCer3.sgdGene
```

### 2. Truncate the Transcriptome
Use `truncateTxome` to restrict transcripts to a maximum length from their 3' end.

```r
library(txcutr)
# Truncate all transcripts to their last 500 nucleotides
txdb_truncated <- truncateTxome(txdb, maxTxLength=500)
```

### 3. Export Results
The truncated annotation can be exported to standard formats for use in aligners (like STAR) or quantifiers (like Salmon/Kallisto).

**Export GTF:**
```r
exportGTF(txdb_truncated, file="truncated_annotation.gtf.gz")
```

**Export FASTA (requires a BSgenome object):**
```r
library(BSgenome.Scerevisiae.UCSC.sacCer3)
exportFASTA(txdb_truncated, genome=BSgenome.Scerevisiae.UCSC.sacCer3, file="truncated_sequences.fa.gz")
```

### 4. Generate Merge Tables
If multiple transcripts overlap after truncation, or if they are within a certain distance, you may want to merge them for quantification purposes.

```r
# Merge transcripts within 500nt of each other
merge_table <- generateMergeTable(txdb_truncated, minDistance=500)

# Export the table
exportMergeTable(txdb_truncated, minDistance=500, file="merge_table.tsv")
```

## Advanced Usage and Tips

### Parallel Processing
Truncation can be computationally intensive for large mammalian genomes. `truncateTxome` uses `BiocParallel`. You can register a parallel backend to speed up the process:

```r
library(BiocParallel)
register(MulticoreParam(workers = 4))
# truncateTxome will now use 4 cores
```
*Note: Mammalian transcriptomes may require 3-4GB of RAM per core.*

### Pre-filtering Annotations
For high-quality results, especially with GENCODE annotations, it is recommended to filter out transcripts with unvalidated 3' ends (tagged with `mRNA_end_NF`) before processing with `txcutr`.

### Merge Logic
The `generateMergeTable` function gives preference to more distal transcripts (those further "downstream" on the strand) when assigning merged IDs.

## Reference documentation

- [Introduction to txcutr](./references/intro.md)
- [Introduction to txcutr (Rmd)](./references/intro.Rmd)