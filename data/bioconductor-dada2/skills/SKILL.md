---
name: bioconductor-dada2
description: This tool performs high-resolution sample inference from amplicon sequencing data to identify exact amplicon sequence variants. Use when user asks to filter and trim reads, learn sequencing error rates, infer amplicon sequence variants, merge paired-end reads, or remove chimeric sequences.
homepage: https://bioconductor.org/packages/release/bioc/html/dada2.html
---


# bioconductor-dada2

name: bioconductor-dada2
description: High-resolution sample inference from amplicon sequencing data using the DADA2 algorithm. Use this skill when processing marker-gene data (e.g., 16S, 18S, ITS) to perform quality filtering, error rate learning, ASV inference, and chimera removal in R.

## Overview

The `dada2` package implements a complete pipeline to turn raw FASTQ files into a table of Amplicon Sequence Variants (ASVs). Unlike traditional OTU-picking methods that cluster sequences by similarity (e.g., 97%), DADA2 uses a probabilistic model of sequencing errors to infer exact biological sequences. This results in higher resolution, better reproducibility, and fewer spurious sequences.

## Core Workflow

The standard DADA2 workflow follows these sequential steps:

### 1. Filter and Trim
Use `filterAndTrim()` to remove low-quality ends, adapters, or primers and filter out reads with too many expected errors.
```r
filterAndTrim(fwd = fnF, filt = filtF, rev = fnR, filt.rev = filtR,
              trimLeft = 10, truncLen = c(240, 200),
              maxN = 0, maxEE = 2, compress = TRUE)
```
*   **Note:** For paired-end data, ensure `truncLen` leaves enough overlap (>20bp) for merging.

### 2. Learn Error Rates
The algorithm learns the specific error profile of your sequencing run using `learnErrors()`.
```r
errF <- learnErrors(filtF, multithread = TRUE)
errR <- learnErrors(filtR, multithread = TRUE)
```

### 3. Dereplication
Collapse identical reads into unique sequences to reduce computation time while retaining quality summaries.
```r
derepF <- derepFastq(filtF)
derepR <- derepFastq(filtR)
```

### 4. Sample Inference
Apply the core DADA2 denoising algorithm using the learned error models.
```r
dadaF <- dada(derepF, err = errF, multithread = TRUE)
dadaR <- dada(derepR, err = errR, multithread = TRUE)
```

### 5. Merge Paired Reads
Align and merge forward and reverse reads to reconstruct the full amplicon.
```r
mergers <- mergePairs(dadaF, derepF, dadaR, derepR)
```

### 6. Construct Sequence Table
Create an ASV table (analogous to an OTU table) where rows are samples and columns are sequences.
```r
seqtab <- makeSequenceTable(mergers)
```

### 7. Remove Chimeras
Identify and remove chimeric sequences that were formed during PCR.
```r
seqtab.nochim <- removeBimeraDenovo(seqtab, method = "consensus", multithread = TRUE)
```

## Key Functions and Tips

- **Quality Inspection:** Use `plotQualityProfile(filenames)` to visualize where quality drops off before deciding on `truncLen`.
- **Multithreading:** Most heavy functions support `multithread = TRUE` to speed up processing on compatible systems.
- **Gzip Support:** `dada2` reads and writes `.fastq.gz` files natively; there is no need to decompress data.
- **Taxonomy Assignment:** After creating the ASV table, use `assignTaxonomy(seqtab.nochim, "path/to/reference_train_set.fa.gz")` to assign genus-level taxonomy.
- **Downstream Analysis:** The final ASV table is a standard R matrix. It is highly compatible with the `phyloseq` package for visualization and statistical analysis.

## Reference documentation

- [Introduction to dada2](./references/dada2-intro.Rmd)
- [Introduction to dada2](./references/dada2-intro.md)