---
name: bioconductor-transcriptr
description: The transcriptR package identifies and quantifies primary transcripts from nascent RNA-seq data by integrating RNA-seq coverage with ChIP-seq peak information. Use when user asks to identify continuous transcribed units, estimate background noise in RNA-seq, classify transcription start sites from ChIP-seq data, or resolve merged transcript signals.
homepage: https://bioconductor.org/packages/release/bioc/html/transcriptR.html
---


# bioconductor-transcriptr

## Overview

The `transcriptR` package provides a data-driven pipeline to identify and quantify primary transcripts. It is specifically designed for sequencing techniques that capture nascent or nuclear RNA (GRO-seq, nucRNA-seq, chrRNA-seq), which typically show broad coverage across both exons and introns. The package uses a two-part approach:
1. **RNA-seq:** Estimates background noise and identifies continuous transcribed units.
2. **ChIP-seq:** Characterizes and classifies peaks (e.g., H3K4me3) to identify active Transcription Start Sites (TSSs).

The final step integrates these sources to break apart merged RNA-seq signals into individual transcripts based on detected TSS activity.

## Workflow and Core Functions

### 1. RNA-seq Processing (TranscriptionDataSet)

Initialize the analysis by constructing a `TranscriptionDataSet` (TDS) object from a BAM file.

```r
library(transcriptR)
library(GenomicFeatures)

# Construct TDS object
tds <- constructTDS(file = "path/to/rna_seq.bam", 
                    region = NULL, # Optional GRanges to limit scope
                    fragment.size = 250, 
                    unique = FALSE, 
                    paired.end = FALSE, 
                    swap.strand = TRUE)

# Estimate background coverage cutoff (Poisson-based)
estimateBackground(tds, fdr.cutoff = 0.01)

# Tune gap distance (merging fragments based on reference annotations)
# gd is a vector of distances to test
gd <- seq(0, 10000, by = 100)
estimateGapDistance(tds, annot = ref_genes, gap.dist.range = gd)

# Call transcripts
detectTranscripts(tds, estimate.params = TRUE)
```

### 2. ChIP-seq Processing (ChipDataSet)

If ChIP-seq data for TSS marks is available, use it to refine transcript boundaries.

```r
# Construct CDS object
cds <- constructCDS(peaks = "peaks.bed", 
                    reads = "chip_reads.bam", 
                    TxDb = txdb_object,
                    tss.region = c(-2000, 2000))

# Predict gene-associated peaks using logistic regression
# 'pileup' is often the strongest predictor
predictTssOverlap(cds, feature = "pileup", p = 0.75)

# Predict peak strandedness using RNA-seq signal asymmetry
predictStrand(cdsObj = cds, tdsObj = tds, win.size = 2000)
```

### 3. Integration and Refinement

Combine the RNA-seq and ChIP-seq datasets to resolve overlapping or closely spaced transcripts.

```r
# Break merged transcripts using predicted TSS peaks
breakTranscriptsByPeaks(tdsObj = tds, cdsObj = cds, estimate.params = TRUE)

# Annotate and retrieve results
annotateTranscripts(tds, annot = ref_genes, min.overlap = 0.5)
final_trx <- getTranscripts(tds, min.length = 250, min.fpkm = 0.5)
```

## Visualization and Export

The package supports exporting results to standard formats for genome browser visualization.

*   **Coverage:** `exportCoverage(tds, file = "plus.bw", type = "bigWig", strand = "+")`
*   **Transcripts:** `transcriptsToBed(object = final_trx, file = "transcripts.bed")`
*   **ChIP Peaks:** `peaksToBed(object = cds, file = "peaks.bed", gene.associated.peaks = TRUE)`
*   **Diagnostics:** `plotErrorRate(tds)` for gap distance tuning and `plotROC(cds)` for ChIP peak classification performance.

## Key Tips

*   **Nascent RNA:** This package is optimized for primary transcription. Standard mRNA-seq (exonic only) may result in highly fragmented transcript calls.
*   **Gap Distance:** The `estimateGapDistance` function is critical. It balances "dissected" errors (splitting one gene) vs "merged" errors (joining two genes).
*   **Strandedness:** Ensure `swap.strand` is set correctly during `constructTDS` based on your library preparation (e.g., dUTP-based protocols often require swapping).
*   **Peak Merging:** Use `reduce.peaks = TRUE` in `constructCDS` to prevent artificial transcript truncation caused by fragmented ChIP-seq peak calls.

## Reference documentation

- [transcriptR: an integrative tool for ChIP- and RNA-seq based primary transcripts detection and quantification](./references/transcriptR.md)