---
name: bioconductor-findit2
description: Bioconductor-findit2 identifies influential transcription factors and target genes by integrating multi-omics data such as ChIP-seq, ATAC-seq, and RNA-seq. Use when user asks to annotate genomic peaks to multiple genes, calculate regulatory potential scores, find influential transcription factors through enrichment tests, or calculate peak-gene correlations.
homepage: https://bioconductor.org/packages/release/bioc/html/FindIT2.html
---

# bioconductor-findit2

name: bioconductor-findit2
description: Identify influential transcription factors (TFs) and target genes by integrating multi-omics data (ChIP-seq, ATAC-seq, RNA-seq). Use this skill when you need to: (1) Annotate genomic peaks to multiple genes (mmPeakAnno), (2) Calculate Regulatory Potential (RP) scores from peaks or bigwig files, (3) Find influential TFs for a gene set or peak set using enrichment tests (Fisher, Wilcox, MARA), or (4) Calculate peak-gene or peak-peak correlations.

# bioconductor-findit2

## Overview
FindIT2 (Find influential TF and Target) is a Bioconductor package designed to bridge the gap between peak-level data (ChIP-seq/ATAC-seq) and gene-level expression. It moves beyond simple "nearest-gene" annotation by implementing Multi-Peak Multi-Gene (MPMG) logic and Regulatory Potential (RP) models. It is particularly powerful for identifying which TFs drive specific gene sets and for predicting direct targets of a TF by integrating binding data with differential expression.

## Core Workflows

### 1. Multi-Peak Multi-Gene Annotation (mmPeakAnno)
Standard annotation often misses distal regulators. FindIT2 offers three modes:
*   **Nearest Gene**: `mm_nearestGene(peak_GR, Txdb)` - Classic 1-to-1 mapping.
*   **Gene Bound**: `mm_geneBound(peak_GR, Txdb, input_genes)` - Ensures specific genes of interest are linked to their closest peaks.
*   **Gene Scan**: `mm_geneScan(peak_GR, Txdb, upstream, downstream)` - Links every peak within a specific window (e.g., 20kb) to a gene. This is the foundation for RP calculations.

### 2. Regulatory Potential (RP) Calculation
RP converts peak signals into a gene-level score, weighted by distance to the TSS.
*   **From TF Hits**: `calcRP_TFHit(mmAnno, Txdb, decay_dist)` - Uses binary hits or peak scores to rank potential targets.
*   **From BigWig**: `calcRP_coverage(bwFile, Txdb, Chrs_included)` - Summarizes continuous signals (like H3K27ac) into gene scores.
*   **From Peak Matrices**: `calcRP_region(mmAnno, peakScoreMt, Txdb)` - Uses a normalized count matrix (e.g., DESeq2 normalized ATAC counts) to calculate RP across multiple samples.

### 3. Finding Influential TFs
FindIT2 provides several statistical frameworks to identify TFs associated with your data:
*   **For Peak Sets**: Use `findIT_enrichFisher` (fast, binary) or `findIT_enrichWilcox` (uses motif scores) to find TFs enriched in a specific set of peaks (e.g., differential peaks).
*   **For Gene Sets**: 
    *   `findIT_TTPair`: Uses a pre-defined TF-Target database.
    *   `findIT_TFHit`: Calculates RP for all TFs in a database to see which ones regulate your gene set.
    *   `findIT_regionRP`: A "Lisa"-like approach using the `regionRP` object to find TFs whose binding explains the chromatin accessibility of your genes.
*   **Motif Activity**: `findIT_MARA` performs Motif Activity Response Analysis to see TF influence trends across samples.

### 4. Integrating ChIP and RNA
To find high-confidence direct targets, use `integrate_ChIP_RNA(result_geneRP, result_geneDiff)`. This combines the rank of a gene's RP score with the rank of its differential expression (p-value) using a rank-product method.

### 5. Peak-Gene Correlation
Link peaks to genes based on co-variation across samples:
*   `peakGeneCor`: Calculates correlation between peak accessibility and gene expression.
*   `enhancerPromoterCor`: Specifically looks for correlations between distal peaks and promoter peaks.

## Implementation Tips
*   **Feature ID**: Ensure your `GRanges` objects have a `feature_id` column in the metadata. This is the primary key used to join data.
*   **TF ID**: For TF databases, use a `TF_id` column.
*   **Decay Distance**: For *Arabidopsis*, a `decay_dist` of 1000 (1kb) is standard. For Human/Mouse, use 10,000 (10kb).
*   **Normalization**: Always use normalized counts (CPM, VST, or DESeq2-normalized) when providing matrices to `calcRP_region` or `peakGeneCor`.
*   **Visualization**: Use `plot_annoDistance` to check if a TF is promoter-centric or enhancer-centric, and `plot_peakGeneAlias_summary` to visualize the complexity of the peak-gene network.

## Reference documentation
- [Introduction to FindIT2](./references/FindIT2.Rmd)
- [FindIT2: Find influential TF and influential Target](./references/FindIT2.md)