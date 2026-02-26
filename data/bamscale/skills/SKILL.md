---
name: bamscale
description: "BAMscale processes BAM files to generate normalized genomic tracks and quantification matrices for sequencing data analysis. Use when user asks to quantify signal across genomic regions, generate scaled BigWig files, calculate log2 ratios between samples, or process specialized assays like RNA-seq, OK-seq, and END-seq."
homepage: https://github.com/ncbi/BAMscale
---


# bamscale

## Overview

BAMscale is a high-performance tool designed for the rapid processing of BAM files into genomic tracks and quantification matrices. It excels at transforming raw alignment data into normalized BigWig files for visualization and TSV files for downstream statistical analysis. It is particularly useful for specialized sequencing assays like OK-seq, END-seq, and Repli-seq, where strand-specific signal or coverage ratios are required.

## Core Commands

### Peak Quantification (`cov`)
Use this to quantify signal across specific genomic regions (BED file) across multiple samples.

```bash
# Quantify peaks across multiple BAM files
BAMscale cov --bed peaks.bed --bam sample1.bam --bam sample2.bam --prefix output_name
```
*   **Outputs**: Generates four TSV files: Raw, FPKM, TPM, and Library-size normalized coverages.
*   **Tip**: Use `--prefix` to keep output files organized when running multiple comparisons.

### Scaling and Track Generation (`scale`)
Use this to create BigWig files for genome browsers.

```bash
# Basic scaled BigWig generation
BAMscale scale --bam input.bam -t 4

# Generate log2 ratio (e.g., S-phase vs G1-phase for replication timing)
BAMscale scale --bam G1.bam --bam S.bam --operation log2 --binsize 100 --smoothen 500
```
*   **Note**: In `log2` operations, the second BAM file is divided by the first.

## Specialized Operations

### RNA-Seq Coverage
BAMscale uses a specialized algorithm for RNA-seq to handle exon-intron boundaries accurately.

*   **Unstranded**: `BAMscale scale --bam rna.bam --operation rna`
*   **Stranded**: `BAMscale scale --bam rna.bam --operation strandrna`
*   **Stranded (Negated Reverse)**: `BAMscale scale --bam rna.bam --operation strandrnaR` (Useful for "mirror" visualization in IGV).

### Replication Fork Directionality (RFD)
Specifically for OK-seq data to identify replication origins and termini.

```bash
BAMscale scale --bam okseq.bam --operation rfd --binsize 1000
```
*   **Outputs**: Generates three BigWigs: RFD, Watson strand coverage, and Crick strand coverage.

### END-seq Processing
For identifying double-strand breaks at base-pair resolution.

*   **Standard**: `BAMscale scale --operation endseq --bam endseq.bam`
*   **Negated Reverse**: `BAMscale scale --operation endseqr --bam endseq.bam`

## Expert Tips

*   **Multithreading**: Use `-t` to specify threads. Performance gains typically plateau after 4 threads as processing is often I/O bound.
*   **Custom Scaling**: If you have normalization factors from other tools (like DESeq2), apply them directly:
    `BAMscale scale --bam input.bam --scale custom --factor 0.76`
*   **Smoothing**: For noisy data like replication timing, use `--smoothen <int>` to calculate the average of surrounding bins. A value of 500 with a 100bp binsize averages over 100kb.
*   **Index Files**: Ensure your BAM files are sorted and indexed (`.bai`). BAMscale supports both `file.bam.bai` and `file.bai` naming conventions.

## Reference documentation

- [Detailed Use: Quantifying Peak Coverages](./references/github_com_NLM-DIR_BAMscale_wiki_Detailed-Use_-Quantifying-Peak-Coverages-from-Multiple-BAM-Files.md)
- [Detailed Use: Generating Scaled Coverage Tracks](./references/github_com_NLM-DIR_BAMscale_wiki_Detailed-Use_-Generating-Scaled-Coverage-Tracks.md)
- [Detailed usage: RNA-seq coverage tracks](./references/github_com_NLM-DIR_BAMscale_wiki_Detailed-usage_-RNA-seq-coverage-tracks.md)
- [Detailed Use: Replication Timing log2 Coverage Ratio](./references/github_com_NLM-DIR_BAMscale_wiki_Detailed-Use_-Replication-Timing-log2-Coverage-Ratio-from-Two-BAM-Files.md)