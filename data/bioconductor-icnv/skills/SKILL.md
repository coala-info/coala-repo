---
name: bioconductor-icnv
description: bioconductor-icnv detects copy number variations by integrating data from NGS and SNP array platforms using a Hidden Markov Model. Use when user asks to detect CNVs, integrate WES or WGS with SNP array data, or perform platform-specific normalization for genomic structural variant analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/iCNV.html
---


# bioconductor-icnv

name: bioconductor-icnv
description: Integrated Copy Number Variation (iCNV) detection for multiple study designs including WES, WGS, SNP array, or combinations. Use this skill when analyzing genomic data to detect CNVs by integrating platform-specific normalization (CODEX for NGS, SVD for Array) and Hidden Markov Model (HMM) based calling.

## Overview

The `iCNV` package provides a statistical framework for CNV detection that integrates NGS (WES/WGS) and SNP array data. It utilizes platform-specific normalization: Poisson Likelihood Ratio (PLR) for sequencing data and Log R Ratio (LRR) for SNP arrays. The core of the package is a Hidden Markov Model (HMM) that leverages both intensity signals and B-allele frequencies (BAF) to improve calling accuracy.

## Typical Workflow

### 1. NGS Normalization (via CODEX)
For sequencing data, `iCNV` relies on `CODEX` to generate normalized PLR.
```r
library(CODEX)
library(iCNV)

# Get coverage and normalize
bambedObj <- getbambed(bamdir, bedFile, sampname, projectname, chr)
coverageObj <- getcoverage(bambedObj, mapqthres = 20)
gc <- getgc(chr, bambedObj$ref)
mapp <- getmapp(chr, bambedObj$ref)
qcObj <- qc(coverageObj$Y, sampname, chr, bambedObj$ref, mapp, gc)
normObj <- normalize(qcObj$Y_qc, qcObj$gc_qc, K = 1:9)

# Calculate PLR (Poisson Likelihood Ratio)
optK <- 2 # Determined via BIC plot
Y_norm <- normObj$Yhat[[optK]]
plr <- log(pmax(qcObj$Y_qc, 0.0001) / pmax(Y_norm, 0.0001))
ngs_plr <- lapply(seq_len(ncol(plr)), function(i) plr[,i])
```

### 2. SNP Array Normalization
Standardize LRR and optionally apply SVD to remove noise.
```r
# Convert raw intensity to iCNV input
get_array_input(dir, pattern, chr, projectname)
load(paste0(projectname, 'array_lrrbaf_', chr, '.rda'))

# Optional SVD Denoising
lrr.sd <- apply(snp_lrr, 2, function(x) (x - mean(x, na.rm=T))/sd(x, na.rm=T))
lrr.svd <- svd(t(lrr.sd))
# Reconstruct with low-rank components removed
optK <- 5
D.lowrank <- diag(c(rep(0, optK), lrr.svd$d[-(1:optK)]))
lrr.denoise <- t(lrr.svd$u %*% D.lowrank %*% t(lrr.svd$v))
```

### 3. CNV Detection
The `iCNV_detection` function handles single or integrated platforms. All inputs must be in `list` format where each element corresponds to a sample.

**Integrated (NGS + Array):**
```r
icnv_res <- iCNV_detection(ngs_plr, snp_lrr, ngs_baf, snp_baf,
                           ngs_plr.pos, snp_lrr.pos, ngs_baf.pos, snp_baf.pos,
                           projname="my_proj", CN=1, mu=c(-3,0,2))
```

**Single Platform (NGS only):**
```r
icnv_res_ngs <- iCNV_detection(ngs_plr=ngs_plr, ngs_baf=ngs_baf,
                               ngs_plr.pos=ngs_plr.pos, ngs_baf.pos=ngs_baf.pos,
                               CN=0)
```

### 4. Output and Visualization
```r
# Generate result list
icnv.output <- output_list(icnv_res, sampname_qc, CN=1)

# Visualization
plotHMMscore(icnv_res, title="Project Results")
plotindi(ngs_plr, snp_lrr, ngs_baf, snp_baf, ngs_plr.pos, snp_lrr.pos, 
         ngs_baf.pos, snp_baf.pos, icnv_res, I=1) # Plot 1st individual

# Export to Genome Browser format
gb_input <- icnv_output_to_gb(chr, icnv.output)
```

## Key Parameters
- `CN`: Set to 0 for NGS-only, 1 for Array-only or Integrated.
- `mu`: Mean of the HMM emission distribution for three states (Deletion, Neutral, Amplification). Default `c(-3, 0, 2)`.
- `visual`: Controls plotting during detection (0: none, 1: heatmap, 2: individual plots).

## Reference documentation
- [iCNV Vignette](./references/iCNV-vignette.md)