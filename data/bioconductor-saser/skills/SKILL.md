---
name: bioconductor-saser
description: This tool performs aberrant expression and splicing analysis in bulk RNA-seq datasets to detect outliers using a negative binomial framework. Use when user asks to transform BAM files into count matrices, calculate normalization offsets, estimate latent confounders with RUV, or fit models for outlier detection in rare disease research.
homepage: https://bioconductor.org/packages/release/bioc/html/saseR.html
---

# bioconductor-saser

name: bioconductor-saser
description: Perform aberrant expression (AE) and aberrant splicing (AS) analysis in bulk RNA-seq datasets using the saseR Bioconductor package. Use this skill to transform BAM files into count matrices, calculate adapted offsets for splicing proportions, estimate latent confounders with RUV, and fit negative binomial models for outlier detection.

# bioconductor-saser

## Overview
`saseR` is designed for detecting outliers in RNA-seq data, particularly useful in the context of rare Mendelian disorders. It leverages a negative binomial framework with adapted offsets to model both aberrant expression and splicing. The package is highly scalable, using a "fast" parameter estimation method that handles large numbers of latent factors efficiently.

## Core Workflow

### 1. Data Preparation
Transform BAM files into gene, bin, or junction counts using `ASpli`-based functions.

```r
library(saseR)
library(txdbmaker)
library(BiocParallel)

# 1. Setup annotation and BAM list
gtf <- ASpli::aspliExampleGTF()
bams <- ASpli::aspliExampleBamList()
txdb <- makeTxDbFromGFF(gtf)
features <- binGenome(txdb)

# 2. Create targets data frame
targets <- data.frame(
  row.names = paste0('Sample', 1:12),
  bam = bams,
  f1 = rep("A", 12) # Experimental factors (placeholder for AE/AS)
)

# 3. Generate counts (SummarizedExperiment)
ASpliSE <- BamtoAspliCounts(
  features = features,
  targets = targets,
  minReadLength = 100,
  libType = "SE"
)

# 4. Extract specific counts
SEgenes <- convertASpli(ASpliSE, type = "gene")
SEbins <- convertASpli(ASpliSE, type = "bin")
SEjunctions <- convertASpli(ASpliSE, type = "junction")
```

### 2. Aberrant Expression (AE) Analysis
Focuses on total gene count outliers.

```r
# Define design (intercept only for outlier detection)
metadata(SEgenes)$design <- ~1

# Filter and calculate normalization offsets (TMM or geommean)
SEgenes <- SEgenes[filterByExpr(SEgenes), ]
SEgenes <- calculateOffsets(SEgenes, method = "TMM")

# Find latent factors (GD = Gavish-Donoho threshold)
SEgenes <- saseRfindEncodingDim(SEgenes, method = "GD")

# Fit model
SEgenes <- saseRfit(SEgenes, analysis = "AE", fit = "fast")

# Access results
pvals <- assays(SEgenes)$pValue
adjPvals <- assays(SEgenes)$pValueAdjust
```

### 3. Aberrant Splicing (AS) Analysis
Uses adapted offsets to model feature proportions (bins/junctions) relative to the gene/locus.

```r
metadata(SEbins)$design <- ~1

# Calculate AS offsets BEFORE filtering
# aggregation: "locus" for bins, "symbol" or "ASpliCluster" for junctions
SEbins <- calculateOffsets(SEbins, method = "AS", aggregation = "locus")

# Filter low counts
SEbins <- SEbins[filterByExpr(SEbins), ]

# Find latent factors and fit
SEbins <- saseRfindEncodingDim(SEbins, method = "GD")
SEbins <- saseRfit(SEbins, analysis = "AS", fit = "fast")

# Aggregated p-values per locus (gene level splicing outlier)
locusPvals <- metadata(SEbins)$pValuesLocus
```

### 4. Differential Usage with Adapted Offsets
`saseR` logic can be applied to standard `DESeq2` or `edgeR` workflows for differential splicing by manually providing the gene-level aggregate as an offset.

```r
# Example for DESeq2
# counts: bin counts; offsets: total gene counts for those bins
normalizationFactors(dds) <- offsets 
dds <- estimateDispersionsGeneEst(dds)
dispersions(dds) <- mcols(dds)$dispGeneEst
dds <- nbinomWaldTest(dds)
```

## Key Functions
- `binGenome()`: Prepares genomic features from a TxDb object.
- `BamtoAspliCounts()`: High-level wrapper to generate count matrices from BAM files.
- `calculateOffsets()`: Critical step. Use `method="TMM"` for AE and `method="AS"` for AS.
- `saseRfindEncodingDim()`: Estimates the number of latent confounders to control for.
- `saseRfit()`: The main engine. `fit="fast"` is recommended for large datasets or many confounders.

## Tips
- **Order of Operations**: For AE, filter then calculate offsets. For AS, calculate offsets then filter.
- **Latent Factors**: Always use `saseRfindEncodingDim` to account for hidden batch effects or technical noise, which are prevalent in rare disease cohorts.
- **Fast Fit**: The `fast` fit uses an overdispersed quadratic mean-variance relationship, allowing for matrix multiplications that significantly speed up computation compared to standard GLM fitting.

## Reference documentation
- [Main vignette: Aberrant expression and splicing analysis](./references/saseR-vignette.md)