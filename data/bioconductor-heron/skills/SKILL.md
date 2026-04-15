---
name: bioconductor-heron
description: This tool performs hierarchical analysis of high-density peptide array data to identify significant binding events at probe, epitope, and protein levels. Use when user asks to perform quantile normalization, calculate probe-level p-values, identify epitope segments, or aggregate peptide binding results to protein levels.
homepage: https://bioconductor.org/packages/release/bioc/html/HERON.html
---

# bioconductor-heron

name: bioconductor-heron
description: Analysis of high-density peptide array data (e.g., NimbleGen) using the HERON (Hierarchical Epitope pROtein biNding) package. Use this skill to perform quantile normalization, calculate probe-level p-values, identify epitope segments, and aggregate results to epitope and protein levels.

# bioconductor-heron

## Overview

HERON is a Bioconductor package designed for the hierarchical analysis of peptide binding array data. It provides a structured workflow to identify significant binding events at three levels: individual probes, epitope segments (consecutive probes), and whole proteins. It is particularly effective for COVID-19 or other viral peptide tiling arrays where identifying specific epitope regions is critical.

## Core Workflow

### 1. Data Preparation
The central object is the `HERONSequenceDataSet` (a subclass of `SummarizedExperiment`).

```R
library(HERON)

# Required components:
# 1. seq_mat: Matrix of intensities (rows = sequences, cols = samples)
# 2. col_data: DataFrame with 'ptid', 'visit' (pre/post), and 'SampleName'
# 3. probe_meta: Mapping of PROBE_SEQUENCE to PROBE_ID (Protein;Position)

sds <- HERONSequenceDataSet(seq_mat)
colData(sds) <- col_data
metadata(sds)$probe_meta <- probe_meta
```

### 2. Pre-processing and Probe Analysis
Normalize the data and calculate p-values for each probe.

```R
# Quantile normalization
seq_ds_qn <- quantileNormalize(sds)

# Calculate combined p-values (t-test/z-score by default)
# Use d_paired = TRUE for paired pre/post designs
seq_pval_res <- calcCombPValues(seq_ds_qn)

# Convert to probe-level dataset
probe_pval_res <- convertSequenceDSToProbeDS(seq_pval_res)

# Make calls (TRUE/FALSE) based on adjusted p-values
probe_calls_res <- makeProbeCalls(probe_pval_res)
```

### 3. Epitope Segment Identification
Identify blocks of consecutive probes that show binding.

```R
# Find segments using the 'unique' method (all consecutive called probes)
epi_segments <- findEpitopeSegments(probe_calls_res, segment_method = "unique")

# Calculate epitope-level significance using meta p-value methods (e.g., "wmax1")
epi_padj <- calcEpitopePValues(
    probe_calls_res,
    epitope_ids = epi_segments,
    metap_method = "wmax1"
)

# Make epitope-level calls
epi_calls <- makeEpitopeCalls(epi_padj, one_hit_filter = TRUE)
```

### 4. Protein-Level Aggregation
Aggregate epitope results to determine if an entire protein shows significant binding.

```R
prot_padj <- calcProteinPValues(epi_padj, metap_method = "tippetts")
prot_calls <- makeProteinCalls(prot_padj)
```

## Advanced Features

### Alternative Statistical Tests
- **Wilcoxon Test**: Use `calcCombPValues(obj, use = "w")` for non-normal data.
- **Z-score Cutoffs**: Use `calcCombPValues(obj, use = "z")` to make calls based on global z-score thresholds rather than p-values.

### Segmentation Methods
Beyond the "unique" method, HERON supports clustering-based segmentation:
- **hclust**: Hierarchical clustering across samples.
- **skater**: Spatial 'skater' algorithm for segmenting probes.
- **Parameters**: Adjust `segment_score_type` ("binary" or "zscore") and `segment_dist_method` ("hamming" or "euclidean").

### Smoothing
To reduce variability, apply a running average across protein probes:
```R
probe_ds_qn <- convertSequenceDSToProbeDS(seq_ds_qn, probe_meta)
smooth_ds <- smoothProbeDS(probe_ds_qn)
probe_sm_pval <- calcCombPValues(smooth_ds)
```

### Result Summaries
Use `getKofN()` to calculate the number of samples (K), frequency (F), and percentage (P) of positive calls for any level (probe, epitope, or protein).

## Reference documentation

- [Analyzing High Density Peptide Array Data using HERON](./references/full_analysis.md)