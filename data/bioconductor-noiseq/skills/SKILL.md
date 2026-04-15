---
name: bioconductor-noiseq
description: NOISeq is a non-parametric tool for identifying differential expression and performing quality control analysis on RNA-seq data. Use when user asks to identify differentially expressed genes, perform quality control for sequencing biases, or analyze RNA-seq experiments with few or no replicates.
homepage: https://bioconductor.org/packages/release/bioc/html/NOISeq.html
---

# bioconductor-noiseq

## Overview
NOISeq is a non-parametric approach for identifying differential expression in RNA-seq data. Unlike parametric methods (e.g., DESeq2, edgeR), it does not assume a specific distribution (like Negative Binomial) for the counts. It is particularly effective for:
1. **NOISeq-real/sim**: Handling technical replicates or experiments with no replicates by simulating noise distributions.
2. **NOISeqBIO**: Optimized for biological replicates (at least 2 per condition).
3. **Quality Control**: Extensive diagnostic tools to identify sequencing biases (length, GC content, RNA composition).

## Core Workflow

### 1. Data Preparation
NOISeq requires a `readData` object containing counts and experimental factors.

```r
library(NOISeq)

# counts: matrix with features as rows, samples as columns
# factors: data.frame with sample annotations
mydata <- readData(data = mycounts, 
                   factors = myfactors,
                   length = mylength, # Optional: for length bias/RPKM
                   gc = mygc,         # Optional: for GC bias
                   biotype = mybiotypes, # Optional: e.g., protein_coding, lincRNA
                   chromosome = mychroms) # Optional: for Manhattan plots
```

### 2. Quality Control (Exploratory Analysis)
Before DE analysis, check for biases.

```r
# 1. Generate data for a specific plot type
# Types: "biodetection", "countsbio", "saturation", "lengthbias", "GCbias", "cd", "PCA"
qc_data <- dat(mydata, type = "biodetection")

# 2. Plot the data
explo.plot(qc_data)

# 3. Check for RNA composition bias (Diagnostic Test)
# If the test fails, TMM or Upper Quartile normalization is required.
qc_cd <- dat(mydata, type = "cd", norm = FALSE)
explo.plot(qc_cd)

# 4. Generate a full PDF report
QCreport(mydata, factor = "Tissue", file = "QC_report.pdf")
```

### 3. Normalization and Filtering
NOISeq provides built-in functions for common normalization methods.

```r
# Normalization
counts_tmm <- tmm(assayData(mydata)$exprs, long = 1000)
counts_rpkm <- rpkm(assayData(mydata)$exprs, long = mylength)

# Filtering low counts (Method 1: CPM cutoff)
# Highly recommended for NOISeqBIO
filt_data <- filtered.data(mycounts, factor = myfactors$Tissue, 
                           method = 1, cpm = 1)
```

### 4. Differential Expression Analysis

#### For Biological Replicates (Recommended)
Use `noiseqbio` when you have at least 2 biological replicates per condition.

```r
res_bio <- noiseqbio(mydata, 
                     k = 0.5, 
                     norm = "tmm", 
                     factor = "Tissue", 
                     filter = 1) # 1: CPM, 2: Wilcoxon, 3: Proportion
```

#### For Technical Replicates or No Replicates
Use `noiseq`.

```r
# Technical replicates
res_tech <- noiseq(mydata, k = 0.5, norm = "rpkm", 
                   replicates = "technical", factor = "Tissue")

# No replicates (Simulates noise distribution)
res_sim <- noiseq(mydata, k = 0.5, norm = "rpkm", 
                  replicates = "no", factor = "Tissue",
                  nss = 5, pnr = 0.2, v = 0.02)
```

### 5. Interpreting Results
NOISeq uses a "probability of differential expression" (`prob`) rather than a p-value.

```r
# Select DE genes
# For noiseq: q = 0.8 (odds 4:1) or 0.9
# For noiseqbio: q = 0.95 (equivalent to 1 - FDR)
de_genes <- degenes(res_bio, q = 0.95, M = NULL) # M = "up" or "down"

# Visualization
DE.plot(res_bio, q = 0.95, graphic = "expr") # Expression plot
DE.plot(res_bio, q = 0.95, graphic = "MD")   # MD plot (M vs D)
DE.plot(res_bio, q = 0.95, graphic = "distr") # Distribution across biotypes/chroms
```

## Batch Effect Correction (ARSyNseq)
If PCA shows clustering by batch rather than condition, use ARSyNseq.

```r
# If batch is known
mydata_corr <- ARSyNseq(mydata, factor = "Batch", batch = TRUE, norm = "tmm")

# If batch is unknown (identifies systematic noise in residuals)
mydata_corr <- ARSyNseq(mydata, factor = "Tissue", batch = FALSE, norm = "tmm")
```

## Reference documentation
- [NOISeq: Differential Expression in RNA-seq](./references/NOISeq.md)
- [Quality Control of Expression Data Report](./references/QCreport.md)