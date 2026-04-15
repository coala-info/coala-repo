---
name: bioconductor-methrix
description: bioconductor-methrix provides a fast and memory-efficient framework for processing and analyzing large-scale DNA methylation data from WGBS or RRBS. Use when user asks to import bedgraph files, perform quality control reporting, filter CpG sites by coverage or SNPs, subset methylation matrices, or visualize methylation statistics.
homepage: https://bioconductor.org/packages/release/bioc/html/methrix.html
---

# bioconductor-methrix

name: bioconductor-methrix
description: Specialized for the methrix R package for fast processing and analysis of large-scale DNA methylation data (WGBS/RRBS). Use this skill when you need to import bedgraph files, perform quality control, filter CpG sites (by coverage or SNPs), subset methylation matrices, or visualize methylation statistics.

# bioconductor-methrix

## Overview
`methrix` is a Bioconductor package designed to handle large-scale DNA methylation data efficiently. It uses `data.table` for fast operations and supports HDF5-backed arrays for memory-efficient processing of whole-genome bisulfite sequencing (WGBS) data. The package provides a comprehensive workflow from importing raw bedgraph files to downstream analysis, including QC reporting, filtering, and visualization.

## Core Workflow

### 1. Data Import
The primary entry point is `read_bedgraphs`. It requires a reference CpG set, which can be generated using `extract_CPGs`.

```r
library(methrix)
library(BSgenome.Hsapiens.UCSC.hg19)

# 1. Extract reference CpGs
hg19_cpgs <- methrix::extract_CPGs(ref_genome = "BSgenome.Hsapiens.UCSC.hg19")

# 2. Read bedgraphs
# Use 'pipeline' argument for Bismark, MethylDackel, or MethylcTools
meth <- methrix::read_bedgraphs(
  files = c("sample1.bg.gz", "sample2.bg.gz"),
  ref_cpgs = hg19_cpgs,
  pipeline = "Bismark",
  coldata = sample_annotation_df
)
```

### 2. Quality Control and Reporting
Generate an interactive HTML report to assess the quality of the methylation data.

```r
methrix::methrix_report(meth = meth, output_dir = "QC_report")
```

### 3. Filtering Operations
Filtering is essential to remove noise and unreliable loci.

*   **Remove uncovered loci:** `methrix::remove_uncovered(m = meth)`
*   **Coverage-based filtering:** `methrix::coverage_filter(m = meth, cov_thr = 5, min_samples = 2)`
*   **SNP filtering:** `methrix::remove_snps(m = meth)` (requires SNP database like `MafDb.1Kgenomes.phase3.hs37d5`)

### 4. Subsetting and Data Access
`methrix` objects inherit from `SummarizedExperiment`. Subsetting is highly optimized.

*   **By Contig:** `subset_methrix(m, contigs = "chr21")`
*   **By Region:** `subset_methrix(m, regions = granges_object)`
*   **By Sample:** `subset_methrix(m, samples = c("S1", "S2"))`
*   **Extract Matrices:** Use `get_matrix(m, type = "M")` for methylation (Beta values) or `type = "C"` for coverage.

### 5. Visualization and Statistics
*   **Summary Stats:** `get_stats(m)` calculates mean/median methylation and coverage.
*   **PCA:** `methrix_pca(m)` followed by `plot_pca()`.
*   **Distribution Plots:** `plot_violin(m)` for methylation density and `plot_coverage(m)` for read depth.

### 6. Integration with Other Packages
Convert to `bsseq` objects for differential methylation calling using other Bioconductor tools.

```r
bs_object <- methrix::methrix2bsseq(m = meth)
```

## Tips for Large Datasets
*   **HDF5 Support:** When reading very large files, use `h5 = TRUE` in `read_bedgraphs` to store matrices on disk instead of in RAM.
*   **Parallelization:** Many functions support `n_threads` to speed up processing.
*   **Array Comparison:** Use `methrix2epic()` to subset WGBS data to sites present on Illumina 450k or EPIC arrays for cross-platform validation.

## Reference documentation
- [Methrix tutorial](./references/methrix.Rmd)
- [Methrix tutorial (Markdown)](./references/methrix.md)