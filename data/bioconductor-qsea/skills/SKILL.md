---
name: bioconductor-qsea
description: This tool performs quantitative sequencing enrichment analysis for MeDIP-seq and other enrichment-based sequencing data. Use when user asks to model absolute methylation levels, account for copy number variations, perform TMM normalization, or detect differentially methylated regions using generalized linear models.
homepage: https://bioconductor.org/packages/release/bioc/html/qsea.html
---

# bioconductor-qsea

name: bioconductor-qsea
description: Quantitative Sequencing Enrichment Analysis (QSEA) for MeDIP-seq and other enrichment-based sequencing data. Use this skill to model absolute methylation levels, account for CNVs, perform normalization (TMM), and detect differentially methylated regions (DMRs) using generalized linear models (GLMs).

# bioconductor-qsea

## Overview
QSEA is the successor to the MEDIPS package, designed for the quantitative analysis of enrichment-based sequencing data (MeDIP-seq, ChIP-seq, MBD-seq). Its primary strength is the ability to transform relative enrichment into absolute methylation levels (beta values) by modeling background reads and CpG density-dependent enrichment profiles. It also integrates Copy Number Variation (CNV) analysis to normalize read counts.

## Core Workflow

### 1. Data Preparation
Create a sample table (data.frame) with `sample_name`, `file_name` (BAM paths), `group`, and optionally `sex`.

```r
library(qsea)
library(BSgenome.Hsapiens.UCSC.hg19)

# Initialize the qseaSet
qset <- createQseaSet(sampleTable = samples, 
                      BSgenome = "BSgenome.Hsapiens.UCSC.hg19", 
                      window_size = 500, 
                      chr.select = paste0("chr", 1:22))

# Import coverage from BAM files
qset <- addCoverage(qset, uniquePos = TRUE, paired = TRUE)
```

### 2. Normalization and CNV
QSEA can estimate CNVs directly from MeDIP data (using fragments without CpGs) or from input libraries.

```r
# Estimate CNV (MeDIP=TRUE uses CpG-free reads for estimation)
qset <- addCNV(qset, file_name = "file_name", window_size = 2e6, MeDIP = TRUE)

# Estimate library scaling factors (TMM normalization)
qset <- addLibraryFactors(qset)
```

### 3. Transformation to Absolute Methylation
To calculate beta values, QSEA models the enrichment efficiency based on CpG density.

```r
# Add CpG density information
qset <- addPatternDensity(qset, "CG", name = "CpG")

# Estimate background offset
qset <- addOffset(qset, enrichmentPattern = "CpG")

# Calibrate enrichment parameters (requires calibration signal or "blind" estimation)
# Blind calibration example:
wd <- which(getRegions(qset)$CpG_density > 1 & getRegions(qset)$CpG_density < 15)
signal <- (15 - getRegions(qset)$CpG_density[wd]) * .55 / 15 + .25
qset <- addEnrichmentParameters(qset, enrichmentPattern = "CpG", windowIdx = wd, signal = signal)
```

### 4. Differential Methylation Analysis
Uses GLMs and Likelihood Ratio Tests (LRT) similar to DESeq2/edgeR.

```r
# Define design and fit model
design <- model.matrix(~group, getSampleTable(qset))
qseaGLM <- fitNBglm(qset, design, norm_method = "beta")

# Perform contrast (e.g., Tumor vs Normal)
qseaGLM <- addContrast(qset, qseaGLM, coef = 2, name = "TvN")
```

### 5. Results and Visualization
Extract significant windows and annotate them.

```r
# Identify significant windows
sig_idx <- isSignificant(qseaGLM, fdr_th = 0.01)

# Create results table
res_table <- makeTable(qset, glm = qseaGLM, keep = sig_idx, 
                       groupMeans = getSampleGroups(qset), 
                       norm_method = "beta", 
                       annotation = ROIs) # ROIs is a list of GRanges

# Plot coverage for a specific region
plotCoverage(qset, chr = "chr20", start = 38076001, end = 38090000, norm_method = "beta")
```

## Key Functions and Parameters
- `createQseaSet`: Initializes the analysis object. `window_size` determines resolution.
- `addCoverage`: Reads BAM files. Use `parallel = TRUE` with `BiocParallel` for speed.
- `norm_method`: 
    - `"counts"`: Raw reads.
    - `"nrpkm"`: CNV-normalized reads.
    - `"beta"`: Absolute methylation (0 to 1).
- `getOffset`: Check signal-to-noise. Values > 0.9 suggest poor enrichment.
- `plotEPmatrix`: Visualizes the CpG density-dependent enrichment profile.

## Reference documentation
- [QSEA Tutorial](./references/qsea_tutorial.md)