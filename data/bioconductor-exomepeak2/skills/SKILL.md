---
name: bioconductor-exomepeak2
description: The exomePeak2 package performs peak calling and differential modification analysis for MeRIP-Seq data while correcting for GC content bias. Use when user asks to detect RNA modification peaks, perform differential modification analysis between conditions, or quantify modification levels at single-base resolution.
homepage: https://bioconductor.org/packages/3.11/bioc/html/exomePeak2.html
---


# bioconductor-exomepeak2

## Overview
The `exomePeak2` package is designed for the analysis of MeRIP-Seq (Methylated RNA Immunoprecipitation Sequencing) data. It provides a robust framework for detecting RNA modification peaks (e.g., m6A) and performing differential modification analysis between conditions. Its primary strength lies in its bias-aware model, which corrects for GC content variation and technical differences in IP efficiency using Generalized Linear Models (GLM).

## Core Workflows

### 1. One-Step Peak Calling
The simplest way to identify modification peaks is using the `exomePeak2()` wrapper function. It requires BAM files for IP and Input samples and a transcript annotation (GTF/GFF or TxDb).

```r
library(exomePeak2)

# Define file paths
IP_BAMS <- c("IP1.bam", "IP2.bam")
INPUT_BAMS <- c("Input1.bam", "Input2.bam")
GENE_ANNO <- "annotation.gtf"

# Run peak calling
# Note: Providing 'genome' (e.g., "hg19") enables GC content bias correction
result <- exomePeak2(bam_ip = IP_BAMS,
                     bam_input = INPUT_BAMS,
                     gff_dir = GENE_ANNO,
                     genome = "hg19",
                     paired_end = FALSE)
```

### 2. Differential Modification Analysis
To compare two biological conditions (e.g., Control vs. Treated), provide the BAM files for both groups. The package uses an interactive GLM to identify sites where the IP/Input ratio changes significantly.

```r
result <- exomePeak2(bam_ip = CONTROL_IP_BAMS,
                     bam_input = CONTROL_INPUT_BAMS,
                     bam_treated_ip = TREATED_IP_BAMS,
                     bam_treated_input = TREATED_INPUT_BAMS,
                     gff_dir = GENE_ANNO,
                     genome = "hg19")
```

### 3. Single-Base Resolution Analysis
If you have specific sites of interest (e.g., from m6A-CLIP-Seq), you can perform quantification and statistical testing on those specific coordinates using the `mod_annot` argument.

```r
# mod_annot must be a GRanges object
result <- exomePeak2(bam_ip = IP_BAMS,
                     bam_input = INPUT_BAMS,
                     mod_annot = MY_GRANGES_SITES,
                     gff_dir = GENE_ANNO,
                     genome = "hg19")
```

### 4. Multi-Step Analysis and Visualization
For more control or diagnostic purposes, the workflow can be broken down:

1.  **Scan BAMs**: `scanMeripBAM()`
2.  **Call Peaks**: `exomePeakCalling()`
3.  **Normalize**: `normalizeGC()` (corrects for GC bias)
4.  **Statistical Inference**: `glmM()` (for peak calling) or `glmDM()` (for differential modification)
5.  **Visualization**:
    *   `plotLfcGC(SummarizedExomePeaks)`: Check the relationship between GC content and Log2 Fold Change.
    *   `plotSizeFactors(SummarizedExomePeaks)`: Visualize sequencing depth and IP efficiency factors.
6.  **Export**: `exportResults(SummarizedExomePeaks, format = "CSV")`

## Key Parameters
*   `genome`: Specify the UCSC genome ID (e.g., "mm10", "hg38") to enable GC bias correction.
*   `paired_end`: Set to `TRUE` if using paired-end sequencing data.
*   `gff_dir` / `gff`: Path to the GTF/GFF file for transcript annotation.
*   `mod_annot`: A `GRanges` object for site-specific quantification instead of sliding-window peak calling.

## Interpreting Results
The package exports results to a folder named `exomePeak2_output`.
*   **log2FoldChange / log2FC**: The enrichment of IP over Input.
*   **diff.log2FC**: (In differential mode) The change in modification level between conditions.
*   **pvalue / padj (fdr)**: Statistical significance of the modification or the change.
*   **score**: Calculated as `-log10(p-value)` or `-log2(p-value)` depending on the version.

## Reference documentation
- [The exomePeak2 user's guide (v0.99)](./references/Vignette_V_0.99.md)
- [The exomePeak2 Guide (v2.00)](./references/Vignette_V_2.00.Rmd)