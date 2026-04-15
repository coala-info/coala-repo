---
name: bioconductor-pram
description: Bioconductor-pram predicts transcript models by pooling multiple RNA-seq datasets, specifically focusing on intergenic regions. Use when user asks to define intergenic genomic ranges, prepare RNA-seq alignments, build transcript models using pooling or merging methods, and filter or evaluate predicted transcripts.
homepage: https://bioconductor.org/packages/release/bioc/html/pram.html
---

# bioconductor-pram

name: bioconductor-pram
description: Predict transcript models by pooling multiple RNA-seq datasets. Use this skill when you need to perform transcript assembly, specifically for intergenic regions, using meta-assembly methods (pooling or merging) that leverage external tools like StringTie, Cufflinks, or TACO within an R environment.

# bioconductor-pram

## Overview
PRAM (Pooling RNA-seq and Assembling Models) is an R package designed to predict transcript models using multiple RNA-seq datasets. It is particularly effective at identifying transcripts in intergenic regions. The package provides a complete pipeline from defining genomic search spaces to building, filtering, and evaluating transcript models.

## Installation
To install the package from Bioconductor:
```R
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("pram")
```

## Core Workflow
The PRAM workflow typically follows these four steps, which can be executed individually or via the wrapper function `runPRAM()`.

### 1. Define Intergenic Ranges
Use `defIgRanges()` to specify the genomic regions where PRAM should look for new transcripts.
```R
# Define ranges 10kb away from known genes (default radius)
ig_ranges <- pram::defIgRanges(in_gtf = "path/to/annotation.gtf", genome = "hg38")
```
- `genome`: Supports "hg19", "hg38", "mm9", "mm10".
- `radius`: Distance (bp) from known genes to consider "intergenic".

### 2. Prepare RNA-seq Alignments
Extract alignments from BAM files that fall within the defined intergenic regions using `prepIgBam()`.
```R
pram::prepIgBam(finbam = "input.bam", iggrs = ig_ranges, foutbam = "intergenic_only.bam")
```
*Note: PRAM currently supports strand-specific paired-end RNA-seq (fr-firststrand).*

### 3. Build Transcript Models
The `buildModel()` function performs the assembly. It supports seven methods, categorized by whether they pool alignments or merge individual assemblies.
```R
# Example using pooling + StringTie (plst)
pram::buildModel(in_bamv = c("sample1.bam", "sample2.bam"), 
                 out_gtf = "predicted.gtf", 
                 method = "plst",
                 stringtie = "/path/to/stringtie")
```
**Methods:**
- `plcf` / `plst`: Pooling alignments then running Cufflinks or StringTie (Recommended).
- `cfmg` / `stmg`: Running assembly on individual samples then merging (Cuffmerge/StringTie-merge).
- `cftc`: Cufflinks followed by TACO assembly.

### 4. Select and Filter Models
Filter the resulting GTF based on transcript features using `selModel()`.
```R
pram::selModel(fin_gtf = "predicted.gtf", 
               fout_gtf = "filtered.gtf", 
               min_n_exon = 2, 
               min_tr_len = 200)
```

## Evaluation
If you have a set of "true" transcripts (positive controls), use `evalModel()` to calculate precision and recall for exon nucleotides, splice junctions, and full transcript structures.
```R
# Comparison can be done using GTF files or GRanges objects
stats <- pram::evalModel(model_exons = "predicted.gtf", target_exons = "truth.gtf")
```

## Automated Pipeline
For a streamlined execution, use `runPRAM()`:
```R
pram::runPRAM(in_gtf = "genes.gtf", 
              in_bamv = c("s1.bam", "s2.bam"), 
              out_gtf = "output.gtf", 
              method = "plst")
```

## Reference documentation
- [PRAM: Pooling RNA-seq and Assembling Models](./references/pram.Rmd)
- [PRAM: Pooling RNA-seq and Assembling Models](./references/pram.md)