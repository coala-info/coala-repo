---
name: bioconductor-epicompare
description: EpiCompare is an R package for benchmarking and quality control of epigenomic peak datasets through automated comparison and HTML report generation. Use when user asks to compare epigenomic peak files, benchmark datasets against a gold standard, or perform functional annotation and quality control on ChIP-seq and CUT&Tag data.
homepage: https://bioconductor.org/packages/release/bioc/html/EpiCompare.html
---


# bioconductor-epicompare

## Overview
`EpiCompare` is an R package for benchmarking and quality control of epigenomic peak datasets. It automates the comparison of multiple samples (e.g., comparing CUT&Tag to a ChIP-seq "gold standard") and generates a unified HTML report covering general metrics, peak overlaps, and functional annotations.

## Core Workflow

### 1. Prepare Input Data
`EpiCompare` requires a named list of peak files. Inputs can be `GRanges` objects or paths to BED files.

```R
library(EpiCompare)

# Load example data or your own BED files
data("CnT_H3K27ac") 
data("CnR_H3K27ac")

# Create named list
peaklist <- list("CUTnTag" = CnT_H3K27ac, "CUTnRun" = CnR_H3K27ac)
```

### 2. Optional Reference and Metadata
To calculate overlap statistics against a "gold standard" or include fragment metrics:

*   **Reference**: A named list containing one `GRanges` object.
*   **Blacklist**: `GRanges` of problematic regions (built-in: `hg19_blacklist`, `hg38_blacklist`, `mm10_blacklist`).
*   **Picard Files**: Named list of data frames from Picard `MarkDuplicates` metrics.

```R
data("encode_H3K27ac")
reference_peak <- list("ENCODE" = encode_H3K27ac)

data("CnT_H3K27ac_picard")
picard_list <- list("CUTnTag" = CnT_H3K27ac_picard)
```

### 3. Run the Analysis
The main function `EpiCompare()` executes the pipeline. Toggle specific analyses using boolean flags.

```R
EpiCompare(peakfiles = peaklist,
           genome_build = "hg19",
           blacklist = hg19_blacklist,
           picard_files = picard_list,
           reference = reference_peak,
           # Analysis Toggles
           upset_plot = TRUE,         # Overlap intersections
           stat_plot = TRUE,          # Significance of overlaps
           chromHMM_plot = TRUE,      # Chromatin state annotation
           chromHMM_annotation = "K562",
           chipseeker_plot = TRUE,    # Genomic feature annotation
           enrichment_plot = TRUE,    # GO/KEGG pathway analysis
           tss_plot = TRUE,           # Enrichment around TSS
           precision_recall_plot = TRUE,
           # Output settings
           interact = TRUE,           # Interactive HTML plots
           output_filename = "My_Epi_Report",
           output_dir = "./results")
```

## Key Parameters & Options

*   **Genome Builds**: Supports "hg19", "hg38", "mm9", "mm10".
*   **ChromHMM Annotations**: Available cell lines include "K562", "Gm12878", "H1hesc", "Hepg2", "Hmec", "Hsmm", "Huvec", "Nhek", "Nhlf".
*   **Interactivity**: If `interact = TRUE`, heatmaps are generated as interactive HTML widgets.
*   **Output**: Generates an `.html` report and a folder containing individual plot files if `save_output = TRUE`.

## Tips for Success
*   **Naming**: Ensure the names in `peaklist` match the names in `picard_files` for correct sample mapping.
*   **TSS Plots**: Generating TSS plots for very large datasets or many samples can be computationally intensive; consider disabling if speed is a priority.
*   **BED Formats**: While `EpiCompare` supports BED files, it is often safer to import them first using `ChIPseeker::readPeakFile(..., as="GRanges")` to ensure compatibility.

## Reference documentation
- [EpiCompare: Getting started](./references/EpiCompare.md)
- [Docker/Singularity Containers](./references/docker.md)
- [Example report](./references/example_report.md)