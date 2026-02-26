---
name: bioconductor-bifet
description: BiFET identifies transcription factors whose footprints are over-represented in target genomic regions while correcting for GC content and read depth biases. Use when user asks to identify enriched transcription factor footprints, perform bias-corrected enrichment tests, or compare target versus background peak sets in ATAC-seq or DNase-seq data.
homepage: https://bioconductor.org/packages/release/bioc/html/BiFET.html
---


# bioconductor-bifet

name: bioconductor-bifet
description: Bias-free Footprint Enrichment Test (BiFET) for identifying transcription factors (TFs) whose footprints are over-represented in target genomic regions (ATAC-seq or DNAse-seq peaks) while correcting for GC content and read count biases. Use this skill when analyzing TF footprint enrichment to compare target vs. background peak sets.

## Overview

BiFET is designed to identify TFs associated with specific open chromatin regions (e.g., cell-type specific peaks). Standard hypergeometric tests often yield false positives because target regions (like cell-specific peaks) frequently have different GC contents and read depths than background regions. BiFET corrects for these imbalances to provide a more accurate enrichment p-value.

## Workflow and Data Structures

The BiFET workflow requires two specific `GRanges` objects as input.

### 1. Peak Data (GRpeaks)
This object contains the genomic coordinates of the peaks (ATAC-seq or DNase-seq) and must include three specific metadata columns:
- `reads`: Numeric, representing read counts in each peak.
- `GC`: Numeric, representing the GC content of the peak.
- `peaktype`: Factor, designating each peak as "target", "background", or "no".
  - **target**: The regions of interest (e.g., cell-specific peaks).
  - **background**: The regions used for comparison (e.g., non-specific peaks).
  - **no**: Regions to be excluded from the enrichment test.

### 2. Footprint Data (GRmotif)
This object contains the locations of TF footprint calls or PWM occurrences.
- Each row represents a footprint location.
- **Row names** must be the motif IDs (e.g., "MA01371 STAT1").
- Footprints from forward and backward strands for the same PWM should be merged/not differentiated.

## Main Function: calculate_enrich_p

The primary function in the package is `calculate_enrich_p()`. It performs the bias-corrected enrichment test.

```r
library(BiFET)
library(GenomicRanges)

# Assuming GRpeaks and GRmotif are already prepared
result <- calculate_enrich_p(GRpeaks, GRmotif)

# The output is a list containing:
# 1. alpha_k: The bias correction parameters for each PWM
# 2. p.bifet: The bias-corrected p-values (Primary Result)
# 3. p.hyper: Standard hypergeometric p-values for comparison
```

## Implementation Tips

- **Peak Width**: It is recommended to use peaks of a consistent width (e.g., 200bp) centered around the summits for more reliable GC and read count comparisons.
- **Target/Background Definition**: Ensure that "target" and "background" sets are clearly defined. For example, in a two-cell-type comparison, "target" could be Type A-specific peaks, and "background" could be peaks shared between Type A and Type B or peaks specific to Type B.
- **Interpreting Results**: Compare `p.bifet` with `p.hyper`. If a TF has a very significant `p.hyper` but a non-significant `p.bifet`, the initial significance was likely driven by GC or read count bias rather than true biological enrichment.

## Reference documentation

- [A Guide to using BiFET](./references/BiFET.md)