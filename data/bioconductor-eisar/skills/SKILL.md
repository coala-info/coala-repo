---
name: bioconductor-eisar
description: The eisaR package performs Exon-Intron Split Analysis to distinguish between transcriptional and post-transcriptional gene regulation using RNA-seq data. Use when user asks to perform Exon-Intron Split Analysis, quantify exonic and intronic reads, or generate reference files for RNA velocity analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/eisaR.html
---

# bioconductor-eisar

## Overview
The `eisaR` package facilitates Exon-Intron Split Analysis (EISA). By separately quantifying exonic (mature RNA) and intronic (pre-mRNA) reads, users can distinguish between transcriptional regulation (changes in both) and post-transcriptional regulation (changes in exons only). It also provides utilities to build reference objects for alignment-free tools like Salmon/Alevin used in RNA velocity analysis.

## Installation
```r
if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("eisaR")
```

## Exon-Intron Split Analysis (EISA) Workflow

### 1. Prepare Annotations
Extract filtered exonic and gene body regions from a `TxDb` or `EnsDb` object.
```r
library(eisaR)
# strandedData = TRUE for strand-specific RNA-seq
reg <- getRegionsFromTxDb(txdb = txdb, strandedData = TRUE)
# Access ranges: reg$exons and reg$genebodies
```

### 2. Quantify Reads
Count alignments in exons and gene bodies. Intronic counts are derived by subtracting exonic counts from gene body counts.
```r
# Example using QuasR, but any count table (genes x samples) works
cntEx <- qCount(proj, reg$exons)
cntGb <- qCount(proj, reg$genebodies)
cntIn <- cntGb - cntEx
```

### 3. Run EISA
Use `runEISA` to perform the statistical analysis. It identifies quantifiable genes and fits a model (typically via `edgeR`) to find significant interactions between region (exon/intron) and condition.
```r
# rEx and rIn are count matrices (no width column)
# cond is a factor defining experimental groups
res <- runEISA(rEx, rIn, cond)

# To use the original 2015 algorithm:
res_orig <- runEISA(rEx, rIn, cond, method = "Gaidatzis2015")
```

### 4. Visualize Results
Plot the relationship between intronic and exonic log-fold changes.
```r
plotEISA(res)
```

## RNA Velocity Reference Preparation
Prepare references for estimating spliced and unspliced abundances with alignment-free methods (Salmon, kallisto).

### Generate Feature Ranges
Create a `GRangesList` containing spliced transcripts and introns (with optional flanking sequences).
```r
grl <- getFeatureRanges(
    gtf = "path/to/annotation.gtf",
    featureType = c("spliced", "intron"),
    intronType = "separate",
    flankLength = 50L
)
```

### Export Reference Files
Extract sequences and create mapping tables for downstream tools.
```r
# Extract sequences (requires a BSgenome object or FASTA)
seqs <- GenomicFeatures::extractTranscriptSeqs(BSgenome.Hsapiens.UCSC.hg38, transcripts = grl)
Biostrings::writeXStringSet(seqs, "transcriptome_plus_introns.fa")

# Export mapping and GTF
tx2gene <- getTx2Gene(grl)
exportToGtf(grl, filepath = "expanded_annotation.gtf")
```

## Reference documentation
- [Using eisaR for Exon-Intron Split Analysis (EISA)](./references/eisaR.md)
- [Generating reference files for spliced and unspliced abundance estimation](./references/rna-velocity.md)