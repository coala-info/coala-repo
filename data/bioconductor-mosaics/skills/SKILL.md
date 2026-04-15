---
name: bioconductor-mosaics
description: The bioconductor-mosaics package implements a model-based framework for detecting both punctuated and broad enriched regions in ChIP-seq data while accounting for genomic biases. Use when user asks to call peaks, identify transcription factor binding sites, detect histone modifications using HMMs, or account for mappability and GC content in ChIP-seq analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/mosaics.html
---

# bioconductor-mosaics

## Overview

The `mosaics` package implements the MOSAiCS (MOdel-based one and two Sample Analysis and Inference for ChIP-Seq) framework. It is designed to detect enriched regions (peaks) in ChIP-seq data while accounting for common biases such as mappability and GC content. The package supports two main workflows:
1.  **MOSAiCS**: Optimized for punctuated peaks (e.g., transcription factor binding).
2.  **MOSAiCS-HMM**: Uses a Hidden Markov Model to identify broad peaks (e.g., histone modifications).

## Core Workflow

### 1. Data Preparation
Convert aligned read files (BAM, SAM, BED, etc.) into bin-level files.

```R
library(mosaics)

# Construct bins for ChIP and Control
constructBins(infile = "chip.bam", fileFormat = "bam", outfileLoc = "./", 
               PET = FALSE, fragLen = 200, binSize = 200)
constructBins(infile = "input.bam", fileFormat = "bam", outfileLoc = "./", 
               PET = FALSE, fragLen = 200, binSize = 200)

# Load bin-level data into R
binData <- readBins(type = c("chip", "input"), 
                    fileName = c("chip_bin200.txt", "input_bin200.txt"))
```

### 2. Model Fitting
Fit the MOSAiCS model to estimate the background distribution.

```R
# IO = Input Only (two-sample analysis)
# bgEst: "rMOM" for high depth, "matchLow" for low depth
fit <- mosaicsFit(binData, analysisType = "IO", bgEst = "rMOM")

# Check model fit
plot(fit)
```

### 3. Peak Calling
Identify peaks based on the fitted model and desired False Discovery Rate (FDR).

```R
# signalModel: "1S" (one-signal) or "2S" (two-signal)
peaks <- mosaicsPeak(fit, signalModel = "2S", FDR = 0.05, 
                     maxgap = 200, minsize = 50, thres = 10)

# View and export results
peakList <- print(peaks)
export(peaks, type = "bed", filename = "peaks.bed")
```

## Broad Peak Analysis (MOSAiCS-HMM)

For histone modifications, use the HMM extension to account for spatial dependence.

```R
# Fit HMM using a standard MOSAiCS fit as input
hmmFit <- mosaicsFitHMM(fit, signalModel = "2S", init = "mosaics")

# Call peaks using posterior decoding
peaksHMM <- mosaicsPeakHMM(hmmFit, FDR = 0.05, decoding = "posterior")
```

## Post-Processing

Refine peak calls by incorporating read-level information.

```R
# 1. Extract reads for the identified peak regions
peaksHMM <- extractReads(peaksHMM, 
                         chipFile = "chip.bam", chipFileFormat = "bam",
                         controlFile = "input.bam", controlFileFormat = "bam")

# 2. Find peak summits
peaksHMM <- findSummit(peaksHMM)

# 3. Adjust boundaries and filter false positives
peaksHMM <- adjustBoundary(peaksHMM)
peaksHMM <- filterPeak(peaksHMM)
```

## Advanced Features

- **Mappability and GC Content**: If sequencing depth is low, include genomic features in `readBins(type = c("chip", "input", "M", "GC", "N"))` and set `analysisType = "TS"` in `mosaicsFit`.
- **One-Sample Analysis**: If no control is available, use `analysisType = "OS"` (requires M and GC files).
- **Visualization**: Use `generateWig()` to create wiggle files for genome browsers or `plot(peaks, peakNum = 1)` to visualize specific peak profiles in R.
- **Convenience Function**: `mosaicsRunAll()` can wrap the entire two-sample workflow into a single call.

## Reference documentation

- [Analysis of ChIP-seq Data with mosaics Package](./references/mosaics-example.md)