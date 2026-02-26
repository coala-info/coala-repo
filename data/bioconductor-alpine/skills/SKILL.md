---
name: bioconductor-alpine
description: The alpine package models and corrects technical biases in RNA-seq data to provide more accurate transcript abundance estimates. Use when user asks to estimate fragment sequence bias, fit bias models for GC content or fragment length, and calculate bias-corrected FPKM values.
homepage: https://bioconductor.org/packages/3.17/bioc/html/alpine.html
---


# bioconductor-alpine

## Overview

The `alpine` package provides a framework for modeling and correcting technical biases in RNA-seq data, specifically fragment sequence bias. By using a training set of single-isoform genes, `alpine` estimates parameters for various bias components (GC content, fragment length, relative position, and read-start VLMM) and then uses these parameters to provide more accurate transcript abundance estimates (FPKM).

## Typical Workflow

### 1. Data Preparation and Gene Selection
Identify a set of ~100 single-isoform genes with medium to high counts (e.g., 200–10,000) to serve as a training set for the bias model.

```r
library(alpine)
library(GenomicRanges)
library(BSgenome.Hsapiens.NCBI.GRCh38)

# ebt.fit should be a GRangesList of exons for single-isoform genes
# Estimate fragment length distribution
w <- getFragmentWidths(bam.files[1], ebt.fit[[1]])
minsize <- quantile(w, .025)
maxsize <- quantile(w, .975)
readlength <- getReadLength(bam.files)
```

### 2. Defining Fragment Types
Generate a list of DataFrames containing information about all possible fragment types within the training genes.

```r
gene.names <- names(ebt.fit)
names(gene.names) <- gene.names

fragtypes <- lapply(gene.names, function(gene.name) {
  buildFragtypes(exons=ebt.fit[[gene.name]],
                 genome=Hsapiens,
                 readlength=75,
                 minsize=minsize,
                 maxsize=maxsize,
                 gc.str=FALSE)
})
```

### 3. Fitting Bias Models
Define models using R formulas. **Note:** Formulas must end with `+ gene` to account for base expression levels.

```r
models <- list(
  "GC" = list(
    formula = "count ~ ns(gc,knots=gc.knots,Boundary.knots=gc.bk) + ns(relpos,knots=relpos.knots,Boundary.knots=relpos.bk) + gene",
    offset=c("fraglen")
  ),
  "all" = list(
    formula = "count ~ ns(gc,knots=gc.knots,Boundary.knots=gc.bk) + ns(relpos,knots=relpos.knots,Boundary.knots=relpos.bk) + gene",
    offset=c("fraglen","vlmm")
  )
)

fitpar <- lapply(bam.files, function(bf) {
  fitBiasModels(genes=ebt.fit,
                bam.file=bf,
                fragtypes=fragtypes,
                genome=Hsapiens,
                models=models,
                readlength=75,
                minsize=minsize,
                maxsize=maxsize)
})
```

### 4. Visualizing Bias
Use built-in plotting functions to inspect the fitted bias parameters across samples.

```r
plotFragLen(fitpar)
plotGC(fitpar, model="all")
plotRelPos(fitpar, model="all")
```

### 5. Estimating Abundance
Apply the fitted models to estimate abundance for target genes (including multi-isoform genes).

```r
# ebt.theta is a GRangesList of exons for transcripts of interest
res <- lapply(genes.theta, function(gene.name) {
  txs <- txdf.theta$tx_id[txdf.theta$gene_id == gene.name]
  estimateAbundance(transcripts=ebt.theta[txs],
                    bam.files=bam.files,
                    fitpar=fitpar,
                    genome=Hsapiens,
                    model.names=c("null", "GC", "all"))
})
```

### 6. Collating and Normalizing Results
Extract FPKM values into a matrix or `SummarizedExperiment` and normalize across samples.

```r
# Extract FPKM matrix
mat <- extractAlpine(res, model="all")

# Normalize using DESeq median ratio method
norm.mat <- normalizeDESeq(mat, cutoff=0.1)

# Or extract as SummarizedExperiment
se <- extractAlpine(res, model="all", transcripts=ebt.theta)
```

## Key Functions and Tips

- **`buildFragtypes`**: Memory intensive. If processing many genes, consider parallelization or subsetting.
- **`fitBiasModels`**: Requires a `genome` object (e.g., `BSgenome`).
- **`predictCoverage`**: Useful for validating the model by comparing observed vs. predicted fragment coverage along a gene.
- **Model Selection**: The `null` model (no bias correction) and `fraglen` model are often used as baselines to evaluate the impact of GC and VLMM corrections.
- **Supported Data**: Currently limited to unstranded, paired-end RNA-seq with fixed read lengths.

## Reference documentation

- [Modeling and correcting fragment sequence bias](./references/alpine.md)