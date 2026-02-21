# CITE-seq data with CiteFuse and MuData

Danila Bredikhin1\* and Ilia Kats2\*\*

1European Molecular Biology Laboratory, Heidelberg, Germany
2German Cancer Research Center, Heidelberg, Germany

\*danila.bredikhin@embl.de
\*\*i.kats@dkfz-heidelberg.de

#### 2025-10-30

## 0.1 Introduction

CITE-seq data provide RNA and surface protein counts for the same cells.
This tutorial shows how MuData can be integrated into with Bioconductor
workflows to analyse CITE-seq data.

## 0.2 Installation

The most recent dev build can be installed from GitHub:

```
library(remotes)
remotes::install_github("ilia-kats/MuData")
```

Stable version of `MuData` will be available in future bioconductor versions.

## 0.3 Loading libraries

```
library(MuData)
library(SingleCellExperiment)
library(MultiAssayExperiment)
library(CiteFuse)
library(scater)

library(rhdf5)
```

## 0.4 Loading data

We will use CITE-seq data available within
[`CiteFuse` Bioconductor package](http://www.bioconductor.org/packages/release/bioc/html/CiteFuse.html).

```
data("CITEseq_example", package = "CiteFuse")
lapply(CITEseq_example, dim)
#> $RNA
#> [1] 19521   500
#>
#> $ADT
#> [1]  49 500
#>
#> $HTO
#> [1]   4 500
```

This dataset contains three matrices — one with `RNA` counts, one with
antibody-derived tags (`ADT`) counts and one with hashtag oligonucleotide
(`HTO`) counts.

## 0.5 Processing count matrices

While CITE-seq analysis workflows such as
[CiteFuse](http://www.bioconductor.org/packages/release/bioc/vignettes/CiteFuse/inst/doc/CiteFuse.html)
should be consulted for more details, below we exemplify simple data
transformations in order to demonstrate how their output can be saved to
an H5MU file later on.

Following the CiteFuse tutorial, we start with creating a `SingleCellExperiment`
object with the three matrices:

```
sce_citeseq <- preprocessing(CITEseq_example)
sce_citeseq
#> class: SingleCellExperiment
#> dim: 19521 500
#> metadata(0):
#> assays(1): counts
#> rownames(19521): hg19_AL627309.1 hg19_AL669831.5 ... hg19_MT-ND6
#>   hg19_MT-CYB
#> rowData names(0):
#> colnames(500): AAGCCGCGTTGTCTTT GATCGCGGTTATCGGT ... TTGGCAACACTAGTAC
#>   GCTGCGAGTTGTGGCC
#> colData names(0):
#> reducedDimNames(0):
#> mainExpName: NULL
#> altExpNames(2): ADT HTO
```

We will add a new assay with normalised RNA counts:

```
sce_citeseq <- scater::logNormCounts(sce_citeseq)
sce_citeseq  # new assay: logcounts
#> class: SingleCellExperiment
#> dim: 19521 500
#> metadata(0):
#> assays(2): counts logcounts
#> rownames(19521): hg19_AL627309.1 hg19_AL669831.5 ... hg19_MT-ND6
#>   hg19_MT-CYB
#> rowData names(0):
#> colnames(500): AAGCCGCGTTGTCTTT GATCGCGGTTATCGGT ... TTGGCAACACTAGTAC
#>   GCTGCGAGTTGTGGCC
#> colData names(1): sizeFactor
#> reducedDimNames(0):
#> mainExpName: NULL
#> altExpNames(2): ADT HTO
```

To the ADT modality, we will add an assay with normalised counts:

```
sce_citeseq <- CiteFuse::normaliseExprs(
  sce_citeseq, altExp_name = "ADT", transform = "log"
)
altExp(sce_citeseq, "ADT")  # new assay: logcounts
#> class: SummarizedExperiment
#> dim: 49 500
#> metadata(0):
#> assays(2): counts logcounts
#> rownames(49): B220 (CD45R) B7-H1 (PD-L1) ... TCRb TCRg
#> rowData names(0):
#> colnames(500): AAGCCGCGTTGTCTTT GATCGCGGTTATCGGT ... TTGGCAACACTAGTAC
#>   GCTGCGAGTTGTGGCC
#> colData names(0):
```

We will also generate reduced dimensions:

```
sce_citeseq <- scater::runPCA(
  sce_citeseq, exprs_values = "logcounts", ncomponents = 20
)
```

```
scater::plotReducedDim(sce_citeseq, dimred = "PCA",
                       by_exprs_values = "logcounts", colour_by = "CD27")
```

![](data:image/png;base64...)

## 0.6 Making a MultiAssayExperiment object

An appropriate structure for multimodal datasets is
[`MultiAssayExperiment`](https://bioconductor.org/packages/MultiAssayExperiment/).

We will make a respective MultiAssayExperiment object from `sce_citeseq`:

```
experiments <- list(
  ADT = altExp(sce_citeseq, "ADT"),
  HTO = altExp(sce_citeseq, "HTO")
)

# Drop other modalities from sce_citeseq
altExp(sce_citeseq) <- NULL
experiments[["RNA"]] <- sce_citeseq

mae <- MultiAssayExperiment(experiments)
```

## 0.7 Writing to H5MU

We can write the contents of the MultiAssayExperiment object into an H5MU file:

```
writeH5MU(mae, "citefuse_example.h5mu")
```

We can check that all the modalities were written to the file:

```
h5 <- rhdf5::H5Fopen("citefuse_example.h5mu")
h5ls(H5Gopen(h5, "mod"), recursive = FALSE)
#>   group name     otype dclass dim
#> 0     /  ADT H5I_GROUP
#> 1     /  HTO H5I_GROUP
#> 2     /  RNA H5I_GROUP
```

… both assays for ADT — raw counts are stored in `X` and normalised counts
are in the corresponding layer:

```
h5ls(H5Gopen(h5, "mod/ADT"), FALSE)
#>   group   name     otype dclass dim
#> 0     /      X H5I_GROUP
#> 1     / layers H5I_GROUP
#> 2     /    obs H5I_GROUP
#> 3     /    var H5I_GROUP
h5ls(H5Gopen(h5, "mod/ADT/layers"), FALSE)
#>   group      name       otype dclass      dim
#> 0     / logcounts H5I_DATASET  FLOAT 49 x 500
```

… as well as reduced dimensions (PCA):

```
h5ls(H5Gopen(h5, "mod/RNA/obsm"), FALSE)
#>   group name       otype dclass      dim
#> 0     /  PCA H5I_DATASET  FLOAT 20 x 500
# There is an alternative way to access groups:
# h5&'mod'&'RNA'&'obsm'
rhdf5::H5close()
```

## 0.8 References

* [Muon: multimodal omics analysis framework](https://www.biorxiv.org/content/10.1101/2021.06.01.445670) preprint
* [mudata](https://mudata.readthedocs.io/) (Python) documentation
* muon [documentation](https://muon.readthedocs.io/) and [web page](https://gtca.github.io/muon/)
* Kim HJ, Lin Y, Geddes TA, Yang P, Yang JYH (2020). “CiteFuse enables multi-modal analysis of CITE-seq data.” Bioinformatics, 36(14), 4137–4143. <https://doi.org/10.1093/bioinformatics/btaa282>.
* Ramos M, Schiffer L, Re A, Azhar R, Basunia A, Cabrera CR, Chan T, Chapman P, Davis S, Gomez-Cabrero D, Culhane AC, Haibe-Kains B, Hansen K, Kodali H, Louis MS, Mer AS, Reister M, Morgan M, Carey V, Waldron L (2017). “Software For The Integration Of Multi-Omics Experiments In Bioconductor.” Cancer Research, 77(21); e39-42.

## 0.9 Session Info

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
#>  [1] scater_1.38.0               ggplot2_4.0.0
#>  [3] scuttle_1.20.0              CiteFuse_1.22.0
#>  [5] MultiAssayExperiment_1.36.0 SingleCellExperiment_1.32.0
#>  [7] SummarizedExperiment_1.40.0 Biobase_2.70.0
#>  [9] GenomicRanges_1.62.0        Seqinfo_1.0.0
#> [11] IRanges_2.44.0              MatrixGenerics_1.22.0
#> [13] matrixStats_1.5.0           MuData_1.14.0
#> [15] rhdf5_2.54.0                S4Vectors_0.48.0
#> [17] BiocGenerics_0.56.0         generics_0.1.4
#> [19] Matrix_1.7-4                BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] gridExtra_2.3        rlang_1.1.6          magrittr_2.0.4
#>   [4] ggridges_0.5.7       compiler_4.5.1       vctrs_0.6.5
#>   [7] reshape2_1.4.4       stringr_1.5.2        pkgconfig_2.0.3
#>  [10] fastmap_1.2.0        magick_2.9.0         XVector_0.50.0
#>  [13] labeling_0.4.3       ggraph_2.2.2         rmarkdown_2.30
#>  [16] ggbeeswarm_0.7.2     tinytex_0.57         purrr_1.1.0
#>  [19] bluster_1.20.0       xfun_0.53            beachmat_2.26.0
#>  [22] randomForest_4.7-1.2 cachem_1.1.0         jsonlite_2.0.0
#>  [25] rhdf5filters_1.22.0  DelayedArray_0.36.0  BiocParallel_1.44.0
#>  [28] Rhdf5lib_1.32.0      tweenr_2.0.3         cluster_2.1.8.1
#>  [31] irlba_2.3.5.1        parallel_4.5.1       R6_2.6.1
#>  [34] bslib_0.9.0          stringi_1.8.7        RColorBrewer_1.1-3
#>  [37] limma_3.66.0         compositions_2.0-9   jquerylib_0.1.4
#>  [40] Rcpp_1.1.0           bookdown_0.45        knitr_1.50
#>  [43] mixtools_2.0.0.1     BiocBaseUtils_1.12.0 splines_4.5.1
#>  [46] igraph_2.2.1         tidyselect_1.2.1     dichromat_2.0-0.1
#>  [49] abind_1.4-8          yaml_2.3.10          viridis_0.6.5
#>  [52] codetools_0.2-20     lattice_0.22-7       tibble_3.3.0
#>  [55] plyr_1.8.9           withr_3.0.2          S7_0.2.0
#>  [58] evaluate_1.0.5       Rtsne_0.17           survival_3.8-3
#>  [61] bayesm_3.1-6         polyclip_1.10-7      kernlab_0.9-33
#>  [64] pillar_1.11.1        BiocManager_1.30.26  tensorA_0.36.2.1
#>  [67] plotly_4.11.0        dbscan_1.2.3         scales_1.4.0
#>  [70] glue_1.8.0           metapod_1.18.0       pheatmap_1.0.13
#>  [73] lazyeval_0.2.2       tools_4.5.1          BiocNeighbors_2.4.0
#>  [76] robustbase_0.99-6    data.table_1.17.8    ScaledMatrix_1.18.0
#>  [79] locfit_1.5-9.12      scran_1.38.0         graphlayouts_1.2.2
#>  [82] tidygraph_1.3.1      cowplot_1.2.0        grid_4.5.1
#>  [85] tidyr_1.3.1          edgeR_4.8.0          nlme_3.1-168
#>  [88] beeswarm_0.4.0       BiocSingular_1.26.0  ggforce_0.5.0
#>  [91] vipor_0.4.7          rsvd_1.0.5           cli_3.6.5
#>  [94] segmented_2.1-4      S4Arrays_1.10.0      viridisLite_0.4.2
#>  [97] dplyr_1.1.4          uwot_0.2.3           gtable_0.3.6
#> [100] DEoptimR_1.1-4       sass_0.4.10          digest_0.6.37
#> [103] dqrng_0.4.1          SparseArray_1.10.0   ggrepel_0.9.6
#> [106] htmlwidgets_1.6.4    farver_2.1.2         memoise_2.0.1
#> [109] htmltools_0.5.8.1    lifecycle_1.0.4      httr_1.4.7
#> [112] statmod_1.5.1        MASS_7.3-65
```