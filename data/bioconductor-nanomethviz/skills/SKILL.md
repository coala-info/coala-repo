---
name: bioconductor-nanomethviz
description: NanoMethViz is an R package for the visualization and analysis of DNA methylation data from long-read sequencing. Use when user asks to visualize per-read methylation patterns, plot methylation levels for specific genes or genomic regions, or convert long-read methylation calls into formats for differential analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/NanoMethViz.html
---


# bioconductor-nanomethviz

## Overview
`NanoMethViz` is an R package designed for the visualization and analysis of DNA methylation data derived from long-read sequencing (Oxford Nanopore Technologies). It specializes in handling per-read methylation calls, allowing for high-resolution plots that show both population-level averages and individual read patterns (heatmaps). It supports various upstream callers including dorado (modBAM), modkit, Megalodon, Nanopolish, and f5c.

## Installation
```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("NanoMethViz")
library(NanoMethViz)
```

## Data Import and Preparation

### 1. Working with modBAM (Dorado/Modkit)
Modern ONT pipelines produce BAM files with `Mm` and `Ml` tags. These can be used directly.
```r
# Define BAM files and sample names
bam_files <- ModBamFiles(
    samples = c("sample1", "sample2"),
    paths = c("path/to/s1.bam", "path/to/s2.bam")
)

# Create the result object
mbr <- ModBamResult(
    methy = bam_files,
    samples = data.frame(sample = c("sample1", "sample2"), group = c("A", "B")),
    exons = get_exons_mm10() # or get_exons_hg19()
)
```

### 2. Converting Tabular Data to Tabix
For Nanopolish, Megalodon, or modkit TSV exports, data must be converted to a sorted, bgzipped tabix format for efficient access.
```r
# Convert raw caller output to NanoMethViz tabix format
create_tabix_file(
    input_files = c("sample1_calls.tsv.gz", "sample2_calls.tsv.gz"),
    output_file = "methy_data.bgz",
    samples = c("sample1", "sample2")
)
```

### 3. Constructing NanoMethResult
The core object requires methylation data (tabix), sample metadata, and exon annotations.
```r
# 1. Methylation data path
methy <- "methy_data.bgz"

# 2. Sample annotation (must match 'sample' column in data)
sample_anno <- data.frame(
    sample = c("sample1", "sample2"),
    group = c("Control", "Treatment")
)

# 3. Exon annotation (tibble with gene_id, chr, strand, start, end, transcript_id, symbol)
exon_tibble <- get_exons_mm10()

nmr <- NanoMethResult(methy, sample_anno, exon_tibble)
```

## Visualization

### Gene and Region Plotting
Plots include a smoothed average methylation line and an optional read-level heatmap.
```r
# Plot by gene symbol
plot_gene(nmr, "Peg3", heatmap = TRUE)

# Plot a specific genomic region
plot_region(nmr, chr = "chr11", start = 101463573, end = 101470000)

# Highlight specific regions (e.g., DMRs)
plot_gene(nmr, "Peg3", anno_regions = my_dmr_dataframe)
```

### Customizing Plots
- `spaghetti = TRUE`: Show individual read lines instead of a heatmap.
- `compare = FALSE`: Plot samples individually rather than grouped.
- `span`: Adjust smoothing (smaller values = more detail).

## Downstream Analysis

### Exporting to Other Packages
Convert `NanoMethResult` to formats used by differential methylation tools.
```r
# To bsseq (for DSS or general smoothing)
bss <- methy_to_bsseq(nmr)

# To edgeR (for site-level or region-level differential analysis)
gene_regions <- exons_to_genes(NanoMethViz::exons(nmr))
edger_mat <- bsseq_to_edger(bss, gene_regions)
```

### Dimensionality Reduction
Visualize sample similarities using Log-Methylation Ratios (LMR).
```r
# 1. Create LMR matrix (aggregated by gene)
gene_anno <- exons_to_genes(NanoMethViz::exons(nmr))
lmr <- bsseq_to_log_methy_ratio(bss, regions = gene_anno)

# 2. Plot
plot_mds(lmr, groups = sample_anno$group)
plot_pca(lmr, groups = sample_anno$group)
```

## Package Options
- **Site Filtering**: Remove low-coverage sites to reduce noise (default is 3).
  `options("NanoMethViz.site_filter" = 5)`
- **Highlight Color**: Change the color of `anno_regions`.
  `options("NanoMethViz.highlight_col" = "red")`

## Reference documentation
- [UsersGuide](./references/UsersGuide.md)