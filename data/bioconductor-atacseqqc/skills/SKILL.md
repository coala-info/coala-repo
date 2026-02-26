---
name: bioconductor-atacseqqc
description: This tool performs quality control and preprocessing for ATAC-seq data, including fragment size analysis and Tn5 transposase bias correction. Use when user asks to assess library complexity, calculate TSS enrichment scores, shift read coordinates, or split BAM files into nucleosome-free and nucleosome-bound fractions.
homepage: https://bioconductor.org/packages/release/bioc/html/ATACseqQC.html
---


# bioconductor-atacseqqc

name: bioconductor-atacseqqc
description: Quality control and preprocessing for ATAC-seq data. Use this skill to assess library complexity, fragment size distribution, TSS enrichment, and nucleosome positioning. It provides tools for shifting read coordinates to account for Tn5 transposase bias, splitting BAM files into nucleosome-free and nucleosome-bound fractions, and generating transcription factor footprints and V-plots.

# bioconductor-atacseqqc

## Overview
ATACseqQC provides a suite of tools for diagnostic monitoring and preprocessing of ATAC-seq data. It helps researchers evaluate data quality according to published standards (e.g., ENCODE) and prepares data for downstream analysis like peak calling or footprinting by adjusting for Tn5 transposase insertion bias and classifying fragments by nucleosome occupancy.

## Core Workflow

### 1. Initial Quality Assessment
Before processing, evaluate the library complexity and fragment size distribution. A high-quality ATAC-seq library should show clear periodicity in fragment sizes representing nucleosome-free regions (NFR) and nucleosome-bound DNA.

```r
library(ATACseqQC)

# Estimate library complexity
estimateLibComplexity(readsDupFreq(bamfile))

# Plot fragment size distribution
# Expect a large peak <100bp (NFR) and periodic peaks (nucleosomes)
fragSize <- fragSizeDist(bamfile, "Sample_Label")
```

### 2. Coordinate Shifting (Tn5 Adjustment)
Tn5 transposase inserts adaptors separated by 9 bp. To accurately map the center of the open chromatin, reads must be shifted: +4 bp for the positive strand and -5 bp for the negative strand.

```r
# Define tags to preserve (optional but recommended)
tags <- c("AS", "NM", "MD")

# Read BAM and shift
gal <- readBamFile(bamfile, tag=tags, asMates=TRUE, bigFile=TRUE)
shiftedBamfile <- file.path(outPath, "shifted.bam")
gal1 <- shiftGAlignmentsList(gal, outbam=shiftedBamfile)
```

### 3. Enrichment Scoring
Calculate standard metrics to determine if the signal is enriched at expected genomic features.

*   **TSSEscore**: TSS Enrichment Score. ENCODE recommends >10 for high-quality human data.
*   **PTscore**: Promoter/Transcript body score.
*   **NFRscore**: Nucleosome Free Regions score.

```r
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
txs <- transcripts(TxDb.Hsapiens.UCSC.hg19.knownGene)

# Calculate TSS Enrichment
tsse <- TSSEscore(gal1, txs)
tsse$TSSEscore

# Calculate NFR score
nfr <- NFRscore(gal1, txs)
```

### 4. Fragment Splitting
Split the shifted reads into different bins based on fragment length (NFR, mononucleosome, dinucleosome, etc.). This is essential for visualizing nucleosome phasing.

```r
# Split by fragment length and (optionally) conservation
# Conservation requires phastCons packages
objs <- splitGAlignmentsByCut(gal1, txs=txs, outPath = outPath)

# Resulting files: NucleosomeFree.bam, mononucleosome.bam, etc.
```

### 5. Footprinting and V-plots
Identify transcription factor (TF) occupancy by analyzing the "shadow" left by the protein on the DNA.

```r
# Generate footprint for a specific motif (PFM)
library(MotifDb)
ctcf_motif <- query(MotifDb, "CTCF")[[1]]

sigs <- factorFootprints(shiftedBamfile, pfm=ctcf_motif,
                         genome=Hsapiens,
                         min.score="90%",
                         upstream=100, downstream=100)

# Generate V-plot (fragment midpoint vs length)
vp <- vPlot(shiftedBamfile, pfm=ctcf_motif,
            genome=Hsapiens, min.score="90%")
```

## Tips and Best Practices
*   **Genome Matching**: Ensure that the `BSgenome`, `TxDb`, and (optional) `phastCons` packages match your alignment reference exactly (e.g., hg19 vs hg38).
*   **Memory Management**: For large BAM files, use the `which` parameter in `readBamFile` to process data chromosome by chromosome or use `bigFile=TRUE`.
*   **Peak Calling**: Always use the **shifted** BAM file for peak calling (e.g., with MACS2) to ensure peaks are centered on the actual transposase insertion sites.
*   **Conservation**: Including conservation scores in `splitGAlignmentsByCut` improves classification accuracy but significantly increases computation time.

## Reference documentation
- [ATACseqQC Guide](./references/ATACseqQC.md)