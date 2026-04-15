---
name: bioconductor-rlseq
description: RLSeq provides a standardized framework for the quality control and downstream analysis of R-loop mapping data. Use when user asks to perform R-loop forming sequences permutation tests, predict sample quality, analyze genomic feature enrichment, or compare results against the RLBase database.
homepage: https://bioconductor.org/packages/3.14/bioc/html/RLSeq.html
---

# bioconductor-rlseq

## Overview

RLSeq is a core component of the RLSuite toolchain designed for the downstream analysis of R-loop mapping data (e.g., DRIP-seq, RDIP-seq, S9.6-seq). It provides a standardized framework for quality control via R-loop forming sequences (RLFS) permutation tests, genomic feature enrichment, and comparison against a vast database of public R-loop experiments (RLBase).

## Core Workflow

The primary entry point is the `RLSeq()` function, which wraps several analysis steps into a single call.

### 1. Data Initialization (RLRanges)
All analyses require an `RLRanges` object, which extends `GRanges` with R-loop-specific metadata.

```r
library(RLSeq)

# Required: peaks (file path or GRanges) and genome (e.g., "hg38")
# Recommended: coverage (bigWig file path) for noise and correlation analysis
rlr <- RLRanges(
  peaks = "path/to/peaks.broadPeak",
  coverage = "path/to/coverage.bw",
  genome = "hg38",
  mode = "DRIP",
  label = "POS",
  sampleName = "My_Sample"
)
```

### 2. Automated Pipeline
The `RLSeq()` function executes the standard suite of analyses:
- RLFS analysis and quality prediction.
- Genomic feature enrichment.
- Transcript feature overlap.
- Gene annotation.

```r
rlr <- RLSeq(rlr)
```

### 3. Reporting
Generate a comprehensive HTML report summarizing all findings:

```r
report(rlr, reportPath = "RLSeq_Analysis_Report.html")
```

## Individual Analysis Steps

If custom parameters are needed, functions can be called individually on the `RLRanges` object.

### Quality Control & Prediction
- `analyzeRLFS(rlr)`: Performs permutation tests to check if peaks are enriched at R-loop forming sequences.
- `predictCondition(rlr)`: Uses a machine learning model to classify the sample as "POS" (high quality) or "NEG" (low quality).
- `plotRLFSRes(rlr)`: Visualizes the Z-score distribution around RLFS.

### Signal & Noise Analysis
*Note: These functions require coverage data and do not support Windows.*
- `noiseAnalyze(rlr)`: Calculates signal-to-noise metrics.
- `plotFingerprint(rlr)`: Generates a deepTools-style fingerprint plot.
- `corrAnalyze(rlr)`: Correlates the sample signal with "gold-standard" SMRF-seq sites and public RLBase samples.

### Enrichment & Annotation
- `featureEnrich(rlr)`: Tests for enrichment in genomic features (CGI, Exons, etc.) using Fisher's exact test.
- `txFeatureOverlap(rlr)`: Determines the proportion of peaks overlapping specific transcript regions (TSS, TTS, Introns, etc.).
- `geneAnnotation(rlr)`: Intersects peaks with gene models via AnnotationHub.
- `rlRegionTest(rlr)`: Tests for overlap with consensus R-loop regions from RLBase.

## Accessing Public Data
You can pull pre-analyzed data for any sample in the RLBase database using its accession ID.

```r
# Fetch a specific sample from RLBase
rlr_public <- RLRangesFromRLBase(acc = "SRX1025890")
```

## Tips for Success
- **Peak Calling**: For best compatibility with RLBase comparisons, use MACS2 or MACS3 for peak calling.
- **Metadata**: Providing the `mode` (e.g., "DRIP", "S9.6") and `genome` during `RLRanges` construction is critical for accurate comparison against public datasets.
- **Results Extraction**: Use `rlresult(rlr, "resultName")` to extract specific data frames (e.g., "predictRes", "featureEnrichment", "txFeatureOverlap").

## Reference documentation
- [Analyzing R-loop data with RLSeq](./references/RLSeq.md)
- [RLSeq Vignette (Rmd)](./references/RLSeq.Rmd)