---
name: bioconductor-oder
description: This tool identifies and optimizes unannotated expressed regions from RNA-seq coverage data by refining coverage cut-offs and region gaps. Use when user asks to define novel exons, optimize expressed region boundaries using gold-standard annotations, link regions to gene junctions, or generate count matrices for differential expression analysis.
homepage: https://bioconductor.org/packages/3.14/bioc/html/ODER.html
---

# bioconductor-oder

name: bioconductor-oder
description: Use when analyzing RNA-seq coverage data to identify and optimize unannotated expressed regions (ERs). This skill helps in defining novel exons, optimizing coverage cut-offs (MCC) and region gaps (MRG) based on gold-standard exons, annotating ERs with gene junctions, and generating count matrices for downstream differential expression analysis.

# bioconductor-oder

## Overview

ODER (Optimising the Definition of Expressed Regions) is an R package designed to identify and refine regions of unannotated expression from RNA-sequencing data. It builds upon the `derfinder` framework by optimizing two key parameters: the Mean Coverage Cut-off (MCC) and the Max Region Gap (MRG). By comparing identified regions against a set of "gold-standard" exons from reference annotations, ODER finds the most accurate boundaries for expressed regions (ERs). These ERs can then be linked to known genes via junction reads and refined to improve the interpretation of non-coding genetic variants and novel isoforms.

## Installation

Install ODER using `BiocManager`:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("eolagbaju/ODER")
```

## Core Workflow

The ODER pipeline typically follows a four-step sequential process:

1.  **Optimization (`ODER`)**: Define ERs by testing combinations of MCC and MRG against reference exons.
2.  **Annotation (`annotatERs`)**: Link optimized ERs to genes using junction data and categorize them (exon, intron, or intergenic).
3.  **Refinement (`refine_ERs`)**: Adjust ER start/end coordinates based on overlapping junction boundaries.
4.  **Quantification (`get_count_matrix`)**: Generate a count matrix of mean coverage across ERs for downstream analysis.

## Key Functions

### 1. Optimizing Expressed Regions
The `ODER()` function is the entry point. It requires BigWig files and a GTF annotation.

```r
opt_ers <- ODER(
    bw_paths = "path/to/sample.bw",
    auc_raw = total_auc_from_metadata,
    auc_target = 40e6 * 100, # Target library size normalization
    chrs = c("chr21"),
    genome = "hg38",
    mccs = c(2, 4, 6, 8, 10), # Mean coverage cut-offs to test
    mrgs = c(10, 20, 30),     # Max region gaps to test
    gtf = gtf_granges,
    ucsc_chr = TRUE
)
```

### 2. Visualizing Optimization
Use `plot_ers` to evaluate the "exon delta" (error) across the parameter grid.

```r
plot_ers(opt_ers[["deltas"]], opt_ers[["opt_mcc_mrg"]])
```

### 3. Annotating with Junctions
Link ERs to genes using a `RangedSummarizedExperiment` of junctions.

```r
annot_ers <- annotatERs(
    opt_ers = opt_ers[["opt_ers"]],
    junc_data = junction_rse,
    genom_state = genomic_state, # Created via derfinder::makeGenomicState
    gtf = gtf_granges,
    txdb = txdb_object
)
```

### 4. Refining ER Boundaries
Refine the starts and ends of ERs to match junction coordinates precisely.

```r
refined_ers <- refine_ERs(annot_ers)
```

### 5. Generating Count Matrices
Obtain mean coverage across regions. This requires `megadepth` to be installed.

```r
megadepth::install_megadepth()
er_counts <- get_count_matrix(
    bw_paths = bw_path,
    annot_ers = annot_ers,
    cols = sample_metadata_df
)
```

## Important Considerations

*   **Input Formats**: ODER expects coverage data in BigWig format.
*   **Strandedness**: The `bw_pos` and `bw_neg` arguments in `ODER()` should be used for stranded data. If data is unstranded, use `bw_paths` and set `ignore.strand = TRUE`.
*   **Junction Data**: For best results, junctions should be derived from the same samples or tissues used for the BigWig coverage files.
*   **Dependencies**: ODER relies heavily on `GenomicRanges`, `SummarizedExperiment`, and `derfinder`. Familiarity with these S4 classes is recommended.

## Reference documentation

- [ODER: Optimising the Definition of Expressed Regions](./references/ODER_overview.md)
- [ODER: Optimising the Definition of Expressed Regions (Source)](./references/ODER_overview.Rmd)