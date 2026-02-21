# Using schex with Seurat

Reduced dimension plotting is one of the essential tools for the analysis of single cell data. However, as the number of cells/nuclei in these plots increases, the usefulness of these plots decreases. Many cells are plotted on top of each other obscuring information, even when taking advantage of transparency settings. This package provides binning strategies of cells/nuclei into hexagon cells. Plotting summarized information of all cells/nuclei in their respective hexagon cells presents information without obstructions. The package seemlessly works with the two most common object classes for the storage of single cell data; `SingleCellExperiment` from the [SingleCellExperiment](https://bioconductor.org/packages/3.9/bioc/html/SingleCellExperiment.html) package and `Seurat` from the [Seurat](https://satijalab.org/seurat/) package. In this vignette I will be presenting the use of `schex` for `SingleCellExperiment` objects that are converted from `Seurat` objects.

## Load libraries

```
library(schex)
library(dplyr)
library(Seurat)
```

## Setup single cell data

In order to demonstrate the capabilities of the schex package, I will use the a subsetted dataset of Peripheral Blood Mononuclear Cells (PBMC) freely available from 10x Genomics. There are 80 single cells with 230 features in this dataset.

```
pbmc_small
#> An object of class Seurat
#> 230 features across 80 samples within 1 assay
#> Active assay: RNA (230 features, 20 variable features)
#>  3 layers present: counts, data, scale.data
#>  2 dimensional reductions calculated: pca, tsne
```

### Perform dimensionality reductions

The dataset already contains two dimension reductions (PCA and TSNE). We will now add UMAP. Since there is a random component in the UMAP, we will set a seed. You can also add dimension reductions after conversion using package that include functionalities for SingleCellExperiment objects.

```
set.seed(10)
pbmc_small <- RunUMAP(pbmc_small,
    dims = 1:10,
    verbose = FALSE
)
```

### Converting to SingleCellExperiment object

We will now convert the Seurat object into a SingleCellExperiment object.

```
pbmc.sce <- as.SingleCellExperiment(pbmc_small)
```

## Plotting single cell data

At this stage in the workflow we usually would like to plot aspects of our data in one of the reduced dimension representations. Instead of plotting this in an ordinary fashion, I will demonstrate how schex can provide a better way of plotting this.

#### Calculate hexagon cell representation

First, I will calculate the hexagon cell representation for each cell for a specified dimension reduction representation. I decide to use `nbins=40` which specifies that I divide my x range into 10 bins. Note that this might be a parameter that you want to play around with depending on the number of cells/ nuclei in your dataset. Generally, for more cells/nuclei, `nbins` should be increased.

```
pbmc.sce <- make_hexbin(pbmc.sce,
    nbins = 10,
    dimension_reduction = "UMAP"
)
```

#### Plot number of cells/nuclei in each hexagon cell

First I plot how many cells are in each hexagon cell. This should be relatively even, otherwise change the `nbins` parameter in the previous calculation.

```
plot_hexbin_density(pbmc.sce)
```

![](data:image/png;base64...)

#### Plot meta data in hexagon cell representation

Next I colour the hexagon cells by some meta information, such as the median total count in each hexagon cell.

```
plot_hexbin_meta(pbmc.sce, col = "nCount_RNA", action = "median")
#> Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
#> ℹ Please use tidy evaluation idioms with `aes()`.
#> ℹ See also `vignette("ggplot2-in-packages")` for more information.
#> ℹ The deprecated feature was likely used in the schex package.
#>   Please report the issue at <https://github.com/SaskiaFreytag/schex/issues>.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
```

![](data:image/png;base64...)

#### Plot gene expression in hexagon cell representation

Finally, I will visualize the gene expression of the CD1C gene in the hexagon cell representation.

```
gene_id <- "CD1C"
schex::plot_hexbin_feature(pbmc.sce,
    type = "counts", feature = gene_id,
    action = "mean", xlab = "UMAP1", ylab = "UMAP2",
    title = paste0("Mean of ", gene_id)
)
```

![](data:image/png;base64...)

### Understanding `schex` output as `ggplot` objects

The `schex` packages renders ordinary `ggplot` objects and thus these can be treated and manipulated using the [`ggplot` grammar](https://ggplot2.tidyverse.org/). For example the non-data components of the plots can be changed using the function `theme`.

```
gene_id <- "CD1C"
gg <- schex::plot_hexbin_feature(pbmc.sce,
    type = "counts", feature = gene_id,
    action = "mean", xlab = "UMAP1", ylab = "UMAP2",
    title = paste0("Mean of ", gene_id)
)
gg + theme_void()
```

![](data:image/png;base64...)

The fact that `schex` renders `ggplot` objects can also be used to save these plots. Simply use `ggsave` in order to save any created plot.

```
ggsave(gg, file = "schex_plot.pdf")
```

To find the details of the session for reproducibility, use this:

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
#>  [1] Seurat_5.3.1                SeuratObject_5.2.0
#>  [3] sp_2.2-0                    dplyr_1.1.4
#>  [5] schex_1.24.0                SingleCellExperiment_1.32.0
#>  [7] SummarizedExperiment_1.40.0 Biobase_2.70.0
#>  [9] GenomicRanges_1.62.0        Seqinfo_1.0.0
#> [11] IRanges_2.44.0              S4Vectors_0.48.0
#> [13] BiocGenerics_0.56.0         generics_0.1.4
#> [15] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [17] ggplot2_4.0.0
#>
#> loaded via a namespace (and not attached):
#>   [1] RColorBrewer_1.1-3     jsonlite_2.0.0         magrittr_2.0.4
#>   [4] spatstat.utils_3.2-0   farver_2.1.2           rmarkdown_2.30
#>   [7] vctrs_0.6.5            ROCR_1.0-11            spatstat.explore_3.5-3
#>  [10] htmltools_0.5.8.1      S4Arrays_1.10.0        SparseArray_1.10.0
#>  [13] sass_0.4.10            sctransform_0.4.2      parallelly_1.45.1
#>  [16] KernSmooth_2.23-26     bslib_0.9.0            htmlwidgets_1.6.4
#>  [19] ica_1.0-3              plyr_1.8.9             plotly_4.11.0
#>  [22] zoo_1.8-14             cachem_1.1.0           igraph_2.2.1
#>  [25] mime_0.13              lifecycle_1.0.4        pkgconfig_2.0.3
#>  [28] Matrix_1.7-4           R6_2.6.1               fastmap_1.2.0
#>  [31] fitdistrplus_1.2-4     future_1.67.0          shiny_1.11.1
#>  [34] digest_0.6.37          patchwork_1.3.2        tensor_1.5.1
#>  [37] RSpectra_0.16-2        irlba_2.3.5.1          labeling_0.4.3
#>  [40] progressr_0.17.0       spatstat.sparse_3.1-0  httr_1.4.7
#>  [43] polyclip_1.10-7        abind_1.4-8            compiler_4.5.1
#>  [46] withr_3.0.2            S7_0.2.0               fastDummies_1.7.5
#>  [49] hexbin_1.28.5          ggforce_0.5.0          MASS_7.3-65
#>  [52] concaveman_1.2.0       DelayedArray_0.36.0    tools_4.5.1
#>  [55] lmtest_0.9-40          otel_0.2.0             httpuv_1.6.16
#>  [58] future.apply_1.20.0    goftest_1.2-3          glue_1.8.0
#>  [61] nlme_3.1-168           promises_1.4.0         grid_4.5.1
#>  [64] Rtsne_0.17             cluster_2.1.8.1        reshape2_1.4.4
#>  [67] gtable_0.3.6           spatstat.data_3.1-9    tidyr_1.3.1
#>  [70] data.table_1.17.8      XVector_0.50.0         spatstat.geom_3.6-0
#>  [73] RcppAnnoy_0.0.22       ggrepel_0.9.6          RANN_2.6.2
#>  [76] pillar_1.11.1          stringr_1.5.2          spam_2.11-1
#>  [79] RcppHNSW_0.6.0         later_1.4.4            splines_4.5.1
#>  [82] tweenr_2.0.3           lattice_0.22-7         deldir_2.0-4
#>  [85] survival_3.8-3         tidyselect_1.2.1       miniUI_0.1.2
#>  [88] pbapply_1.7-4          knitr_1.50             gridExtra_2.3
#>  [91] scattermore_1.2        xfun_0.53              stringi_1.8.7
#>  [94] lazyeval_0.2.2         yaml_2.3.10            evaluate_1.0.5
#>  [97] codetools_0.2-20       entropy_1.3.2          tibble_3.3.0
#> [100] cli_3.6.5              uwot_0.2.3             xtable_1.8-4
#> [103] reticulate_1.44.0      jquerylib_0.1.4        dichromat_2.0-0.1
#> [106] Rcpp_1.1.0             spatstat.random_3.4-2  globals_0.18.0
#> [109] png_0.1-8              spatstat.univar_3.1-4  parallel_4.5.1
#> [112] dotCall64_1.2          listenv_0.9.1          viridisLite_0.4.2
#> [115] scales_1.4.0           ggridges_0.5.7         crayon_1.5.3
#> [118] purrr_1.1.0            rlang_1.1.6            cowplot_1.2.0
```