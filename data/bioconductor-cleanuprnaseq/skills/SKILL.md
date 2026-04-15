---
name: bioconductor-cleanuprnaseq
description: This tool detects and corrects genomic DNA contamination in RNA-seq data by estimating background noise from intergenic and intronic regions. Use when user asks to identify gDNA contamination, correct gene expression counts for residual DNA, or analyze mapping statistics across genomic features.
homepage: https://bioconductor.org/packages/release/bioc/html/CleanUpRNAseq.html
---

# bioconductor-cleanuprnaseq

name: bioconductor-cleanuprnaseq
description: Detect and correct genomic DNA (gDNA) contamination in RNA-seq data. Use this skill when analyzing RNA-seq datasets (especially rRNA-depleted or SMART-Seq protocols) that exhibit high intergenic or intronic mapping rates, or when gene expression quantitation is suspected to be skewed by residual DNA.

# bioconductor-cleanuprnaseq

## Overview
CleanUpRNAseq provides a workflow to identify and mitigate genomic DNA (gDNA) contamination in RNA-seq data. It uses mapping statistics from intergenic and intronic regions to estimate the background noise contributed by gDNA and provides methods to subtract this noise from gene-level counts. The package supports both unstranded and stranded library protocols.

## Core Workflow

### 1. Annotation and SAF Preparation
The package requires an `EnsDb` object matching the genome version used for alignment. Use `get_saf` to generate Simplified Annotation Format (SAF) files for different genomic features.

```r
library(CleanUpRNAseq)
library(EnsDb.Hsapiens.v86)

# Prepare SAF for features
saf_list <- get_saf(
    ensdb_sqlite = EnsDb.Hsapiens.v86,
    bamfile = "sample.bam",
    mitochondrial_genome = "MT"
)
```

### 2. Summarizing Reads
Create a `SummarizedCounts` object to manage metadata and count data. Use `summarize_reads` to quantify reads across genomic features and `salmon_tximport` for transcript-level data.

```r
# Define sample metadata
col_data <- data.frame(
    sample_name = c("S1", "S2"),
    BAM_file = c("s1.bam", "s2.bam"),
    salmon_quant_file = c("s1/quant.sf", "s2/quant.sf"),
    group = c("Ctrl", "Trt")
)

# Initialize container
sc <- create_summarizedcounts(lib_strand = 0, colData = col_data)

# Summarize genomic features
counts_list <- summarize_reads(
    SummarizedCounts = sc,
    saf_list = saf_list,
    gtf = "annotation.gtf",
    threads = 4
)

# Import Salmon counts
salmon_counts <- salmon_tximport(sc, ensdb_sqlite = EnsDb.Hsapiens.v86)
```

### 3. Detecting Contamination
Generate diagnostic plots to assess the extent of gDNA contamination. High percentages of reads in intergenic or intronic regions typically indicate contamination.

```r
# Plot mapping status
p1 <- plot_assignment_stat(sc)
# Plot distribution over features (genes, introns, intergenic)
p2 <- plot_read_distr(get_region_stat(sc))
# PCA and Heatmap to see sample clustering
p3 <- plot_pca_heatmap(sc)
```

### 4. Correcting Contamination
Choose a correction method based on the library type:

*   **Unstranded (Global):** Uses median per-base read coverage over intergenic regions.
    ```r
    corrected_counts <- correct_global(sc)
    ```
*   **Unstranded (GC-aware):** Leverages GC-content bias for more granular correction.
    ```r
    corrected_counts <- correct_GC(sc, gene_gc = gene_GC_data, intergenic_gc = intergenic_GC_data)
    ```
*   **Stranded:** Uses counts from the opposite strand as the contamination estimate.
    ```r
    # Requires Salmon quant with opposite strandedness setting
    corrected_counts <- correct_stranded(sc)
    ```

## Tips for Success
*   **EnsDb Consistency:** Ensure the `EnsDb` version exactly matches the GTF used for alignment.
*   **Strandedness:** For stranded data, you must run Salmon twice (once with the correct `--libType` and once with the opposite) to use `correct_stranded`.
*   **Wrapper Functions:** For a streamlined experience, use `create_diagnostic_plots()` and `correct_for_contamination()` which bundle multiple steps.

## Reference documentation
- [CleanUpRNAseq: detecting and correcting gDNA contamination in RNA-seq data](./references/CleanUpRNAseq.md)