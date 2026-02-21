---
name: deeptools
description: deeptools is a specialized suite of Python-based tools designed to transform mapped sequencing reads (BAM files) into interpretable biological insights.
homepage: https://github.com/deeptools/deepTools
---

# deeptools

## Overview

deeptools is a specialized suite of Python-based tools designed to transform mapped sequencing reads (BAM files) into interpretable biological insights. It provides a standardized workflow for normalizing data to account for sequencing depth, comparing treatment and control samples, and generating sophisticated visualizations like heatmaps and profile plots. Use this skill to perform quality control on libraries, generate genomic coverage tracks, and analyze signal enrichment over specific genomic features like Transcription Start Sites (TSS) or gene bodies.

## Core Workflows and CLI Patterns

### 1. Generating Normalized Coverage (BAM to bigWig)
The `bamCoverage` tool is the primary method for creating coverage files for genome browsers.

*   **Basic RPKM Normalization:**
    `bamCoverage -b input.bam -o output.bw --normalizeUsing RPKM`
*   **Effective Genome Size (RPGC) Normalization:**
    Useful for comparing samples across different species or assemblies.
    `bamCoverage -b input.bam -o output.bw --normalizeUsing RPGC --effectiveGenomeSize 2913022398`
*   **Filtering by Quality:**
    `bamCoverage -b input.bam -o output.bw --minMappingQuality 30 --ignoreDuplicates`

### 2. Comparing Samples (Treatment vs. Control)
Use `bamCompare` to generate a ratio or log2ratio track between two samples.

*   **Log2 Ratio:**
    `bamCompare -b1 treatment.bam -b2 control.bam -o log2ratio.bw --operation log2`

### 3. Quality Control and Correlation
Before downstream analysis, assess the global similarity between samples or the strength of a ChIP-seq signal.

*   **Multi-BAM Summary:**
    `multiBamSummary bins -b file1.bam file2.bam -o results.npz`
*   **Correlation Plot:**
    `plotCorrelation -in results.npz --corMethod spearman --skipZeros --plotTitle "Spearman Correlation" --whatToPlot heatmap -o heatmap_correlation.png`
*   **ChIP-seq Enrichment (Fingerprint):**
    `plotFingerprint -b treatment.bam control.bam --labels Treatment Control -plot fingerprint.png`

### 4. Visualization (Heatmaps and Profiles)
Visualization is a two-step process: first calculate a matrix, then plot it.

*   **Step 1: computeMatrix**
    *   *Reference-point mode (e.g., TSS):*
        `computeMatrix reference-point --referencePoint TSS -b signal.bw -R genes.bed -beforeRegionStart 3000 -afterRegionStart 3000 -o matrix.gz`
    *   *Scale-regions mode (e.g., gene bodies):*
        `computeMatrix scale-regions -b signal.bw -R genes.bed --regionBodyLength 1000 -o matrix.gz`
*   **Step 2: plotHeatmap or plotProfile**
    *   `plotHeatmap -m matrix.gz -out heatmap.pdf --colorMap RdBu_r`
    *   `plotProfile -m matrix.gz -out profile.pdf --plotType lines`

## Expert Tips and Best Practices

*   **Parallelization:** Most deeptools commands support the `--numberOfProcessors` (or `-p`) flag. Always set this to the number of available CPU cores to significantly speed up processing of large BAM files.
*   **Blacklisted Regions:** For many organisms, certain genomic regions (e.g., centromeres, high-signal artifacts) should be excluded. Use the `--blackListFileName` argument to provide a BED file of regions to ignore.
*   **Bin Size:** The default bin size for coverage is 50bp. For high-resolution analysis (like transcription factor ChIP-seq), consider reducing this to 1bp or 10bp using `--binSize`.
*   **Missing Data:** When plotting, use `--missingDataColor` in `plotHeatmap` to distinguish between zero signal and regions with no data.
*   **Matrix Operations:** Use `computeMatrixOperations` to subset, filter, or join existing matrices without re-calculating them from the bigWig files.

## Reference documentation
- [deepTools GitHub Repository](./references/github_com_deeptools_deepTools.md)
- [deepTools Wiki](./references/github_com_deeptools_deepTools_wiki.md)