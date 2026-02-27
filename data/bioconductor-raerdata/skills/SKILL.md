---
name: bioconductor-raerdata
description: This package provides curated RNA editing atlases and preprocessed sequencing datasets for human and mouse genomes. Use when user asks to access REDIportal editing sites, retrieve RNA editing datasets for human or mouse, or load example BAM files for RNA editing analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/raerdata.html
---


# bioconductor-raerdata

## Overview

The `raerdata` package provides curated datasets and databases specifically designed for characterizing RNA editing. It serves as a companion to the `raer` package, offering high-quality atlases of known A-to-I editing sites and preprocessed sequencing data (WGS, RNA-seq, and scRNA-seq) for human and mouse genomes.

## Installation

Install the package using `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("raerdata")
library(raerdata)
```

## Accessing RNA Editing Atlases

The package provides `GRanges` objects containing known editing sites.

### REDIportal Sites
REDIportal contains millions of identified A-to-I sites.
*   **Human (hg38):** `rediportal_coords_hg38()`
*   **Mouse (mm10):** `rediportal_coords_mm10()`

### CDS Recoding Sites
These are specific sites within coding sequences that result in amino acid substitutions.
*   **Human (hg38):** `gabay_sites_hg38()`
*   **Mouse (mm10):** `gabay_sites_mm10()` (lifted over from human)

## Example Datasets

These functions return lists containing paths to BAM files, FASTA references, and associated metadata.

### 1. NA12878 Cell Line (WGS & RNA-seq)
Useful for comparing genomic SNPs vs. RNA variants on chromosome 4.
```r
data_na12878 <- NA12878()
# Access components: data_na12878$bams, data_na12878$fasta, data_na12878$snps
```

### 2. ADAR1 Knockout (GSE99249)
RNA-seq data from HEK293 cells (WT vs ADAR1KO) treated with Interferon beta, focused on chromosome 18.
```r
data_adar <- GSE99249()
# Access components: data_adar$bams, data_adar$fasta, data_adar$sites
```

### 3. Single-Cell RNA-seq (10x PBMC)
Includes a `SingleCellExperiment` object and BAM file for chromosome 16.
```r
data_pbmc <- pbmc_10x()
# Access components: data_pbmc$bam, data_pbmc$sites, data_pbmc$sce
```

## Direct ExperimentHub Access

If you need to browse or download specific files individually:

```r
library(ExperimentHub)
eh <- ExperimentHub()
raer_query <- query(eh, "raerdata")
# View available resources
mcols(raer_query)[, c("ah_id", "title")]
```

## Workflow Tips

*   **Memory Management:** The REDIportal objects are large (millions of ranges). Use standard `GenomicRanges` subsetting to focus on specific regions of interest.
*   **Integration with raer:** These datasets are intended to be passed into `raer` functions for site discovery and quantification.
*   **Genome Versions:** Ensure your analysis uses `hg38` for human data and `mm10` for mouse data to match the coordinates provided in this package.

## Reference documentation

- [raerdata: datasets and databases for use with the raer package](./references/raerdata.md)