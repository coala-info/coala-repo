---
name: bioconductor-riboprofiling
description: This tool performs analysis and quality assessment of ribosome-profiling data to identify translated regions and quantify protein synthesis. Use when user asks to process BAM files for Ribo-seq analysis, estimate ribosome P-site offsets, quantify coverage across genomic features, or analyze codon-level translation dynamics.
homepage: https://bioconductor.org/packages/release/bioc/html/RiboProfiling.html
---

# bioconductor-riboprofiling

name: bioconductor-riboprofiling
description: Analysis and quality assessment of Ribosome-profiling (Ribo-seq) data. Use this skill to process BAM files to determine read match length distributions, estimate ribosome P-site offsets, quantify coverage across genomic features (CDS, UTRs), and analyze codon-level translation dynamics.

## Overview

RiboProfiling is designed to process Ribosome-profiling data starting from BAM files. It enables the identification of translated regions by accounting for the fact that ribosomes protect mRNA fragments (footprints) from RNAse digestion. The package provides tools for quality control, P-site offset calibration, feature quantification, and codon-level analysis including Principal Component Analysis (PCA) of codon coverage.

## Data Input and Preparation

Load the library and prepare BAM file references.

library(RiboProfiling)
library(GenomicAlignments)

# Define BAM files
bam_url <- "http://genomique.info/data/public/RiboProfiling/ctrl.bam"
listInputBam <- c(BamFile(bam_url))

# Load as GAlignments for manual processing
aln <- readGAlignments(BamFile(bam_url))

## Quick Start Workflow

The `riboSeqFromBAM` function is a wrapper that performs read length histograms, offset estimation, and feature counting in one step.

# Requires a genome name (e.g., "hg19") or a TxDb object
covData <- riboSeqFromBAM(listInputBam, genomeName="hg19")

## Quality Assessment: Read Match Length

Use `histMatchLength` to visualize the distribution of footprint sizes. Ribosome footprints are typically around 30bp.

matchLenDistr <- histMatchLength(aln, 0)
# Plot the histogram
matchLenDistr[[2]]

## P-site Offset Estimation

Ribosome P-site positions must be inferred from the read starts. This is done by analyzing coverage around the Transcription Start Site (TSS).

1. Convert alignments to start positions:
alnGRanges <- readsToStartOrEnd(aln, what="start")

2. Define regions around promoters:
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
oneBinRanges <- aroundPromoter(txdb, alnGRanges, percBestExpressed=0.001)

3. Calculate and plot coverage:
listPromoterCov <- readStartCov(
    alnGRanges,
    oneBinRanges,
    matchSize=c(29:31),
    fixedInterval=c(-20, 20),
    renameChr="aroundTSS",
    charPerc="perc"
)
plotSummarizedCov(listPromoterCov)

## Feature Quantification

Quantify reads on 5'UTR, CDS, and 3'UTR after applying the calculated offset (e.g., -14).

# Get annotations
cds <- cdsBy(txdb, by="tx", use.names=TRUE)
exonGRanges <- exonsBy(txdb, by="tx", use.names=TRUE)
cdsPosTransc <- orfRelativePos(cds, exonGRanges)

# Count shifted reads
countsData <- countShiftReads(
    exonGRanges=exonGRanges[names(cdsPosTransc)],
    cdsPosTransc=cdsPosTransc,
    alnGRanges=alnGRanges,
    shiftValue=-14
)

# Visualize counts
listCountsPlots <- countsPlot(list(countsData[[1]]), grep("_counts$", colnames(countsData[[1]])), 1)

## Codon-Level Analysis

Analyze translation dynamics by looking at codon usage and stalling.

1. Associate coverage with codon types:
library(BSgenome.Hsapiens.UCSC.hg19)
genomeSeq <- BSgenome.Hsapiens.UCSC.hg19
listReadsCodon <- countsData[[2]]
orfCoord <- cds[names(cds) %in% names(listReadsCodon)]
codonData <- codonInfo(listReadsCodon, genomeSeq, orfCoord)

2. Perform PCA on codon coverage:
codonCovMatrix <- codonData[[2]]
# Filter for expressed genes
ixExpGenes <- which(apply(codonCovMatrix, 1, sum) >= 50)
listPCACodonCoverage <- codonPCA(t(codonCovMatrix[ixExpGenes, ]), "codonCoverage")
listPCACodonCoverage[[2]]

## Reference documentation

- [RiboProfiling](./references/RiboProfiling.md)