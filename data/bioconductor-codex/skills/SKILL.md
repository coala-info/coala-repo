---
name: bioconductor-codex
description: "bioconductor-codex performs normalization and copy number variation calling for whole exome sequencing data using a Poisson latent factor model. Use when user asks to normalize exome sequencing data, detect germline or somatic copy number variations, or remove systemic biases from GC content and exon capture."
homepage: https://bioconductor.org/packages/release/bioc/html/CODEX.html
---


# bioconductor-codex

name: bioconductor-codex
description: Normalization and copy number variation (CNV) calling for whole exome sequencing (WES) data. Use this skill to process .bam and .bed files to detect germline or somatic CNVs using a Poisson latent factor model that removes biases from GC content, exon capture, and systemic artifacts.

# bioconductor-codex

## Overview

CODEX (COpy number determination by EXome sequencing) is a specialized R package for calling copy number variations from whole exome sequencing data. It is designed to work with multiple samples processed via the same pipeline, using a Poisson likelihood-based recursive segmentation procedure. Unlike many other tools, it does not strictly require matched controls, as it can estimate systemic biases across the sample cohort.

## Workflow and Usage

### 1. Data Preparation
CODEX requires BAM files, a BED file defining exon targets, and sample names.

```r
library(CODEX)

# Define inputs
bamdir <- c("/path/to/sample1.bam", "/path/to/sample2.bam")
sampname <- as.matrix(c("Sample1", "Sample2"))
bedFile <- "/path/to/targets.bed"
chr <- 22 # Process chromosome by chromosome

# Initialize object
bambedObj <- getbambed(bamdir = bamdir, bedFile = bedFile, 
                       sampname = sampname, projectname = "MyProject", chr = chr)
```

### 2. Coverage and Feature Extraction
Extract raw read depths and calculate exon-specific features (GC content and mappability).

```r
# Get raw read depth (Y)
coverageObj <- getcoverage(bambedObj, mapqthres = 20)
Y <- coverageObj$Y

# Get GC and Mappability
gc <- getgc(chr, bambedObj$ref)
mapp <- getmapp(chr, bambedObj$ref)
```

### 3. Quality Control
Filter exons and samples based on coverage, length, mappability, and GC content.

```r
qcObj <- qc(Y, sampname, chr, bambedObj$ref, mapp, gc, 
            cov_thresh = c(20, 4000), 
            length_thresh = c(20, 2000), 
            mapp_thresh = 0.9, 
            gc_thresh = c(20, 80))

# Extract QC-passed data
Y_qc <- qcObj$Y_qc
gc_qc <- qcObj$gc_qc
ref_qc <- qcObj$ref_qc
```

### 4. Normalization
Fit the Poisson latent factor model. Use `normalize` for general cohorts or `normalize2` if specific control samples are available.

```r
# General normalization (testing K factors 1 to 9)
normObj <- normalize(Y_qc, gc_qc, K = 1:9)

# If using case-control (e.g., samples 1, 3, 5 are controls)
# normObj <- normalize2(Y_qc, gc_qc, K = 1:9, normal_index = c(1, 3, 5))

# Determine optimal K (usually via BIC)
choiceofK(normObj$AIC, normObj$BIC, normObj$RSS, normObj$K, filename = "K_choice.pdf")
optK <- normObj$K[which.max(normObj$BIC)]
```

### 5. Segmentation and CNV Calling
Call CNVs using the "integer" mode for germline or "fraction" mode for somatic/cancer samples.

```r
finalcall <- segment(Y_qc, normObj$Yhat, optK = optK, K = normObj$K, 
                     sampname_qc = qcObj$sampname_qc, 
                     ref_qc = qcObj$ref_qc, 
                     chr = chr, lmax = 200, mode = "integer")

# View results
head(finalcall)
```

## Key Parameters and Tips

- **Chromosome Consistency**: Ensure the chromosome naming (e.g., "22" vs "chr22") is identical between your BED file and BAM headers.
- **Choice of K**: CODEX is conservative. If BIC suggests a very high K that might over-normalize and wash out signals, a smaller K is often preferred.
- **Output Columns**:
    - `copy_no`: Estimated copy number.
    - `lratio`: Likelihood ratio (higher indicates stronger evidence for CNV).
    - `mBIC`: Modified BIC used for segmentation stopping.
- **Memory Management**: Process the genome chromosome by chromosome to manage memory usage effectively.

## Reference documentation
- [CODEX Vignette](./references/CODEX_vignettes.md)