# scDotPlot

Ben Laufer

#### 30 October 2025

#### Package

scDotPlot 1.4.0

# 1 Introduction

Dot plots of single-cell RNA-seq data allow for an examination of the relationships between cell groupings (e.g. clusters) and marker gene expression. The scDotPlot package offers a unified approach to perform a hierarchical clustering analysis and add annotations to the columns and/or rows of a scRNA-seq dot plot. It works with SingleCellExperiment and Seurat objects as well as data frames. The `scDotPlot()` function uses data from `scater::plotDots()` or `Seurat::DotPlot()` along with the `aplot` package to add dendrograms from `ggtree` and optional annotations.

# 2 Installation

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}

BiocManager::install("scDotPlot")
```

To install the development version directly from GitHub:

```
if (!requireNamespace("remotes", quietly = TRUE)) {
    install.packages("remotes")
}

remotes::install_github("ben-laufer/scDotPlot")
```

# 3 SingleCellExperiment

## 3.1 Prepare object

First, we normalize the object and then, for the purpose of this example, subset to remove cells without cell-type labels.

```
library(scRNAseq)
library(scuttle)

sce <- ZeiselBrainData()

sce <- sce |>
    logNormCounts() |>
    subset(x = _, , level2class != "(none)")
```

## 3.2 Get features

The features argument accepts a character vector with the gene IDs. For this example, we quickly obtain the top markers of for each cell type and then add them to the rowData of the object.

```
library(scran)
library(purrr)
library(dplyr)
library(AnnotationDbi)

features <- sce |>
    scoreMarkers(sce$level1class) |>
    map(~ .x |>
            as.data.frame() |>
            arrange(desc(mean.AUC))|>
            dplyr::slice(1:6) |>
            rownames()) |>
    unlist2()

rowData(sce)$Marker <- features[match(rownames(sce), features)] |>
    names()
```

## 3.3 Plot logcounts

Finally, we create the plot. The `group` arguments utilize the colData, while the `features` arguments use the rowData. The `paletteList` argument can be used to manually specify the colors for the annotations specified through `groupAnno` and `featureAnno`. The clustering of the columns shows that cell the cell sub-types cluster by cell-type, while the clustering of the rows shows that most of the markers clusters by their cell type.

```
library(scDotPlot)
library(ggsci)

sce |>
    scDotPlot(features = features,
              group = "level2class",
              groupAnno = "level1class",
              featureAnno = "Marker",
              groupLegends = FALSE,
              annoColors = list("level1class" = pal_d3()(7),
                                "Marker" = pal_d3()(7)),
              annoWidth = 0.02)
```

![scDotPlot of SingleCellExperiment logcounts](data:image/png;base64...)

Figure 1: scDotPlot of SingleCellExperiment logcounts

## 3.4 Plot Z-scores

Plotting by Z-score through `scale = TRUE` improves the clustering result for the rows.

```
sce |>
    scDotPlot(scale = TRUE,
              features = features,
              group = "level2class",
              groupAnno = "level1class",
              featureAnno = "Marker",
              groupLegends = FALSE,
              annoColors = list("level1class" = pal_d3()(7),
                                "Marker" = pal_d3()(7)),
              annoWidth = 0.02)
```

![scDotPlot of SingleCellExperiment Z-scores](data:image/png;base64...)

Figure 2: scDotPlot of SingleCellExperiment Z-scores

# 4 Seurat

## 4.1 Get features

After loading the example Seurat object, we find the top markers for each cluster and add them to the assay of interest.

```
library(Seurat)
library(SeuratObject)
library(tibble)

data("pbmc_small")

features <- pbmc_small |>
    FindAllMarkers(only.pos = TRUE, verbose = FALSE) |>
    group_by(cluster) |>
    dplyr::slice(1:6) |>
    dplyr::select(cluster, gene)

pbmc_small[[DefaultAssay(pbmc_small)]][[]] <- pbmc_small[[DefaultAssay(pbmc_small)]][[]] |>
    rownames_to_column("gene") |>
    left_join(features, by = "gene") |>
    column_to_rownames("gene")

features <- features |>
    deframe()
```

## 4.2 Plot logcounts

Plotting a Seurat object is similar to plotting a SingleCellExperiment object.

```
pbmc_small |>
    scDotPlot(features = features,
              group = "RNA_snn_res.1",
              groupAnno = "RNA_snn_res.1",
              featureAnno = "cluster",
              annoColors = list("RNA_snn_res.1" = pal_d3()(7),
                                "cluster" = pal_d3()(7)),
              groupLegends = FALSE,
              annoWidth = 0.075)
```

![scDotPlot of Seurat logcounts](data:image/png;base64...)

Figure 3: scDotPlot of Seurat logcounts

## 4.3 Plot Z-scores

Again, we see that plotting by Z-score improves the clustering result for the rows.

```
pbmc_small |>
    scDotPlot(scale = TRUE,
              features = features,
              group = "RNA_snn_res.1",
              groupAnno = "RNA_snn_res.1",
              featureAnno = "cluster",
              annoColors = list("RNA_snn_res.1" = pal_d3()(7),
                                "cluster" = pal_d3()(7)),
              groupLegends = FALSE,
              annoWidth = 0.075)
```

![scDotPlot of Seurat Z-scores](data:image/png;base64...)

Figure 4: scDotPlot of Seurat Z-scores

# 5 Package support

The [Bioconductor support site](https://support.bioconductor.org/) is the preferred method to ask for help. Before posting, it’s recommended to check [previous posts](https://support.bioconductor.org/tag/scDotPlot/) for the answer and look over the [posting guide](http://www.bioconductor.org/help/support/posting-guide/). For the post, it’s important to use the `scDotPlot` tag and provide both a minimal reproducible example and session information.

# 6 Acknowledgement

This package was inspired by the [single-cell example from aplot](https://yulab-smu.top/pkgdocs/aplot.html#a-single-cell-example).

# 7 Session info

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
##  [1] future_1.67.0               tibble_3.3.0
##  [3] Seurat_5.3.1                SeuratObject_5.2.0
##  [5] sp_2.2-0                    ggsci_4.1.0
##  [7] scDotPlot_1.4.0             AnnotationDbi_1.72.0
##  [9] dplyr_1.1.4                 purrr_1.1.0
## [11] scran_1.38.0                scuttle_1.20.0
## [13] scRNAseq_2.24.0             SingleCellExperiment_1.32.0
## [15] SummarizedExperiment_1.40.0 Biobase_2.70.0
## [17] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [19] IRanges_2.44.0              S4Vectors_0.48.0
## [21] BiocGenerics_0.56.0         generics_0.1.4
## [23] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [25] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] fs_1.6.6                 ProtGenerics_1.42.0      spatstat.sparse_3.1-0
##   [4] bitops_1.0-9             httr_1.4.7               RColorBrewer_1.1-3
##   [7] tools_4.5.1              sctransform_0.4.2        alabaster.base_1.10.0
##  [10] R6_2.6.1                 HDF5Array_1.38.0         uwot_0.2.3
##  [13] lazyeval_0.2.2           rhdf5filters_1.22.0      withr_3.0.2
##  [16] gridExtra_2.3            progressr_0.17.0         cli_3.6.5
##  [19] spatstat.explore_3.5-3   fastDummies_1.7.5        labeling_0.4.3
##  [22] alabaster.se_1.10.0      sass_0.4.10              S7_0.2.0
##  [25] spatstat.data_3.1-9      ggridges_0.5.7           pbapply_1.7-4
##  [28] systemfonts_1.3.1        yulab.utils_0.2.1        Rsamtools_2.26.0
##  [31] scater_1.38.0            dichromat_2.0-0.1        parallelly_1.45.1
##  [34] limma_3.66.0             RSQLite_2.4.3            gridGraphics_0.5-1
##  [37] BiocIO_1.20.0            ica_1.0-3                spatstat.random_3.4-2
##  [40] Matrix_1.7-4             ggbeeswarm_0.7.2         abind_1.4-8
##  [43] lifecycle_1.0.4          yaml_2.3.10              edgeR_4.8.0
##  [46] rhdf5_2.54.0             SparseArray_1.10.0       BiocFileCache_3.0.0
##  [49] Rtsne_0.17               grid_4.5.1               blob_1.2.4
##  [52] promises_1.4.0           dqrng_0.4.1              ExperimentHub_3.0.0
##  [55] crayon_1.5.3             miniUI_0.1.2             lattice_0.22-7
##  [58] beachmat_2.26.0          cowplot_1.2.0            GenomicFeatures_1.62.0
##  [61] cigarillo_1.0.0          KEGGREST_1.50.0          pillar_1.11.1
##  [64] knitr_1.50               metapod_1.18.0           rjson_0.2.23
##  [67] future.apply_1.20.0      codetools_0.2-20         glue_1.8.0
##  [70] ggiraph_0.9.2            fontLiberation_0.1.0     ggfun_0.2.0
##  [73] spatstat.univar_3.1-4    data.table_1.17.8        treeio_1.34.0
##  [76] vctrs_0.6.5              png_0.1-8                gypsum_1.6.0
##  [79] spam_2.11-1              gtable_0.3.6             cachem_1.1.0
##  [82] xfun_0.54                S4Arrays_1.10.0          mime_0.13
##  [85] survival_3.8-3           statmod_1.5.1            bluster_1.20.0
##  [88] fitdistrplus_1.2-4       ROCR_1.0-11              nlme_3.1-168
##  [91] ggtree_4.0.1             fontquiver_0.2.1         bit64_4.6.0-1
##  [94] alabaster.ranges_1.10.0  filelock_1.0.3           RcppAnnoy_0.0.22
##  [97] GenomeInfoDb_1.46.0      bslib_0.9.0              irlba_2.3.5.1
## [100] vipor_0.4.7              KernSmooth_2.23-26       otel_0.2.0
## [103] DBI_1.2.3                tidyselect_1.2.1         bit_4.6.0
## [106] compiler_4.5.1           curl_7.0.0               httr2_1.2.1
## [109] BiocNeighbors_2.4.0      h5mread_1.2.0            fontBitstreamVera_0.1.1
## [112] DelayedArray_0.36.0      plotly_4.11.0            bookdown_0.45
## [115] rtracklayer_1.70.0       scales_1.4.0             lmtest_0.9-40
## [118] rappdirs_0.3.3           stringr_1.5.2            digest_0.6.37
## [121] goftest_1.2-3            spatstat.utils_3.2-0     alabaster.matrix_1.10.0
## [124] rmarkdown_2.30           XVector_0.50.0           htmltools_0.5.8.1
## [127] pkgconfig_2.0.3          dbplyr_2.5.1             fastmap_1.2.0
## [130] ensembldb_2.34.0         rlang_1.1.6              htmlwidgets_1.6.4
## [133] UCSC.utils_1.6.0         shiny_1.11.1             farver_2.1.2
## [136] jquerylib_0.1.4          zoo_1.8-14               jsonlite_2.0.0
## [139] BiocParallel_1.44.0      BiocSingular_1.26.0      RCurl_1.98-1.17
## [142] magrittr_2.0.4           ggplotify_0.1.3          dotCall64_1.2
## [145] patchwork_1.3.2          Rhdf5lib_1.32.0          Rcpp_1.1.0
## [148] viridis_0.6.5            gdtools_0.4.4            ape_5.8-1
## [151] reticulate_1.44.0        stringi_1.8.7            alabaster.schemas_1.10.0
## [154] MASS_7.3-65              AnnotationHub_4.0.0      plyr_1.8.9
## [157] parallel_4.5.1           listenv_0.9.1            ggrepel_0.9.6
## [160] deldir_2.0-4             Biostrings_2.78.0        splines_4.5.1
## [163] tensor_1.5.1             locfit_1.5-9.12          igraph_2.2.1
## [166] spatstat.geom_3.6-0      RcppHNSW_0.6.0           reshape2_1.4.4
## [169] ScaledMatrix_1.18.0      BiocVersion_3.22.0       XML_3.99-0.19
## [172] evaluate_1.0.5           BiocManager_1.30.26      httpuv_1.6.16
## [175] RANN_2.6.2               tidyr_1.3.1              polyclip_1.10-7
## [178] scattermore_1.2          alabaster.sce_1.10.0     ggplot2_4.0.0
## [181] rsvd_1.0.5               xtable_1.8-4             restfulr_0.0.16
## [184] AnnotationFilter_1.34.0  tidytree_0.4.6           RSpectra_0.16-2
## [187] later_1.4.4              viridisLite_0.4.2        aplot_0.2.9
## [190] beeswarm_0.4.0           memoise_2.0.1            GenomicAlignments_1.46.0
## [193] cluster_2.1.8.1          globals_0.18.0
```