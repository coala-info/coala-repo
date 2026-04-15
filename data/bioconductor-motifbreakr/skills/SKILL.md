---
name: bioconductor-motifbreakr
description: motifbreakR predicts the impact of genetic variants on transcription factor binding sites by analyzing motif disruptions. Use when user asks to predict the effect of SNPs or indels on transcription factor binding, calculate p-values for motif disruptions, or visualize the impact of alleles on binding sites.
homepage: https://bioconductor.org/packages/release/bioc/html/motifbreakR.html
---

# bioconductor-motifbreakr

name: bioconductor-motifbreakr
description: Expert guidance for using the motifbreakR R package to predict the effects of genetic variants (SNPs, SNVs, and indels) on transcription factor binding sites. Use this skill when a user needs to: (1) Read variants from rsIDs, BED, or VCF files, (2) Interrogate motifs from MotifDb or internal datasets (ENCODE, HOCOMOCO, HOMER), (3) Calculate the impact of alleles using log-probabilities, weighted-sum, or relative entropy, (4) Calculate p-values for motif disruptions, and (5) Visualize or export results.

# bioconductor-motifbreakr

## Overview
`motifbreakR` is a Bioconductor package designed to predict how single nucleotide polymorphisms (SNPs) or small insertions/deletions (indels) disrupt transcription factor binding sites (TFBS). It works by comparing the binding scores of reference and alternate alleles against Position Probability Matrices (PPMs). It supports any genome available via `BSgenome` and thousands of motifs from `MotifDb`.

## Core Workflow

### 1. Load Required Libraries
```r
library(motifbreakR)
library(MotifDb)
library(BSgenome.Hsapiens.UCSC.hg19) # Example genome
library(SNPlocs.Hsapiens.dbSNP155.GRCh37) # Example SNP locations
```

### 2. Import Variants
Variants must be converted into a specific `GRanges` format.

*   **From rsIDs:**
    ```r
    snps.mb <- snps.from.rsid(rsid = c("rs1551515", "rs1551513"),
                              dbSNP = SNPlocs.Hsapiens.dbSNP155.GRCh37,
                              search.genome = BSgenome.Hsapiens.UCSC.hg19)
    ```
*   **From BED/VCF files:**
    Use `snps.from.file()` for SNVs or `variants.from.file()` for a mix of SNVs and indels.
    ```r
    # BED file name field must be rsID or 'chr:pos:ref:alt'
    variants <- variants.from.file(file = "path/to/file.vcf",
                                   search.genome = BSgenome.Hsapiens.UCSC.hg19,
                                   format = "vcf")
    ```

### 3. Select Motifs
You can use the entire `MotifDb` or subsets. `motifbreakR` also provides a supplemental dataset:
```r
data(motifbreakR_motif) # Loads ENCODE, FactorBook, HOCOMOCO, and HOMER
# Subset MotifDb for Human HOCOMOCO motifs
human.hoco <- subset(MotifDb, organism == "Hsapiens" & dataSource == "HOCOMOCOv10")
```

### 4. Run the Analysis
The `motifbreakR()` function is the primary engine.
```r
results <- motifbreakR(snpList = variants,
                       pwmList = human.hoco,
                       threshold = 0.85, # Score threshold (0 to 1)
                       method = "ic",    # Options: 'ic' (info content), 'log', or 'default'
                       bkg = c(A=0.25, C=0.25, G=0.25, T=0.25),
                       BPPARAM = BiocParallel::SerialParam())
```

### 5. Calculate P-values
To refine results, calculate the significance of the match for both alleles.
```r
# Granularity 1e-4 to 1e-6 is a good balance of speed and accuracy
results <- calculatePvalue(results, granularity = 1e-4)
```

### 6. Visualization and Export
*   **Plotting:** Visualize the motif disruption.
    ```r
    plotMB(results = results, rsid = "rs1006140", effect = "strong")
    ```
*   **Exporting:**
    ```r
    exportMBtable(results, file = "results.tsv", format = "tsv")
    exportMBbed(results, file = "results.bed", color = "effect_size")
    ```

## Key Parameters and Methods
*   **Methods:**
    *   `log`: Sum of log probabilities (standard).
    *   `default`: Weighted sum (weights positions by importance).
    *   `ic`: Information content (Relative Entropy).
*   **Thresholds:** The `threshold` argument in `motifbreakR()` filters by the percentage of the maximum possible score. If `filterp = TRUE`, the threshold is treated as a p-value cutoff.
*   **Parallelization:** By default, it uses `BiocParallel::bpparam()`. On Windows, use `SnowParam()` for parallel execution.

## Reference documentation
- [motifbreakR: an Introduction](./references/motifbreakR-vignette.md)