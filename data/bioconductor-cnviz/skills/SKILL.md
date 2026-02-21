---
name: bioconductor-cnviz
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/CNViz.html
---

# bioconductor-cnviz

name: bioconductor-cnviz
description: Visualizing copy number variants (CNV), loss of heterozygosity (LOH), and SNV/indel data using the CNViz interactive Shiny application. Use this skill when you need to prepare genomic data (probe-level, gene-level, or segment-level) and launch a web-based visualization tool for copy number analysis in R.

## Overview

CNViz is an R/Bioconductor package designed to bridge the gap between raw copy number data tables and intuitive genomic visualizations. It provides an interactive Shiny interface (`launchCNViz`) that allows users to explore large-scale chromosomal changes alongside gene-level alterations and small variants (SNVs/indels).

## Core Workflow

The primary function is `launchCNViz()`. To use it, you must format your genomic data into specific data frames or GRanges objects.

### 1. Data Preparation

CNViz accepts four main types of genomic data. While only one of `probe_data`, `gene_data`, or `segment_data` is strictly required, providing all three creates the most comprehensive visualization.

*   **Meta Data**: A single-row data frame.
    *   Required column: `ploidy` (defaults to 2 if missing).
    *   Optional: `purity`, `sex`, `diagnosis`.
*   **Probe Data**: High-resolution data (thousands of rows).
    *   Required columns: `chr`, `start`, `end`, `gene`, `log2`.
    *   Optional: `weight` (confidence score).
*   **Gene Data**: Aggregated gene-level data.
    *   Required columns: `chr`, `start`, `end`, `gene`, `log2`.
    *   Optional: `loh` (logical TRUE/FALSE), `weight` (e.g., number of probes).
    *   *Note*: If you have copy number (C) instead of log2, calculate it using `log2(C/2)`.
*   **Segment Data**: Large-scale chromosomal segments.
    *   Required columns: `chr`, `start`, `end`, `log2`.
    *   Optional: `loh` (logical).
*   **Variant Data**: SNVs and short indels.
    *   Required columns: `gene`, `mutation_id`.
    *   Optional: `start` (to plot on the probe map), `depth`, `ref`, `alt`.

### 2. Launching the Application

Once data frames are prepared, call the launcher:

```r
library(CNViz)

launchCNViz(
  sample_name = "MySample_001",
  meta_data = my_meta_df,
  probe_data = my_probe_df,
  gene_data = my_gene_df,
  segment_data = my_segment_df,
  variant_data = my_variant_df
)
```

## Tips for Success

*   **Coordinate Systems**: Ensure all chromosomal coordinates (start/end) use the same assembly (e.g., hg38) across all input data frames.
*   **Handling Zero Copy Number**: If a gene has a copy number of 0, the log2 value is `-Inf`. `launchCNViz` handles these values automatically for plotting purposes.
*   **Object Compatibility**: You can pass `GRanges` objects for probe, gene, and segment data, provided the `gene` and `log2` information are stored in the metadata columns (`mcols`).
*   **Purity/Ploidy Alignment**: If your gene-level data is adjusted for purity but your probe-level data is raw, the plots may not align perfectly. It is recommended to document these differences for the end-user.

## Reference documentation

- [CNViz](./references/CNViz.md)