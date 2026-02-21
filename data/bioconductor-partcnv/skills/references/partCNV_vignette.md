# Identify locally aneuploid cells from scRNA-seq using partCNV

Ziyi Li1\* and Ruoxing Li2

1Department of Biostatistics, the University of Texas MD Anderson Cancer Center
2Department of Biostatistics, the University of Texas Health Science Center

\*zli16@mdanderson.org

#### 30 October 2025

#### Abstract

This package uses a statistical framework for rapid and accurate detection of aneuploid cells with local copy number deletion or amplification. Our method uses an EM algorithm with mixtures of Poisson distributions while incorporating cytogenetics information (e.g., regional deletion or amplification) to guide the classification (partCNV). When applicable, we further improve the accuracy by integrating a Hidden Markov Model for feature selection (partCNVH).

#### Package

partCNV 1.8.0

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Understand your cytogenetics data](#understand-your-cytogenetics-data)
* [4 Load example data](#load-example-data)
* [5 Run partCNV](#run-partcnv)
* [6 Run partCNVH](#run-partcnvh)
* [Session info](#session-info)

# 1 Introduction

Single-cell RNA sequencing is becoming an increasingly common tool to investigate the cellular population and patients’ outcome in cancer research. However, due to the sparse data and the complex tumor microenvironment, it is challenging to identify neoplastic cells that play important roles in tumor growth and disease progression. This challenge is exaggerated in the research of blood cancer patients, from whom the neoplastic cells can be highly similar to the normal cells.

In this package we present partCNV/partCNVH, a statistical framework for rapid and accurate detection of aneuploid cells with local copy number deletion or amplification. Our method uses an EM algorithm with mixtures of Poisson distributions while incorporating **cytogenetics information** to guide the classification (partCNV). When applicable, we further improve the accuracy by integrating a Hidden Markov Model for feature selection (partCNVH).

# 2 Installation

The package can be installed using `BiocManager` by the following commands

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("partCNV")
```

Alternatively, the package can be installed using `devtools` and launched by

```
library(devtools)
install_github("rx-li/partCNV")
```

# 3 Understand your cytogenetics data

First of all, our method can only be used to infer cell status if the patient has a part of the cells with cytogenetics alterations. For example, if a patient has cytogenetics data as `46,XY,del(20)(q11.1q13.1)[5]/46,XY[15]`, it means that out of 20 metaphases, 5 (i.e., 25%) of the cells has deletion on chromosome 20 in region q11.1 to q13.1. If the patient has a normal cytogenetics, e.g., 46,XY[20], or all altered cells, e.g., 46,XY,del(20)(q11.1q13.1)[25], there won’t be any need to apply the proposed method.

Second, when you have a complicated cytogenetics feature, use them one by one to identify the desired cell group. For example, `47,XY,+8[5]/46,idem,del(8)(q21.2q24.3)/46,XY[7]`, we start with the chromosome amplification on chromosome 8 excluding the region (q21.2q24.3) to identify the cells with this alteration using the proposed method. After the cells with chromosome 8 amplification are identified, we apply the proposed method to identify cells with del(8)(q21.2q24.3).

Lastly, our tool is primarily designed for analyzing the scRNA-seq data from patients with hematologic malignancies, such as MDS and AML. For solid tumors such as lung cancer and breast cancer, it is better to use CNV based method such as [copyKAT](https://github.com/navinlabcode/copykat) and inferCNV *[inferCNV](https://bioconductor.org/packages/3.22/inferCNV)*.

# 4 Load example data

The analysis can start from whole-genome scRNA-seq data or a subset of scRNA-seq data based on the location of interest. In this package, we prepared a whole-genome scRNA-seq data:

```
library(partCNV)
data(SimData)
dim(SimData)
```

```
## [1] 24519   400
```

```
SimData[1:5,1:5]
```

```
## 5 x 5 sparse Matrix of class "dgCMatrix"
##            C1 C2 C3 C4 C5
## AL627309.1  .  .  .  .  .
## AL627309.5  .  .  .  .  .
## AL627309.4  .  .  .  .  .
## AP006222.2  .  .  .  .  .
## LINC01409   .  .  .  .  .
```

This simple example dataset contains 24519 genes and 400 cells. If you start with Seurat object (after quality control), run:

```
library(Seurat)
Seurat_obj <- NormalizeData(Your_SeuratObj, normalization.method = "LogNormalize", scale.factor = 10000)
Counts = Seurat_obj@assays$RNA@counts
```

If you start with a SingleCellExperiment object, the counts can be normalized using function `NormalizeCounts`.

```
Counts <- NormalizeCounts(Your_SingleCellExperimentObj, scale_factor=10000)
```

# 5 Run partCNV

Since this is simulation data, prior knowledge (e.g., cytogenetics data in real studies) shows that this example data has 40% of cells with deletion on chromosome 20 q11.1 to q13.1. Let’s get started with locating this region.

```
res <- GetCytoLocation(cyto_feature = "chr20(q11.1-q13.1)")
```

```
## loading from cache
```

```
## require("GenomicRanges")
```

```
## Interested region: chr20:28100001-51200000.
```

```
## A total of 381 genes are located in this region.
```

Then let’s subset the data and normalize the data:

```
GEout <- GetExprCountCyto(cytoloc_output = res, Counts = as.matrix(SimData), normalization = TRUE, qt_cutoff = 0.99)
```

For this function, the qt\_cutoff is to filter out the cells with very low expressions. 0.99 here means that we filter out cells that only express in 1% (1-0.99) cells. Make this `qt_cutoff` larger if your total gene number within the region is small.

Now we apply partCNV:

```
pcout <- partCNV(int_counts = GEout$ProcessedCount,
                 cyto_type = "del",
                 cyto_p = 0.40)
```

Understand the results:

```
table(pcout)
```

```
## pcout
##   0   1
## 242 158
```

```
sum(pcout==1)/length(pcout)
```

```
## [1] 0.395
```

```
p1 <- sum(pcout==1)/length(pcout)
```

39.5% of cells are labeled as locally aneuploid (1) and others are diploid (0).

Let’s visualize it:

```
library(Seurat)
sim_seurat <- CreateSeuratObject(counts = SimData)
sim_seurat <- NormalizeData(sim_seurat, normalization.method = "LogNormalize", scale.factor = 10000)
sim_seurat <- FindVariableFeatures(sim_seurat, selection.method = "vst", nfeatures = 2000)
all.genes <- rownames(sim_seurat)
sim_seurat <- ScaleData(sim_seurat, features = all.genes)
sim_seurat <- RunPCA(sim_seurat, features = VariableFeatures(object = sim_seurat))
sim_seurat <- RunUMAP(sim_seurat, dims = 1:10)
sim_seurat <- AddMetaData(
    object = sim_seurat,
    metadata = pcout,
    col.name = "partCNV_label"
)
sim_seurat$partCNV_label <- factor(sim_seurat$partCNV_label, levels = c(1,0), labels = c(
    "aneuploid", "diploid"
))
```

```
library(ggplot2)
DimPlot(sim_seurat, reduction = "umap", group = "partCNV_label") + ggtitle(paste0("partCNV (", signif(p1,2)*100, "%)"))
```

![](data:image/png;base64...)

# 6 Run partCNVH

Compared with partCNV, partCNVH added an additional step of feature selection. This is especially helpful if your cytogenetics provide a very broad region and part of it does not have chromosomal alterations. The first two steps of using partCNVH are exactly the same as using partCNV.

```
res <- GetCytoLocation(cyto_feature = "chr20(q11.1-q13.1)")
```

```
## loading from cache
```

```
## Interested region: chr20:28100001-51200000.
```

```
## A total of 381 genes are located in this region.
```

```
GEout <- GetExprCountCyto(cytoloc_output = res, Counts = as.matrix(SimData), normalization = TRUE, qt_cutoff = 0.99)
```

For this function, the qt\_cutoff is to filter out the cells with very low expressions. 0.99 here means that we filter out cells that only express in 1% (1-0.99) cells. Make this `qt_cutoff` larger if your total gene number within the region is small.

Now we apply partCNVH:

```
pcHout <- partCNVH(int_counts = GEout$ProcessedCount,
                 cyto_type = "del",
                 cyto_p = 0.40)
```

Understand the results (in pcHout, EMlabel is the partCNV label and EMHMMlabel is the partCNVH label).

```
table(pcHout$EMHMMlabel)
```

```
##
##   0   1
## 235 165
```

```
sum(pcHout$EMHMMlabel==1)/length(pcHout$EMHMMlabel)
```

```
## [1] 0.4125
```

```
p2 <- sum(pcHout$EMHMMlabel==1)/length(pcHout$EMHMMlabel)
```

41.25% of cells are labeled as locally aneuploid (1) and others are diploid (0).

Let’s visualize it:

```
# I commented these steps because they are exactly the same as partCNV run.
# library(Seurat)
# sim_seurat <- CreateSeuratObject(counts = SimData)
# sim_seurat <- NormalizeData(sim_seurat, normalization.method = "LogNormalize", scale.factor = 10000)
# sim_seurat <- FindVariableFeatures(sim_seurat, selection.method = "vst", nfeatures = 2000)
# all.genes <- rownames(sim_seurat)
# sim_seurat <- ScaleData(sim_seurat, features = all.genes)
# sim_seurat <- RunPCA(sim_seurat, features = VariableFeatures(object = sim_seurat))
# sim_seurat <- RunUMAP(sim_seurat, dims = 1:10)
sim_seurat <- AddMetaData(
    object = sim_seurat,
    metadata = pcHout$EMHMMlabel,
    col.name = "partCNVH_label"
)
sim_seurat$partCNVH_label <- factor(sim_seurat$partCNVH_label, levels = c(1,0), labels = c(
    "aneuploid", "diploid"
))
```

```
library(ggplot2)
DimPlot(sim_seurat, reduction = "umap", group = "partCNVH_label") + ggtitle(paste0("partCNVH (", signif(p2,2)*100, "%)"))
```

![](data:image/png;base64...)

# Session info

```
## R version 4.5.1 Patched (2025-08-23 r88802)
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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] ggplot2_4.0.0        Seurat_5.3.1         SeuratObject_5.2.0
##  [4] sp_2.2-0             future_1.67.0        GenomicRanges_1.62.0
##  [7] Seqinfo_1.0.0        IRanges_2.44.0       S4Vectors_0.48.0
## [10] BiocGenerics_0.56.0  generics_0.1.4       partCNV_1.8.0
## [13] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RcppAnnoy_0.0.22            splines_4.5.1
##   [3] later_1.4.4                 filelock_1.0.3
##   [5] tibble_3.3.0                polyclip_1.10-7
##   [7] fastDummies_1.7.5           lifecycle_1.0.4
##   [9] httr2_1.2.1                 globals_0.18.0
##  [11] Rsolnp_2.0.1                lattice_0.22-7
##  [13] MASS_7.3-65                 magrittr_2.0.4
##  [15] plotly_4.11.0               sass_0.4.10
##  [17] rmarkdown_2.30              jquerylib_0.1.4
##  [19] yaml_2.3.10                 httpuv_1.6.16
##  [21] otel_0.2.0                  sctransform_0.4.2
##  [23] spam_2.11-1                 spatstat.sparse_3.1-0
##  [25] reticulate_1.44.0           cowplot_1.2.0
##  [27] pbapply_1.7-4               DBI_1.2.3
##  [29] RColorBrewer_1.1-3          abind_1.4-8
##  [31] Rtsne_0.17                  purrr_1.1.0
##  [33] nnet_7.3-20                 rappdirs_0.3.3
##  [35] ggrepel_0.9.6               irlba_2.3.5.1
##  [37] listenv_0.9.1               spatstat.utils_3.2-0
##  [39] goftest_1.2-3               RSpectra_0.16-2
##  [41] spatstat.random_3.4-2       fitdistrplus_1.2-4
##  [43] parallelly_1.45.1           codetools_0.2-20
##  [45] DelayedArray_0.36.0         tidyselect_1.2.1
##  [47] farver_2.1.2                matrixStats_1.5.0
##  [49] BiocFileCache_3.0.0         spatstat.explore_3.5-3
##  [51] jsonlite_2.0.0              progressr_0.17.0
##  [53] ggridges_0.5.7              survival_3.8-3
##  [55] tools_4.5.1                 ica_1.0-3
##  [57] Rcpp_1.1.0                  glue_1.8.0
##  [59] gridExtra_2.3               SparseArray_1.10.0
##  [61] xfun_0.53                   MatrixGenerics_1.22.0
##  [63] dplyr_1.1.4                 withr_3.0.2
##  [65] numDeriv_2016.8-1.1         BiocManager_1.30.26
##  [67] fastmap_1.2.0               digest_0.6.37
##  [69] truncnorm_1.0-9             R6_2.6.1
##  [71] mime_0.13                   scattermore_1.2
##  [73] tensor_1.5.1                dichromat_2.0-0.1
##  [75] spatstat.data_3.1-9         RSQLite_2.4.3
##  [77] tidyr_1.3.1                 data.table_1.17.8
##  [79] httr_1.4.7                  htmlwidgets_1.6.4
##  [81] S4Arrays_1.10.0             uwot_0.2.3
##  [83] pkgconfig_2.0.3             gtable_0.3.6
##  [85] blob_1.2.4                  lmtest_0.9-40
##  [87] S7_0.2.0                    SingleCellExperiment_1.32.0
##  [89] XVector_0.50.0              htmltools_0.5.8.1
##  [91] dotCall64_1.2               bookdown_0.45
##  [93] scales_1.4.0                Biobase_2.70.0
##  [95] png_0.1-8                   spatstat.univar_3.1-4
##  [97] knitr_1.50                  reshape2_1.4.4
##  [99] nlme_3.1-168                curl_7.0.0
## [101] cachem_1.1.0                zoo_1.8-14
## [103] stringr_1.5.2               BiocVersion_3.22.0
## [105] KernSmooth_2.23-26          parallel_4.5.1
## [107] miniUI_0.1.2                AnnotationDbi_1.72.0
## [109] pillar_1.11.1               grid_4.5.1
## [111] vctrs_0.6.5                 RANN_2.6.2
## [113] promises_1.4.0              dbplyr_2.5.1
## [115] xtable_1.8-4                cluster_2.1.8.1
## [117] evaluate_1.0.5              magick_2.9.0
## [119] tinytex_0.57                cli_3.6.5
## [121] compiler_4.5.1              rlang_1.1.6
## [123] crayon_1.5.3                future.apply_1.20.0
## [125] labeling_0.4.3              plyr_1.8.9
## [127] stringi_1.8.7               viridisLite_0.4.2
## [129] deldir_2.0-4                Biostrings_2.78.0
## [131] lazyeval_0.2.2              spatstat.geom_3.6-0
## [133] Matrix_1.7-4                RcppHNSW_0.6.0
## [135] patchwork_1.3.2             depmixS4_1.5-1
## [137] bit64_4.6.0-1               KEGGREST_1.50.0
## [139] shiny_1.11.1                SummarizedExperiment_1.40.0
## [141] AnnotationHub_4.0.0         ROCR_1.0-11
## [143] igraph_2.2.1                memoise_2.0.1
## [145] bslib_0.9.0                 bit_4.6.0
```