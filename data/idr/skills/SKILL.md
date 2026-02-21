---
name: idr
description: The IDR (Irreproducible Discovery Rate) framework is a statistical tool used to quantify the consistency of findings between biological replicates.
homepage: https://github.com/kundajelab/idr
---

# idr

## Overview

The IDR (Irreproducible Discovery Rate) framework is a statistical tool used to quantify the consistency of findings between biological replicates. Unlike fixed p-value or q-value thresholds which can be arbitrary, IDR analyzes the rank consistency of features (typically genomic peaks) across replicates. It fits a bivariate model to separate a "reproducible" component (signal) from an "irreproducible" component (noise), allowing researchers to select a threshold based on a specific rate of irreproducibility (e.g., 0.05).

## Installation

The most reliable way to install IDR is via Bioconda:

```bash
conda install bioconda::idr
```

## Common CLI Patterns

### Basic Comparison of Two Replicates
To compare two replicate peak files (e.g., narrowPeak format) and output the results:

```bash
idr --samples rep1_peaks.narrowPeak rep2_peaks.narrowPeak \
    --input-file-type narrowPeak \
    --rank signal.value \
    --output-file results.idr
```

### Using an Oracle Peak List
If you have a "gold standard" or merged peak list (e.g., peaks called from pooled replicates), use it as a reference to match peaks between replicates:

```bash
idr --samples rep1.bed rep2.bed \
    --peak-list merged_peaks.bed \
    --input-file-type bed \
    --output-file results.idr
```

### Generating Diagnostic Plots
Visualizing the rank consistency and IDR scores is critical for assessing data quality:

```bash
idr --samples rep1.narrowPeak rep2.narrowPeak \
    --plot \
    --output-file results.idr
```
*Note: This generates a `.png` file with the same base name as the output file.*

## Expert Tips and Best Practices

### 1. Do Not Pre-Threshold Input Peaks
IDR requires the "noise" component to accurately fit its model. You should provide a large number of peaks (e.g., the top 100,000 to 200,000 peaks) called with a very loose threshold (e.g., p-value < 0.1 or q-value < 0.1). If you only provide high-confidence peaks, the model cannot distinguish signal from noise effectively.

### 2. Choosing the Ranking Column
The `--rank` parameter determines how peaks are ordered before comparison.
- **narrowPeak/broadPeak**: Use `signal.value` (column 7) or `p.value` (column 8). `signal.value` is generally preferred for ChIP-seq.
- **BED**: Use `score` (column 5).
- **Custom**: Use `columnIndex` (1-based) to specify a specific column.

### 3. Interpreting the Output Score
The 5th column of the IDR output file contains a scaled IDR value: `min(int(log2(-125 IDR), 1000)`.
- A score of **1000** corresponds to an IDR of 0.
- A score of **540** corresponds to an IDR of 0.05.
- To filter for a 5% IDR threshold, keep peaks with a score $\ge$ 540.

### 4. Peak Matching Logic
If `--peak-list` is not provided, IDR merges overlapping peaks from replicates. If multiple peaks overlap, IDR uses the `--peak-merge-method` (default: `summit`) to determine the representative point. If you have specific summits, ensure your input files include them to improve matching precision.

### 5. Handling More Than Two Replicates
While the IDR CLI supports multiple samples, the standard ENCODE workflow often involves pairwise comparisons (e.g., Rep 1 vs Rep 2) and comparing "pseudo-replicates" (splitting one replicate in half) to assess internal consistency.

## Reference documentation
- [IDR Overview and Installation](./references/anaconda_org_channels_bioconda_packages_idr_overview.md)
- [IDR GitHub Documentation and Usage](./references/github_com_kundajelab_idr.md)