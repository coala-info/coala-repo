# Beyond Sequence-based Spatially-Resolved Data

Starting from Version 1.2.0, `escheR` package supports additional two data structures as input, including [`SpatialExperiment`](https://bioconductor.org/packages/release/bioc/html/SpatialExperiment.html) and `data.frame` from `base` R. In addition, `escheR` supports in-situ visualization of image-based spatially resolved data, which will be the focus of future development.

# Visualized Dimensionality Reduced Embedding with `SingleCellExperiment`

## `SpatialExperiment` inherits `SingleCellExperiment`

Following the same syntax, one can also visualize dimensionality reduced embeddings of a `SpatialExperiment` object by providing the argument `dimred` with a non-null value. Hence, the first 2 columns of the corresponding `reducedDim(spe)` assay will be used as the x-y coordinate of the plot, replacing `spatialCoords(spe)`.

```
library(escheR)
library(STexampleData)
library(scater)
library(scran)

spe <- Visium_humanDLPFC() |>
  logNormCounts()
spe <- spe[, spe$in_tissue == 1]
spe <- spe[, !is.na(spe$ground_truth)]
top.gene <- getTopHVGs(spe, n=500)

set.seed(100) # See below.
spe <- runPCA(spe, subset_row = top.gene)

make_escheR(
  spe,
  dimred = "PCA"
) |>
  add_fill(var = "ground_truth") +
  theme_minimal()
```

![](data:image/png;base64...)

# Hex Binning

```
spe$counts_MOBP <- counts(spe)[which(rowData(spe)$gene_name=="MOBP"),]
spe$ground_truth <- factor(spe$ground_truth)

# Point Binning version
make_escheR(
  spe,
  dimred = "PCA"
) |>
  add_ground_bin(
    var = "ground_truth"
    ) |>
  add_fill_bin(
    var = "counts_MOBP"
    ) +
  # Customize aesthetics
   scale_fill_gradient(low = "white", high = "black", name = "MOBP Count")+
  scale_color_discrete(name = "Spatial Domains") +
  theme_minimal()
```

![](data:image/png;base64...)

> Note 1: The strategy of binning to avoid overplotting is previously proposed in [`schex`](https://www.bioconductor.org/packages/release/bioc/html/schex.html). While we provide an implementation in `escheR`, we would caution our users that the binning strategy could lead to intermixing of cluster memberships. In our implementation, the majority membership of the data points belonging to a bin is selected as the label of the bin. Users should use the binning strategy under their own discretion, and interpret the visualization carefully.

> Note 2: `add_fill_bin()` shoudl be applied after `add_ground_bin()` for the better visualization outcome.

# Image-based `SpatialExperiment` Object

To demonstrate the principle that `escheR` can be used to visualize image-based spatially-resolved data pending optimization, we include two image-based spatially resolved transcriptomics data generated via seqFish platform and Slide-seq V2 platform respectively. The two datasets have been previously curated in the [`STexampleData`](https://bioconductor.org/packages/release/data/experiment/vignettes/STexampleData/inst/doc/STexampleData_overview.html) package

## seqFISH

```
library(STexampleData)
library(escheR)
spe_seqFISH <- seqFISH_mouseEmbryo()

make_escheR(spe_seqFISH) |>
  add_fill(var = "embryo")
```

![](data:image/png;base64...)

> NOTE: trimming down the `colData(spe)` before piping into make-escheR could reduce the computation time to make the plots, specifically when `colData(spe)` contains extremely large number of irrelavent features/columns.

## SlideSeqV2

```
library(STexampleData)
library(escheR)
spe_slideseq <- SlideSeqV2_mouseHPC()

make_escheR(spe_slideseq) |>
  add_fill(var = "celltype")
```

![](data:image/png;base64...)

# Beyond Bioconductor Eco-system

We aim to provide accessibility to all users regardless of their programming background and preferred single-cell analysis pipelines. Nevertheless , with limited resource, our sustaining efforts will prioritize towards the maintenance of the established functionality and the optimization for image-based spatially resolved data. We regret we are not be able to provide seamless interface to other R pipelines such as `Seurat` and `Giotto` in foreseeable future.

Instead, we provide a generic function that works with a `data.frame` object as input. For example, relevant features in `Suerat` can be easily exported as a `data.frame` object manually or via `tidyseurat`[<https://github.com/stemangiola/tidyseurat>]. The exported data frame can be pipe into `escheR`.

```
library(escheR)
library(Seurat)
pbmc_small <- SeuratObject::pbmc_small
pbmc_2pc <- pbmc_small@reductions$pca@cell.embeddings[,1:2]
pbmc_meta <- pbmc_small@meta.data

#> Call generic function for make_escheR.data.frame
make_escheR(
  object = pbmc_meta,
  .x = pbmc_2pc[,1],
  .y = pbmc_2pc[,2]) |>
  add_fill(var = "groups")
```

# Session information

```
utils::sessionInfo()
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
#>  [1] scran_1.38.0                scater_1.38.0
#>  [3] scuttle_1.20.0              ggpubr_0.6.2
#>  [5] STexampleData_1.17.1        SpatialExperiment_1.20.0
#>  [7] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
#>  [9] Biobase_2.70.0              GenomicRanges_1.62.0
#> [11] Seqinfo_1.0.0               IRanges_2.44.0
#> [13] S4Vectors_0.48.0            MatrixGenerics_1.22.0
#> [15] matrixStats_1.5.0           ExperimentHub_3.0.0
#> [17] AnnotationHub_4.0.0         BiocFileCache_3.0.0
#> [19] dbplyr_2.5.1                BiocGenerics_0.56.0
#> [21] generics_0.1.4              escheR_1.10.0
#> [23] ggplot2_4.0.0               BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] DBI_1.2.3            gridExtra_2.3        httr2_1.2.1
#>   [4] rlang_1.1.6          magrittr_2.0.4       compiler_4.5.1
#>   [7] RSQLite_2.4.3        png_0.1-8            vctrs_0.6.5
#>  [10] pkgconfig_2.0.3      crayon_1.5.3         fastmap_1.2.0
#>  [13] backports_1.5.0      magick_2.9.0         XVector_0.50.0
#>  [16] labeling_0.4.3       rmarkdown_2.30       ggbeeswarm_0.7.2
#>  [19] tinytex_0.57         purrr_1.1.0          bit_4.6.0
#>  [22] bluster_1.20.0       xfun_0.53            beachmat_2.26.0
#>  [25] cachem_1.1.0         jsonlite_2.0.0       blob_1.2.4
#>  [28] DelayedArray_0.36.0  BiocParallel_1.44.0  cluster_2.1.8.1
#>  [31] irlba_2.3.5.1        broom_1.0.10         parallel_4.5.1
#>  [34] R6_2.6.1             bslib_0.9.0          RColorBrewer_1.1-3
#>  [37] limma_3.66.0         car_3.1-3            jquerylib_0.1.4
#>  [40] Rcpp_1.1.0           bookdown_0.45        knitr_1.50
#>  [43] igraph_2.2.1         Matrix_1.7-4         tidyselect_1.2.1
#>  [46] viridis_0.6.5        dichromat_2.0-0.1    abind_1.4-8
#>  [49] yaml_2.3.10          codetools_0.2-20     curl_7.0.0
#>  [52] lattice_0.22-7       tibble_3.3.0         BumpyMatrix_1.18.0
#>  [55] withr_3.0.2          KEGGREST_1.50.0      S7_0.2.0
#>  [58] evaluate_1.0.5       Biostrings_2.78.0    pillar_1.11.1
#>  [61] BiocManager_1.30.26  filelock_1.0.3       carData_3.0-5
#>  [64] BiocVersion_3.22.0   scales_1.4.0         glue_1.8.0
#>  [67] metapod_1.18.0       tools_4.5.1          hexbin_1.28.5
#>  [70] BiocNeighbors_2.4.0  ScaledMatrix_1.18.0  locfit_1.5-9.12
#>  [73] ggsignif_0.6.4       cowplot_1.2.0        grid_4.5.1
#>  [76] tidyr_1.3.1          edgeR_4.8.0          AnnotationDbi_1.72.0
#>  [79] beeswarm_0.4.0       BiocSingular_1.26.0  vipor_0.4.7
#>  [82] rsvd_1.0.5           Formula_1.2-5        cli_3.6.5
#>  [85] rappdirs_0.3.3       S4Arrays_1.10.0      viridisLite_0.4.2
#>  [88] dplyr_1.1.4          gtable_0.3.6         rstatix_0.7.3
#>  [91] sass_0.4.10          digest_0.6.37        dqrng_0.4.1
#>  [94] ggrepel_0.9.6        SparseArray_1.10.0   rjson_0.2.23
#>  [97] farver_2.1.2         memoise_2.0.1        htmltools_0.5.8.1
#> [100] lifecycle_1.0.4      httr_1.4.7           statmod_1.5.1
#> [103] bit64_4.6.0-1
```