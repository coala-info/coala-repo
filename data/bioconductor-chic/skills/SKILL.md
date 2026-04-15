---
name: bioconductor-chic
description: This tool performs comprehensive quality control analysis for ChIP-seq data by calculating ENCODE, global, and local enrichment metrics. Use when user asks to evaluate ChIP-seq sample quality, calculate cross-correlation metrics, generate fingerprint plots, or compare datasets against reference compendia using machine learning models.
homepage: https://bioconductor.org/packages/3.8/bioc/html/ChIC.html
---

# bioconductor-chic

name: bioconductor-chic
description: Quality control analysis for ChIP-seq data using the ChIC package. Use this skill to calculate ENCODE metrics (EM), global enrichment metrics (GM), and local enrichment metrics (LM). It supports cross-correlation analysis, fingerprint plots, metagene profiles, and comparison against a precomputed compendium of reference values to assess sample quality using machine learning models.

# bioconductor-chic

## Overview
The ChIC (ChIP-seq quality Control) package provides a comprehensive suite of tools to evaluate the quality of ChIP-seq datasets. It categorizes quality control into three main areas: ENCODE metrics (cross-correlation and peak calling), Global enrichment (read distribution/fingerprint plots), and Local enrichment (signal around TSS, TES, and gene bodies). A key feature is its built-in compendium of reference values from ENCODE and Roadmap, allowing for automated quality scoring via Random Forest models.

## Core Workflow

### 1. Data Preparation
ChIC requires ChIP and Input BAM files. For initial processing, use `readBamFile()`.
```r
library(ChIC)
chipBam <- readBamFile("path/to/chip.bam")
inputBam <- readBamFile("path/to/input.bam")
```

### 2. ENCODE Metrics (EM)
The wrapper `qualityScores_EM()` performs cross-correlation, removes local anomalies, and calculates peak-calling scores.
```r
# mc: number of cores for parallelization
# annotationID: "hg19" or "mm9"
CC_Result <- qualityScores_EM(chipName="chip_id", 
                             inputName="input_id", 
                             annotationID="hg19", 
                             read_length=36, 
                             mc=4)

# Extract tag shift for subsequent steps
finalTagShift <- CC_Result$QCscores_ChIP$tag.shift
```

### 3. Global Enrichment Metrics (GM)
Calculates metrics based on the global read distribution (Fingerprint plot). Requires smoothed density profiles.
```r
# Smoothing profiles
smoothedChip <- tagDensity(chipBamSelected, annotationID="hg19", tag.shift=finalTagShift)
smoothedInput <- tagDensity(inputBamSelected, annotationID="hg19", tag.shift=finalTagShift)

# Calculate GM scores
GM_Results <- qualityScores_GM(densityChip=smoothedChip, 
                               densityInput=smoothedInput, 
                               savePlotPath="fingerprint.pdf")
```

### 4. Local Enrichment Metrics (LM)
Analyzes signal enrichment around specific genomic features (TSS, TES, Gene Body).
```r
# Create metagene profiles
Meta_Result <- createMetageneProfile(smoothed.densityChip=smoothedChip,
                                     smoothed.densityInput=smoothedInput,
                                     annotationID="hg19",
                                     tag.shift=finalTagShift)

# Extract specific scores
TSS_Scores <- qualityScores_LM(data=Meta_Result$TSS, tag="TSS")
TES_Scores <- qualityScores_LM(data=Meta_Result$TES, tag="TES")
geneBody_Scores <- qualityScores_LMgenebody(Meta_Result$geneBody)
```

### 5. Quality Assessment and Machine Learning
Compare your sample against the ChIC compendium or generate a single quality score.
```r
# List available reference marks
listAvailableElements(target="H3K4me3")

# Compare metagene profile to compendium
metagenePlotsForComparison(data=Meta_Result$geneBody, 
                           target="H3K4me3", 
                           tag="geneBody")

# Generate a single quality score (0 to 1)
qc_score <- predictionScore(target="H3K4me3",
                            features_cc=CC_Result,
                            features_global=GM_Results,
                            features_TSS=TSS_Scores,
                            features_TES=TES_Scores,
                            features_scaled=geneBody_Scores)
```

## Key Metrics Definitions
- **NSC (Normalized Strand Cross-correlation):** Ratio of maximal cross-correlation to background.
- **RSC (Relative Strand Cross-correlation):** Ratio of fragment-length peak to read-length peak.
- **PBC (PCR Bottleneck Coefficient):** Measure of library complexity.
- **FRiP:** Fraction of Reads in Peaks.

## Reference documentation
- [ChIC-Vignette](./references/ChIC-Vignette.md)