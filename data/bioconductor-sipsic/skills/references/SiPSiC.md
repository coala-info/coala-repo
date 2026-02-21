# SiPSiC - Infer Biological Pathway Activity from Single-Cell RNA-Seq Data

#### 30 October 2025

#### Abstract

Single Pathway analysis in Single Cells (SiPSiC) enables you to calculate a per-cell score for a biological pathway of your choice from single-cell RNA-seq (scRNA-seq) data. Its only function is the getPathwayScores function, which takes scRNA-seq data and an array containing the names of the genes comprising the relevant biological pathway, and calculates pathway scores for each cell in the data. Have the data in Transcripts-Per-Miilion (TPM) or Counts-Per-Million (CPM) units for best results.

#### Package

SiPSiC 1.10.0

# Contents

* [Introduction](#introduction)
* [Installation](#installation)
* [Code Example](#code-example)
* [SiPSiC’s Algorithm](#sipsics-algorithm)
  + [1. Pathway data extraction](#pathway-data-extraction)
  + [2. Score normalization](#score-normalization)
  + [3. Normalized gene rankings calculation](#normalized-gene-rankings-calculation)
  + [4. Gene weighing](#gene-weighing)
  + [5. Pathway scoring](#pathway-scoring)
* [Session Information](#session-information)

# Introduction

Single cell RNA sequencing is a prevelant practice to interrogate tissue characteristics and heterogeneity in health and disease. Finding which gene sets (pathways) are enriched in single cells allows to unravel
the different subpopulations of cells that exist in the interrogated tissue and elucidate their biological and functional underpinnings. Different methods have been developed for this purpose, the most prominent
of which is AUCell. However, some of these methods, including AUCell, use gene rankings to test for such enrichment and avoid using data of different cells when calculating pathway scores for a specific cell.
While AUCell and other methods produced insightful results in prior research, we found that some important findings might be missed by using them. We therefore developed SiPSiC to allow the dissection of tissue
heterogeneity and unravel the function and biological traits of cell subpopulations. By using gene counts and the transcriptome of different cells in the data when calculating pathway scores for an individual cell,
SiPSiC allows to unveil subpopulation characteristics which are sometimes missed by other methods, hence it has been deposited to Bioconductor.

# Installation

Install SiPSiC by executing the following commands in an R session:

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("SiPSiC")
```

# Code Example

```
library(SiPSiC)
geneCountsMatrix <- matrix(rpois(16, lambda = 10), ncol = 4, nrow = 4)
geneCountsMatrix <- as(geneCountsMatrix, "dgCMatrix")

## Make sure your matrix is indeed a sparse matrix (of type dgCMatrix)!

rownames(geneCountsMatrix) <- c("Gene1", "Gene2", "Gene3", "Gene4")
colnames(geneCountsMatrix) <- c("Cell1", "Cell2", "Cell3", "Cell4")
assayData <- SingleCellExperiment(assays = list(counts = geneCountsMatrix))
pathwayGenesList <- c("Gene1", "Gene2", "Gene4")
scoresAndIndices <- getPathwayScores(counts(assayData), pathwayGenesList) # The third parameter, percentForNormalization, is optional; If not specified, its value is set to 5.
pathwayScoresOfCells <- scoresAndIndices$pathwayScores
pathwayGeneIndices <- scoresAndIndices$index
```

# SiPSiC’s Algorithm

Taking an scRNA-seq data matrix and the list of genes of which the relevant pathway consists, SiPSiC uses five steps to calculate the score for all the cells in the data; These are:

## 1. Pathway data extraction

Pick only genes which belong to the pathway.

## 2. Score normalization

For each gene separately: If none of the cells transcribe the gene, keep the values as they are (all zeros); Otherwise, calculate the median of the X% top expressing cells (X is specified by the percentForNormalization parameter and is 5 by default), divide all values by this median and keep them. If the median is zero, however, the values are divided by the maximum value across all cells instead.
The reason behind this step is that scRNA-seq data are normally sparse, namely, the fraction of zeros in the data is large; Thus, by selecting the median of the top 5% cells there is a high likelihood that for most genes the value will be greater than zero, while on the other hand it will also not be an outlier, which may perturb further processing steps.

## 3. Normalized gene rankings calculation

Independently of step 2, rank the genes by their total counts (TPM or CPM) across all cells, then divide the ranks by the total number of genes; This normalization ensures that all the ranks remain within the range (0,1] regardless of the total number of genes.

## 4. Gene weighing

Multiply the results of each gene from step 2 by its normalized ranking from step 3.

## 5. Pathway scoring

Set each cell’s pathway score as the average of its values across all genes, as provided by step 4. Note that the higher the total number of counts for a gene is, the more it affects the pathway scores of all the cells in the data. We find this reasonable as the transcription of genes with higher total counts is likely to differ to a greater extent between cells, allowing us to reveal biological differences more accurately.

# Session Information

Following is the output of the ‘sessionInfo()’ function observed on the system on which the package was built:

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] SiPSiC_1.10.0               SingleCellExperiment_1.32.0
#>  [3] SummarizedExperiment_1.40.0 Biobase_2.70.0
#>  [5] GenomicRanges_1.62.0        Seqinfo_1.0.0
#>  [7] IRanges_2.44.0              S4Vectors_0.48.0
#>  [9] BiocGenerics_0.56.0         generics_0.1.4
#> [11] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [13] Matrix_1.7-4                BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] cli_3.6.5           knitr_1.50          rlang_1.1.6
#>  [4] xfun_0.53           DelayedArray_0.36.0 jsonlite_2.0.0
#>  [7] htmltools_0.5.8.1   sass_0.4.10         rmarkdown_2.30
#> [10] grid_4.5.1          abind_1.4-8         evaluate_1.0.5
#> [13] jquerylib_0.1.4     fastmap_1.2.0       yaml_2.3.10
#> [16] lifecycle_1.0.4     bookdown_0.45       BiocManager_1.30.26
#> [19] compiler_4.5.1      XVector_0.50.0      lattice_0.22-7
#> [22] digest_0.6.37       R6_2.6.1            SparseArray_1.10.0
#> [25] bslib_0.9.0         tools_4.5.1         S4Arrays_1.10.0
#> [28] cachem_1.1.0
```