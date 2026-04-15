---
name: bioconductor-atacseqtfea
description: This package identifies differential transcription factor activity between experimental conditions by analyzing TF footprints in ATAC-seq data. Use when user asks to identify transcription factor binding sites, calculate weighted binding scores, or perform transcription factor enrichment analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/ATACseqTFEA.html
---

# bioconductor-atacseqtfea

## Overview

The `ATACseqTFEA` package identifies differential transcription factor (TF) activity between experiment conditions using ATAC-seq data. Unlike tools that only consider chromatin openness, `ATACseqTFEA` incorporates TF footprints—the specific patterns of protection from transposase cleavage caused by TF binding. It uses an enrichment score approach to assess the activity of hundreds of TFs simultaneously.

## Core Workflow

### 1. Preparation of Binding Sites
You must first identify potential TF binding sites across the genome or within specific peak regions.

```r
library(ATACseqTFEA)
library(BSgenome.Hsapiens.UCSC.hg38) # Example genome

# Load provided motifs (Human, Zebrafish, or DeepSTARR clusters)
motifs <- readRDS(system.file("extdata", "PWMatrixList.rds", package="ATACseqTFEA"))

# Scan for binding sites
bindingSites <- prepareBindingSites(
  motifs, 
  genome = Hsapiens, 
  grange = peaks, # GRanges object of ATAC-seq peaks
  p.cutoff = 5e-05
)
```

### 2. One-Step TFEA
For standard analysis with biological replicates, use the wrapper function. Note: Input BAM files should ideally be pre-shifted using `ATACseqQC::shiftGAlignmentsList`.

```r
res <- TFEA(
  bamExp = c("exp_rep1.bam", "exp_rep2.bam"),
  bamCtl = c("ctl_rep1.bam", "ctl_rep2.bam"),
  bindingSites = bindingSites,
  positive = 0, negative = 0 # Set to 0 if BAMs are already shifted
)
```

### 3. Step-by-Step Analysis
For fine-tuning parameters (e.g., filtering criteria or custom weighting), execute the pipeline manually:

1.  **Expand Sites**: Define proximal and distal regions around motifs.
    ```r
    exbs <- expandBindingSites(bindingSites, proximal=40, distal=40, gap=10)
    ```
2.  **Count Insertions**: Count 5' ends in the defined regions.
    ```r
    counts <- count5ends(bam = all_bams, bindingSites = bindingSites, ...)
    ```
3.  **Filter & Normalize**: Remove sites with low coverage and convert to counts per base (CPB).
    ```r
    counts <- eventsFilter(counts, "proximalRegion > 0")
    counts <- countsNormalization(counts, proximal=40, distal=40)
    ```
4.  **Score & Differential Analysis**: Calculate weighted binding scores and use `limma` logic for differential testing.
    ```r
    counts <- getWeightedBindingScore(counts)
    design <- cbind(CTL=1, EXPvsCTL=c(1, 1, 0, 0)) # Example design
    counts <- DBscore(counts, design=design, coef="EXPvsCTL")
    ```
5.  **Enrichment**: Run the final TFEA.
    ```r
    res <- doTFEA(counts)
    ```

## Visualization and Results

*   **Volcano Plot**: View global TF enrichment.
    ```r
    ESvolcanoplot(TFEAresults = res, TFnameToShow = "CTCF")
    ```
*   **Enrichment Score Plot**: View the GSEA-style running enrichment for a specific TF.
    ```r
    plotES(res, TF = "TAL1", outfolder = NA)
    ```
*   **Footprinting**: Use `ATACseqQC` to visualize the aggregate footprint at the identified sites.
    ```r
    library(ATACseqQC)
    sigs <- factorFootprints(bams, pfm = motifs[["TF_NAME"]], 
                             bindingSites = getBindingSites(res, TF="TF_NAME"), ...)
    ```

## Tips
*   **BAM Shifting**: Accurate footprinting requires 5' end shifting (+4bp for positive strand, -5bp for negative strand). Use `ATACseqQC` before running `TFEA`.
*   **Species Support**: Ensure the `BSgenome` and `TxDb` packages match your experimental organism and assembly (e.g., `BSgenome.Mmusculus.UCSC.mm10`).
*   **Motif Selection**: The package provides `best_curated_Human.rds` (1279 motifs) and `cluster_PWMs.rds` (6502 motifs) in its `extdata` directory.

## Reference documentation
- [ATACseqTFEA Guide](./references/ATACseqTFEA.md)