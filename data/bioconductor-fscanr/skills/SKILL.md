---
name: bioconductor-fscanr
description: This tool detects programmed ribosomal frameshifting events from BLASTX or diamond BLASTX sequence alignments. Use when user asks to identify translational recoding events, detect ribosomal frameshifts, or analyze genomic and mRNA sequences for frame shifts using protein homolog alignments.
homepage: https://bioconductor.org/packages/3.12/bioc/html/FScanR.html
---

# bioconductor-fscanr

name: bioconductor-fscanr
description: Detect programmed ribosomal frameshifting (PRF) events from BLASTX or diamond BLASTX homolog sequence alignments. Use this skill when analyzing genomic, cDNA, or mRNA sequences against peptide libraries to identify translational recoding events (-2, -1, +1, +2 frames).

# bioconductor-fscanr

## Overview
`FScanR` is a specialized tool for identifying Programmed Ribosomal Frameshifting (PRF) events. It works by analyzing the output of BLASTX (or diamond BLASTX) alignments between a query sequence (genomic/cDNA/mRNA) and a protein database. By detecting shifts in the reading frame between high-scoring segment pairs (HSPs) that align to the same subject protein, `FScanR` can pinpoint potential recoding sites.

## Installation
```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("FScanR")
library(FScanR)
```

## Data Preparation
The input must be a tabular BLASTX or diamond BLASTX output with exactly 14 columns.

**Required BLASTX format:**
`-outfmt '6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qframe sframe'`

**Required diamond BLASTX format:**
`-outfmt 6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qframe qframe`

## Workflow

### 1. Load Alignment Data
```r
# Load your tabular BLASTX output
blast_results <- read.table("path/to/blast_output.tab", header = FALSE, sep = "\t")
```

### 2. Detect PRF Events
The primary function is `FScanR()`. It filters alignments based on E-value and the distance between frames.

```r
# Detect PRF events
prf_results <- FScanR(blast_results, evalue_cutoff = 1e-05, frameDist_cutoff = 10)

# View results
head(prf_results)
```

### 3. Parameters
- `evalue_cutoff`: Default is `1e-05`. Stricter cutoffs increase fidelity but may increase false negatives.
- `frameDist_cutoff`: Default is `10` (nt). This is the minimum distance between two segments to be considered a frameshift. It should be at least 4 nt to avoid false positives from small gaps or introns.

### 4. Interpreting Results
The output is a data frame where the `FS_type` column indicates the shift:
- `-2` or `-1`: Backward frameshifts.
- `+1` or `+2`: Forward frameshifts.

```r
# Summary of detected types
table(prf_results$FS_type)
```

## Visualization
A simple way to visualize the distribution of PRF events is via a pie chart:
```r
mytable <- table(prf_results$FS_type)
lbls <- paste(names(mytable), " : ", mytable, sep="")
pie(mytable, labels = lbls, main="PRF Events Distribution", col=cm.colors(length(mytable)))
```

## Reference documentation
- [FScanR: detect programmed ribosomal frameshifting events from various genomes](./references/FScanR.Rmd)
- [FScanR: detect programmed ribosomal frameshifting events from various genomes](./references/FScanR.md)