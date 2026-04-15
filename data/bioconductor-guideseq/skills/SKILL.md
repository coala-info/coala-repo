---
name: bioconductor-guideseq
description: This package analyzes GUIDE-seq and PEtag-seq data to identify CRISPR-Cas9 off-target cleavage sites. Use when user asks to identify off-target sites, process UMI-tagged sequencing data, call peaks from double-stranded oligonucleotide integration assays, or map sequence homology to a guide RNA.
homepage: https://bioconductor.org/packages/release/bioc/html/GUIDEseq.html
---

# bioconductor-guideseq

name: bioconductor-guideseq
description: Analysis of GUIDE-seq and PEtag-seq data to identify CRISPR-Cas9 off-target cleavage sites. Use this skill when analyzing high-throughput sequencing data from double-stranded oligonucleotide (dsODN) integration assays, including UMI filtering, peak calling, and off-target sequence homology mapping.

# bioconductor-guideseq

## Overview

The `GUIDEseq` package provides a comprehensive pipeline for analyzing GUIDE-seq (Genome-wide Unbiased Identification of DSBs Enabled by Sequencing) data. It processes raw alignment files to identify unique cleavage events, clusters them into peaks, and annotates these peaks by searching for homology with the target guide RNA (gRNA) and Protospacer Adjacent Motif (PAM).

## Core Workflow

The package can be used either as a single wrapper function or as a step-by-step pipeline for finer control.

### 1. All-in-One Analysis
The `GUIDEseqAnalysis` function executes the entire pipeline from alignment files to annotated off-targets.

```r
library(GUIDEseq)
library(BSgenome.Hsapiens.UCSC.hg19)

results <- GUIDEseqAnalysis(
    alignment.inputfile = "path/to/sorted.bam",
    umi.inputfile = "path/to/umi_reads.txt",
    gRNA.file = "path/to/gRNA.fa",
    BSgenomeName = Hsapiens,
    min.reads = 1,
    n.cores.max = 1
)
# Access results
results$offTargets    # Annotated off-target sites
results$merged.peaks  # Identified cleavage sites
```

### 2. Step-by-Step Pipeline

#### Step 1: Remove PCR Bias
Use `getUniqueCleavageEvents` to filter reads and collapse PCR duplicates using Unique Molecular Identifiers (UMIs).

```r
uniqueCleavageEvents <- getUniqueCleavageEvents(
    alignment.file = "sorted.bam", 
    umi.inputfile = "umi.txt",
    n.cores.max = 1
)
# Returns a GRanges object of unique cleavage sites
cleavage.gr <- uniqueCleavageEvents$cleavage.gr
```

#### Step 2: Peak Calling
Summarize cleavage events into peaks using a sliding window approach.

```r
peaks <- getPeaks(
    cleavage.gr, 
    window.size = 20, 
    step = 20, 
    min.reads = 2
)
peaks.gr <- peaks$peaks
```

#### Step 3: Merge Strands
Merge peaks from the plus and minus strands that represent the same double-strand break.

```r
mergedPeaks <- mergePlusMinusPeaks(
    peaks.gr = peaks.gr,
    distance.threshold = 40,
    plus.strand.start.gt.minus.strand.end = TRUE
)
```

#### Step 4: Off-target Annotation
Search for sequence homology between identified peaks and the gRNA.

```r
offTargets <- offTargetAnalysisOfPeakRegions(
    gRNA = "gRNA.fa",
    peaks = mergedPeaks$mergedPeaks.gr,
    BSgenomeName = Hsapiens,
    max.mismatch = 3,
    PAM.pattern = "(NAG|NGG|NGA)$",
    PAM.size = 3,
    gRNA.size = 20
)
```

## Input Requirements

- **Alignment File**: A BAM or BED file. If using BED, it must contain CIGAR information.
- **UMI File**: A tab-delimited file with at least two columns: Read ID and the corresponding UMI sequence.
- **Genome**: A `BSgenome` object corresponding to the organism (e.g., `BSgenome.Hsapiens.UCSC.hg19`).
- **gRNA File**: A FASTA file containing the target spacer sequence (without the PAM).

## Key Parameters

- `min.reads`: Minimum number of unique reads required to call a peak. Increase this to reduce false positives in high-background datasets.
- `window.size` / `step`: Controls the resolution of peak calling. Default is 20bp.
- `distance.threshold`: Maximum distance between plus and minus strand peaks to be considered a single cleavage event.
- `upstream` / `downstream`: The region around the peak to search for gRNA homology (default 50bp).

## Reference documentation

- [GUIDEseq user's guide](./references/GUIDEseq.md)