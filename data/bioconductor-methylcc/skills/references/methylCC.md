# The methylCC user’s guide

Stephanie C. Hicks1 and Rafael A. Irizarry2

1Johns Hopkins Bloomberg School of Public Health
2Dana-Farber Cancer Institute

#### 25 November 2025

#### Abstract

A tool to estimate the cell composition of DNA
methylation whole blood sample measured on any
platform technology (microarray and sequencing).

#### Package

methylCC 1.24.1

# 1 Introduction

There are several approaches available to adjust for differents in the
relative proportion of cell types in whole blood measured from
DNA methylation (DNAm). For example, *reference-based approaches*
require the use of reference data sets made up of purified cell types to
identify cell type-specific DNAm signatures. These cell type-specific DNAm
signatures are used to estimate the relative proportions of cell types
directly, but these reference data sets are laborious and expensive to
collect. Furthermore, these reference data sets will need to be
continuously collected over time as new platform technologies emerge
measuring DNAm because the observed methylation levels for the same CpGs
in the same sample vary depending the platform technology.

In contrast, there are *reference-free approaches*,
which are based on methods related to surrogate variable analysis or
linear mixed models. These approaches do not provide
estimates of the relative proportions of cell types, but rather these
methods just remove the variability induced from the differences in
relative cell type proportions in whole blood samples.

Here, we present a statistical model that estimates the cell composition
of whole blood samples measured from DNAm. The method can be applied
to microarray or sequencing data (for example whole-genome bisulfite
sequencing data, WGBS, reduced representation bisulfite sequencing
data, RRBS). Our method is based on the
idea of identifying informative genomic regions that are clearly
methylated or unmethylated for each cell type, which permits
estimation in multiple platform technologies as cell types preserve
their methylation state in regions independent of platform despite
observed measurements being platform dependent.

# 2 Getting Started

Load the `methylCC` R package and other packages that we’ll need
later on.

```
library(FlowSorted.Blood.450k)
library(methylCC)
library(minfi)
library(tidyr)
library(dplyr)
library(ggplot2)
```

# 3 Data

## 3.1 Whole Blood Illumina 450k Microarray Data Example

```
# Phenotypic information about samples
head(pData(FlowSorted.Blood.450k))
```

```
## DataFrame with 6 rows and 8 columns
##          Sample_Name      Slide       Array               Basename    SampleID
##          <character>  <numeric> <character>            <character> <character>
## WB_105        WB_105 5684819001      R01C01 idat/5684819001_R01C01         105
## WB_218        WB_218 5684819001      R02C01 idat/5684819001_R02C01         218
## WB_261        WB_261 5684819001      R03C01 idat/5684819001_R03C01         261
## PBMC_105    PBMC_105 5684819001      R04C01 idat/5684819001_R04C01         105
## PBMC_218    PBMC_218 5684819001      R05C01 idat/5684819001_R05C01         218
## PBMC_261    PBMC_261 5684819001      R06C01 idat/5684819001_R06C01         261
##          CellTypeLong    CellType         Sex
##           <character> <character> <character>
## WB_105    Whole blood         WBC           M
## WB_218    Whole blood         WBC           M
## WB_261    Whole blood         WBC           M
## PBMC_105         PBMC        PBMC           M
## PBMC_218         PBMC        PBMC           M
## PBMC_261         PBMC        PBMC           M
```

```
# RGChannelSet
rgset <- FlowSorted.Blood.450k[,
                pData(FlowSorted.Blood.450k)$CellTypeLong %in% "Whole blood"]
```

# 4 Using the `estimatecc()` function

## 4.1 Input for `estimatecc()`

The `estimatecc()` function must have
one object as input:

1. an `object` such as an `RGChannelSet` from
   the R package `minfi` or a `BSseq` object
   from the R package `bsseq`. This object should
   contain observed DNAm levels at CpGs (rows)
   in a set of \(N\) whole blood samples (columns).

## 4.2 Running `estimatecc()`

In this example, we are interested in estimating the cell
composition of the whole blood samples listed in the
`FlowSorted.Blood.450k` R/Bioconductor package.
To run the `methylcC::estimatecc()` function,
just provide the `RGChannelSet`. This will
create an `estimatecc` object. We
will call the object `est`.

```
set.seed(12345)
est <- estimatecc(object = rgset)
est
```

```
## estimatecc: Estimate Cell Composition of Whole Blood
##                 Samples using DNA methylation
##    Input object class:  RGChannelSet
##    Reference cell types:  Gran CD4T CD8T Bcell Mono NK
##    Number of Whole Blood Samples:  6
##    Name of Whole Blood Samples:  WB_105 WB_218 WB_261 WB_043 WB_160 WB_149
```

To see the cell composition estimates, use the
`cell_counts()` function.

```
cell_counts(est)
```

```
##             Gran       CD4T       CD8T      Bcell       Mono         NK
## WB_105 0.4242292 0.16915420 0.09506568 0.04187765 0.08357502 0.18609822
## WB_218 0.4906710 0.15471447 0.00000000 0.04979116 0.14346117 0.16136217
## WB_261 0.5476117 0.11895815 0.14007846 0.01725995 0.08869797 0.08739378
## WB_043 0.5038143 0.12420228 0.08031593 0.06515287 0.07218653 0.15432807
## WB_160 0.6803254 0.07139726 0.04965732 0.00000000 0.09526148 0.10335854
## WB_149 0.5375962 0.14902349 0.10814235 0.03227085 0.06111685 0.11185025
```

## 4.3 Compare to `minfi::estimateCellCounts()`

We can also use the `estimateCellCounts()` from R/Bioconductor package
[`minfi`](http://bioconductor.org/packages/release/bioc/html/minfi.html)
to estimate the cell composition for each of the whole blood samples.

```
sampleNames(rgset) <- paste0("Sample", 1:6)

est_minfi <- minfi::estimateCellCounts(rgset)
est_minfi
```

```
##               CD8T      CD4T          NK      Bcell       Mono      Gran
## Sample1 0.13967126 0.1581874 0.137528672 0.07040633 0.06383445 0.4835306
## Sample2 0.05797617 0.1751543 0.072686689 0.09859270 0.12429750 0.5228217
## Sample3 0.12091718 0.1531062 0.029632651 0.05447982 0.06775822 0.6064806
## Sample4 0.10438514 0.1709784 0.024322195 0.11447040 0.05233508 0.5700027
## Sample5 0.03775465 0.1465998 0.003996696 0.04767462 0.07452444 0.7069746
## Sample6 0.06568804 0.1873355 0.054344189 0.07039282 0.05196750 0.5932074
```

Then, we can compare the estimates to `methylCC::estimatecc()`.

```
df_minfi = gather(cbind("samples" = rownames(cell_counts(est)),
                        as.data.frame(est_minfi)),
                  celltype, est, -samples)

df_methylCC = gather(cbind("samples" = rownames(cell_counts(est)),
                           cell_counts(est)),
                     celltype, est, -samples)

dfcombined <- full_join(df_minfi, df_methylCC,
                               by = c("samples", "celltype"))

ggplot(dfcombined, aes(x=est.x, y = est.y, color = celltype)) +
    geom_point() + xlim(0,1) + ylim(0,1) +
    geom_abline(intercept = 0, slope = 1) +
    xlab("Using minfi::estimateCellCounts()") +
    ylab("Using methylCC::estimatecc()") +
    labs(title = "Comparing cell composition estimates")
```

![](data:image/png;base64...)

We see the estimates closely match for the six cell types.

# 5 SessionInfo

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] parallel  stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] IlluminaHumanMethylation450kanno.ilmn12.hg19_0.6.1
##  [2] IlluminaHumanMethylation450kmanifest_0.4.0
##  [3] ggplot2_4.0.1
##  [4] dplyr_1.1.4
##  [5] tidyr_1.3.1
##  [6] methylCC_1.24.1
##  [7] FlowSorted.Blood.450k_1.48.0
##  [8] minfi_1.56.0
##  [9] bumphunter_1.52.0
## [10] locfit_1.5-9.12
## [11] iterators_1.0.14
## [12] foreach_1.5.2
## [13] Biostrings_2.78.0
## [14] XVector_0.50.0
## [15] SummarizedExperiment_1.40.0
## [16] Biobase_2.70.0
## [17] MatrixGenerics_1.22.0
## [18] matrixStats_1.5.0
## [19] GenomicRanges_1.62.0
## [20] Seqinfo_1.0.0
## [21] IRanges_2.44.0
## [22] S4Vectors_0.48.0
## [23] BiocGenerics_0.56.0
## [24] generics_0.1.4
## [25] knitr_1.50
## [26] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3        jsonlite_2.0.0
##   [3] magrittr_2.0.4            magick_2.9.0
##   [5] GenomicFeatures_1.62.0    farver_2.1.2
##   [7] rmarkdown_2.30            BiocIO_1.20.0
##   [9] vctrs_0.6.5               multtest_2.66.0
##  [11] memoise_2.0.1             Rsamtools_2.26.0
##  [13] DelayedMatrixStats_1.32.0 RCurl_1.98-1.17
##  [15] askpass_1.2.1             tinytex_0.58
##  [17] htmltools_0.5.8.1         S4Arrays_1.10.0
##  [19] curl_7.0.0                Rhdf5lib_1.32.0
##  [21] SparseArray_1.10.3        rhdf5_2.54.0
##  [23] sass_0.4.10               nor1mix_1.3-3
##  [25] bslib_0.9.0               bsseq_1.46.0
##  [27] plyr_1.8.9                cachem_1.1.0
##  [29] GenomicAlignments_1.46.0  lifecycle_1.0.4
##  [31] pkgconfig_2.0.3           Matrix_1.7-4
##  [33] R6_2.6.1                  fastmap_1.2.0
##  [35] digest_0.6.39             siggenes_1.84.0
##  [37] reshape_0.8.10            AnnotationDbi_1.72.0
##  [39] RSQLite_2.4.4             base64_2.0.2
##  [41] beachmat_2.26.0           labeling_0.4.3
##  [43] httr_1.4.7                abind_1.4-8
##  [45] compiler_4.5.2            beanplot_1.3.1
##  [47] rngtools_1.5.2            withr_3.0.2
##  [49] bit64_4.6.0-1             S7_0.2.1
##  [51] BiocParallel_1.44.0       DBI_1.2.3
##  [53] R.utils_2.13.0            HDF5Array_1.38.0
##  [55] MASS_7.3-65               openssl_2.3.4
##  [57] DelayedArray_0.36.0       rjson_0.2.23
##  [59] permute_0.9-8             gtools_3.9.5
##  [61] tools_4.5.2               rentrez_1.2.4
##  [63] R.oo_1.27.1               glue_1.8.0
##  [65] quadprog_1.5-8            h5mread_1.2.1
##  [67] restfulr_0.0.16           nlme_3.1-168
##  [69] rhdf5filters_1.22.0       grid_4.5.2
##  [71] gtable_0.3.6              BSgenome_1.78.0
##  [73] tzdb_0.5.0                R.methodsS3_1.8.2
##  [75] preprocessCore_1.72.0     data.table_1.17.8
##  [77] hms_1.1.4                 xml2_1.5.0
##  [79] pillar_1.11.1             limma_3.66.0
##  [81] genefilter_1.92.0         splines_4.5.2
##  [83] lattice_0.22-7            survival_3.8-3
##  [85] rtracklayer_1.70.0        bit_4.6.0
##  [87] GEOquery_2.78.0           annotate_1.88.0
##  [89] tidyselect_1.2.1          bookdown_0.45
##  [91] xfun_0.54                 scrime_1.3.5
##  [93] statmod_1.5.1             yaml_2.3.10
##  [95] evaluate_1.0.5            codetools_0.2-20
##  [97] cigarillo_1.0.0           tibble_3.3.0
##  [99] BiocManager_1.30.27       cli_3.6.5
## [101] xtable_1.8-4              jquerylib_0.1.4
## [103] dichromat_2.0-0.1         Rcpp_1.1.0
## [105] png_0.1-8                 XML_3.99-0.20
## [107] readr_2.1.6               blob_1.2.4
## [109] mclust_6.1.2              doRNG_1.8.6.2
## [111] sparseMatrixStats_1.22.0  bitops_1.0-9
## [113] scales_1.4.0              illuminaio_0.52.0
## [115] purrr_1.2.0               crayon_1.5.3
## [117] rlang_1.1.6               KEGGREST_1.50.0
```