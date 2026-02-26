---
name: bioconductor-exomepeak
description: This tool analyzes MeRIP-seq and m6A-seq data to identify RNA methylation sites and detect differential modification levels between experimental conditions. Use when user asks to call peaks for RNA methylation, identify m6A sites, or perform differential methylation analysis on epitranscriptome shotgun sequencing data.
homepage: https://bioconductor.org/packages/3.6/bioc/html/exomePeak.html
---


# bioconductor-exomepeak

name: bioconductor-exomepeak
description: Analysis of affinity-based epitranscriptome shotgun sequencing data (MeRIP-seq/m6A-seq). Use this skill to perform peak calling for RNA methylation sites and identify differential methylation between experimental conditions using the exomePeak R package.

## Overview
The `exomePeak` package is designed for the analysis of MeRIP-seq (m6A-seq) data. It identifies RNA methylation sites (peak calling) and detects differential post-transcriptional RNA modification sites between two conditions. It supports multiple biological replicates, removes PCR artifacts, and handles multi-mapping reads internally.

## Core Functionality
The primary interface for the package is the `exomepeak()` function, which handles both peak calling and differential analysis depending on the provided arguments.

### Peak Calling (Single Condition)
To identify RNA methylation sites under a single experimental condition, provide IP and Input control BAM files along with gene annotation.

```r
library(exomePeak)

# Define file paths
gtf_file <- "path/to/annotation.gtf"
ip_bams <- c("IP1.bam", "IP2.bam")
input_bams <- c("Input1.bam", "Input2.bam")

# Run peak calling
result <- exomepeak(GENE_ANNO_GTF = gtf_file,
                    IP_BAM = ip_bams,
                    INPUT_BAM = input_bams)

# Access results
consistent_peaks <- result$con_peaks
all_peaks <- result$all_peaks
```

### Differential Methylation Analysis (Two Conditions)
To identify sites that are differentially regulated between two conditions (e.g., Treated vs. Control), include the `TREATED_IP_BAM` and `TREATED_INPUT_BAM` arguments.

```r
result <- exomepeak(GENE_ANNO_GTF = gtf_file,
                    IP_BAM = control_ip_bams,
                    INPUT_BAM = control_input_bams,
                    TREATED_IP_BAM = treated_ip_bams,
                    TREATED_INPUT_BAM = treated_input_bams)

# Access differential results
diff_peaks <- result$diff_peaks
sig_diff_peaks <- result$sig_siff_peaks
con_sig_diff_peaks <- result$con_sig_diff_peaks # Recommended
```

## Input Specifications
*   **Gene Annotation**: Can be provided via `GENE_ANNO_GTF` (path to GTF), a `TxDb` object, or by specifying `GENOME` (e.g., `"hg19"`) to download from UCSC.
*   **BAM Files**: Should be sorted and indexed.
*   **Paired-end Data**: Currently handled in "naive mode," where pairs are treated as independent reads.

## Interpreting Results
The function outputs files to the working directory (default: `exomePeak_output`) and returns a `GRangesList` object.

### Key Metadata Columns
*   **lg.p / lg.fdr**: log10 p-value and FDR for the peak being a methylation site.
*   **fold_enrchment**: Enrichment of IP over Input.
*   **diff.lg.p / diff.lg.fdr**: Significance of the differential methylation between conditions.
*   **diff.log2.fc**: Log2 odds ratio. Positive values indicate hyper-methylation in the treated condition; negative values indicate hypo-methylation.

### Peak Types
*   **Peaks**: Identified on merged data.
*   **Consistent Peaks (con_peaks)**: Peaks consistently enriched across all replicates. These are highly recommended for downstream analysis due to higher reproducibility.

## Reference documentation
- [exomePeak-Overview](./references/exomePeak-Overview.md)