---
name: bioconductor-interest
description: The IntEREst package estimates and compares splicing efficiency across RNA-seq samples by quantifying intron retention and exon-exon junction levels. Use when user asks to quantify intron retention, identify U12-type minor introns, or perform differential splicing analysis between experimental groups.
homepage: https://bioconductor.org/packages/release/bioc/html/IntEREst.html
---


# bioconductor-interest

## Overview

The **IntEREst** (Intron Exon Retention Estimator) package is designed to estimate and compare splicing efficiency across multiple RNA-seq samples. It specifically excels at quantifying Intron Retention (IR) by counting reads at intron-exon junctions and within introns, as well as measuring exon-exon junction levels. A key feature is its specialized support for U12-type (minor) introns, allowing for comparative studies between major (U2) and minor spliceosome targets.

## Core Workflow

### 1. Reference Preparation
Before counting reads, you must create a reference object containing coordinates for introns and exons.

```r
library(IntEREst)

# Prepare reference from a GTF/GFF3 file or UCSC/biomaRt
# collapseExons=TRUE avoids assigning reads from alternative exons to introns
testRef <- referencePrepare(
    sourceBuild="file",
    filePath="path/to/file.gff3",
    fileFormat="gff3",
    collapseExons=TRUE
)
```

### 2. Annotating U12 Introns
If studying minor introns, use `annotateU12` to identify them based on Position Weight Matrices (PWM) for splice sites.

```r
# Uses internal pwmU12db for scoring
annoRef <- annotateU12(
    referenceChr = ref$chr,
    referenceBegin = ref$begin,
    referenceEnd = ref$end,
    referenceIntronExon = ref$int_ex,
    refGenome = BSgenome.Hsapiens.UCSC.hg19,
    setNaAs = "U2"
)
```

### 3. Read Summarization
Use `interest()` (parallel) or `interest.sequential()` to quantify reads from BAM files.

*   **Method "IntRet"**: Counts reads mapping to introns (Intron Retention).
*   **Method "IntSpan"**: Counts reads spanning across introns.
*   **Method "ExEx"**: Counts reads mapping to exon-exon junctions.

```r
# Example for Intron Retention
interest(
    bamFile = "sample.bam",
    reference = ref,
    method = "IntRet",
    junctionReadsOnly = FALSE, # Recommended for IntRet
    isPaired = TRUE,
    yieldSize = 10000,
    outFile = "results_intret.tsv"
)
```

### 4. Creating SummarizedExperiment Objects
After processing BAMs, load the results into a `SummarizedExperiment` for downstream analysis.

```r
# Load results from TSV files
irObj <- readInterestResults(
    resultFiles = "results_intret.tsv",
    sampleNames = "Sample1",
    sampleAnnotation = data.frame(group="test"),
    commonColumns = 1:10, # Columns from the reference
    freqCol = 11,         # Column with raw counts
    scaledRetentionCol = 12
)
```

## Differential Retention Analysis

IntEREst provides wrappers for popular differential expression tools adapted for IR analysis:

*   **Exact Test**: `exactTestInterest()` (edgeR-based pair-wise comparison).
*   **GLM/QLF**: `glmInterest()` or `qlfInterest()` (edgeR-based for complex designs).
*   **DESeq2**: `deseqInterest()`.
*   **DEXSeq**: `DEXSeqIntEREst()`.

```r
# Simple edgeR-based comparison
testResults <- exactTestInterest(
    irObj,
    sampleAnnoCol = "group",
    sampleAnnotation = c("control", "test")
)
```

## Visualization and U12 Analysis

The package includes specialized plotting functions to compare intron types:

*   **`u12Boxplot()`**: Compares FPKM levels of U12 vs U2 introns.
*   **`u12BoxplotNb()`**: Compares U12 introns to their immediate upstream/downstream U2 neighbors.
*   **`u12DensityPlotIntron()`**: Plots log fold-change densities for different intron classes.
*   **`plot()`**: General distribution check for the `SummarizedExperiment` object.

## Recommended Pipeline for Differential IR

To perform a robust differential IR analysis (comparing intron-mapping reads relative to intron-spanning reads):
1.  Run `interest()` with `method="IntSpan"` on uncollapsed exons.
2.  Run `interest()` with `method="IntRet"` on collapsed exons.
3.  Combine objects using `cbind()`.
4.  Use `deseqInterest()` with a design like `~condition + condition:intronExon` to find introns where the ratio of retained to spanned reads changes significantly between conditions.

## Reference documentation
- [IntEREst](./references/IntEREst.md)