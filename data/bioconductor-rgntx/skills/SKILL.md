---
name: bioconductor-rgntx
description: RgnTX provides a permutation test framework to statistically estimate the association between sets of transcriptome regions while accounting for alternative splicing and isoform ambiguity. Use when user asks to perform transcriptomic permutation tests, shuffle features within specific transcript contexts, or evaluate associations between RNA features with isoform ambiguity.
homepage: https://bioconductor.org/packages/release/bioc/html/RgnTX.html
---


# bioconductor-rgntx

## Overview
The `RgnTX` package provides a permutation test framework specifically designed for the transcriptome. Unlike genome-centric tools, `RgnTX` accounts for the complex architecture of the transcriptome, including alternative splicing and isoform ambiguity. It allows for statistically estimating the association between two sets of transcriptome regions by shuffling features within specific transcriptomic contexts (e.g., mature mRNA, CDS, UTRs).

## Core Workflows

### 1. Data Preparation
`RgnTX` uses `GRanges` or `GRangesList` objects. 
- **GRangesList**: Each element is a feature; the name of the element must be the **Transcript ID**.
- **GRanges**: Must include a `transcriptsHits` metadata column for transcript IDs and a `group` column if a feature consists of multiple ranges.

```r
library(RgnTX)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene

# Convert between formats
gr <- GRangesList2GRanges(grl_object)
grl <- GRanges2GRangesList(gr_object)
```

### 2. Randomization Strategies
Randomization is the "shuffling" step of the permutation test.
- `randomizeTx()`: Picks random regions of a specified length from a given transcriptome space.
- `randomizeFeaturesTx()`: Shuffles existing features within their known associated transcripts.
- `randomizeFeaturesTxIA()`: Shuffles features with **Isoform Ambiguity** (IA) within the set of all possible isoforms they could map to.

```r
# Randomize 100 regions of 100nt in mature mRNA
rand_regions <- randomizeTx(txdb, trans_ids = "all", random_num = 100, random_length = 100, type = "mature")
```

### 3. Permutation Testing
The primary functions for testing associations.

#### Standard Association (Known Isoforms)
Use `permTestTx` when the transcript belonging of each feature is known.
```r
results <- permTestTx(RS1 = set_A, RS2 = set_B, txdb = txdb, 
                      type = "mature", ntimes = 50, 
                      ev_function_1 = overlapCountsTx)
```

#### Association with Isoform Ambiguity (IA)
Use `permTestTxIA` when it is unclear which specific isoform a feature belongs to.
```r
results_ia <- permTestTxIA(RS1 = m6a_sites, RS2 = target_regions, 
                           txdb = txdb, ntimes = 50)
```

#### Custom Region Testing (e.g., Stop Codons)
Use `permTestTx_customPick` or `permTestTxIA_customPick` to test if features associate with specific functional regions defined by a custom function.
```r
# Example: Testing association with stop codons
results_custom <- permTestTxIA_customPick(RS1 = m6a_data, txdb = txdb,
                                          customPick_function = getStopCodon,
                                          ntimes = 50)
```

### 4. Evaluation Functions
These define the statistic being measured:
- `overlapCountsTx`: Counts number of overlaps.
- `overlapCountsTxIA`: Calculates weighted overlaps for ambiguous isoforms.
- `overlapWidthTx`: Sum of overlapping nucleotides.
- `distanceTx`: Mean distance to the closest region.

### 5. Visualizing and Interpreting Results
- `plotPermResults(results)`: Generates a histogram of random evaluations vs. the observed value.
- **P-value**: Percentage of random trials more extreme than observed.
- **Z-score**: Number of standard deviations the observed value is from the random mean.

### 6. Shifted Z-Scores
To determine if an association is position-specific, use `shiftedZScoreTx`. A peak at the center (0) indicates the association is highly dependent on the exact location.
```r
shifted_res <- shiftedZScoreTx(results, txdb = txdb, window = 2000, step = 200)
plotShiftedZScoreTx(shifted_res)
```

## Tips for Success
- **Transcript IDs**: Ensure you use the internal IDs from the `TxDb` object (e.g., "170"), not gene symbols or external Ensembl IDs, unless the `TxDb` is configured for them.
- **Type Argument**: Use `type = "mature"` for mRNAs, `"CDS"` for coding sequences, or `"fiveUTR"`/`"threeUTR"` for untranslated regions to constrain the null model.
- **Performance**: Permutation tests are computationally expensive. Start with `ntimes = 50` for testing and increase to `500` or `1000` for publication-quality results.

## Reference documentation
- [RgnTX: colocalization analysis of transcriptome elements in the presence of isoform heterogeneity and ambiguity](./references/RgnTX.md)