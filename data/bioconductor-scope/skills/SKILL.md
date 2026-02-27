---
name: bioconductor-scope
description: SCOPE identifies copy number variants in single-cell DNA sequencing data using a Poisson latent factor model. Use when user asks to perform normalization, correct for GC content bias, identify diploid control cells, or conduct multi-sample segmentation for copy number estimation.
homepage: https://bioconductor.org/packages/release/bioc/html/SCOPE.html
---


# bioconductor-scope

name: bioconductor-scope
description: Statistical framework for calling copy number variants (CNVs) from single-cell DNA sequencing (scDNA-seq) data. Use this skill to perform normalization, GC content bias correction, and multi-sample segmentation for single-cell copy number estimation using the SCOPE R package.

# bioconductor-scope

## Overview

SCOPE (Single-cell Copy Number Estimation) is an R package designed to identify copy number variations in single-cell DNA sequencing data. It utilizes a Poisson latent factor model to account for GC content bias and technical artifacts. Key features include the use of Gini coefficients to identify diploid/normal control cells and multi-sample segmentation to find shared breakpoints across cells within the same genetic lineage.

## Core Workflow

### 1. Pre-preparation and Binning
Define genomic bins (default 500kb) and extract read counts from BAM files.

```r
library(SCOPE)
library(BSgenome.Hsapiens.UCSC.hg38)

# Define BAM files and sample names
bamfolder <- system.file("extdata", package = "WGSmapp")
bamFile <- list.files(bamfolder, pattern = '*.dedup.bam$')
bamdir <- file.path(bamfolder, bamFile)
sampname_raw <- sapply(strsplit(bamFile, ".", fixed = TRUE), "[", 1)

# Create bin-level GRanges object
bambedObj <- get_bam_bed(bamdir = bamdir, sampname = sampname_raw, hgref = "hg38")
ref_raw <- bambedObj$ref
```

### 2. GC Content and Mappability
Calculate bias metrics for each bin. Supports hg19, hg38, and mm10.

```r
mapp <- get_mapp(ref_raw, hgref = "hg38")
gc <- get_gc(ref_raw, hgref = "hg38")
values(ref_raw) <- cbind(values(ref_raw), DataFrame(gc, mapp))
```

### 3. Coverage and Quality Control
Generate the read depth matrix and filter low-quality bins/cells.

```r
# Get raw read depth
coverageObj <- get_coverage_scDNA(bambedObj, mapqthres = 40, seq = 'paired-end', hgref = "hg38")
Y_raw <- coverageObj$Y

# Perform QC
QCmetric_raw <- get_samp_QC(bambedObj)
qcObj <- perform_qc(Y_raw = Y_raw, sampname_raw = sampname_raw, ref_raw = ref_raw, QCmetric_raw = QCmetric_raw)
Y <- qcObj$Y
ref <- qcObj$ref
```

### 4. Normalization and Ploidy Initialization
Identify normal cells using Gini coefficients and initialize ploidy states.

```r
# Calculate Gini coefficients to find diploid cells
Gini <- get_gini(Y)
norm_idx <- which(Gini <= 0.12) # Example threshold for normal cells

# First-pass normalization (no latent factors)
normObj.pre <- normalize_codex2_ns_noK(Y_qc = Y, gc_qc = ref$gc, norm_index = norm_idx)

# Initialize ploidy
ploidy <- initialize_ploidy(Y = Y, Yhat = normObj.pre$Yhat, ref = ref)

# Full SCOPE normalization (supports parallel computing)
normObj.scope <- normalize_scope_foreach(Y_qc = Y, gc_qc = ref$gc, K = 1, 
                                         ploidyInt = ploidy, norm_index = norm_idx, 
                                         T = 1:5, beta0 = normObj.pre$beta.hat, nCores = 2)

# Extract best Yhat based on BIC
Yhat <- normObj.scope$Yhat[[which.max(normObj.scope$BIC)]]
```

### 5. Segmentation and Visualization
Perform cross-sample segmentation to identify integer copy numbers.

```r
# Segmentation chromosome by chromosome
chrs <- unique(as.character(seqnames(ref)))
segment_cs <- lapply(chrs, function(chri) {
    segment_CBScs(Y = Y, Yhat = Yhat, sampname = colnames(Y), 
                  ref = ref, chr = chri, mode = "integer", max.ns = 1)
})
iCN_mat <- do.call(rbind, lapply(segment_cs, function(z){z[["iCN"]]}))

# Plot heatmap
plot_iCN(iCNmat = iCN_mat, ref = ref, Gini = Gini, filename = "SCOPE_heatmap")
```

## Key Functions
- `get_gini()`: Computes cell-specific Gini coefficients to identify outliers or diploid cells.
- `initialize_ploidy()`: Estimates initial ploidy states for the EM algorithm.
- `normalize_scope()` / `normalize_scope_foreach()`: Main normalization functions using the Poisson latent factor model.
- `segment_CBScs()`: Performs multi-sample segmentation to identify shared breakpoints.
- `plot_iCN()`: Generates heatmaps of integer copy number profiles.

## Tips
- **Normal Cell Selection**: If no prior knowledge of diploid cells exists, use a Gini coefficient threshold (typically < 0.12) to identify them.
- **Parallelization**: Use `normalize_scope_foreach` for significantly faster performance on large single-cell datasets.
- **Custom Genomes**: While hg19/hg38 are defaults, SCOPE can be adapted to mm10 by specifying `hgref = "mm10"` and providing appropriate blacklist regions.

## Reference documentation
- [SCOPE: Single-cell Copy Number Estimation](./references/SCOPE_vignette.md)