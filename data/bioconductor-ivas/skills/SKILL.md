---
name: bioconductor-ivas
description: This tool identifies genetic variants affecting alternative splicing by integrating RNA-seq transcript expression and genotype data. Use when user asks to identify splicing quantitative trait loci, detect alternative splicing patterns, calculate transcript expression ratios, or map SNPs to splicing events.
homepage: https://bioconductor.org/packages/release/bioc/html/IVAS.html
---

# bioconductor-ivas

name: bioconductor-ivas
description: Identification of genetic variants affecting alternative splicing (sQTL) using RNA-seq transcript expression and genotype data. Use this skill when analyzing the relationship between SNPs and alternative splicing patterns (exon skipping, alternative splice sites, intron retention) in R.

## Overview

The `IVAS` package identifies Splicing Quantitative Trait Loci (sQTLs) by integrating transcript-level expression data (e.g., FPKM from Cufflinks) with genotype data. It categorizes alternative splicing (AS) events into four types: Exon Skipping (ES), Alternative 3' Splice Site (A3SS), Alternative 5' Splice Site (A5SS), and Intron Retention (IR). The analysis typically follows a three-step workflow: finding AS patterns, calculating expression ratios, and performing sQTL mapping using linear regression or generalized linear mixed models.

## Core Workflow

### 1. Data Preparation
The package requires four main inputs:
- **Genotype Data**: A matrix where columns are individuals and rows are SNPs (e.g., "AA", "CG").
- **Expression Data**: A matrix of transcript FPKM values. Column names must match the genotype matrix.
- **SNP Positions**: A data frame with columns `SNP`, `CHR`, and `locus`.
- **Transcript Model**: A `TxDb` object (created via `GenomicFeatures::makeTxDbFromGFF`).

### 2. Identifying Splicing Patterns
Use `Splicingfinder` to detect AS events from the reference transcript model.
```r
library(IVAS)
# sample.Txdb is a TxDb object
ASdb <- Splicingfinder(GTFdb = sample.Txdb, calGene = NULL, Ncor = 1)
```

### 3. Calculating AS Ratios
Calculate the ratio of transcripts containing the AS exon versus those that do not.
```r
# sampleexp is the FPKM matrix
ASdb <- RatioFromFPKM(GTFdb = sample.Txdb, 
                      ASdb = ASdb, 
                      Total.expdata = sampleexp, 
                      Ncor = 1)
```

### 4. sQTL Mapping
Identify SNPs significantly associated with the calculated splicing ratios.
```r
# samplesnp is genotype matrix, samplesnplocus is position data
ASdb <- sQTLsFinder(ASdb = ASdb, 
                    Total.snpdata = samplesnp, 
                    Total.snplocus = samplesnplocus, 
                    method = "lm", 
                    Ncor = 1)
```

## Key Functions and Objects

- **ASdb Object**: A specialized S4 class used to store results. Data is organized into slots: `@SplicingModel`, `@Ratio`, and `@sQTLs`. Each slot contains a list with elements `ES`, `ASS`, and `IR`.
- **Parallel Processing**: `Splicingfinder`, `RatioFromFPKM`, and `sQTLsFinder` all support the `Ncor` argument to utilize multiple cores via the `foreach` package.
- **Visualization**: Use `saveBplot` to generate boxplots of splicing ratios grouped by genotype.
  ```r
  saveBplot(ASdb = ASdb, 
            Total.snpdata = samplesnp, 
            Total.snplocus = samplesnplocus, 
            CalIndex = "ASS7", 
            out.dir = "./results")
  ```

## Tips for Success
- **Sample Size**: Like all QTL studies, population-scale sample sizes are recommended for statistical significance.
- **Index IDs**: Use the `Index` column (e.g., "ES1", "ASS7") from the `SplicingModel` slot to target specific events in downstream functions using the `CalIndex` argument.
- **Method Selection**: The `sQTLsFinder` function supports "lm" (linear model) for standard analysis.

## Reference documentation
- [IVAS: Identification of genetic Variants affecting Alternative Splicing](./references/IVAS.md)